@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_hlaalu_wall2_01.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*4
magick convert tx_hlaalu_wall2_01.* tx_hlaalu_wall2_02.* tx_hlaalu_wall2_03.* tx_hlaalu_sideedge_01.* tx_hlaalu_topedge_01.* tx_hlaalu_topedge_02.* tx_hlaalu_topedge_03.* -resize %resolutionW% -append -gravity north -background black -extent x%resolutionH%  -define dds:compression=dxt1 ATL/tx_hlaalu_atlas.dds

if not defined run_without_pause pause
