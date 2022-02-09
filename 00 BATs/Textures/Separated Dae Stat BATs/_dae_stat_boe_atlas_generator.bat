@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.* -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_boethiah_fronttorso.* tx_daed_boethiah_hand.* -gravity southwest -composite -append ATL/boe00.bmp
magick convert tx_daed_boethiah_frontskirt.* tx_daed_boethiah_backskirt.* +append ATL/boe01.bmp
magick convert ATL/boe00.bmp tx_daed_boethiah_backtorso.* tx_daed_boethiah_face.* tx_daed_boethiah_hair.* -append ATL/boe02.bmp
magick convert tx_daed_boethiah_axe.* tx_daed_boethiah_cape.* ATL/boe01.bmp -append ATL/boe03.bmp

magick convert ATL/boe02.bmp ATL/boe03.bmp -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe.dds

magick convert tx_daed_boethiah_pauldron.* tx_daed_boethiah_feet.* tx_daed_boethiah_upperleg.* tx_daed_boethiah_lowerleg.* -append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe01.dds

cd ATL
del boe00.bmp
del boe01.bmp
del boe02.bmp
del boe03.bmp
cd ..

if not defined run_without_pause pause