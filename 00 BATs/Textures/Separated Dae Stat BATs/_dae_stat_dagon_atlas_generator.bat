@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_mehrunesdagon_axe.dds -rotate 90 +append ATL/dag1.bmp
magick convert tx_daed_mehrunesdagon_arm.dds tx_daed_mehrunesdagon_arm.dds -append ATL/dag2.bmp
magick convert tx_daed_mehrunesdagon_lower_leg.dds tx_daed_mehrunesdagon_lower_leg.dds +append ATL/dag3.bmp

magick convert tx_daed_mehrunesdagon_fronttorso.dds tx_daed_mehrunesdagon_backtorso.dds tx_daed_mehrunesdagon_cowhead.dds +append ATL/dag4.bmp
magick convert ATL/dag2.bmp tx_daed_mehrunesdagon_skirt.dds tx_daed_mehrunesdagon_foot.dds tx_daed_mehrunesdagon_upper_leg.dds +append ATL/dag5.bmp
magick convert ATL/dag3.bmp tx_daed_mehrunesdagon_face.dds +append ATL/dag6.bmp
magick convert ATL/dag1.bmp tx_daed_mehrunesdagon_hand.dds tx_daed_mehrunesdagon_ear.dds -gravity northwest -background "#3e3433" +append ATL/dag7.bmp

magick convert ATL/dag4.bmp ATL/dag5.bmp ATL/dag6.bmp ATL/dag7.bmp -background "#3e3433" -append -define dds:compression=dxt1 ATL/atlad_dae_stat_dagon.dds

cd ATL
del "dag1.bmp"
del "dag2.bmp"
del "dag3.bmp"
del "dag4.bmp"
del "dag5.bmp"
del "dag6.bmp"
del "dag7.bmp"
cd ..

if not defined run_without_pause pause