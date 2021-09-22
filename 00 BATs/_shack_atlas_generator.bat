@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_siding.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*8

magick convert tx_wood_weathered_rings.dds tx_wood_weathered_rings_01.dds -append ATL/temp1.bmp
magick convert tx_shack_screen.dds tx_shack_screen.dds -append ATL/temp2.bmp
magick convert ATL/temp2.bmp ATL/temp2.bmp ATL/temp2.bmp ATL/temp1.bmp +append ATL/temp3.bmp
magick convert tx_wood_wethered.dds tx_wood_wethered.dds +append ATL/temp4.bmp
magick convert tx_rope_heavy.dds tx_rope_heavy.dds +append ATL/temp5.bmp
magick convert tx_wood_shack_door.dds -rotate 90 -append ATL/temp6.bmp

magick convert tx_wood_siding.dds tx_wood_siding_01.dds tx_shack_foundation.dds ATL/temp4.bmp ATL/temp4.bmp tx_shack_thatch.dds tx_shack_thatch.dds ATL/temp3.bmp ATL/temp5.bmp ATL/temp6.bmp tx_metal_iron_rusty.dds -resize %resolutionW% -append -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_shack.dds

cd ATL
del temp1.bmp
del temp2.bmp
del temp3.bmp
del temp4.bmp
del temp5.bmp
del temp6.bmp
cd ...

if not defined run_without_pause pause