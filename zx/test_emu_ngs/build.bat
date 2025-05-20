
@echo off

if not exist tmp md tmp
set path=%path%;d:\yad\svn\pentevo\tools\asl\bin\;d:\yad\svn\pentevo\tools\mhmt\
set includes=d:\yad\svn\pentevo\rom\;make

cls

asl -U -L -x -olist tmp\main.lst -i %includes% -D ADR_START=0x8100 main.a80 || goto error
p2bin main.p tmp\main.rom -r $-$ -k || goto error

asl -U -L -x -olist tmp\main_sp.lst -i %includes% -D ADR_START=0x8100,_SPRINTER main.a80 || goto error
p2bin main.p tmp\main_sp.rom -r $-$ -k || goto error

mhmt -mlz tmp\main.rom tmp\main.pack
mhmt -mlz tmp\main_sp.rom tmp\main_sp.pack

asl -U -L -x -olist tmp\make_scl.lst -i %includes% -D ADR_START=0x8100 make\make_scl.a80 || goto error
p2bin make\make_scl.p testngs.scl -r $-$ -k || goto error

asl -U -L -x -olist tmp\make_exe.lst -i %includes% -D ADR_START=0x8100 make\make_exe.a80 || goto error
p2bin make\make_exe.p testngs.exe -r $-$ -k || goto error

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit
