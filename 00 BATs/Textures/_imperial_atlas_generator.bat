@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert Tx_imp_floor_01.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_imp_block_01.dds tx_imp_block_02.dds tx_imp_block_03.dds tx_imp_block_03.dds +append ATL/temp1.bmp

magick convert Tx_imp_botfront_01.dds Tx_imp_botfront_01.dds -append ATL/temp2.bmp
magick convert Tx_imp_botside_01.dds Tx_imp_botside_01.dds -append ATL/temp3.bmp
magick convert ATL/temp2.bmp ATL/temp3.bmp +append -rotate "90" ATL/temp4.bmp
magick convert Tx_imp_colthin_01.dds Tx_imp_colthin_02.dds Tx_imp_colwide_01.dds +append -rotate "90" ATL/temp5.bmp
magick convert Tx_imp_foursquares_01.dds Tx_imp_foursquares_01.dds +append ATL/temp6.bmp
magick convert Tx_imp_full_01.dds Tx_imp_full_01.dds +append ATL/temp7.bmp
magick convert Tx_imp_half_01.dds Tx_imp_half_01.dds Tx_imp_half_01.dds Tx_imp_half_01.dds +append ATL/temp8.bmp
magick convert Tx_imp_midfront_01.dds Tx_imp_midside_01.dds +append ATL/temp9.bmp
magick convert ATL/temp9.bmp ATL/temp9.bmp ATL/temp9.bmp ATL/temp9.bmp -append -rotate "90" ATL/temp10.bmp
magick convert Tx_imp_plain_01.dds Tx_imp_plain_01.dds +append ATL/temp11.bmp
magick convert Tx_imp_stripdark_01.dds Tx_imp_stripdark_01.dds +append ATL/temp12.bmp
magick convert Tx_imp_stripmed_01.dds Tx_imp_stripmed_01.dds +append ATL/temp13.bmp
magick convert Tx_imp_topfront_01.dds Tx_imp_topside_01.dds +append ATL/temp14.bmp
magick convert ATL/temp14.bmp ATL/temp14.bmp -append -rotate "90" ATL/temp15.bmp

magick convert tx_imp_archtop_01.dds ATL/temp1.bmp ATL/temp4.bmp Tx_imp_ceiling_01.dds Tx_imp_ceiling_strip_01.dds Tx_imp_ceiling_strip_02.dds  ATL/temp5.bmp Tx_imp_floor_01.dds Tx_imp_floor_02.dds ATL/temp6.bmp ATL/temp7.bmp ATL/temp8.bmp ATL/temp10.bmp ATL/temp11.bmp Tx_imp_step_01.dds Tx_imp_step_02.dds Tx_imp_step_03.dds Tx_imp_step_04.dds Tx_imp_step_05.dds Tx_imp_step_06.dds Tx_imp_step_06.dds ATL/temp12.bmp ATL/temp13.bmp ATL/temp15.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_imperial_atlas1.dds

magick convert Tx_imp_wall_01.dds Tx_imp_wall_02.dds Tx_imp_wall_03.dds Tx_imp_walltop_01.dds Tx_imp_walltop_01.dds Tx_imp_walltop_01.dds Tx_imp_walltop_01.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/tx_imperial_atlas2.dds

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
cd..

if not defined run_without_pause pause
