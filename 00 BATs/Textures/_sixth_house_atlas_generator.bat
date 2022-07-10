@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert tx_metal_6th_bells_top.dds -format %%w info:') do set resolutionW=%%i
set /A resolution2=%resolutionW%*2
set /A resolutionH=%resolution2%*4

magick convert tx_glass_6th_blackblock.dds tx_glass_6th_blackblock.dds +append ATL/temp1.bmp
magick convert ATL/temp1.bmp ATL/temp1.bmp -append ATL/temp2.bmp
magick convert ATL/temp2.bmp tx_metal_6th_design.dds +append ATL/temp3.bmp
magick convert tx_glass_6th_jewel.dds tx_wood_6th_redblock.dds +append ATL/temp4.bmp
magick convert tx_metal_6th_strip.dds tx_metal_6th_strip.dds +append ATL/temp5.bmp
magick convert tx_wood_6th_redblock_01.dds tx_wood_6th_post.dds -rotate 90 -append ATL/temp6.bmp

magick convert tx_metal_6th_top.dds tx_metal_6th_bells_top.dds tx_metal_6th_bells.dds tx_glass_obsidian.dds ATL/temp3.bmp ATL/temp4.bmp ATL/temp5.bmp ATL/temp5.bmp tx_stone_6th_trim_01.dds tx_metal_6th_strip_01.dds tx_metal_6th_strip_01.dds tx_wood_6th_blacktrim.dds tx_wood_6th_redtrim_01.dds tx_wood_6th_redtrim.dds ATL/temp6.bmp -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_6th.dds

magick convert tx_ash_firepit.dds tx_ash_firepit.dds +append ATL/temp7.bmp
magick convert tx_stone_6th_ashstatue.dds -rotate -90 +append ATL/temp8.bmp

magick convert tx_glass_6th_ashaltar.dds ATL/temp8.bmp ATL/temp7.bmp tx_glass_obsidian_strip.dds tx_stone_6th_trim_02.dds -background "#312c28" -resize %resolution2% -append -extent x%resolutionH% -define dds:compression=dxt1 ATL/atlad_6th01.dds

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
