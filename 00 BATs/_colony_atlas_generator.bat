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
for /f %%i in ('magick convert tx_colony_wood09.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%
set /A resolutionH=%resolutionW%*8

magick convert tx_colony_wood01.dds tx_colony_wood02.dds tx_colony_wood06.dds +append ATL/temp1.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp -rotate 90 +append ATL/temp2.bmp
magick convert tx_colony_wood12.dds tx_colony_wood12.dds tx_colony_wood13.dds tx_colony_wood13.dds -rotate -90 +append ATL/temp3.bmp
magick convert tx_colony_wood14.dds tx_colony_wood14.dds +append ATL/temp4.bmp
magick convert tx_colony_woodpanel01.dds tx_colony_woodpanel02.dds +append ATL/temp5.bmp
magick convert tx_colony_woodpanel04.dds tx_colony_woodpanel05.dds -append ATL/temp6.bmp
magick convert ATL/temp6.bmp ATL/temp6.bmp +append ATL/temp7.bmp
magick convert tx_colony_base.dds tx_colony_base.dds tx_colony_base.dds tx_colony_base.dds +append ATL/temp8.bmp
magick convert tx_colony_wooddoor02.dds tx_colony_wooddoor01.dds +append ATL/temp9.bmp
magick convert tx_colony_wood05.dds tx_colony_wood07.dds +append ATL/temp10.bmp
magick convert tx_colony_wood10.dds -rotate 90 +append ATL/temp11.bmp

magick convert ATL/temp2.bmp tx_colony_wood03.dds tx_colony_wood04.dds tx_colony_wood08.dds ATL/temp11.bmp ATL/temp3.bmp ATL/temp4.bmp tx_colony_wood11.dds tx_colony_wood09.dds tx_colony_wood15.dds ATL/temp5.bmp tx_colony_woodpanel03.dds ATL/temp7.bmp ATL/temp8.bmp ATL/temp9.bmp tx_colony_floor01.dds tx_colony_floor02.dds ATL/temp10.bmp -background "#180800" -gravity northwest -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_colony_wood.dds

set /A resolutionH=%resolutionW%*4
magick convert tx_colony_chemney.dds tx_colony_chemney03.dds tx_colony_chemney04.dds -append ATL/temp15.bmp
magick convert tx_colony_chemney05.dds tx_colony_chemney08.dds tx_colony_chemney07.dds -append ATL/temp12.bmp
magick convert ATL/temp15.bmp ATL/temp12.bmp +append ATL/temp13.bmp
magick convert tx_colony_roof02.dds tx_colony_roof03.dds +append ATL/temp14.bmp

magick convert tx_colony_roof.dds ATL/temp14.bmp tx_colony_roof04.dds ATL/temp13.bmp tx_colony_icecles01.dds tx_colony_icecles02.dds -background "rgba(0, 0, 0, 0.0)" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt5 ATL/atlad_colony_roof.dds


for /f %%i in ('magick convert tx_colony_stone01.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionW=%resolutionW%/%resize%
set /A resolutionH=%resolutionW%*8

magick convert tx_colony_rock01.dds tx_colony_rock01.dds tx_colony_rock02.dds tx_colony_rock03.dds tx_colony_rock04.dds -append ATL/temp16.bmp
magick convert ATL/temp16.bmp ATL/temp16.bmp +append ATL/temp17.bmp
magick convert ATL/temp17.bmp tx_colony_stone01.dds tx_colony_stone01.dds tx_colony_stone02.dds tx_colony_stone03.dds tx_colony_stone03.dds -background "#5a5b56" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_colony_rock.dds


cd ATL
del "temp1.bmp"
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
del "temp5.bmp"
del "temp6.bmp"
del "temp7.bmp"
del "temp8.bmp"
del "temp9.bmp"
del "temp10.bmp"
del "temp11.bmp"
del "temp12.bmp"
del "temp13.bmp"
del "temp14.bmp"
del "temp15.bmp"
del "temp16.bmp"
del "temp17.bmp"
del "temp18.bmp"
cd ..

if not defined run_without_pause pause