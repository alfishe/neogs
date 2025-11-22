
@echo off

if not exist tmp md tmp
call setpath_tools
call setpath_includes

cls

rem test for NeoGS

asl -U -L -C -x -olist tmp\testngs.lst -i %includes% -D ADR_START=0x8000 testngs.a80 || goto error
p2bin testngs.p tmp\testngs.rom -r $-$ -k

mhmt -mlz tmp\testngs.rom tmp\testngs.pack 

asl -U -L -C -x -olist tmp\make_hobeta.lst -i %includes% -D ADR_START=0x8000 make_hobeta.a80 || goto error
p2bin make_hobeta.p testngs.$C -r $-$ -k || goto error

asl -U -L -C -x -olist tmp\make_scl.lst -i %includes% -D ADR_START=0x8000 make_scl.a80 || goto error
p2bin make_scl.p testngs.scl -r $-$ -k || goto error

csum32 testngs.scl -a

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit