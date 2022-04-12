@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_willow_flower_03.* -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%*2

magick convert Tx_willow_flower_01.* Tx_willow_flower_03.* Tx_bittergreen_01.* +append -define dds:compression=dxt1 ATL/atlad_willow_flower.dds

if not defined run_without_pause pause
