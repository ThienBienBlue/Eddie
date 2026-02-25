@echo off
setlocal

rem Old VS2022
rem set VARMSBUILD="C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin\MSBuild.exe"

for /f "usebackq delims=" %%i in (`
  "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" ^
    -latest -products * ^
    -find MSBuild\Current\Bin\MSBuild.exe
`) do (
  endlocal
  set "VARMSBUILD=%%i"
  exit /b 0
)

endlocal
exit /b 1
