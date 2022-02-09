@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.* -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_molagbal_horn.* tx_daed_molagbal_tongue.* +append ATL/mol1.bmp
magick convert tx_daed_molagbal_fronttorso.* tx_daed_molagbal_head.* tx_daed_molagbal_ear.* ATL/mol1.bmp -append ATL/mol2.bmp
magick convert tx_daed_molagbal_backtorso.* tx_daed_molagbal_jaw.* tx_daed_molagbal_hand.* tx_daed_molagbal_hand.* -append ATL/mol3.bmp

magick convert ATL/mol2.bmp ATL/mol3.bmp +append -define dds:compression=dxt1 ATL/atlad_dae_molag.dds

magick convert tx_daed_molagbal_upperleg.* tx_daed_molagbal_lowerleg.* tx_daed_molagbal_foot.* tx_daed_molagbal_tail.* tx_daed_molagbal_arm.* -append -define dds:compression=dxt1 ATL/atlad_dae_molag01.dds

cd ATL
del "mol1.bmp"
del "mol2.bmp"
del "mol3.bmp"
cd ..

if not defined run_without_pause pause
