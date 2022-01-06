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
for /f %%i in ('magick convert Tx_V_floor_01.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%
set /A resolutionH=%resolutionW%*16

magick convert Tx_block_adobe_redbrown_01.dds Tx_block_adobe_redbrown_01.dds +append ATL/temp1.bmp
for /f %%i in ('magick convert Tx_V_bridgedetail_04.dds -format %%h info:') do set resolutionBH=%%i
for /f %%i in ('magick convert Tx_V_bridgedetail_04.dds -format %%w info:') do set resolutionBW=%%i
if "%resolutionBH%" NEQ "%resolutionBW%" (
	magick convert Tx_V_bridgedetail_04.dds -define dds:compression=dxt1 -gravity north -background black -extent x%resolutionBW% Tx_V_bridgedetail_04.dds
)

magick convert Tx_V_bridgedetail_04.dds Tx_V_bridgedetail_04.dds +append ATL/temp2.bmp
magick convert tx_v_bridgedetail_02.dds ATL/temp1.bmp ATL/temp2.bmp Tx_V_floor_01.dds Tx_V_entcover_01.dds Tx_V_bridgedetail_03.dds Tx_V_bridgedetail_01.dds Tx_V_base_10.dds Tx_V_base_09.dds Tx_V_base_07.dds Tx_V_base_04.dds Tx_V_base_02.dds Tx_V_base_01.dds Tx_V_strip_02.dds Tx_V_strip_04.dds Tx_V_strip_03.dds Tx_V_strip_01.dds Tx_V_base_08.dds Tx_wall_adobe_brown_02.dds Tx_V_B_base_01.dds -resize %resolutionW% -append -gravity south -background black -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_velothi.dds
cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
