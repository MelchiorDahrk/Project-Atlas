@echo off
REM What you should edit. The texture will be resized by 2^resizeLevel i.e. resizeLevel of 2 and the 1024px wide textures will result in atlas reduced four times and thus 256px wide.
set resizeLevel=0

REM Don't touch anything below unless you understand what you are doing.

set resize=1
IF /I %resizeLevel% GEQ 1 (
	set base=2
	FOR /L %%i IN (1,1,%resizeLevel%) DO SET /A resize*=base
)

if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_dragonstatue_head.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%

set /A resolutionE=%resolutionW%/2

magick convert tx_dragonstatue_eye.dds -gravity Northwest -background black -extent %resolutionE%x%resolutionE% ATL/temp1.bmp
magick convert tx_dragonstatue_body.dds ATL/temp1.bmp -resize %resolutionE% -append ATL/temp2.bmp
magick convert tx_dragonstatue_foot.dds ATL/temp2.bmp -resize x%resolutionW% +append ATL/temp3.bmp
magick convert tx_dragonstatue_metal_1.dds tx_dragonstatue_metal_1.dds -resize x%resolutionE% +append ATL/temp4.bmp
magick convert tx_dragonstatue_metal2.dds tx_dragonstatue_metal2.dds -resize x%resolutionE% +append ATL/temp5.bmp
magick convert tx_dragonstatue_metal3.dds tx_marble_black.dds -resize x%resolutionE% +append ATL/temp6.bmp

magick convert ATL/temp3.bmp tx_dragonstatue_head.dds tx_dragonstatue_leg.dds ATL/temp4.bmp ATL/temp5.bmp ATL/temp6.bmp tx_dragonstatue_wing.dds -resize %resolutionW% -append -gravity north -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/tx_drag_stat_atlas.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
del "temp6.bmp"
cd ..

if not defined run_without_pause pause

