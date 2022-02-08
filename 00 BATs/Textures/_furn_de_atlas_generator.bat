@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_oldwood.dds -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*16

magick convert tx_keyhole_04.dds tx_hinge_02.dds +append ATL/temp1.bmp
magick convert tx_wood_oldwood_rings.dds tx_wood_weathered_rings.dds +append ATL/temp2.bmp
magick convert tx_wood_swirlwood_strip_02.dds tx_wood_swirlwood_strip_01.dds tx_wood_swirlwood_strip.dds -append ATL/temp3.bmp
magick convert ATL/temp3.bmp ATL/temp3.bmp +append ATL/temp4.bmp
magick convert tx_wood_wethered.dds -rotate -90 ATL/temp5.bmp

magick convert tx_wood_oldwood_scarred.dds tx_wood_oldwood_scarred.dds ATL/temp5.bmp tx_wood_oldwood.dds tx_wood_oldwood.dds -rotate 90 -append ATL/temp6.bmp
magick convert tx_wood_oldwood_design_01.dds tx_wood_oldwood_strip.dds -append ATL/temp7.bmp
magick convert ATL/temp7.bmp ATL/temp7.bmp +append ATL/temp8.bmp
magick convert tx_wood_oldwood_metal.dds -rotate 90 ATL/temp9.bmp
magick convert tx_fabric_brownsquare_01.dds tx_fabric_brownsquare_01.dds +append ATL/temp10.bmp
magick convert tx_ropestrip_01.dds -rotate -90 +append ATL/temp11.bmp

magick convert ATL/temp10.bmp ATL/temp11.bmp ATL/temp1.bmp tx_metal_strip_02.dds ATL/temp6.bmp ATL/temp9.bmp tx_wood_oldwood_panel_01.dds ATL/temp2.bmp tx_wood_oldwood_corner.dds tx_wood_oldwood_design.dds ATL/temp8.bmp tx_wood_swirlwood_chest.dds tx_wood_swirlwood_trim_02.dds tx_wood_swirlwood_trim_01.dds tx_wood_swirlwood_trim.dds ATL/temp4.bmp tx_wood_swirlwood_leg.dds tx_wood_swirlwood_design.dds tx_wood_swirlwood.dds tx_wood_swirlwood.dds -gravity southwest -background "#2e2518" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_de_furniture.dds

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
del "temp10.bmp
del "temp11.bmp"
cd ..

if not defined run_without_pause pause
