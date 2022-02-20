@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_siltstrider_skin_00.* -format %%w info:') do set resolutionW=%%i

magick convert tx_siltstrider_skin_00.* tx_siltstrider_skin_01.* -append ATL/temp1.bmp
magick convert tx_siltstrider_skin_04.* tx_siltstrider_skin_04.* -rotate 90 +append ATL/temp2.bmp
magick convert tx_siltstrider_skin_07.* tx_siltstrider_skin_07.* -rotate 90 +append ATL/temp3.bmp
magick convert tx_siltstrider_skin_02.* tx_siltstrider_skin_03.* +append ATL/temp4.bmp
magick convert tx_siltstrider_stem_01.* tx_siltstrider_stem_01.* -append ATL/temp5.bmp
magick convert ATL/temp5.bmp tx_siltstrider_stem_00.* -layers merge -gravity north -append ATL/temp6.bmp
magick convert tx_siltstrider_skin_09.* tx_siltstrider_skin_12.* -append ATL/temp7.bmp
magick convert tx_siltstrider_skin_11.* -rotate -90 +append ATL/temp8.bmp
magick convert tx_siltstrider_skin_08.* tx_siltstrider_skin_13.* tx_siltstrider_skin_13.* ATL/temp8.bmp -rotate 90 +append ATL/temp9.bmp
magick convert tx_siltstrider_skin_05.* tx_siltstrider_skin_05.* -append ATL/temp10.bmp 
magick convert ATL/temp10.bmp ATL/temp10.bmp ATL/temp10.bmp tx_siltstrider_skin_06.* +append ATL/temp11.bmp
magick convert ATL/temp6.bmp ATL/temp7.bmp tx_creature_duskyalit_09.* +append ATL/temp12.bmp
 
magick convert ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp ATL/temp4.bmp ATL/temp12.bmp ATL/temp9.bmp ATL/temp11.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_siltstrider.dds

magick convert tx_siltstrider_dead_02.* tx_siltstrider_dead_03.* +append ATL/temp110.bmp
magick convert tx_siltstrider_dead_04.* tx_siltstrider_dead_04.* -rotate 90 +append ATL/temp120.bmp
magick convert tx_siltstrider_dead_05.* tx_siltstrider_dead_05.* -append ATL/temp130.bmp
magick convert tx_siltstrider_dead_06.* tx_siltstrider_dead_11.* ATL/temp130.bmp ATL/temp130.bmp +append ATL/temp140.bmp

magick convert tx_siltstrider_dead_00.* tx_siltstrider_dead_01.* ATL/temp110.bmp tx_siltstrider_dead_07.* ATL/temp120.bmp ATL/temp140.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_siltstrider_d.dds

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
del "temp110.bmp"
del "temp120.bmp"
del "temp130.bmp"
del "temp140.bmp"
cd ..

if not defined run_without_pause pause