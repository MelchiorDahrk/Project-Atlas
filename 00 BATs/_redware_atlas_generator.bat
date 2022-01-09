@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_redware_button.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_redware_strip_02.dds tx_redware_strip_02.dds tx_redware_strip_02.dds tx_redware_strip_02.dds +append ATL/temp1.bmp

magick convert tx_redware_stripes.dds tx_redware_stripes.dds tx_redware_stripes.dds tx_redware_stripes.dds +append ATL/temp2.bmp

magick convert tx_redware_strip_01.dds tx_redware_strip_01.dds +append ATL/temp3.bmp

magick convert ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp tx_redware_button.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_redware_atlas.dds
cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
cd ..

if not defined run_without_pause pause
