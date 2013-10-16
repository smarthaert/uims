SET OLDPATH=%PATH%
CD %1
path=C:\Program Files\Borland\Delphi7\bin
dcc32.exe /B winSkinD7R.dpk -$H-,W-
dcc32.exe /B winSkinD7D.dpk -$H-,W-
del dcc32.cfg
SET Path=%OLDPATH%
