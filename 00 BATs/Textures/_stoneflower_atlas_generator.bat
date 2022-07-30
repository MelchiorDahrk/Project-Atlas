@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_bittergreen_01.* -format %%w info:') do set resolutionW=%%i

magick convert Tx_bittergreen_01.* -fill "#1b581f" -colorize 17 -crop 25%%x50% ATL/stem.bmp
magick convert Tx_stoneflower_01.* ATL/stem-4.bmp -gravity southwest +composite ATL/temp2.bmp
magick convert ATL/temp2.bmp Tx_stoneflower_02.* +append ATL/atlad_stoneflower.bmp

cd ATL
del stem-0.bmp
del stem-1.bmp
del stem-2.bmp
del stem-3.bmp
del stem-4.bmp
del stem-5.bmp
del stem-6.bmp
del stem-7.bmp
del temp2.bmp
if not defined run_without_pause pause