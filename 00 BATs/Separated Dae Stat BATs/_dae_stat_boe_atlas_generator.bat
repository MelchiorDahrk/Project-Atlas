@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_boethiah_fronttorso.dds tx_daed_boethiah_hand.dds -gravity southwest -composite -append ATL/boe00.bmp
magick convert tx_daed_boethiah_frontskirt.dds tx_daed_boethiah_backskirt.dds +append ATL/boe01.bmp
magick convert ATL/boe00.bmp tx_daed_boethiah_backtorso.dds tx_daed_boethiah_face.dds tx_daed_boethiah_hair.dds -append ATL/boe02.bmp
magick convert tx_daed_boethiah_axe.dds tx_daed_boethiah_cape.dds ATL/boe01.bmp -append ATL/boe03.bmp

magick convert ATL/boe02.bmp ATL/boe03.bmp -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe.dds

magick convert tx_daed_boethiah_pauldron.dds tx_daed_boethiah_feet.dds tx_daed_boethiah_upperleg.dds tx_daed_boethiah_lowerleg.dds -append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe01.dds

cd ATL
del boe00.bmp
del boe01.bmp
del boe02.bmp
del boe03.bmp
