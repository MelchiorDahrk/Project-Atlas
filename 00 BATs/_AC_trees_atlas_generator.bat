@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_mushroom_01.dds -format %%w info:') do set resolutionW=%%i

magick convert Tx_mushroom_03.dds Tx_mushroom_03.dds +append ATL/temp1.bmp
magick convert Tx_mushroom_05.dds Tx_mushroom_05.dds +append ATL/temp2.bmp

magick convert Tx_mushroom_01.dds Tx_mushroom_02.dds Tx_mushroom_04.dds ATL/temp1.bmp ATL/temp2.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_tree_ac.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
