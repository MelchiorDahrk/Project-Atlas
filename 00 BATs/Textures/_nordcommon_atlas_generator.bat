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

magick convert tx_brickedge_left_01.dds tx_brickedge_right_01.dds -resize x%resolutionW% +append -rotate "90" ATL/temp1.bmp
magick convert tx_roofedge_01.dds -rotate "90" ATL/temp2.bmp
magick convert tx_thatch_01.dds -rotate "90" ATL/temp3.bmp
magick convert tx_wall_stuccostone_el_01.dds tx_wall_stuccostone_e_02.dds tx_wall_stuccostone_er_01.dds -resize x%resolutionW% +append -rotate "90" ATL/temp4.bmp
magick convert tx_window_diamond_01.dds tx_window_diamond_01.dds -append -rotate "270" ATL/temp5.bmp
magick convert tx_metal_strip_01.dds tx_metal_strip_01.dds +append ATL/temp6.bmp

magick convert tx_stucco_imp_02.dds tx_stucco_imp_01.dds tx_wall_brick_imp_01.dds ATL/temp1.bmp tx_shingles_01.dds ATL/temp2.bmp tx_rooftop_01.dds ATL/temp3.bmp tx_wall_stuccostone_01.dds ATL/temp4.bmp tx_wall_stone_02.dds ATL/temp5.bmp ATL/temp6.bmp ATL/temp6.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_nordcommon_atlas.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
del "temp6.bmp"
cd..

if not defined run_without_pause pause
