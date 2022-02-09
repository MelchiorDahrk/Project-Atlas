@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*2

magick convert tx_daed_azura_headthing.* tx_daed_azura_flowerpetal.* tx_daed_azura_ear.* -background "#3e3433" +append -gravity west ATL/az00.bmp
magick convert ATL/az00.bmp tx_daed_azura_hand.* -background "#3e3433" -append ATL/az001.bmp
magick convert ATL/az001.bmp tx_daed_azura_dress.* +append ATL/az1.bmp
magick convert tx_daed_azura_moon.* tx_daed_azura_sun.* +append ATL/az2.bmp

magick convert tx_daed_azura_face.* tx_daed_azura_torso.* ATL/az1.bmp ATL/az2.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_dae_stat_azura.dds

magick convert tx_daed_boethiah_fronttorso.* tx_daed_boethiah_hand.* -gravity southwest -composite -append ATL/boe00.bmp
magick convert tx_daed_boethiah_frontskirt.* tx_daed_boethiah_backskirt.* +append ATL/boe01.bmp
magick convert ATL/boe00.bmp tx_daed_boethiah_backtorso.* tx_daed_boethiah_face.* tx_daed_boethiah_hair.* -append ATL/boe02.bmp
magick convert tx_daed_boethiah_axe.* tx_daed_boethiah_cape.* ATL/boe01.bmp -append ATL/boe03.bmp

magick convert ATL/boe02.bmp ATL/boe03.bmp -resize %resolutionW% +append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe.dds

magick convert tx_daed_boethiah_pauldron.* tx_daed_boethiah_feet.* tx_daed_boethiah_upperleg.* tx_daed_boethiah_lowerleg.* -append -define dds:compression=dxt1 ATL/atlad_dae_stat_boe01.dds

magick convert tx_daed_mehrunesdagon_axe.* -rotate 90 +append ATL/dag1.bmp
magick convert tx_daed_mehrunesdagon_arm.* tx_daed_mehrunesdagon_arm.* -append ATL/dag2.bmp
magick convert tx_daed_mehrunesdagon_lower_leg.* tx_daed_mehrunesdagon_lower_leg.* +append ATL/dag3.bmp

magick convert tx_daed_mehrunesdagon_fronttorso.* tx_daed_mehrunesdagon_backtorso.* tx_daed_mehrunesdagon_cowhead.* +append ATL/dag4.bmp
magick convert ATL/dag2.bmp tx_daed_mehrunesdagon_skirt.* tx_daed_mehrunesdagon_foot.* tx_daed_mehrunesdagon_upper_leg.* +append ATL/dag5.bmp
magick convert ATL/dag3.bmp tx_daed_mehrunesdagon_face.* +append ATL/dag6.bmp
magick convert ATL/dag1.bmp tx_daed_mehrunesdagon_hand.* tx_daed_mehrunesdagon_ear.* -gravity northwest -background "#3e3433" +append ATL/dag7.bmp

magick convert ATL/dag4.bmp ATL/dag5.bmp ATL/dag6.bmp ATL/dag7.bmp -background "#3e3433" -append -define dds:compression=dxt1 ATL/atlad_dae_stat_dagon.dds

magick convert tx_daed_malacath_hair.* tx_daed_malacath_hand.* -gravity southeast -composite -append ATL/mala00.bmp
magick convert tx_daed_malacath_skirtback.* tx_daed_malacath_skirtfront.* +append ATL/mala1.bmp
magick convert tx_daed_malacath_feet.* ATL/mala00.bmp -append ATL/mala2.bmp
magick convert tx_daed_malacath_upper_leg.* tx_daed_malacath_lower_leg.* -append ATL/mala3.bmp
magick convert ATL/mala1.bmp ATL/mala2.bmp ATL/mala3.bmp +append ATL/mala5.bmp
magick convert tx_daed_malacath_fronttorso.* tx_daed_malacath_backtorso.* -resize %resolutionW% -append ATL/mala6.bmp
magick convert ATL/mala6.bmp tx_daed_malacath_belt_center_piece.* -gravity southwest -composite -append ATL/mala7.bmp
magick convert ATL/mala7.bmp tx_daed_malacath_ear.* -gravity southeast -composite -append ATL/mala8.bmp
magick convert tx_daed_malacath_face.* tx_daed_malacath_sword.* -append ATL/mala9.bmp
magick convert ATL/mala8.bmp ATL/mala9.bmp +append ATL/mala10.bmp

magick convert ATL/mala5.bmp ATL/mala10.bmp -append -define dds:compression=dxt1 ATL/atlad_dae_stat_mala.dds

magick convert tx_daed_molagbal_horn.* tx_daed_molagbal_tongue.* +append ATL/mol1.bmp
magick convert tx_daed_molagbal_fronttorso.* tx_daed_molagbal_head.* tx_daed_molagbal_ear.* ATL/mol1.bmp -append ATL/mol2.bmp
magick convert tx_daed_molagbal_backtorso.* tx_daed_molagbal_jaw.* tx_daed_molagbal_hand.* tx_daed_molagbal_hand.* -append ATL/mol3.bmp

magick convert ATL/mol2.bmp ATL/mol3.bmp +append -define dds:compression=dxt1 ATL/atlad_dae_molag.dds

magick convert tx_daed_molagbal_upperleg.* tx_daed_molagbal_lowerleg.* tx_daed_molagbal_foot.* tx_daed_molagbal_tail.* tx_daed_molagbal_arm.* -append -define dds:compression=dxt1 ATL/atlad_dae_molag01.dds

magick convert tx_daed_sheogorath_torso01.* tx_daed_sheogorath_torso02.* +append ATL/sheo1.bmp
magick convert tx_daed_sheogorath_lowerpant01.* tx_daed_sheogorath_sleeve01.* +append ATL/sheo2.bmp
magick convert tx_daed_sheogorath_head.* tx_daed_sheogorath_shoe01.* +append ATL/sheo3.bmp
magick convert tx_daed_sheogorath_hand.* tx_daed_sheogorath_ear.* tx_daed_sheogorath_ear.* tx_daed_sheogorath_shoe01.* -background "#3e3433" +append -gravity west ATL/sheo4.bmp

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