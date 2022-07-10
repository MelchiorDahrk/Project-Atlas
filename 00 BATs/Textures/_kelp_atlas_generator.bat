@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_kelp_03.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2
magick convert tx_kelp_02.dds -rotate 90 +append ATL/temp1.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp tx_kelp_04.dds -append ATL/temp2.bmp
magick convert ATL/temp2.bmp ATL/temp2.bmp ATL/temp2.bmp ATL/temp2.bmp +append ATL/temp3.bmp
magick convert tx_kelp_01.dds -rotate 90 +append ATL/temp4.bmp

magick convert tx_kelp_03.dds ATL/temp4.bmp ATL/temp3.bmp -append -gravity north -background "#26280d" -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_kelp.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
cd ..

if not defined run_without_pause pause