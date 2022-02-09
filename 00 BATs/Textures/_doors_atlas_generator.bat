@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_velothi_door_01.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*8

magick convert tx_jail_door_01.* -rotate 90 -append ATL/temp1.bmp
magick convert tx_metal_hlaalulock.* tx_keyhole_05.* +append ATL/temp2.bmp
magick convert tx_hlaalu_doorplank_01.* -resize %resolutionW% -append ATL/temp3.bmp

magick convert ATL/temp1.bmp tx_hinge_02.* ATL/temp2.bmp tx_metal_strip_02.* tx_velothi_doorstrip_01.* ATL/temp3.bmp tx_velothi_door_01.* tx_hlaalu_door_02.* tx_hlaalu_door_01.* -gravity southwest -background "#26261b" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_doors_01.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
cd ..

if not defined run_without_pause pause
