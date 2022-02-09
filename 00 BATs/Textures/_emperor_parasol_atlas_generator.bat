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
for /f %%i in ('magick convert tx_emperor_parasol_01.* -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%

magick convert tx_emperor_parasol_02.* tx_emperor_parasol_02.* +append ATL/temp1.bmp
magick convert tx_emperor_parasol_03.* tx_emperor_parasol_03.* tx_emperor_parasol_03.* tx_emperor_parasol_03.* +append ATL/temp2.bmp

magick convert tx_emperor_parasol_01.* ATL/temp1.bmp ATL/temp2.bmp ATL/temp2.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_parasol_atlas.dds

cd ATL
del "temp1.bmp"
del "temp2.bmp"
cd ..

if not defined run_without_pause pause
