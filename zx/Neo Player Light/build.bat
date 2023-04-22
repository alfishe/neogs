
@echo off

if not exist tmp md tmp
set path=%path%;d:\yad\svn\pentevo\tools\asl\bin\;d:\yad\svn\pentevo\tools\mhmt\
set includes=d:\yad\svn\pentevo\rom\;make

asl -U -L -x -olist tmp\play4ngs.lst -i %includes% play4ngs.a80 || goto error
p2bin play4ngs.p tmp\play4ngs.rom -r $-$ -k

mhmt -mlz tmp\play4ngs.rom tmp\play4ngs_pack.rom

asl -U -L -x -olist tmp\face_play.lst -i %includes% -D ADR_START=0x8100 face_play.a80 || goto error
p2bin face_play.p tmp\npl.rom -r $-$ -k

mhmt -mlz tmp\npl.rom tmp\npl_pack.rom

asl -U -L -x -olist tmp\face_play_sp.lst -i %includes% -D ADR_START=0x8100,_SPRINTER face_play.a80 || goto error
p2bin face_play.p tmp\nplsp.rom -r $-$ -k

mhmt -mlz tmp\nplsp.rom tmp\nplsp_pack.rom

asl -U -L -x -olist tmp\make_npl4hobeta.lst -i %includes% -D ADR_START=0x8100 make_npl4hobeta.a80 || goto error
p2bin make_npl4hobeta.p NPL.$C -r $-$ -k

asl -U -L -x -olist tmp\make_npl4scl.lst -i %includes% -D ADR_START=0x8100 make_npl4scl.a80 || goto error
p2bin make_npl4scl.p npl.scl -r $-$ -k

asl -U -L -x -olist tmp\make_basictape.lst -i %includes% make_basictape.a80 || goto error
p2bin make_basictape.p tmp\npl.!b -r $-$ -k

copy /B /Y make\ngsplay.src ngsplay.tap

..\..\tools\taptool\taptool +$ ngsplay.tap tmp\npl.!b
..\..\tools\taptool\taptool +$ ngsplay.tap NPL.$C

asl -U -L -x -olist tmp\make_exe.lst -i %includes% -D ADR_START=0x8100 make_exe.a80 || goto error
p2bin make_exe.p npl.exe -r $-$ -k

echo ########################
echo # -= End Compile Ok =- #
echo ########################
goto exit

:error
echo #######################
echo # -= Error Compile =- #
echo #######################

:exit
