@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_marshmerrow_03.* -format %%w info:') do set resolutionW=%%i

magick convert Tx_marshmerrow_03.* Tx_marshmerrow_02.* -gravity east -background black -composite -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_marshmerrow.dds

if not defined run_without_pause pause
