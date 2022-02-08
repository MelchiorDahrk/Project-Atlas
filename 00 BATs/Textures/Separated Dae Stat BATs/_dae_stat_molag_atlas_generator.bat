@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_daed_azura_face.dds -format %%w info:') do set resolutionW=%%i

magick convert tx_daed_molagbal_horn.dds tx_daed_molagbal_tongue.dds +append ATL/mol1.bmp
magick convert tx_daed_molagbal_fronttorso.dds tx_daed_molagbal_head.dds tx_daed_molagbal_ear.dds ATL/mol1.bmp -append ATL/mol2.bmp
magick convert tx_daed_molagbal_backtorso.dds tx_daed_molagbal_jaw.dds tx_daed_molagbal_hand.dds tx_daed_molagbal_hand.dds -append ATL/mol3.bmp

magick convert ATL/mol2.bmp ATL/mol3.bmp +append -define dds:compression=dxt1 ATL/atlad_dae_molag.dds

magick convert tx_daed_molagbal_upperleg.dds tx_daed_molagbal_lowerleg.dds tx_daed_molagbal_foot.dds tx_daed_molagbal_tail.dds tx_daed_molagbal_arm.dds -append -define dds:compression=dxt1 ATL/atlad_dae_molag01.dds

cd ATL
del "mol1.bmp"
del "mol2.bmp"
del "mol3.bmp"
cd ..

if not defined run_without_pause pause
