@echo off
title Valorant Quick Setup
echo ============================================
echo   Valorant Quick Setup
echo ============================================
echo.

REM ------------------------------------------------------------
REM 1. MOUSE: pointer speed 6/11, Enhance Pointer Precision OFF
REM    (registry value 10 = slider position 6)
REM ------------------------------------------------------------
echo [1/6] Setting mouse...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f >nul

REM Apply the mouse settings immediately (no logoff needed)
set "PS=%temp%\apply_mouse.ps1"
echo $a = Add-Type -Name MouseA -Namespace W -PassThru -MemberDefinition '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(int a,int b,int[] c,int d);' > "%PS%"
echo $b = Add-Type -Name MouseB -Namespace W -PassThru -MemberDefinition '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(int a,int b,int c,int d);' >> "%PS%"
echo $a::SystemParametersInfo(4,0,[int[]](0,0,0),2) ^| Out-Null >> "%PS%"
echo $b::SystemParametersInfo(113,0,10,2) ^| Out-Null >> "%PS%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS%" >nul 2>&1
del "%PS%" >nul 2>&1

REM ------------------------------------------------------------
REM 2. POWER PLAN: High Performance
REM ------------------------------------------------------------
echo [2/6] Setting power plan to High Performance...
powercfg /setactive SCHEME_MIN >nul 2>&1
if errorlevel 1 (
    REM Plan is hidden on some PCs, so recreate it and activate the copy
    for /f "tokens=4" %%G in ('powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2^>nul') do powercfg /setactive %%G >nul 2>&1
)

REM ------------------------------------------------------------
REM 3. XBOX GAME BAR: disable
REM ------------------------------------------------------------
echo [3/6] Disabling Xbox Game Bar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v UseNostalgia /t REG_DWORD /d 0 /f >nul 2>&1

REM ------------------------------------------------------------
REM 4. FULLSCREEN OPTIMIZATIONS: disable for VALORANT
REM    Searches common drives for the Riot install and sets the
REM    Windows compatibility flag (no game files are modified)
REM ------------------------------------------------------------
echo [4/6] Disabling Fullscreen Optimizations for VALORANT...
set "FOUND=0"
for %%D in (C D E F G) do if exist "%%D:\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe" (
    reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%%D:\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f >nul 2>&1
    set "FOUND=1"
)
if "%FOUND%"=="0" echo       VALORANT not found in the usual folders, skipped.

REM ------------------------------------------------------------
REM 5. STICKY KEYS / FILTER KEYS / TOGGLE KEYS: disable popups
REM    Stops the Shift x5 popup from minimizing your game
REM ------------------------------------------------------------
echo [5/6] Disabling Sticky Keys and Filter Keys popups...
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d 122 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d 58 /f >nul 2>&1

REM ------------------------------------------------------------
REM 6. NOTIFICATION POPUPS: turn off Windows toasts
REM ------------------------------------------------------------
echo [6/6] Turning off notification popups...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo Done! Mouse: speed 6, precision off. Power: High Performance. Game Bar: off.
echo Fullscreen Optimizations, Sticky Keys popup and notifications: off.
echo If the mouse or Sticky Keys feel unchanged, sign out and back in once.
echo.

REM ------------------------------------------------------------
REM Open Display settings (for the stretched resolution)
REM ------------------------------------------------------------
echo Opening Display settings...
start "" ms-settings:display

REM ------------------------------------------------------------
REM Reminder: steps for stretched resolution (done by hand)
REM ------------------------------------------------------------
echo.
echo ============================================================
echo   STRETCHED RES - do this by hand (example: 1280x960)
echo ============================================================
echo NVIDIA Control Panel:
echo   1. Adjust desktop size and position: set scaling to Full-screen,
echo      untick Override scaling mode.
echo   2. Change resolution - Customize - Create Custom Resolution: 1280x960.
echo   3. In VALORANT: Display Mode Windowed, Resolution 1280x960,
echo      Aspect Ratio Fill.
echo   4. Set the desktop to 1280x960 in NVIDIA Control Panel.
echo.
echo AMD Radeon Software:
echo   1. Settings - Display - Custom Resolutions - Create New: 1280x960.
echo      Check the refresh rate matches your monitor, then Save.
echo   2. On the same Display page: GPU Scaling On, Scaling Mode Full Panel.
echo   3. In VALORANT: Display Mode Fullscreen, your native resolution,
echo      Aspect Ratio Fill, Apply. Then switch to Windowed and Apply again.
echo   4. Windows Settings - Display: pick 1280x960 and keep the change.
echo   Note: switch back to native before relaunching VALORANT, then repeat.
echo ============================================================
echo.

REM ------------------------------------------------------------
REM Launch VALORANT through the Riot Client, if found
REM ------------------------------------------------------------
set "RIOT="
for %%D in (C D E F G) do if exist "%%D:\Riot Games\Riot Client\RiotClientServices.exe" if not defined RIOT set "RIOT=%%D:\Riot Games\Riot Client\RiotClientServices.exe"
if defined RIOT (
    echo Launching VALORANT...
    start "" "%RIOT%" --launch-product=valorant --launch-patchline=live
) else (
    echo Riot Client not found in the usual folders, open VALORANT yourself.
)
echo.
pause
