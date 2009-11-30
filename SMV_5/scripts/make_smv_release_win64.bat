@echo off
set version=%1
REM
REM This batch file creates a self unarchiving file containing
REM a release version of smokeview and associated files
REM
REM usage: 
REM  make_smv_release_win64 version
REM    where version is of the from X.Y_svn#

cd ..\for_bundle
set zipbase=smv_%version%_win64
set smvdir=to_google\%zipbase%

echo
echo filling distribution directory
IF EXIST %smvdir% rmdir /S /Q %smvdir%
mkdir %smvdir%
mkdir %smvdir%\Documentation
copy smokeview.ini %smvdir%\smokeview.ini
copy smokeview64_release.exe %smvdir%\smokeview.exe
copy smokezip64_release.exe %smvdir%\smokezip64.exe
copy smokediff64_release.exe %smvdir%\smokediff64.exe
copy devices.svo %smvdir%\.
copy glew32.dll %smvdir%\.
copy pthreadVC.dll %smvdir%\.
copy readme.html %smvdir%\Documentation\.

echo
echo winzipping distribution directory
cd %smvdir%
wzzip -a -r -P %zipbase%.zip *

echo
echo creating self-extracting archive
c:\bin\winzip\wzipse32 %zipbase%.zip -d "c:\program files\fds\fds5\bin"
copy %zipbase%.exe ..\.

cd ..\..\..\scripts