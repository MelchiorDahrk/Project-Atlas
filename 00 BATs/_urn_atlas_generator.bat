@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_urn_01.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_urn_plain_01.dds tx_urn_plain_01.dds +append ATL/temp1.bmp

magick convert tx_urn_01.dds tx_urn_01.dds tx_urn_top_01.dds ATL/temp1.bmp tx_urn_strip_01.dds tx_urn_strip_01.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_urns_atlas.dds
cd ATL
del "temp1.bmp"
cd ..

if not defined run_without_pause pause
