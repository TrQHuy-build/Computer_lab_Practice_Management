# SQL Server LAN Configuration Script
# Chạy với quyền Administrator

Write-Host "=== SQL Server LAN Configuration Tool ===" -ForegroundColor Cyan
Write-Host "This script checks and helps configure SQL Server for LAN access" -ForegroundColor Yellow

# Function để kiểm tra SQL Server Service
function Check-SQLServerService {
    param([string]$InstanceName = "SQLEXPRESS")
    
    Write-Host "`n[1] Checking SQL Server Service..." -ForegroundColor Green
    
    $service = Get-Service -Name "MSSQL`$$InstanceName" -ErrorAction SilentlyContinue
    
    if ($service) {
        if ($service.Status -eq "Running") {
            Write-Host "✓ SQL Server ($InstanceName) is RUNNING" -ForegroundColor Green
            return $true
        } else {
            Write-Host "✗ SQL Server ($InstanceName) is STOPPED" -ForegroundColor Red
            Write-Host "Do you want to start it? (Y/N)" -ForegroundColor Yellow
            $response = Read-Host
            if ($response -eq "Y") {
                Start-Service -Name "MSSQL`$$InstanceName"
                Write-Host "✓ SQL Server started" -ForegroundColor Green
                return $true
            }
        }
    } else {
        Write-Host "✗ SQL Server ($InstanceName) not found" -ForegroundColor Red
        Write-Host "Please install SQL Server first" -ForegroundColor Yellow
        return $false
    }
}

# Function để lấy IP Address
function Get-MachineIP {
    Write-Host "`n[2] Getting Machine IP Address..." -ForegroundColor Green
    
    $ipConfig = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }
    
    if ($ipConfig) {
        $ip = $ipConfig.IPv4Address.IPAddress
        Write-Host "✓ Your IP Address: $ip" -ForegroundColor Green
        return $ip
    } else {
        Write-Host "✗ Could not determine IP address" -ForegroundColor Red
        return $null
    }
}

# Function để kiểm tra Firewall
function Check-Firewall {
    Write-Host "`n[3] Checking Windows Firewall..." -ForegroundColor Green
    
    $profile = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $true }
    
    if ($profile) {
        Write-Host "✓ Windows Firewall is ENABLED" -ForegroundColor Green
        Write-Host "  Profile: $($profile.Name -join ', ')" -ForegroundColor Gray
        
        # Check if port 1433 is allowed
        $rule = Get-NetFirewallRule -DisplayName "*SQL Server*" -ErrorAction SilentlyContinue
        if ($rule) {
            Write-Host "✓ SQL Server firewall rule found" -ForegroundColor Green
        } else {
            Write-Host "✗ No SQL Server firewall rule found" -ForegroundColor Red
            Write-Host "Do you want to create firewall rule for port 1433? (Y/N)" -ForegroundColor Yellow
            $response = Read-Host
            if ($response -eq "Y") {
                New-NetFirewallRule -DisplayName "SQL Server 1433" `
                    -Direction Inbound `
                    -LocalPort 1433 `
                    -Protocol TCP `
                    -Action Allow | Out-Null
                Write-Host "✓ Firewall rule created for port 1433" -ForegroundColor Green
            }
        }
    } else {
        Write-Host "✓ Windows Firewall is DISABLED (Network access enabled)" -ForegroundColor Green
    }
}

# Function để tạo sample database
function Create-SampleDatabase {
    param([string]$ServerName, [string]$InstanceName = "SQLEXPRESS")
    
    Write-Host "`n[4] Creating Sample Database..." -ForegroundColor Green
    
    $connectionString = "Server=$ServerName\$InstanceName;Integrated Security=True;"
    
    try {
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString
        $connection.Open()
        
        $command = $connection.CreateCommand()
        $command.CommandText = @"
        -- Create database if not exists
        IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QL_PHONG_TH')
        BEGIN
            CREATE DATABASE [QL_PHONG_TH]
            PRINT 'Database QL_PHONG_TH created successfully'
        END
        ELSE
        BEGIN
            PRINT 'Database QL_PHONG_TH already exists'
        END
"@
        
        $command.ExecuteNonQuery()
        $connection.Close()
        
        Write-Host "✓ Database QL_PHONG_TH verified/created" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "✗ Error: $_" -ForegroundColor Red
        return $false
    }
}

# Function để tạo SQL Login
function Create-SQLLogin {
    param([string]$ServerName, [string]$InstanceName = "SQLEXPRESS", [string]$Username, [string]$Password)
    
    Write-Host "`n[5] Creating SQL Login..." -ForegroundColor Green
    
    $connectionString = "Server=$ServerName\$InstanceName;Integrated Security=True;"
    
    try {
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString
        $connection.Open()
        
        $command = $connection.CreateCommand()
        $command.CommandText = @"
        -- Create login if not exists
        IF NOT EXISTS (SELECT name FROM sys.syslogins WHERE name = '$Username')
        BEGIN
            CREATE LOGIN [$Username] WITH PASSWORD = '$Password'
            PRINT 'Login $Username created successfully'
        END
        ELSE
        BEGIN
            PRINT 'Login $Username already exists'
        END
        
        -- Create user in database
        USE [QL_PHONG_TH]
        IF NOT EXISTS (SELECT name FROM sys.sysusers WHERE name = '$Username')
        BEGIN
            CREATE USER [$Username] FOR LOGIN [$Username]
            ALTER ROLE db_owner ADD MEMBER [$Username]
            PRINT 'User $Username created in QL_PHONG_TH'
        END
"@
        
        $command.ExecuteNonQuery()
        $connection.Close()
        
        Write-Host "✓ SQL Login and User created successfully" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "✗ Error: $_" -ForegroundColor Red
        return $false
    }
}

# Main execution
Write-Host ""
Write-Host "Select SQL Server Instance (default: SQLEXPRESS):" -ForegroundColor Yellow
$instanceName = Read-Host "Instance Name (press Enter for default)"
if ([string]::IsNullOrEmpty($instanceName)) {
    $instanceName = "SQLEXPRESS"
}

# Check SQL Server Service
if (-not (Check-SQLServerService -InstanceName $instanceName)) {
    Write-Host "`nScript terminated. SQL Server must be running." -ForegroundColor Red
    exit
}

# Get IP Address
$machineIP = Get-MachineIP
if ($null -eq $machineIP) {
    $machineIP = "localhost"
}

# Check Firewall
Check-Firewall

# Create database
if (Create-SampleDatabase -ServerName "." -InstanceName $instanceName) {
    
    # Ask for SQL Login creation
    Write-Host "`nDo you want to create a SQL Login for remote access? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "Y") {
        $username = Read-Host "Enter username (default: RemoteUser)"
        if ([string]::IsNullOrEmpty($username)) {
            $username = "RemoteUser"
        }
        
        $password = Read-Host "Enter password" -AsSecureString
        $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUni($password))
        
        if (Create-SQLLogin -ServerName "." -InstanceName $instanceName -Username $username -Password $plainPassword) {
            Write-Host ""
            Write-Host "=== Configuration Summary ===" -ForegroundColor Cyan
            Write-Host "Server Name: .\$instanceName or $machineIP\$instanceName" -ForegroundColor Green
            Write-Host "Database: QL_PHONG_TH" -ForegroundColor Green
            Write-Host "SQL User: $username" -ForegroundColor Green
            Write-Host "Connection String: Server=$machineIP,$instanceName;Database=QL_PHONG_TH;User Id=$username;Password=$plainPassword" -ForegroundColor Yellow
        }
    }
}

Write-Host "`n=== Setup Complete ===" -ForegroundColor Cyan
Write-Host "For detailed instructions, see SQL_SERVER_LAN_SETUP.md" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to exit"
