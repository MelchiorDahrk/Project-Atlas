@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert TX_A_Eidelons_towershield.dds -format %%H info:') do set resolutionH=%%i

magick convert TX_A_Eidelons_towershield02.dds TX_A_Eidelons_towershield02.dds +append ATL/temp1.bmp

magick convert TX_A_Eidelons_towershield01.dds Tx_A_shieldgrip.dds ATL/temp1.bmp ATL/temp1.bmp -append ATL/temp2.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp -append ATL/temp3.bmp

magick convert TX_A_Eidelons_towershield.dds ATL/temp2.bmp ATL/temp3.bmp +append -define dds:compression=dxt1 ATL/atlad_a_eleidon.dds

cd ATL
del temp1.bmp
del temp2.bmp
del temp3.bmp
cd ..

if not defined run_without_pause pause
