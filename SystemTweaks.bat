@echo off
color 04
title System Performance Tweaks - Administrator Mode Required
mode con: cols=100 lines=40

:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ============================================================================
    echo                    ERROR: Administrator Rights Required
    echo ============================================================================
    echo.
    echo This script must be run as Administrator to apply system tweaks.
    echo Right-click this file and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

:MENU
cls
echo ================================================================================
echo                        SYSTEM PERFORMANCE TWEAKS V1.0
echo ================================================================================
echo.
echo  [1] Clean Temporary Files
echo  [2] Optimize Network Settings
echo  [3] Disable Unnecessary Services
echo  [4] Clear DNS Cache
echo  [5] Defragment and Optimize Drives
echo  [6] Disable Windows Telemetry
echo  [7] Optimize Visual Effects for Performance
echo  [8] Clean Windows Update Cache
echo  [9] Registry Performance Tweaks
echo  [10] Run All Tweaks (Recommended)
echo  [0] Exit
echo.
echo ================================================================================
set /p choice="Enter your choice (0-10): "

if "%choice%"=="1" goto CLEAN_TEMP
if "%choice%"=="2" goto NETWORK
if "%choice%"=="3" goto SERVICES
if "%choice%"=="4" goto DNS
if "%choice%"=="5" goto DEFRAG
if "%choice%"=="6" goto TELEMETRY
if "%choice%"=="7" goto VISUAL
if "%choice%"=="8" goto UPDATES
if "%choice%"=="9" goto REGISTRY
if "%choice%"=="10" goto ALL_TWEAKS
if "%choice%"=="0" goto EXIT
goto MENU

:CLEAN_TEMP
cls
echo ================================================================================
echo                          CLEANING TEMPORARY FILES
echo ================================================================================
echo.
echo [*] Deleting temporary files...
del /q/f/s %TEMP%\* >nul 2>&1
del /q/f/s C:\Windows\Temp\* >nul 2>&1
del /q/f/s C:\Windows\Prefetch\* >nul 2>&1
echo [+] Temporary files cleaned successfully!
echo.
pause
goto MENU

:NETWORK
cls
echo ================================================================================
echo                        OPTIMIZING NETWORK SETTINGS
echo ================================================================================
echo.
echo [*] Resetting network stack...
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
echo [+] Network stack reset!
echo.
echo [*] Optimizing TCP/IP settings...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global chimney=enabled >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
netsh int tcp set global netdma=enabled >nul 2>&1
echo [+] TCP/IP optimized!
echo.
pause
goto MENU

:SERVICES
cls
echo ================================================================================
echo                      DISABLING UNNECESSARY SERVICES
echo ================================================================================
echo.
echo [*] Disabling Windows Search (you can enable later if needed)...
sc config WSearch start=disabled >nul 2>&1
echo [*] Disabling Superfetch...
sc config SysMain start=disabled >nul 2>&1
echo [*] Disabling Print Spooler (if you don't use printers)...
sc config Spooler start=disabled >nul 2>&1
echo [+] Services optimized!
echo.
echo NOTE: Some services were disabled. You can re-enable them in services.msc
echo.
pause
goto MENU

:DNS
cls
echo ================================================================================
echo                           CLEARING DNS CACHE
echo ================================================================================
echo.
echo [*] Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
echo [+] DNS cache cleared!
echo.
pause
goto MENU

:DEFRAG
cls
echo ================================================================================
echo                       OPTIMIZING DISK DRIVES
echo ================================================================================
echo.
echo [*] Analyzing and optimizing drives...
echo [!] This may take several minutes...
defrag C: /O >nul 2>&1
echo [+] Drive optimization complete!
echo.
pause
goto MENU

:TELEMETRY
cls
echo ================================================================================
echo                        DISABLING WINDOWS TELEMETRY
echo ================================================================================
echo.
echo [*] Disabling telemetry services...
sc config DiagTrack start=disabled >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc stop dmwappushservice >nul 2>&1
echo [+] Telemetry services disabled!
echo.
pause
goto MENU

:VISUAL
cls
echo ================================================================================
echo                  OPTIMIZING VISUAL EFFECTS FOR PERFORMANCE
echo ================================================================================
echo.
echo [*] Adjusting system for best performance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
echo [+] Visual effects optimized!
echo.
pause
goto MENU

:UPDATES
cls
echo ================================================================================
echo                      CLEANING WINDOWS UPDATE CACHE
echo ================================================================================
echo.
echo [*] Stopping Windows Update service...
net stop wuauserv >nul 2>&1
echo [*] Clearing update cache...
del /q/f/s C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
echo [*] Starting Windows Update service...
net start wuauserv >nul 2>&1
echo [+] Update cache cleaned!
echo.
pause
goto MENU

:REGISTRY
cls
echo ================================================================================
echo                       APPLYING REGISTRY TWEAKS
echo ================================================================================
echo.
echo [*] Creating system restore point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Registry Tweaks", 100, 7 >nul 2>&1
echo [*] Optimizing menu show delay...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
echo [*] Disabling startup delay...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
echo [*] Optimizing system responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
echo [+] Registry tweaks applied!
echo.
pause
goto MENU

:ALL_TWEAKS
cls
echo ================================================================================
echo                         RUNNING ALL SYSTEM TWEAKS
echo ================================================================================
echo.
echo [!] This will apply all optimizations. Press any key to continue...
pause >nul
echo.
echo [1/9] Cleaning temporary files...
del /q/f/s %TEMP%\* >nul 2>&1
del /q/f/s C:\Windows\Temp\* >nul 2>&1
del /q/f/s C:\Windows\Prefetch\* >nul 2>&1
echo [+] Complete
echo.
echo [2/9] Optimizing network settings...
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
echo [+] Complete
echo.
echo [3/9] Disabling unnecessary services...
sc config WSearch start=disabled >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
echo [+] Complete
echo.
echo [4/9] Clearing DNS cache...
ipconfig /flushdns >nul 2>&1
echo [+] Complete
echo.
echo [5/9] Optimizing drives (this may take a while)...
defrag C: /O >nul 2>&1
echo [+] Complete
echo.
echo [6/9] Disabling telemetry...
sc config DiagTrack start=disabled >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc stop dmwappushservice >nul 2>&1
echo [+] Complete
echo.
echo [7/9] Optimizing visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
echo [+] Complete
echo.
echo [8/9] Cleaning Windows Update cache...
net stop wuauserv >nul 2>&1
del /q/f/s C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1
echo [+] Complete
echo.
echo [9/9] Applying registry tweaks...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
echo [+] Complete
echo.
echo ================================================================================
echo                          ALL TWEAKS COMPLETED!
echo ================================================================================
echo.
echo [!] A system restart is recommended for all changes to take effect.
echo.
set /p restart="Would you like to restart now? (Y/N): "
if /i "%restart%"=="Y" shutdown /r /t 30 /c "System will restart in 30 seconds to apply tweaks. Save your work!"
echo.
pause
goto MENU

:EXIT
cls
echo ================================================================================
echo                            EXITING TWEAKS UTILITY
echo ================================================================================
echo.
echo Thank you for using System Performance Tweaks!
echo.
timeout /t 2 >nul
exit

