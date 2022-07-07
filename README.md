# Project Atlas

Project Atlas
Version: 0.7.1

======= About Project Atlas  =======
Vanilla Morrowind has objects split into different shapes each using its own unique texture. This is bad for performance and is one of the game's primary FPS bottlenecks. Each shape (even within a single mesh file) requires its own drawcall. There are close to 5,000 different textures in Morrowind's data; many of which are very similar or outright identical and some meshes are split into more than 75 different shapes. Merging those meshes into a single shape which references a single texture atlas is the ideal situation for game performance.

The goal of Project Atlas is to identify the most performance heavy areas of vanilla Morrowind and some popular mods and target high usage/strain meshes in those areas for atlasing. This effort involves reworking the UVs for those meshes and creating texture atlases to cover various sets.

======= Installation =======

Order of
installation
==============

Below is a list of other commonly used mods which may conflict. For any mods not included, generally:
If the mod is ONLY for mesh-level bug or performance fixes, install BEFORE PA
... is a smoothed mesh or cosmetic replacer, install AFTER
... has an available patch, install BEFORE PA, and the patch AFTER
... is a texture replacer, can be installed at any time, but may need to have new atlases generated (see below)

Weapon Sheathing -> Morrowind Optimization Patch -> Glow in the Dahrk -> Graphic Herbalism MWSE -> Intelligent Textures/Morrowind Enhanced Textures -> Project Atlas -> any additional cosmetic mesh or texture replacers

Wrye Mash
Installation
==============

Archive is set up to use Sub-Packages for Mash Installers:

	00 BATs --- Used to regenerate atlases. Only needed if you use retextures; skip otherwise. 
	00 Core --- Includes all completed atlas sets
	01 Textures --- Pregenerated atlases made using vanilla textures, Intelligent Textures, or Morrowind Enhanced Textures (MET). Only one is needed.

	Optional files and patches

	02 Urns - Smoothed --- Smoothed mesh replacer for urns
	03 Redware - Smoothed --- Smoothed mesh replacer for redware pottery
	04 Redware - Smoothed --- Smoothed mesh replacer for redware pottery
	05 Wood Poles - Hi Res Texture --- Texture replacer for wood poles and rope
	
	06 Glow in the Dahrk Patch --- Includes patches for all atlas sets

	07 Graphic Herbalism Patch --- adds GH support to atlased harvestable plants

	08 ILFAS (Improved Lights for All Shaders) Patch --- Carries forward normal/material edits

Manual
Installation
==============

- Install the Core folder by moving the contents into your Morrowind/Data Files folder. For any of these steps, say yes to all if prompted to overwrite
- If you use any texture replacers other than Intelligent Textures/MET, move the Textures folder inside BATs folder into Data Files, and follow the instructions for patching texture mods later on
- Install one of the three textures folders, based on your preferred resolution/mod
- Install the optional folders and included patches, if necessary

Texture 
Patching
==============

Project Atlas makes use of the program Image Magick to generate atlases, using the included BAT files. 

- Install [Image Magick](https://www.imagemagick.org/script/download.php). During install, select options "Install legacy utilities (e. g. convert)" and "Add application directory to system path"
- Open your Data Files/Textures folder, and find the included BAT files. They should sort fairly high on the list alphabetically. Individual BAT files can be run directly by double clicking on them, or the included Atlas Handler (__atlas_handler.bat) can run all or multiple files at once.

Some important notes:
- Vanilla textures must be present as loose files. Intelligent Textures or other vanilla-based texture mods will work
- If the new textures are different proportions than vanilla, the atlas may be generated incorrectly. If the image is an odd size (resolutions not a power of two) or has large white/blank spaces then your installed mods may be incompatible.
- If you get white meshes ingame or want to scale down a texture for any other reason then open the applicable BAT file with a text editor and follow the instructions at the top.

======= Team Members =======
FloorBelow
Greatness7
Lord Berandas
Melchior Dahrk
MwGek
Petethegoat
Pop000100
R-Zero
Remiros
revenorror
RubberMan
Sataniel
Stuporstar
vtastek
Wollibeebee

======= Changelog =======
Version 0.7.1
	Added Large basket 
	Updated Velothi atlas - split into two separate atlases for Velothi houses and Vivec-specific textures. 
	Updated Kelp atlas
	Added patch for Morrowind Enhanced Textures
	Remade vanilla textures with the Uncompressed Textures Resource
	Moved smoothed Emperor Parasols from the main archive to a separate folder. Remade the ones in the main mod from vanilla.
	Remade a few problematic IT 4.0 atlases with IT 3.0 textures
Version 0.7.0
	Merged AtlAd into Project Atlas
	Added Azura's Coast trees
	Added Ashlands trees
	Added barnacles
	Added Bloodmoon - cave door
	Added Septims and Dwemer coins
	Added Raven Rock buildings
	Added Daedric statues - Azura, Sheogorath, Boethiah, Malacath, Molag Bal and Mehrunes Dagon
	Added Kelp
	Added Limeware
	Added Unique weapons - The Mace of Molag Bal
	Added Shacks
	Added Docks
	Added Silt Striders - alive and dead
	Added Skeletons
	Added Silverware
	Added Dunmer furniture
	Added Doors - Hlaalu and Velothi
	Added Statues - St. Olms and Delyn
	Updated Wood poles
	Updated Bitter Coast mushrooms
	Updated Ebonheart dragon statue
	Updated Hlaalu buildings
	Updated Redoran buildings
	Updated Imperial buildings
	Updated Common buildings
	Updated Velothi buildings
	Updated Redware pots
	Updated Emperor Parasol trees
	Updated Dunmer urns
Version 0.6.5
	Copied required textures to "BC Mushrooms - Smoothed - Glowing Bitter Coast Patch" folder
Version 0.6.4
	Updated GitD patch for Interior Sunrays
Version 0.6.3
	Added batch file for dragon statue
Version 0.6.2
	Updated Imperial and Hlaalu sets
	Added GitD patches for Common & Nordic, Hlaalu, and Redoran
Version 0.6.1
	Revised installation instructions
Version 0.6.0
	Combined packages
Version 0.5.2
	fixed collision on ex_de_railing_03.nif & ex_de_railing_06.nif in ATL Wood Poles
Version 0.5.1
	Updated GITD patch for ATL Velothi to include the Velothi window
	fixed atlas generator in ATL Redware
Version 0.5.0
	Added ATL Redware
	Added smoothed option to ATL Urns
	Added smoothed option to ATL BC Mushrooms
Version 0.4.3
	Added GitD patch to ATL Imperial
Version 0.4.2
	Patches broken UV in ATL Imperial and added Fort Darius Mesh.
Version 0.4.1
	Added texture patcher to ATL Urns.
Version 0.4
	Added ATL Imperial
Version 0.3.1
	Fixed ATL Velothi - velothi entrance UV
Version 0.3.0
	Added Urns by Remiros
Version 0.2.3
	Updated texture replacer patcher for Wood Poles and BC Mushrooms
Version 0.2.2
	Clarified texture replacer patcher on Hlaalu and Velothi
	Added texture replacer patcher for BC Mushrooms
Version 0.2.1
	Patched collision meshes in ATL Wood Poles
Version 0.2.0
	Added Redoran set by Remiros
Version 0.1.0
	Initial release