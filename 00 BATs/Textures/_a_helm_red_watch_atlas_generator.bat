@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_A_watchmanHelm.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_A_watchmanHelm.dds tx_A_watchmanHelm01.dds -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_a_helm_red_watch.dds

if not defined run_without_pause pause
