@echo off
SET GMDir=BLHeli_GM
SET GMVer=v1.00
SET Bootloader=bootloader\BLHeli_m8_16_PD2.HEX

RMDIR Output >nul 2>&1
MKDIR Output >nul 2>&1

SET GMPath=..\Atmel\Output\%GMDir%
setlocal EnableDelayedExpansion

:: Remove the existing hex file and eeprom file
del Output\*_%GMVer%.* /Q >nul 2>&1

:: Copy the Green Machine Atmel config files
copy config\hfuse.hfs Output\%GMDir%_%GMVer%.hfs  >nul 2>&1
copy config\lfuse.lfs Output\%GMDir%_%GMVer%.lfs  >nul 2>&1
copy config\lock.loc Output\%GMDir%_%GMVer%.loc  >nul 2>&1

:: Copy the Green Machine BLHeli eeprom
copy %GMPath%\%GMDir%_%GMVer%.eep Output\%GMDir%_%GMVer%.eep  >nul 2>&1

:: Copy the Green Machine BLHeli software
set "cmd=findstr /R /N "^^" %GMPath%\%GMDir%_%GMVer%.hex | find /C ":""
for /f %%a in ('!cmd!') do set lineCount=%%a

SET startLine=2
SET currentLine=1
SET /a maxLine=%lineCount%-1
for /f "delims=|" %%i in (%GMPath%\%GMDir%_%GMVer%.hex) do (
  if !currentLine! geq !startLine! (
    if !currentLine! leq !maxLine! echo %%i>> Output\%GMDir%_%GMVer%.hex
  )
  set /a currentLine=!currentLine!+1
)

:: Add the BLHeli bootloader
set "cmd=findstr /R /N "^^" %Bootloader% | find /C ":""
for /f %%a in ('!cmd!') do set lineCount=%%a

SET startLine=3
SET currentLine=1
SET /a maxLine=%lineCount%
for /f "delims=|" %%i in (%Bootloader%) do (
  if !currentLine! geq !startLine! (
	if !currentLine! leq !maxLine! echo %%i>> Output\%GMDir%_%GMVer%.hex
  )
  set /a currentLine=!currentLine!+1
)

