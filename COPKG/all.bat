@echo off
setlocal

if "%1"=="clean" goto :clean
if "%1"=="noclean" (
	set __NOCLEAN__=true
	shift)

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
call :build x64 Release v140
call :build x64 Debug v140
call :build x64 Release v120
call :build x64 Debug v120
call :build x64 Release v110
call :build x64 Debug v110
call :build x64 Release v100
call :build x64 Debug v100
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
call :build Win32 Release v140
call :build Win32 Debug v140
call :build Win32 Release v120
call :build Win32 Debug v120
call :build Win32 Release v110
call :build Win32 Debug v110
call :build Win32 Release v100
call :build Win32 Debug v100
endlocal

if "__NOCLEAN__"=="true" goto :eof

goto :clean

:build
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=DynamicLibrary libffi\libffi.sln
msbuild /P:Platform=%1 /P:Configuration=%2 /P:PlatformToolset=%3 /P:ConfigurationType=StaticLibrary libffi\libffi.sln
goto :eof

:clean
rd /s /q libffi\libffi\Win32
rd /s /q libffi\libffi\x64

