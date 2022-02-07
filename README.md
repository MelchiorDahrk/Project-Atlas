# Project Atlas

AtlAd is an unofficial add-on to [Project Atlas](https://www.nexusmods.com/morrowind/mods/45399) which seeks to maintain parity with the [Morrowind Optimization Patch](https://www.nexusmods.com/morrowind/mods/45384), further improve performance on existing meshes, and expand the mod by covering additional sets.


Installation Order

[Weapon Sheathing](https://www.nexusmods.com/morrowind/mods/46069) > [Morrowind Optimization Patch](https://www.nexusmods.com/morrowind/mods/45384) (including Weapon Sheathing patch) > (if applicable) [Glow in the Dahrk](https://www.nexusmods.com/morrowind/mods/45886) > [Project Atlas](https://www.nexusmods.com/morrowind/mods/45399) (including GitD patches, if needed) > [Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/46599) (including applicable Project Atlas patches) > (if applicable) [Intelligent Textures](https://www.nexusmods.com/morrowind/mods/47469) (including atlas patch) > AtlAd > any additional cosmetic mesh or texture replacers

- Install the Core folder by moving the contents into your Morrowind/Data Files folder. For any of these steps, say yes to all if prompted to overwrite
- If you use any texture replacers other than Intelligent Textures, move the contents of the BATs folder into Data Files/Textures, and follow the instructions for patching texture mods later on
- Install one of the two textures folders, based on your preferred resolution
- if you use GitD, install the GitD patch. 


Patching

AtlAd (as well as Project Atlas) are not compatible with any mod which replaces their included meshes, or any mod which replaces certain vanilla textures. 
Texture replacers can be patched by:
- Installing [Image Magick](https://www.imagemagick.org/script/download.php). During install, select options "Install legacy utilities (e. g. convert)" and "Add application directory to system path"
- Open your Data Files/Textures folder, and find the included BAT files. They should sort fairly high on the list alphabetically. Double click on the file to run it, and the program will patch automatically.
- (optional) Check in the Textures/ATL folder to give the new texture a look. If the image is an odd size (any dimensions not a power of two) then your atlas generated incorrectly. This would be caused either by an overly sensitive BAT file, or by texture replacers which are not vanilla dimensions. Report an issue with the BAT and mention the names of any applicable texture replacers you use and I can give it a look.

Mesh replacers must be manually patched. If you have any mesh replacers you prefer the look of, install after AtlAd and allow overwrite. The only conflict will be loss of a potential performance gain, so this is generally no problem. 

Compatability

Mesh replacers are generally not compatible with AtlAd, unless the two have no overlap (not unlikely), or there is an available patch.

[Project Atlas](https://www.nexusmods.com/morrowind/mods/45399) - AtlAd is an expansion, not a full replacement to PA, and they should be used together. AtlAd replaces four textures/BATs from PA (atlas_woodpoles.dds, tx_redoran_atlas.dds, tx_redwall_atlas.dds, and atlas_velothi.dds) and should therefore win any overwrite conflicts with both PA and Intelligent Textures to make sure AtlAd's meshes appear correctly.  
PA's optional smoothed meshes are not compatible. Install these individual options after AtlAd.  
PA's included wood pole texture replacer may not be compatible depending on your setup. Check your results in the Textures/ATL folder after you patch your texture atlases and see if it was improperly generated.  
AtlAd replaces most, but not all PA meshes. Patches made for PA will always work for AtlAd, however.  
[Morrowind Optimization Patch](https://www.nexusmods.com/morrowind/mods/45384) - fully compatible. AtlAd carries over all MOP changes.  
[Graphic Herbalism](https://www.nexusmods.com/morrowind/mods/46599) - Fully compatible. Grab the patch from the "GH Patches and Replacers" file.  
[Glowing Bitter Coast](http://mw.modhistory.com/download-44-14321) - Compatible. Install the Glowing Bitter Coast - Atlas patch from GH's page above. An adjusted patch will be made in the future.  
[Glowing Flames](https://www.nexusmods.com/morrowind/mods/46124) - Minor visual conflict. Install after AtlAd. Patch will be made in the future.  
[Parasol Particles](https://www.nexusmods.com/morrowind/mods/47755) - Install the patch hosted [>here<](https://www.nexusmods.com/morrowind/mods/48923)  
[Mushroom Tree Replacer](https://www.nexusmods.com/morrowind/mods/45350) by PeterBitt - Includes its own atlased meshes. Install after AtlAd and allow overwrite.  
[Telvanni Bump Maps](https://www.nexusmods.com/morrowind/mods/42431)/[Vivec Bump Maps](https://www.nexusmods.com/morrowind/mods/40199) - Incompatible. Install after AtlAd and allow overwrite if you want the full features of the mod. If you're fine with only the new textures, install only that folder and regenerate atlases. 
[Weapon Sheathing](https://www.nexusmods.com/morrowind/mods/46069) - Compatible. Patch included in main archive. 
