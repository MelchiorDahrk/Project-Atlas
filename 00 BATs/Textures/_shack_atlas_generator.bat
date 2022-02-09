@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_siding.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*8

magick convert tx_wood_weathered_rings.* tx_wood_weathered_rings_01.* -append ATL/temp1.bmp
magick convert tx_shack_screen.* tx_shack_screen.* -append ATL/temp2.bmp
magick convert ATL/temp2.bmp ATL/temp2.bmp ATL/temp2.bmp ATL/temp1.bmp +append ATL/temp3.bmp
magick convert tx_wood_wethered.* tx_wood_wethered.* +append ATL/temp4.bmp
magick convert tx_rope_heavy.* tx_rope_heavy.* +append ATL/temp5.bmp
magick convert tx_wood_shack_door.* -rotate 90 -append ATL/temp6.bmp

magick convert tx_wood_siding.* tx_wood_siding_01.* tx_shack_foundation.* ATL/temp4.bmp ATL/temp4.bmp tx_shack_thatch.* tx_shack_thatch.* ATL/temp3.bmp ATL/temp5.bmp ATL/temp6.bmp tx_metal_iron_rusty.* -resize %resolutionW% -append -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_shack.dds

cd ATL
del temp1.bmp
del temp2.bmp
del temp3.bmp
del temp4.bmp
del temp5.bmp
del temp6.bmp
cd ..

if not defined run_without_pause pause