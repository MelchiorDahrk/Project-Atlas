@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_hull09.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_wood_hull09.dds tx_wood_hull10.dds tx_wood_hull11.dds tx_wood_hull12.dds tx_wood_hull13.dds tx_wood_hull14.dds tx_wood_hull15.dds tx_wood_hull16.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_ship_hull.dds

if not defined run_without_pause pause