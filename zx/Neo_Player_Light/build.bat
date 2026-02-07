
@echo off

if not exist tmp md tmp
set path=%path%;d:\yad\svn\pentevo\tools\asl\bin\;d:\yad\svn\pentevo\tools\mhmt\
set includes=d:\yad\svn\pentevo\rom\;make

cls

asl -U -L -x -olist tmp\play_on_ngs.lst -i %includes% play_on_ngs.a80 || goto error
p2bin play_on_ngs.p tmp\play_on_ngs.rom -r $-$ -k || goto error

mhmt -mlz tmp\play_on_ngs.rom tmp\play_on_ngs.pack

asl -U -L -x -olist tmp\face_play.lst -i %includes% -D ADR_START=0x8100 face_play.a80 || goto error
p2bin face_play.p tmp\npl.rom -r $-$ -k || goto error

mhmt -mlz tmp\npl.rom tmp\npl.pack

asl -U -L -x -olist tmp\face_play_sp.lst -i %includes% -D ADR_START=0x8100,_SPRINTER face_play.a80 || goto error
p2bin face_play.p tmp\nplsp.rom -r $-$ -k || goto error

mhmt -mlz tmp\nplsp.rom tmp\nplsp.pack

asl -U -L -x -olist tmp\make_npl4hobeta.lst -i %includes% -D ADR_START=0x8100 make\make_npl4hobeta.a80 || goto error
p2bin make\make_npl4hobeta.p NPL.$C -r $-$ -k || goto error

asl -U -L -x -olist tmp\make_npl4scl.lst -i %includes% -D ADR_START=0x8100 make\make_npl4scl.a80 || goto error
p2bin make\make_npl4scl.p npl.scl -r $-$ -k || goto error

asl -U -L -x -olist tmp\make_basictape.lst -i %includes% make\make_basictape.a80 || goto error
p2bin make\make_basictape.p tmp\npl.!b -r $-$ -k || goto error

copy /B /Y make\npl.src npl.tap

..\..\tools\taptool\taptool +$ npl.tap tmp\npl.!b
..\..\tools\taptool\taptool +$ npl.tap NPL.$C

asl -U -L -x -olist tmp\make_exe.lst -i %includes% -D ADR_START=0x8100 make\make_exe.a80 || goto error
p2bin make\make_exe.p npl.exe -r $-$ -k || goto error

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit
