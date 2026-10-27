@echo off
:: ResearchPilot-Skills uninstaller for all editions: zh / en / es.
:: Usage: uninstall.bat [claude|codex|codebuddy]
setlocal EnableExtensions DisableDelayedExpansion

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=claude"
set "DEST="

if /I "%TARGET%"=="claude" set "DEST=%USERPROFILE%\.claude\skills"
if /I "%TARGET%"=="codex" set "DEST=%USERPROFILE%\.codex\skills"
if /I "%TARGET%"=="codebuddy" set "DEST=%CD%\.codebuddy\skills"

if not defined DEST (
    echo Usage: uninstall.bat [claude^|codex^|codebuddy]
    exit /b 1
)

:: All editions share these names. G.8 belongs to the Chinese edition.
set "skills=research[fig] research[START] research[A]-exploration research[B]-idea research[C]-experiment research[D]-implementation research[E]-coding research[F]-iteration research[G.0]-plan research[G.1]-method research[G.2]-experiments research[G.3]-abstract research[G.4]-introduction research[G.5]-related research[G.6]-conclusion research[G.7]-review research[G.8]-translate"
for %%D in ("%DEST%") do set "DEST=%%~fD"

echo Uninstalling ResearchPilot-Skills [zh/en/es] from "%DEST%"
set "removed=0"
for %%s in (%skills%) do (
    if exist "%DEST%\%%s\" (
        rmdir /S /Q "%DEST%\%%s"
        if exist "%DEST%\%%s\" (
            echo [ERROR] Could not remove %%s
            exit /b 1
        )
        echo   [removed] %%s
        set /a removed+=1 >nul
    )
)

echo.
echo Removed: %removed% skills.
endlocal
exit /b 0
