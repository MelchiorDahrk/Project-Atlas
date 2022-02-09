@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_skeleton_skull.* -format %%w info:') do set resolutionW=%%i
set /A resolutionHf=%resolutionW%/2
set /A resolutionQtr=%resolutionW%/4

magick convert tx_skeleton_ribcage01.* -resize %resolutionW% -append ATL/temprib.bmp
magick convert tx_skeleton_skull.* ATL/temprib.bmp -append ATL/temp1.bmp

magick convert tx_skeleton_scapula.* tx_skeleton_clavicle.* tx_skeleton_foot01.* -resize %resolutionQtr% -append ATL/temp2.bmp

magick convert tx_skeleton_spine.* -resize 50%%x100%% +append ATL/temp3.bmp
magick convert ATL/temp3.bmp ATL/temp2.bmp -resize %resolutionQtr% +append ATL/temp4.bmp
magick convert tx_skeleton_jaw.* -resize 100%%x50%% +append ATL/temp5.bmp
magick convert tx_skeleton_radius.* tx_skeleton_sacrum.* -resize %resolutionQtr% +append ATL/temp6.bmp
magick convert ATL/temp5.bmp ATL/temp6.bmp -append ATL/temp7.bmp
magick convert ATL/temp4.bmp ATL/temp7.bmp +append ATL/temp8.bmp
magick convert tx_skeleton_hipbone.* tx_skeleton_hand.* -resize %resolutionHf% +append ATL/temp9.bmp
magick convert ATL/temp1.bmp ATL/temp8.bmp ATL/temp9.bmp -append -define dds:compression=dxt1 ATL/atlad_Skeleton.dds

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
del "temprib.bmp"
cd ..

if not defined run_without_pause pause