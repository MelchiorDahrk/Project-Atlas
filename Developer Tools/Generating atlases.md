Project Atlas makes use of the program Image Magick to generate atlases, using the included BAT files. 

- Install [Image Magick](https://www.imagemagick.org/script/download.php). During install, select options "Install legacy utilities (e. g. convert)" and "Add application directory to system path"
- Open your Data Files/Textures folder, and find the included BAT files. They should sort fairly high on the list alphabetically. Individual BAT files can be run directly by double clicking on them, or the included Atlas Handler (__atlas_handler.bat) can run all or multiple files at once.

Some important notes:
- Vanilla textures must be present as loose files. Intelligent Textures or other vanilla-based texture mods will work
- If the new textures are different proportions than vanilla, the atlas may be generated incorrectly. If the image is an odd size (resolutions not a power of two) or has large white/blank spaces then your installed mods may be incompatible.
- If you get white meshes ingame or want to scale down a texture for any other reason then open the applicable BAT file with a text editor and follow the instructions at the top.