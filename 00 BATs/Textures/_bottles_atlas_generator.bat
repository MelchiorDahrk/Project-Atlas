@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_wicker_tan.dds -format %%W info:') do set resolutionW=%%i

magick convert tx_cork_01.dds tx_cork_01.dds +append ATL/temp4.bmp

magick convert -resize %resolutionW% Tx_straw_woven.dds Tx_straw_woven.dds Tx_wicker_tan.dds Tx_wicker_tan.dds -append ATL/temp5.bmp
magick convert ATL/temp5.bmp ATL/temp4.bmp -gravity west +composite ATL/temp6.bmp

magick convert Tx_glass_bottle_blue_01.dds Tx_glass_bottle_blue.dds ATL/temp6.bmp -define dds:compression=dxt1 -append ATL/atlad_bottle_bl.dds
magick convert Tx_glass_bottle_brown_01.dds Tx_glass_bottle_brown.dds ATL/temp6.bmp -define dds:compression=dxt1 -append ATL/atlad_bottle_br.dds
magick convert Tx_glass_bottle_green_01.dds Tx_glass_bottle_green.dds ATL/temp6.bmp -define dds:compression=dxt1 -append ATL/atlad_bottle_gr.dds

cd ATL
del temp4.bmp
del temp5.bmp
del temp6.bmp
cd ..

if not defined run_without_pause pause
