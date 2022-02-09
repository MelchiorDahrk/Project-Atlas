@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_hull09.* -format %%w info:') do set resolutionW=%%i

magick convert tx_wood_hull09.* tx_wood_hull10.* tx_wood_hull11.* tx_wood_hull12.* tx_wood_hull13.* tx_wood_hull14.* tx_wood_hull15.* tx_wood_hull16.* -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_ship_hull.dds

if not defined run_without_pause pause