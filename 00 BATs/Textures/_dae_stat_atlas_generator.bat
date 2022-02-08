@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_daed_azura_headthing.dds tx_daed_azura_flowerpetal.dds tx_daed_azura_ear.dds -background "#3e3433" +append -gravity west ATL/az00.bmp
magick convert ATL/az00.bmp tx_daed_azura_hand.dds -background "#3e3433" -append ATL/az001.bmp
magick convert ATL/az001.bmp tx_daed_azura_dress.dds +append ATL/az1.bmp
magick convert tx_daed_azura_moon.dds tx_daed_azura_sun.dds +append ATL/az2.bmp

magick convert tx_daed_azura_face.dds tx_daed_azura_torso.dds ATL/az1.bmp ATL/az2.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_dae_stat_azura.dds

magick convert tx_daed_boethiah_fronttorso.dds tx_daed_boethiah_hand.dds -gravity southwest -composite -append ATL/boe00.bmp
magick convert tx_daed_boethiah_frontskirt.dds tx_daed_boethiah_backskirt.dds +append ATL/boe01.bmp
magick convert ATL/boe00.bmp tx_daed_boethiah_backtorso.dds tx_daed_boethiah_face.dds tx_daed_boethiah_hair.dds -append ATL/boe02.bmp
magick convert tx_daed_boethiah_axe.dds tx_daed_boethiah_cape.dds ATL/boe01.bmp -append ATL/boe03.bmp

magick convert ATL/boe02.bmp ATL/boe03.bmp -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe.dds

magick convert tx_daed_boethiah_pauldron.dds tx_daed_boethiah_feet.dds tx_daed_boethiah_upperleg.dds tx_daed_boethiah_lowerleg.dds -append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe01.dds

magick convert tx_daed_mehrunesdagon_axe.dds -rotate 90 +append ATL/dag1.bmp
magick convert tx_daed_mehrunesdagon_arm.dds tx_daed_mehrunesdagon_arm.dds -append ATL/dag2.bmp
magick convert tx_daed_mehrunesdagon_lower_leg.dds tx_daed_mehrunesdagon_lower_leg.dds +append ATL/dag3.bmp

magick convert tx_daed_mehrunesdagon_fronttorso.dds tx_daed_mehrunesdagon_backtorso.dds tx_daed_mehrunesdagon_cowhead.dds +append ATL/dag4.bmp
magick convert ATL/dag2.bmp tx_daed_mehrunesdagon_skirt.dds tx_daed_mehrunesdagon_foot.dds tx_daed_mehrunesdagon_upper_leg.dds +append ATL/dag5.bmp
magick convert ATL/dag3.bmp tx_daed_mehrunesdagon_face.dds +append ATL/dag6.bmp
magick convert ATL/dag1.bmp tx_daed_mehrunesdagon_hand.dds tx_daed_mehrunesdagon_ear.dds -gravity northwest -background "#3e3433" +append ATL/dag7.bmp

magick convert ATL/dag4.bmp ATL/dag5.bmp ATL/dag6.bmp ATL/dag7.bmp -background "#3e3433" -append -define dds:compression=dxt1 ATL/atlad_dae_stat_dagon.dds

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

magick convert tx_daed_molagbal_horn.dds tx_daed_molagbal_tongue.dds +append ATL/mol1.bmp
magick convert tx_daed_molagbal_fronttorso.dds tx_daed_molagbal_head.dds tx_daed_molagbal_ear.dds ATL/mol1.bmp -append ATL/mol2.bmp
magick convert tx_daed_molagbal_backtorso.dds tx_daed_molagbal_jaw.dds tx_daed_molagbal_hand.dds tx_daed_molagbal_hand.dds -append ATL/mol3.bmp

magick convert ATL/mol2.bmp ATL/mol3.bmp +append -define dds:compression=dxt1 ATL/atlad_dae_molag.dds

magick convert tx_daed_molagbal_upperleg.dds tx_daed_molagbal_lowerleg.dds tx_daed_molagbal_foot.dds tx_daed_molagbal_tail.dds tx_daed_molagbal_arm.dds -append -define dds:compression=dxt1 ATL/atlad_dae_molag01.dds

magick convert tx_daed_sheogorath_torso01.dds tx_daed_sheogorath_torso02.dds +append ATL/sheo1.bmp
magick convert tx_daed_sheogorath_lowerpant01.dds tx_daed_sheogorath_sleeve01.dds +append ATL/sheo2.bmp
magick convert tx_daed_sheogorath_head.dds tx_daed_sheogorath_shoe01.dds +append ATL/sheo3.bmp
magick convert tx_daed_sheogorath_hand.dds tx_daed_sheogorath_ear.dds tx_daed_sheogorath_ear.dds tx_daed_sheogorath_shoe01.dds -background "#3e3433" +append -gravity west ATL/sheo4.bmp

magick convert ATL/sheo1.bmp ATL/sheo2.bmp ATL/sheo3.bmp ATL/sheo4.bmp -resize %resolutionW% -append -gravity northwest -background "#3e3433" -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_dae_sheo.dds

cd ATL
del az00.bmp
del az001.bmp
del az1.bmp
del az2.bmp
del boe00.bmp
del boe01.bmp
del boe02.bmp
del boe03.bmp
del "dag1.bmp"
del "dag2.bmp"
del "dag3.bmp"
del "dag4.bmp"
del "dag5.bmp"
del "dag6.bmp"
del "dag7.bmp"
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
del "mol1.bmp"
del "mol2.bmp"
del "mol3.bmp"
del sheo1.bmp
del sheo2.bmp
del sheo3.bmp
del sheo4.bmp
cd ..

if not defined run_without_pause pause