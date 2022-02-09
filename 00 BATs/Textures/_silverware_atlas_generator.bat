@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_metal_silver_plate_01.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*4

magick convert tx_metal_silver.* tx_metal_silver.* +append ATL/temp1.bmp
magick convert tx_metal_silver_strip_03.* tx_metal_silver_strip_03.* +append ATL/temp2.bmp

magick convert tx_metal_silver_plate_01.* tx_metal_silver_strip_01.* tx_metal_silver_strip_01.* tx_metal_silver_strip_02.* tx_metal_silver_strip_02.* ATL/temp2.bmp ATL/temp1.bmp ATL/temp1.bmp -resize %resolutionW% -append -gravity north -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_silverware.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause