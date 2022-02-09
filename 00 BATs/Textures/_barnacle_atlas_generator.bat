@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_barnacle_01.* -format %%w info:') do set resolutionW=%%i

magick convert tx_barnacle_01.* tx_barnacle_02.* -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_barnacle.dds

if not defined run_without_pause pause