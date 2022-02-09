@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_wood_brown_posts_02.* -format %%w info:') do set resolutionH=%%i
set /A resolutionHalf=%resolutionH%/2
magick convert tx_wood_brown_rings_01.* Tx_wood_dock_rings.* -resize %resolutionHalf% -append ATL/temp1.bmp
magick convert Tx_wood_wethered.* -rotate "90" ATL/temp2.bmp
magick convert tx_wood_weathered_rings.* tx_wood_wormridden_rings.* -resize %resolutionHalf% -append ATL/temp3.bmp
magick convert tx_rope_brown_02.* tx_rope_brown_02.* -append ATL/temp4.bmp
magick convert tx_rope_heavy.* -rotate "90" ATL/temp5.bmp

magick convert Tx_wood_brown_posts_02.* ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp Tx_ropestrip_01.* ATL/temp4.bmp ATL/temp5.bmp -resize x%resolutionH% +append -define dds:compression=dxt1 ATL/atlas_woodpoles.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
cd ..

if not defined run_without_pause pause