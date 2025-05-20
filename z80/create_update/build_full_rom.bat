
@echo on

cd ..\main_rom

call build.bat

cd ..\loader_ngs

call build.bat

cd ..\bootFPGA00

..\..\tools\mhmt\mhmt ..\..\fpga\current\quartus\main.rbf main.mlz

call mk.bat bootFPGA

..\..\tools\addcrc\addcrc -n bootFPGA.bin bootFPGA.crc

del *.lst
del *.mlz
del *.rbf
del *.hex

cd ..\create_update

copy /B /Y ..\loader_ngs\loader_ngs.rom
copy /B /Y ..\main_rom\neogs.rom
copy /B /Y ..\bootFPGA00\bootFPGA.crc fpga.bin

..\..\tools\asw\asw -U -L make_full_rom.a80
..\..\tools\asw\p2bin make_full_rom.p full_ngs.rom -r $-$ -k

del loader_ngs.rom
del neogs.rom

copy /B /Y full_ngs.rom D:\yad\UnrealSpeccy\full_ngs.rom

pause