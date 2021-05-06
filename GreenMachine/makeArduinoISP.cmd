@ECHO off
SET PORT=COM4
SET AVRPATH=..\bin
SET HEXPATH=ArduinoISP
SET HEXFILE=ArduinoISP4m5_Uno.hex

%AVRPATH%\avrdude -C %AVRPATH%\avrdude.conf -c arduino -D -b 115200 -P %PORT% -p m328p -u -U flash:w:"%HEXPATH%\%HEXFILE%":i 
pause