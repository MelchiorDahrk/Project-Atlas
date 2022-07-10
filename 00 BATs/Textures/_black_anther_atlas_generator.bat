@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_black_anther_01.dds -format %%w info:') do set resolutionW=%%i

magick convert Tx_bittergreen_01.dds Tx_black_anther_03.dds -gravity north -composite +append ATL/temp1.bmp

magick convert Tx_black_anther_01.dds Tx_black_anther_02.dds ATL/temp1.bmp +append -define dds:compression=dxt1 ATL/atlad_black_anther.dds

cd ATL
del temp1.bmp
cd ..

if not defined run_without_pause pause
