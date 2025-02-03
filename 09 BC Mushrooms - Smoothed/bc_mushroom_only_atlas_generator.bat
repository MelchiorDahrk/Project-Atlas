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
for /f %%i in ('magick convert tx_bc_mushroom_01.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%

magick convert tx_bc_mushroom_03.dds tx_bc_mushroom_03.dds +append ATL/temp1.bmp

magick convert tx_bc_mushroom_04.dds tx_bc_mushroom_01.dds tx_bc_mushroom_02.dds tx_bc_mushroom_02.dds ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_bc_mushroom_only_atlas.dds

cd ATL
del "temp1.bmp"
cd ..

pause