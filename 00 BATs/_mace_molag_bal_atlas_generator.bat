@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_w_art_molagbal00.dds -format %%h info:') do set resolutionH=%%i

magick convert tx_w_art_molagbal01.dds tx_w_art_molagbal01.dds +append ATL/temp1.bmp
magick convert tx_metal_strip_01.dds tx_metal_strip_01.dds -append -rotate 90 ATL/temp2.bmp
magick convert ATL/temp1.bmp ATL/temp2.bmp -append ATL/temp3.bmp

magick convert tx_w_art_molagbal00.dds ATL/temp3.bmp -resize x%resolutionH% +append -define dds:compression=dxt1 ATL/atlad_molagbal.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
