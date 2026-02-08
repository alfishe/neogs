
@echo off

if not exist tmp md tmp
call setpath_tools
call setpath_includes

cls

rem сборка основного кода
asl -U -L -C -x -olist tmp\flasher.lst -i %includes% flasher.a80 || goto error
p2bin flasher.p tmp\flasher.rom -r $-$ -k

mhmt -mlz tmp\flasher.rom tmp\flasher.pack

rem сборка scl
asl -U -L -C -x -olist tmp\make_flasher2scl.lst -i %includes% make\make_flasher2scl.a80 || goto error
p2bin make\make_flasher2scl.p flasher.scl -r $-$ -k

csum32 flasher.scl -a

rem сборка Hobeta
asl -U -L -C -x -olist tmp\flasher4hobeta.lst -i %includes% make\flasher4hobeta.a80 || goto error
p2bin make\flasher4hobeta.p FLASHNGS.$C -r $-$ -k

rem сборка tap
copy /B /Y make\flasher.src flasher.tap
taptool +$ flasher.tap make\flasher.!b
taptool +$ flasher.tap FLASHNGS.$C

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit
