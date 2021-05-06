@ECHO off
@ECHO ***** Batch file for BlHeli (from 4712)  v.2           *****
@ECHO ***** All Messages will be saved to MakeHex_Result.txt *****
@ECHO ***** Start compile with any key  - CTRL-C to abort    *****
Break ON
@pause
DEL MakeHex_Result.txt /Q >nul 2>&1

rem ***** Adapt settings to your enviroment ****
DEL Output\Hex\*.* /Q >nul 2>&1
DEL Output\Eep\*.* /Q >nul 2>&1
RMDIR Output\Hex >nul 2>&1
RMDIR Output\Eep >nul 2>&1
DEL Output\*.* /Q >nul 2>&1
RMDIR Output >nul 2>&1
MKDIR Output >nul 2>&1
MKDIR Output\Hex >nul 2>&1
MKDIR Output\Eep >nul 2>&1
SET Revision=REV14_9
SET AtmelPath="C:\Taeron\BLHeli\bin"
rem SET AtmelPath="C:\Dev\Atmel\AVR Tools\AvrAssembler2"
SET GMDir=BLHeli_GM
SET GMVer=v1.00
MKDIR Output\%GMDir% >nul 2>&1


@ECHO Revision: %Revision% >> MakeHex_Result.txt
@ECHO Path for Atmel assembler: %AtmelPath% >> MakeHex_Result.txt
@ECHO Start compile ..... >> MakeHex_Result.txt

SET NAME=FC_45A_HV
call:compile


goto :end


:compile
SET BESC=%NAME%_MAIN
call :compile2

goto :eof

:compile2
@ECHO compiling %BESC%  
@ECHO. >> MakeHex_Result.txt
@ECHO ********************************************************************  >> MakeHex_Result.txt
@ECHO %BESC%  >> MakeHex_Result.txt
@ECHO ********************************************************************  >> MakeHex_Result.txt
%AtmelPath%\avrasm2.exe -D %BESC% -D GMVer=\"%GMVer%\" -fI -o "Output\Hex\%BESC%_%Revision%.HEX" BLHeli.asm -e "Output\Eep\%BESC%_%Revision%.EEP" >> MakeHex_Result.txt
@ECHO. >> MakeHex_Result.txt
copy /y "Output\Hex\%BESC%_%Revision%.HEX" Output\%GMDir%\%GMDir%_%GMVer%.HEX >nul
copy /y "Output\Eep\%BESC%_%Revision%.EEP" Output\%GMDir%\%GMDir%_%GMVer%.EEP >nul
goto :eof

:end

@pause
exit
