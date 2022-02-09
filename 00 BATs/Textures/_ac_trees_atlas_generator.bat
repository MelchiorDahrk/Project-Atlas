@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_mushroom_01.* -format %%w info:') do set resolutionW=%%i

magick convert Tx_mushroom_03.* Tx_mushroom_03.* +append ATL/temp1.bmp
magick convert Tx_mushroom_05.* Tx_mushroom_05.* +append ATL/temp2.bmp

magick convert Tx_mushroom_01.* Tx_mushroom_02.* Tx_mushroom_04.* ATL/temp1.bmp ATL/temp2.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_tree_ac.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
