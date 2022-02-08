@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_daed_sheogorath_torso01.dds tx_daed_sheogorath_torso02.dds +append ATL/sheo1.bmp
magick convert tx_daed_sheogorath_lowerpant01.dds tx_daed_sheogorath_sleeve01.dds +append ATL/sheo2.bmp
magick convert tx_daed_sheogorath_head.dds tx_daed_sheogorath_shoe01.dds +append ATL/sheo3.bmp
magick convert tx_daed_sheogorath_hand.dds tx_daed_sheogorath_ear.dds tx_daed_sheogorath_ear.dds tx_daed_sheogorath_shoe01.dds -background "#3e3433" +append -gravity west ATL/sheo4.bmp

magick convert ATL/sheo1.bmp ATL/sheo2.bmp ATL/sheo3.bmp ATL/sheo4.bmp -resize %resolutionW% -append -gravity northwest -background "#3e3433" -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_dae_sheo.dds

cd ATL
del sheo1.bmp
del sheo2.bmp
del sheo3.bmp
del sheo4.bmp
cd ..

if not defined run_without_pause pause