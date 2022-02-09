@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_ashtree_bark_01.* -format %%w info:') do set resolutionW=%%i

magick convert tx_ashtree_bark_02.* tx_ashtree_bark_02.* +append ATL/temp1.bmp

magick convert tx_ashtree_bark_03.* tx_ashtree_bark_03.* -append ATL/temp2.bmp
magick convert ATL/temp2.bmp Atl/temp2.bmp ATL/temp2.bmp ATL/temp2.bmp +append ATL/temp3.bmp

magick convert tx_ashtree_bark_01.* ATL/temp1.bmp ATL/temp3.bmp -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_ashtree.dds

cd "ATL"
del temp1.bmp
del temp2.bmp
del temp3.bmp
cd ..

if not defined run_without_pause pause