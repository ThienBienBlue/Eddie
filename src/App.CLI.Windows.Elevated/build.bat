@echo off
SETLOCAL

IF "%~1"=="" (
	echo "First param must be Debug or Release"
	GOTO error
)

IF "%~2"=="" (
	echo "Second param must be x86 or x64"
	GOTO error
)

set VARSCRIPTDIR=%~dp0
call "%VARSCRIPTDIR%\..\..\repository\windows_common\locate_msbuild.bat" || exit /b 1
set VARCONFIG=%~1
set VARARCH=%~2
set VARARCHCOMPILE=%VARARCH%

set VARSOLUTIONPATH="%VARSCRIPTDIR%\App.CLI.Windows.Elevated.sln"

echo "Build eddie-cli-elevated - Config: %VARCONFIG%, Arch: %VARARCH%"

"%VARMSBUILD%" /verbosity:minimal /property:CodeAnalysisRuleSet=%VARRULESETPATH% /p:Configuration=%VARCONFIG% /p:Platform=%VARARCHCOMPILE% /t:Rebuild %VARSOLUTIONPATH% || GOTO error

GOTO done

:error
echo Something wrong
EXIT /B 1

:done

echo "Build eddie-cli-elevated - Done"

EXIT /B 0
