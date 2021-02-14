@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_skeleton_skull.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_skeleton_skull.dds tx_skeleton_ribcage01.dds -append ATL/temp1.bmp
magick convert tx_skeleton_scapula.dds tx_skeleton_clavicle.dds tx_skeleton_foot01.dds -append ATL/temp2.bmp
magick convert tx_skeleton_spine.dds -resize 50%%x100%% +append ATL/temp3.bmp
magick convert ATL/temp3.bmp ATL/temp2.bmp +append ATL/temp4.bmp
magick convert tx_skeleton_jaw.dds -resize 100%%x50%% +append ATL/temp5.bmp
magick convert tx_skeleton_radius.dds tx_skeleton_sacrum.dds +append ATL/temp6.bmp
magick convert ATL/temp5.bmp ATL/temp6.bmp -append ATL/temp7.bmp
magick convert ATL/temp4.bmp ATL/temp7.bmp +append ATL/temp8.bmp
magick convert tx_skeleton_hipbone.dds tx_skeleton_hand.dds +append ATL/temp9.bmp
magick convert ATL/temp1.bmp ATL/temp8.bmp ATL/temp9.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_Skeleton.dds.dds

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
