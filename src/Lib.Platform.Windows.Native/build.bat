@echo off
SETLOCAL

echo Command Line: %0 %*

if "%~1"=="" (
	echo "First param must be Debug or Release"
	GOTO error
)

if "%~2"=="" (
	echo "Second param must be x86 or x64"
	GOTO error
)

rem call "%~dp0locate_msbuild.bat" || exit /b 1

set VARSCRIPTDIR=%~dp0
call "%VARSCRIPTDIR%\..\..\repository\windows_common\locate_msbuild.bat" || exit /b 1
set VARCONFIG=%~1
set VARARCH=%~2
set VARARCHCOMPILE=%VARARCH%

set VARSOLUTIONPATH="%VARSCRIPTDIR%\Lib.Platform.Windows.Native.sln"

"%VARMSBUILD%" /verbosity:minimal /property:CodeAnalysisRuleSet=%VARRULESETPATH% /p:Configuration=%VARCONFIG% /p:Platform=%VARARCHCOMPILE% /t:Rebuild %VARSOLUTIONPATH% || GOTO error

GOTO done

:error
echo Something wrong
EXIT /B 1

:done
EXIT /B 0

