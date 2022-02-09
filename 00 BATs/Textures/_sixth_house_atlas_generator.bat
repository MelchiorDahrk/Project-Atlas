@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_metal_6th_bells_top.* -format %%w info:') do set resolutionW=%%i
set /A resolution2=%resolutionW%*2
set /A resolutionH=%resolution2%*4

magick convert tx_glass_6th_blackblock.* tx_glass_6th_blackblock.* +append ATL/temp1.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp -append ATL/temp2.bmp
magick convert ATL/temp2.bmp tx_metal_6th_design.* +append ATL/temp3.bmp
magick convert tx_glass_6th_jewel.* tx_wood_6th_redblock.* +append ATL/temp4.bmp
magick convert tx_metal_6th_strip.* tx_metal_6th_strip.* +append ATL/temp5.bmp
magick convert tx_wood_6th_redblock_01.* tx_wood_6th_post.* -rotate 90 -append ATL/temp6.bmp

magick convert tx_metal_6th_top.* tx_metal_6th_bells_top.* tx_metal_6th_bells.* tx_glass_obsidian.* ATL/temp3.bmp ATL/temp4.bmp ATL/temp5.bmp ATL/temp5.bmp tx_stone_6th_trim_01.* tx_metal_6th_strip_01.* tx_metal_6th_strip_01.* tx_wood_6th_blacktrim.* tx_wood_6th_redtrim_01.* tx_wood_6th_redtrim.* ATL/temp6.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_6th.dds

magick convert tx_ash_firepit.* tx_ash_firepit.* +append ATL/temp7.bmp
magick convert tx_stone_6th_ashstatue.* -rotate -90 +append ATL/temp8.bmp

magick convert tx_glass_6th_ashaltar.* ATL/temp8.bmp ATL/temp7.bmp tx_glass_obsidian_strip.* tx_stone_6th_trim_02.* -background "#312c28" -resize %resolution2% -append -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_6th01.dds

cd ATL
del temp1.bmp
del temp2.bmp
del temp3.bmp
del temp4.bmp
del temp5.bmp
del temp6.bmp
del temp7.bmp
del temp8.bmp
cd ..

if not defined run_without_pause pause
