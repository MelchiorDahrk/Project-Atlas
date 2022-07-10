@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wicker_brown_02.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_wicker_brown_02.dds tx_wicker_brown_02.dds tx_rope_heavy.dds tx_wicker_border_01.dds -gravity north -background "#574b33" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_furn_basket.dds

if not defined run_without_pause pause