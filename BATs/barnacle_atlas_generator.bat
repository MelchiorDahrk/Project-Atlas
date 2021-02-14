@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_barnacle_01.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_barnacle_01.dds tx_barnacle_02.dds -resize %resolutionW% -append -gravity south -define dds:compression=dxt1 ATL/atlad_barnacle.dds
