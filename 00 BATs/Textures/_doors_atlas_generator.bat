@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_velothi_door_01.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*8

magick convert tx_jail_door_01.dds -rotate 90 -append ATL/temp1.bmp
magick convert tx_metal_hlaalulock.dds tx_keyhole_05.dds +append ATL/temp2.bmp

magick convert ATL/temp1.bmp tx_hinge_02.dds ATL/temp2.bmp tx_metal_strip_02.dds tx_velothi_doorstrip_01.dds tx_hlaalu_doorplank_01.dds tx_velothi_door_01.dds tx_hlaalu_door_02.dds tx_hlaalu_door_01.dds -gravity southwest -background "#26261b" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_doors_01.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
