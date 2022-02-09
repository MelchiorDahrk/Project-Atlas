@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_v_st_statue_03.* -format %%w info:') do set resolutionW=%%i

magick convert tx_v_st_statue_10.* tx_v_st_statue_11.* tx_v_st_statue_05.* tx_v_st_statue_07.* -append ATL/temp2.bmp
magick convert tx_v_st_statue_04.* tx_v_st_statue_08.* -append ATL/temp3.bmp
magick convert ATL/temp3.bmp ATL/temp2.bmp ATL/temp2.bmp +append ATL/temp4.bmp

magick convert tx_v_st_statue_03.* tx_v_st_statue_09.* tx_v_st_statue_01.* tx_v_st_statue_02.* ATL/temp4.bmp -append -resize %resolutionW% -define dds:compression=dxt1 ATL/atlad_stat_saints.dds

cd ATL
del "temp2.bmp"
del "temp3.bmp"
del "temp4.bmp"
cd ..

if not defined run_without_pause pause
