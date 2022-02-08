@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_siltstrider_skin_00.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_siltstrider_skin_00.dds tx_siltstrider_skin_01.dds -append ATL/temp1.bmp
magick convert tx_siltstrider_skin_04.dds tx_siltstrider_skin_04.dds -rotate 90 +append ATL/temp2.bmp
magick convert tx_siltstrider_skin_07.dds tx_siltstrider_skin_07.dds -rotate 90 +append ATL/temp3.bmp
magick convert tx_siltstrider_skin_02.dds tx_siltstrider_skin_03.dds +append ATL/temp4.bmp
magick convert tx_siltstrider_stem_01.dds tx_siltstrider_stem_01.dds -append ATL/temp5.bmp
magick convert ATL/temp5.bmp tx_siltstrider_stem_00.dds -layers merge -gravity north -append ATL/temp6.bmp
magick convert tx_siltstrider_skin_09.dds tx_siltstrider_skin_12.dds -append ATL/temp7.bmp
magick convert tx_siltstrider_skin_11.dds -rotate -90 +append ATL/temp8.bmp
magick convert tx_siltstrider_skin_08.dds tx_siltstrider_skin_13.dds tx_siltstrider_skin_13.dds ATL/temp8.bmp -rotate 90 +append ATL/temp9.bmp
magick convert tx_siltstrider_skin_05.dds tx_siltstrider_skin_05.dds -append ATL/temp10.bmp 
magick convert ATL/temp10.bmp ATL/temp10.bmp ATL/temp10.bmp tx_siltstrider_skin_06.dds +append ATL/temp11.bmp
magick convert ATL/temp6.bmp ATL/temp7.bmp tx_creature_duskyalit_09.dds +append ATL/temp12.bmp
 
magick convert ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp ATL/temp4.bmp ATL/temp12.bmp ATL/temp9.bmp ATL/temp11.bmp -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_siltstrider.dds

magick convert tx_siltstrider_dead_02.dds tx_siltstrider_dead_03.dds +append ATL/temp110.bmp
magick convert tx_siltstrider_dead_04.dds tx_siltstrider_dead_04.dds -rotate 90 +append ATL/temp120.bmp
magick convert tx_siltstrider_dead_05.dds tx_siltstrider_dead_05.dds -append ATL/temp130.bmp
magick convert tx_siltstrider_dead_06.dds tx_siltstrider_dead_11.dds ATL/temp130.bmp ATL/temp130.bmp +append ATL/temp140.bmp

magick convert tx_siltstrider_dead_00.dds tx_siltstrider_dead_01.dds ATL/temp110.bmp tx_siltstrider_dead_07.dds ATL/temp120.bmp ATL/temp140.bmp -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_siltstrider_d.dds

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