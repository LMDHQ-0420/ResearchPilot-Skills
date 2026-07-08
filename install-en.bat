@echo off
:: ResearchPilot-Skills English version installer (Windows)
:: Usage: install-en.bat [claude|codex|codebuddy]
:: Default: Claude Code (%USERPROFILE%\.claude\skills\)

setlocal EnableDelayedExpansion

set TARGET=%~1
if "%TARGET%"=="" set TARGET=claude

if "%TARGET%"=="claude"    set DEST=%USERPROFILE%\.claude\skills
if "%TARGET%"=="codex"     set DEST=%USERPROFILE%\.codex\skills
if "%TARGET%"=="codebuddy" set DEST=%CD%\.codebuddy\skills

if not defined DEST (
    echo Usage: install-en.bat [claude^|codex^|codebuddy]
    echo   claude     -^> %%USERPROFILE%%\.claude\skills\ ^(default^)
    echo   codex      -^> %%USERPROFILE%%\.codex\skills\
    echo   codebuddy  -^> .codebuddy\skills\ ^(current directory^)
    exit /b 1
)

set SRC=skills\ResearchPilot-Skills-en

if not exist "%DEST%" mkdir "%DEST%"

echo Installing ResearchPilot-Skills (English) -^> %DEST%
echo.

set skills=research[START] research[A]-exploration research[B]-idea research[C]-experiment research[D]-implementation research[E]-coding research[F]-iteration research[G.0]-plan research[G.1]-method research[G.2]-experiments research[G.3]-abstract research[G.4]-introduction research[G.5]-related research[G.6]-conclusion research[G.7]-review

set count=0
for %%s in (%skills%) do (
    if exist "%SRC%\%%s" (
        xcopy /E /I /Q /Y "%SRC%\%%s" "%DEST%\%%s\" >nul
        echo   [OK] %%s
        set /a count+=1
    ) else (
        echo   [SKIP] %%s ^(not found^)
    )
)

echo.
echo Installation complete (%count% skills).
echo Verify: dir "%DEST%" | findstr research
echo.
echo Run /research[START] in Claude Code to test.
endlocal
