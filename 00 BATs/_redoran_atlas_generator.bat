@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_redoran_marble_red.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*4

magick convert tx_redoran_barracks_trim.dds tx_redoran_barracks_trim.dds +append ATL/temp1.bmp
magick convert tx_border_redoran_step_01.dds tx_border_redoran_step_01.dds +append ATL/temp2.bmp
magick convert tx_block_adobe_white_01.dds tx_redoran_hut_03.dds +append ATL/temp3.bmp
magick convert tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds +append ATL/temp4.bmp

magick convert tx_redoran_marble_red.dds tx_redoran_marble_white.dds tx_redoran_tavern_01.dds ATL/temp1.bmp ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp ATL/temp3.bmp -resize %resolutionW% -append -gravity north -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/tx_redoran_atlas.dds

magick convert tx_redoran_hut_00.dds tx_redoran_hut_00.dds tx_redoran_hut_00.dds ATL/temp1.bmp ATL/temp1.bmp ATL/temp4.bmp ATL/temp4.bmp ATL/temp2.bmp ATL/temp2.bmp -resize %resolutionW% -append -gravity north -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/tx_redwall_atlas.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
cd ..

if not defined run_without_pause pause