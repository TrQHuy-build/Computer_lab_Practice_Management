# SQL Server Configuration - Automated Version
# Không yêu cầu input từ người dùng

$ErrorActionPreference = "SilentlyContinue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SQL Server LAN Configuration Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Kiểm tra SQL Server Service
Write-Host "`n[Step 1] Checking SQL Server Service..." -ForegroundColor Yellow

$instances = @("SQLEXPRESS", "MSSQLSERVER", "SQL2019", "SQL2022")
$foundService = $false
$instanceName = ""

foreach ($instance in $instances) {
    $serviceName = if ($instance -eq "MSSQLSERVER") { "MSSQLSERVER" } else { "MSSQL`$$instance" }
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    
    if ($service) {
        Write-Host "  ✓ Found: $instance" -ForegroundColor Green
        $instanceName = $instance
        $foundService = $true
        
        if ($service.Status -eq "Running") {
            Write-Host "    Status: RUNNING" -ForegroundColor Green
        } else {
            Write-Host "    Status: STOPPED - Attempting to start..." -ForegroundColor Yellow
            Start-Service -Name $serviceName -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
            Write-Host "    Status: STARTED" -ForegroundColor Green
        }
        break
    }
}

if (-not $foundService) {
    Write-Host "  ✗ SQL Server not found. Please install SQL Server first." -ForegroundColor Red
    Write-Host "    Download: https://www.microsoft.com/en-us/sql-server/sql-server-downloads" -ForegroundColor Yellow
    exit 1
}

# Lấy IP Address
Write-Host "`n[Step 2] Getting Your IP Address..." -ForegroundColor Yellow

$ipConfig = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.IPv4Address -ne $null } | Select-Object -First 1

if ($ipConfig) {
    $ip = $ipConfig.IPv4Address[0].IPAddress
    Write-Host "  ✓ Your IP Address: $ip" -ForegroundColor Green
} else {
    $ip = "localhost"
    Write-Host "  ⚠ Could not detect IP, using: $ip" -ForegroundColor Yellow
}

# Kiểm tra Firewall
Write-Host "`n[Step 3] Checking Windows Firewall..." -ForegroundColor Yellow

$firewallStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $true }

if ($firewallStatus) {
    Write-Host "  ✓ Windows Firewall is ENABLED" -ForegroundColor Green
    
    # Kiểm tra rule cho SQL Server
    $rule = Get-NetFirewallRule -DisplayName "*SQL Server*" -ErrorAction SilentlyContinue | Select-Object -First 1
    
    if ($rule) {
        Write-Host "  ✓ SQL Server firewall rule exists" -ForegroundColor Green
    } else {
        Write-Host "  ! Creating firewall rule for port 1433..." -ForegroundColor Yellow
        New-NetFirewallRule -DisplayName "SQL Server 1433" `
            -Direction Inbound `
            -LocalPort 1433 `
            -Protocol TCP `
            -Action Allow `
            -Profile @("Domain", "Private", "Public") `
            -ErrorAction SilentlyContinue | Out-Null
        Write-Host "  ✓ Firewall rule created" -ForegroundColor Green
    }
} else {
    Write-Host "  ✓ Windows Firewall is DISABLED (Network access available)" -ForegroundColor Green
}

# Tạo Database
Write-Host "`n[Step 4] Creating/Verifying Database..." -ForegroundColor Yellow

try {
    [System.Reflection.Assembly]::LoadWithPartialName("System.Data") | Out-Null
    
    $serverName = ".\$instanceName"
    $connectionString = "Server=$serverName;Integrated Security=True;Connection Timeout=10;"
    
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    $connection.Open()
    
    Write-Host "  ✓ Connected to SQL Server" -ForegroundColor Green
    
    $command = $connection.CreateCommand()
    $command.CommandText = "SELECT name FROM sys.databases WHERE name = 'QL_PHONG_TH'"
    $result = $command.ExecuteScalar()
    
    if ($result -eq "QL_PHONG_TH") {
        Write-Host "  ✓ Database 'QL_PHONG_TH' already exists" -ForegroundColor Green
    } else {
        Write-Host "  ! Creating database 'QL_PHONG_TH'..." -ForegroundColor Yellow
        $command.CommandText = "CREATE DATABASE [QL_PHONG_TH]"
        $command.ExecuteNonQuery() | Out-Null
        Write-Host "  ✓ Database created successfully" -ForegroundColor Green
    }
    
    $connection.Close()
} catch {
    Write-Host "  ⚠ Warning: Could not create database automatically" -ForegroundColor Yellow
    Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Gray
    Write-Host "    You may need to run Database_Setup_Full.sql manually" -ForegroundColor Yellow
}

# Tạo SQL Login
Write-Host "`n[Step 5] Creating SQL Login 'RemoteUser'..." -ForegroundColor Yellow

try {
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    $connection.Open()
    
    # Tạo login
    $command = $connection.CreateCommand()
    $command.CommandText = @"
    IF NOT EXISTS (SELECT name FROM sys.syslogins WHERE name = 'RemoteUser')
    BEGIN
        CREATE LOGIN [RemoteUser] WITH PASSWORD = 'Server2024@SQL'
    END
"@
    $command.ExecuteNonQuery() | Out-Null
    
    # Tạo user trong database
    $command.CommandText = @"
    USE [QL_PHONG_TH]
    IF NOT EXISTS (SELECT name FROM sys.sysusers WHERE name = 'RemoteUser')
    BEGIN
        CREATE USER [RemoteUser] FOR LOGIN [RemoteUser]
        ALTER ROLE db_owner ADD MEMBER [RemoteUser]
    END
"@
    $command.ExecuteNonQuery() | Out-Null
    
    Write-Host "  ✓ SQL Login 'RemoteUser' created" -ForegroundColor Green
    
    $connection.Close()
} catch {
    Write-Host "  ⚠ Warning: Could not create SQL Login" -ForegroundColor Yellow
    Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Gray
}

# Hiển thị tóm tắt
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  ✓ CONFIGURATION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n📋 Connection Details:" -ForegroundColor Green
Write-Host "  Server: $ip,1433" -ForegroundColor White
Write-Host "  Instance: .\$instanceName" -ForegroundColor White
Write-Host "  Database: QL_PHONG_TH" -ForegroundColor White
Write-Host "  SQL User: RemoteUser" -ForegroundColor White
Write-Host "  Password: Server2024@SQL" -ForegroundColor White

Write-Host "`n🔗 Connection String (SQL Authentication):" -ForegroundColor Green
Write-Host "  Server=$ip,1433;Database=QL_PHONG_TH;User Id=RemoteUser;Password=Server2024@SQL;TrustServerCertificate=True" -ForegroundColor Yellow

Write-Host "`n🔗 Connection String (Windows Authentication):" -ForegroundColor Green
Write-Host "  Server=$ip,1433;Database=QL_PHONG_TH;Trusted_Connection=True;TrustServerCertificate=True" -ForegroundColor Yellow

Write-Host "`n📝 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Update appsettings.json with the connection string above" -ForegroundColor White
Write-Host "  2. Run: dotnet run" -ForegroundColor White
Write-Host "  3. From other machines, use: $ip,1433" -ForegroundColor White

Write-Host "`n✅ Configuration complete! You can now access SQL Server from other machines on the LAN." -ForegroundColor Green
