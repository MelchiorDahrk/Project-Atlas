@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_daed_sheogorath_torso01.* tx_daed_sheogorath_torso02.* +append ATL/sheo1.bmp
magick convert tx_daed_sheogorath_lowerpant01.* tx_daed_sheogorath_sleeve01.* +append ATL/sheo2.bmp
magick convert tx_daed_sheogorath_head.* tx_daed_sheogorath_shoe01.* +append ATL/sheo3.bmp
magick convert tx_daed_sheogorath_hand.* tx_daed_sheogorath_ear.* tx_daed_sheogorath_ear.* tx_daed_sheogorath_shoe01.* -background "#3e3433" +append -gravity west ATL/sheo4.bmp

magick convert ATL/sheo1.bmp ATL/sheo2.bmp ATL/sheo3.bmp ATL/sheo4.bmp -resize %resolutionW% -append -gravity northwest -background "#3e3433" -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_dae_sheo.dds

cd ATL
del sheo1.bmp
del sheo2.bmp
del sheo3.bmp
del sheo4.bmp
cd ..

if not defined run_without_pause pause