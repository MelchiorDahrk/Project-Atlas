@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_barnacle_01.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_bm_ic_cavedoor_02.dds -rotate 90 +append ATL/temp1.bmp

magick convert tx_bm_ic_cavedoor_01.dds ATL/temp1.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_bm_cavedoor.dds

cd ATL
del "temp1.bmp"
cd ..

if not defined run_without_pause pause