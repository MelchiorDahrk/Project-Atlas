@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_marshmerrow_03.dds -format %%w info:') do set resolutionW=%%i

magick convert Tx_marshmerrow_03.dds Tx_marshmerrow_02.dds -gravity east -background black -composite -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_marshmerrow.dds

if not defined run_without_pause pause
