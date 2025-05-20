
@echo off

cd ..\main_rom

call build.bat

cd ..\loader_ngs

call build.bat

cd ..\create_update

copy /B /Y ..\loader_ngs\loader_ngs.rom
copy /B /Y ..\main_rom\neogs.rom
addcrc loader_ngs.rom
ren crc.bin loader.crc
addcrc fpga.bin
ren crc.bin fpga.crc
addcrc neogs.rom
ren crc.bin neogs.crc

..\..\tools\asw\asw -U -L build_update.a80
..\..\tools\asw\p2bin build_update.p ngs_rom.upd -r $-$ -k

del loader_ngs.rom
del neogs.rom
del loader.crc
del fpga.crc
del neogs.crc

pause
