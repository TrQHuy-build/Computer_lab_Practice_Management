@echo off
REM Script Clean & Build ASP.NET Core Project

cd /d "d:\PTTKYC\New folder (5)\QL_TH_MT\QL_TH_MT"

echo.
echo ========================================
echo  Cleaning Project...
echo ========================================
if exist bin rmdir /s /q bin
if exist obj rmdir /s /q obj

echo.
echo ========================================
echo  Building Project...
echo ========================================
dotnet clean
dotnet restore
dotnet build --configuration Debug

echo.
echo ========================================
echo  Build Complete!
echo ========================================
echo.
echo Next: Run 'dotnet run' to start the app
echo.
pause
