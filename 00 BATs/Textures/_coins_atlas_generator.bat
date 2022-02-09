@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_cointop_01.* -format %%w info:') do set resolutionW=%%i

magick convert tx_coinside_01.* tx_coinside_01.* tx_coinside_01.* tx_coinside_01.* -rotate 90 +append ATL/temp1.bmp
magick convert tx_dwrv_coin10.* tx_dwrv_coin10.* +append ATL/temp2.bmp

magick convert tx_cointop_01.* ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp tx_dwrv_coin00.* ATL/temp2.bmp ATL/temp2.bmp -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_coins.dds

cd ATL
del temp1.bmp
del temp2.bmp
cd ..

if not defined run_without_pause pause