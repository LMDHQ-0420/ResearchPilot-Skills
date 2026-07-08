@echo off
:: ResearchPilot-Skills 卸载脚本（Windows，中英文均可）
:: Usage / 用法：uninstall.bat [claude|codex|codebuddy]

setlocal EnableDelayedExpansion

set TARGET=%~1
if "%TARGET%"=="" set TARGET=claude

if "%TARGET%"=="claude"    set DEST=%USERPROFILE%\.claude\skills
if "%TARGET%"=="codex"     set DEST=%USERPROFILE%\.codex\skills
if "%TARGET%"=="codebuddy" set DEST=%CD%\.codebuddy\skills

if not defined DEST (
    echo 用法 / Usage: uninstall.bat [claude^|codex^|codebuddy]
    exit /b 1
)

echo 卸载 ResearchPilot-Skills from %DEST%
echo.

set skills=research[START] research[A]-exploration research[B]-idea research[C]-experiment research[D]-implementation research[E]-coding research[F]-iteration research[G.0]-plan research[G.1]-method research[G.2]-experiments research[G.3]-abstract research[G.4]-introduction research[G.5]-related research[G.6]-conclusion research[G.7]-review research[G.8]-translate

set removed=0
for %%s in (%skills%) do (
    if exist "%DEST%\%%s" (
        rmdir /S /Q "%DEST%\%%s"
        echo   [removed] %%s
        set /a removed+=1
    )
)

echo.
echo 已卸载 %removed% 个 skill。
endlocal
