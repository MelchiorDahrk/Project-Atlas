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
for /f %%i in ('magick convert Tx_V_floor_01.* -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%
set /A resolutionH=%resolutionW%*8

magick convert Tx_block_adobe_redbrown_01.* Tx_block_adobe_redbrown_01.* +append ATL/temp1.bmp

for /f %%i in ('magick convert Tx_V_bridgedetail_04.* -format %%h info:') do set resolutionBH=%%i
for /f %%i in ('magick convert Tx_V_bridgedetail_04.* -format %%w info:') do set resolutionBW=%%i
if "%resolutionBH%" NEQ "%resolutionBW%" (
	magick convert Tx_V_bridgedetail_04.* -gravity north -background black -extent x%resolutionBW% Tx_V_bridgedetail_04.bmp
)
magick convert Tx_V_bridgedetail_04.* Tx_V_bridgedetail_04.* +append ATL/temp2.bmp

magick convert tx_v_base_08.* tx_v_base_01.* tx_wall_adobe_brown_02.* ATL/temp1.bmp tx_v_strip_01.* tx_v_b_base_01.* tx_v_strip_04.* tx_v_strip_03.* tx_v_floor_01.* ATL/temp2.bmp tx_v_bridgedetail_03.* tx_v_bridgedetail_02.* tx_v_bridgedetail_01.* -resize %resolutionW% -append -gravity south -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_velothi_01.dds

magick convert tx_v_strip_02.* tx_v_base_09.* tx_v_base_07.* tx_v_base_04.* tx_v_base_02.* tx_v_base_10.* tx_v_entcover_01.* -resize %resolutionW% -append -gravity south -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_velothi_02.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
