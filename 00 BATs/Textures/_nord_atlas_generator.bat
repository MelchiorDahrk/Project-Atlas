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
for /f %%i in ('magick convert tx_wall_stuccostone_01.dds -format %%w info:') do set resolutionW=%%i

set /A resolutionW=%resolutionW%/%resize%

set /A resolutionT=%resolutionW%*3

magick convert tx_wall_stuccostone_el_01.dds tx_wall_stuccostone_e_02.dds tx_wall_stuccostone_er_01.dds -resize x%resolutionW% +append -rotate "90" ATL/temp1.bmp
magick convert "tx_stone _right_01.dds" "tx_stone _mid_01.dds" "tx_stone _left_01.dds" -resize x%resolutionW% +append -rotate "90" ATL/temp2.bmp

magick convert tx_wall_stuccostone_01.dds ATL/temp1.bmp tx_wall_stone_01.dds ATL/temp2.bmp -resize %resolutionW% -append -gravity north -background black -extent x%resolutionT% ATL/temp3.bmp
magick convert tx_thatch_01.dds -rotate "180" ATL/temp4.bmp

magick convert ATL/temp3.bmp ATL/temp4.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_nord_atlas.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
cd..

if not defined run_without_pause pause
