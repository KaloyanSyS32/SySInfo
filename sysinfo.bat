@echo off
setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set "os=%%i"
echo OS: %os%

for /f "tokens=2 delims==" %%i in ('wmic os get Version /value') do set "version=%%i"
echo OS Ver: %version%

for /f "tokens=2 delims==" %%i in ('wmic computersystem get model /value') do set "model=%%i"
echo PC: %model%

set "cpu_name="
for /f "skip=1 tokens=* delims=" %%i in ('wmic cpu get name') do (
    if not defined cpu_name if not "%%i"=="" set "cpu_name=%%i"
)
echo CPU: %cpu_name%

for /f "tokens=2 delims==" %%i in ('wmic computersystem get totalphysicalmemory /value') do set "ram=%%i"
for /f "usebackq" %%g in (`powershell -command "('{0:N2}' -f (%ram% / 1GB))"`) do set "ram_gb=%%g"
echo RAM: %ram_gb% GB

for /f "skip=1 tokens=* delims=" %%i in ('wmic path win32_VideoController get name') do (
    set "gpu=%%i"
    if not "!gpu!"=="" echo.!gpu!
)


pause
