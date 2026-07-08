@echo off
:: ResearchPilot-Skills 中文版安装脚本（Windows）
:: 用法：install-zh.bat [claude|codex|codebuddy]
:: 默认安装到 Claude Code（%USERPROFILE%\.claude\skills\）

setlocal EnableDelayedExpansion

set TARGET=%~1
if "%TARGET%"=="" set TARGET=claude

if "%TARGET%"=="claude"    set DEST=%USERPROFILE%\.claude\skills
if "%TARGET%"=="codex"     set DEST=%USERPROFILE%\.codex\skills
if "%TARGET%"=="codebuddy" set DEST=%CD%\.codebuddy\skills

if not defined DEST (
    echo 用法：install-zh.bat [claude^|codex^|codebuddy]
    echo   claude     -^> %%USERPROFILE%%\.claude\skills\ （默认）
    echo   codex      -^> %%USERPROFILE%%\.codex\skills\
    echo   codebuddy  -^> .codebuddy\skills\ （当前目录下）
    exit /b 1
)

set SRC=skills\ResearchPilot-Skills-zh

if not exist "%DEST%" mkdir "%DEST%"

echo 安装中文版 ResearchPilot-Skills -^> %DEST%
echo.

set skills=research[START] research[A]-exploration research[B]-idea research[C]-experiment research[D]-implementation research[E]-coding research[F]-iteration research[G.0]-plan research[G.1]-method research[G.2]-experiments research[G.3]-abstract research[G.4]-introduction research[G.5]-related research[G.6]-conclusion research[G.7]-review research[G.8]-translate

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
echo 安装完成（%count% 个 skill）。
echo 验证：dir "%DEST%" | findstr research
echo.
echo 启动后运行 /research[START] 测试安装。
endlocal
