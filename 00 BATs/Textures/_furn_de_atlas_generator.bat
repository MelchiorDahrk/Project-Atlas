@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_wood_oldwood.* -format %%w info:') do set resolutionW=%%i
set /A resolutionH=%resolutionW%*16

magick convert tx_keyhole_04.* tx_hinge_02.* +append ATL/temp1.bmp
magick convert tx_wood_oldwood_rings.* tx_wood_weathered_rings.* +append ATL/temp2.bmp
magick convert tx_wood_swirlwood_strip_02.* tx_wood_swirlwood_strip_01.* tx_wood_swirlwood_strip.* -append ATL/temp3.bmp
magick convert ATL/temp3.bmp ATL/temp3.bmp +append ATL/temp4.bmp
magick convert tx_wood_wethered.* -rotate -90 ATL/temp5.bmp

magick convert tx_wood_oldwood_scarred.* tx_wood_oldwood_scarred.* ATL/temp5.bmp tx_wood_oldwood.* tx_wood_oldwood.* -rotate 90 -append ATL/temp6.bmp
magick convert tx_wood_oldwood_design_01.* tx_wood_oldwood_strip.* -append ATL/temp7.bmp
magick convert ATL/temp7.bmp ATL/temp7.bmp +append ATL/temp8.bmp
magick convert tx_wood_oldwood_metal.* -rotate 90 ATL/temp9.bmp
magick convert tx_fabric_brownsquare_01.* tx_fabric_brownsquare_01.* +append ATL/temp10.bmp
magick convert tx_ropestrip_01.* -rotate -90 +append ATL/temp11.bmp

magick convert ATL/temp10.bmp ATL/temp11.bmp ATL/temp1.bmp tx_metal_strip_02.* ATL/temp6.bmp ATL/temp9.bmp tx_wood_oldwood_panel_01.* ATL/temp2.bmp tx_wood_oldwood_corner.* tx_wood_oldwood_design.* ATL/temp8.bmp tx_wood_swirlwood_chest.* tx_wood_swirlwood_trim_02.* tx_wood_swirlwood_trim_01.* tx_wood_swirlwood_trim.* ATL/temp4.bmp tx_wood_swirlwood_leg.* tx_wood_swirlwood_design.* tx_wood_swirlwood.* tx_wood_swirlwood.* -gravity southwest -background "#2e2518" -append -resize %resolutionW% -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlas_de_furniture.dds

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
