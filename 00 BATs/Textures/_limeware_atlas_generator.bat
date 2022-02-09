@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_limeware_platter.* -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%*2
for /f %%i in ('magick convert tx_limeware_platter.* -format %%h info:') do set resolutionH=%%i

for /f %%i in ('magick convert tx_limeware_strip_01.* -format %%h info:') do set lwStripH=%%i
set /A lwStripH=lwStripH/7

magick convert tx_limeware_strip_01.* -crop %lwStripW%x%lwStripH%+0+0 -rotate 90 +append ATL/temp1.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp -append ATL/temp2.bmp
magick convert Atl/temp2.bmp -resize x%resolutionH% -append ATL/temp2.bmp
magick convert tx_limeware_platter.* tx_limeware_platter_01.* ATL/temp2.bmp +append ATL/temp3.bmp

magick convert ATL/temp3.bmp -resize %resolutionW%! +append -define dds:compression=dxt1 ATL/atlad_lwplatter.dds


for /f %%i in ('magick convert tx_limeware_top.* -format %%w info:') do set resolutionW=%%i

magick convert tx_limeware_strip_01.* tx_limeware_strip_02.* tx_limeware_strip_03.* -append ATL/temp4.bmp
magick convert ATL/temp4.bmp ATL/temp4.bmp +append ATL/temp5.bmp
magick convert ATL/temp5.bmp tx_limeware_top.* tx_limeware_top.* -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_lw.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
cd ..

if not defined run_without_pause pause