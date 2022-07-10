@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_malacath_hair.dds tx_daed_malacath_hand.dds -gravity southeast -composite -append ATL/mala00.bmp
magick convert tx_daed_malacath_skirtback.dds tx_daed_malacath_skirtfront.dds +append ATL/mala1.bmp
magick convert tx_daed_malacath_feet.dds ATL/mala00.bmp -append ATL/mala2.bmp
magick convert tx_daed_malacath_upper_leg.dds tx_daed_malacath_lower_leg.dds -append ATL/mala3.bmp
magick convert ATL/mala1.bmp ATL/mala2.bmp ATL/mala3.bmp +append ATL/mala5.bmp
magick convert tx_daed_malacath_fronttorso.dds tx_daed_malacath_backtorso.dds -resize %resolutionW% -append ATL/mala6.bmp
magick convert ATL/mala6.bmp tx_daed_malacath_belt_center_piece.dds -gravity southwest -composite -append ATL/mala7.bmp
magick convert ATL/mala7.bmp tx_daed_malacath_ear.dds -gravity southeast -composite -append ATL/mala8.bmp
magick convert tx_daed_malacath_face.dds tx_daed_malacath_sword.dds -append ATL/mala9.bmp
magick convert ATL/mala8.bmp ATL/mala9.bmp +append ATL/mala10.bmp

magick convert ATL/mala5.bmp ATL/mala10.bmp -append -define dds:compression=dxt1 ATL/atlad_dae_stat_mala.dds

cd ATL
del mala00.bmp
del mala1.bmp
del mala2.bmp
del mala3.bmp
del mala5.bmp
del mala6.bmp
del mala7.bmp
del mala8.bmp
del mala9.bmp
del mala10.bmp
cd ..

if not defined run_without_pause pause