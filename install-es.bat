@echo off
:: Instalador de ResearchPilot-Skills en espanol (Windows).
:: Uso: install-es.bat [claude|codex|codebuddy]
setlocal EnableExtensions DisableDelayedExpansion

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=claude"
set "DEST="

if /I "%TARGET%"=="claude" set "DEST=%USERPROFILE%\.claude\skills"
if /I "%TARGET%"=="codex" set "DEST=%USERPROFILE%\.codex\skills"
if /I "%TARGET%"=="codebuddy" set "DEST=%CD%\.codebuddy\skills"

if not defined DEST (
    echo Uso: install-es.bat [claude^|codex^|codebuddy]
    exit /b 1
)

set "SRC=%~dp0skills\ResearchPilot-Skills-es"
set "skills=research[fig] research[START] research[A]-exploration research[B]-idea research[C]-experiment research[D]-implementation research[E]-coding research[F]-iteration research[G.0]-plan research[G.1]-method research[G.2]-experiments research[G.3]-abstract research[G.4]-introduction research[G.5]-related research[G.6]-conclusion research[G.7]-review"

:: Verificar todos los archivos antes de instalar.
for %%s in (%skills%) do (
    if not exist "%SRC%\%%s\SKILL.md" (
        echo [ERROR] No se encontro "%SRC%\%%s\SKILL.md"
        exit /b 1
    )
)

if not exist "%DEST%\" (
    mkdir "%DEST%"
    if errorlevel 1 exit /b 1
)

echo Instalando ResearchPilot-Skills en espanol en "%DEST%"
set "count=0"
for %%s in (%skills%) do (
    xcopy /E /I /Q /Y "%SRC%\%%s" "%DEST%\%%s\" >nul
    if errorlevel 1 (
        echo [ERROR] No se pudo instalar %%s
        exit /b 1
    )
    echo   [OK] %%s
    set /a count+=1 >nul
)

echo.
echo Completado: %count% habilidades.
echo Reinicia el asistente y ejecuta /research[START].
endlocal
exit /b 0
