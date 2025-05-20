
@echo off

echo #########
echo # BUILD #
echo #########

path=d:\yad\svn\pentevo\tools\asl\bin\;d:\yad\svn\pentevo\tools\mhmt\;d:\yad\svn\pentevo\tools\noice2equ;d:\yad\svn\pentevo\tools\csum32
set includes=d:\yad\svn\pentevo\rom\
if not exist tmp md tmp

cls

asl -U -L -xx -i %includes% -olist tmp\gs105b.lst main_ngs.a80 || goto error
p2bin main_ngs.p ..\gs105b.rom -r $-$ -k

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit
