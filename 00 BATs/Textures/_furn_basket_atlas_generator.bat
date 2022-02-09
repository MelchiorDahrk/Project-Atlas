@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wicker_brown_02.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_wicker_brown_02.* tx_wicker_brown_02.* tx_rope_heavy.* tx_wicker_border_01.* -gravity north -background "#574b33" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_furn_basket.dds

if not defined run_without_pause pause