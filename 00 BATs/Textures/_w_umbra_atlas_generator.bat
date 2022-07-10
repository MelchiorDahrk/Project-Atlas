@echo off
if not exist ATL mkdir ATL
for /f %%i in ('magick convert TX_W_umbra00.dds -format %%w info:') do set resolutionW=%%i

magick convert TX_W_Ebony_edging.dds TX_W_Ebony_edging.dds TX_W_Ebony_edging.dds TX_W_Ebony_edging.dds +append -rotate 90 ATL/temp1.bmp

magick convert ATL/temp1.bmp TX_W_umbra00.dds TX_W_umbra03.dds TX_W_umbra01.dds TX_W_umbra02.dds -resize %resolutionW% -append -define dds:compression=dxt1 ATL/atlad_w_umbra.dds

cd ATL
del temp1.bmp
cd ..

if not defined run_without_pause pause