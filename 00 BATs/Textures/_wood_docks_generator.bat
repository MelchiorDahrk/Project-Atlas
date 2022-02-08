@echo off

if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_docks_01.dds -format %%h info:') do set resolutionH=%%i
set /A resolutionW=%resolutionH%*2
set /A resolutionQtr=%resolutionH%/4

magick convert tx_wood_dock_rings.dds tx_wood_weathered_rings.dds -resize %resolutionQtr% -append ATL/temp1.bmp
magick convert tx_rope_heavy.dds tx_rope_heavy.dds -rotate 90 +append ATL/temp2.bmp
magick convert ATL/temp2.bmp ATL/temp2.bmp -append ATL/temp3.bmp
magick convert tx_wood_barnacle_01.dds tx_wood_barnacle_01.dds -rotate -180 -append ATL/temp4.bmp
magick convert tx_wood_barnacle_02.dds tx_wood_barnacle_02.dds -rotate 90 -append ATL/temp5.bmp

magick convert tx_wood_docks_01.dds ATL/temp4.bmp ATL/temp5.bmp ATL/temp3.bmp ATL/temp1.bmp -background "#35332a" +append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_wood_docks.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
cd ..

if not defined run_without_pause pause