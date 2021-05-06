@ECHO off

SET AVRPATH=..\bin
SET HEXPATH=Output

SET PORT=COM4
SET PROJECT=BLHeli_GM
SET VER=1.00

CALL :ERASE

SET LOCATION=lock
SET SUF=loc
CALL :UPLOAD

SET LOCATION=hfuse
SET SUF=hfs
CALL :UPLOAD

SET LOCATION=lfuse
SET SUF=lfs
CALL :UPLOAD

SET LOCATION=flash
SET SUF=hex
CALL :UPLOAD

SET LOCATION=eeprom
SET SUF=eep
CALL :UPLOAD

GOTO :END

:DOWNLOAD
	%AVRPATH%\avrdude -C %AVRPATH%\avrdude.conf -c arduino -b 19200 -p m8 -P %PORT% -n -U %location%:r:%HEXPATH%\%PROJECT%_v%VER%.%SUF%:i
	exit /B

:UPLOAD
	%AVRPATH%\avrdude -C %AVRPATH%\avrdude.conf -c arduino -b 19200 -p m8 -P %PORT% -U %location%:w:%HEXPATH%\%PROJECT%_v%VER%.%SUF%:i
	exit /B

:ERASE
	%AVRPATH%\avrdude -C %AVRPATH%\avrdude.conf -c arduino -b 19200 -p m8 -P %PORT% -e
	exit /B

:END
SET PORT=
SET PROJECT=
SET VER=
SET LOCATION=
SET SUF=
pause
