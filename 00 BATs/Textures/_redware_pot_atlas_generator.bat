@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_item_pot_redware_01.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_item_pot_redware_03.dds tx_item_pot_redware_03.dds +append ATL/temp1.bmp

magick convert tx_item_pot_redware_02.dds tx_item_pot_redware_02.dds +append ATL/temp2.bmp

magick convert tx_item_pot_orange_green.dds ATL/temp1.bmp ATL/temp2.bmp tx_item_pot_redware_01.dds tx_item_pot_redware_01.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_item_pot_redware_atlas.dds
cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
