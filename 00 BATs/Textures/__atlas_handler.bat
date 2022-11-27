@echo off
set run_without_pause=1
cls
:start
cls
@echo.
@echo.

:type
@echo  0 - Ashtree Atlas              1 - Azura's Coast Tree Atlas  2 - Azura Statue Atlas
@echo  3 - Barnacle Atlas             4 - Bloodmoon Cave Door Atlas 5 - Bloodmoon Colony Tileset Atlas
@echo  6 - Boethiah Statue Atlas      7 - Coins Atlas               8 - Common Tileset Atlas
@echo  9 - Dark Elf Furniture Atlas  10 - Doors Atlas              11 - Dragon Statue Atlas
@echo 12 - Emperor Parasol Atlas     13 - Fungus Atlas             14 - Hlaalu Tileset Atlas
@echo 15 - Imperial Tileset          16 - Kelp Atlas               17 - Limeware Atlas
@echo 18 - Mace of Molag Bal Atlas   19 - Malacath Statue Atlas    20 - Molag Bal Statue Atlas
@echo 21 - Mushroom Atlas            22 - Mushroom Only Atlas      23 - Nordic Tileset Atlas
@echo 24 - Redoran Atlas             25 - Redware Atlas            26 - Redware Pot Atlas
@echo 27 - Saints Statues Atlas      28 - Shack Atlas              29 - Sheogorath Statue Atlas
@echo 30 - Ship Atlas                31 - Silt Strider Atlas       32 - Silverware Atlas
@echo 33 - Sixth House Atlas         34 - Skeleton Atlas           35 - Urn Atlas
@echo 36 - Velothi Tileset Atlas     37 - Wood Docks Atlas         38 - Woodpoles Atlas
@echo 39 - Large Basket Atlas
@echo 40 - Ebony Mail Atlas          41 - Helm of Oreyn Bearclaw   42 - Boots of the Apostle
@echo 43 - Redoran Watchman Helm
@echo                                98 - Run All                  99 - Exit
set /p _input="What Patcher To Run? [0 - 38] " || set _input=0
set /a _inputeval="%_input%"*1
if %_inputEval% GTR 99 goto type
if %_inputEval% LSS 0 goto type

if %_inputEval% EQU 0 (
@echo Generating ashtree atlas.
python3 atlasgen.py "_ashtree_atlas.atlas"
)
if %_inputEval% EQU 1 (
@echo Generating azura's coast tree atlas.
python3 atlasgen.py "_ac_trees_atlas.atlas"
)
if %_inputEval% EQU 2 (
@echo Generating Azura statue atlas.
python3 atlasgen.py "Separated Dae Stat BATs\_dae_stat_azura_atlas.atlas"
)
if %_inputEval% EQU 3 (
@echo Generating barnacle atlas.
python3 atlasgen.py "_barnacle_atlas.atlas"
)
if %_inputEval% EQU 4 (
@echo Generating Bloodmoon cave door atlas.
python3 atlasgen.py "_bm_cavedoor_atlas.atlas"
)
if %_inputEval% EQU 5 (
@echo Generating Bloodmoon colony tileset atlas.
python3 atlasgen.py "_colony_atlas.atlas"
)
if %_inputEval% EQU 6 (
@echo Generating Boethiah statue atlas.
python3 atlasgen.py "Separated Dae Stat BATs\_dae_stat_boe_atlas.atlas"
)
if %_inputEval% EQU 7 (
@echo Generating common tileset atlas.
python3 atlasgen.py "_nordcommon_atlas.atlas"
)
if %_inputEval% EQU 8 (
@echo Generating coins atlas.
python3 atlasgen.py "_coins_atlas.atlas"
)
if %_inputEval% EQU 9 (
@echo Generating dark elf furniture atlas.
python3 atlasgen.py "_furn_de_atlas.atlas"
)
if %_inputEval% EQU 10 (
@echo Generating doors atlas.
python3 atlasgen.py _doors.atlas
)
if %_inputEval% EQU 11 (
@echo Generating dragon statue atlas.
python3 atlasgen.py "_dragonstatue_atlas.atlas"
)
if %_inputEval% EQU 12 (
@echo Generating emperor parasol atlas.
python3 atlasgen.py "_emperor_parasol_atlas.atlas"
)
if %_inputEval% EQU 13 (
@echo Generating fungus atlas.
python3 atlasgen.py "_bc_fungus_atlas.atlas"
)
if %_inputEval% EQU 14 (
@echo Generating hlaalu tileset atlas.
python3 atlasgen.py "_hlaalu_atlas.atlas"
)
if %_inputEval% EQU 15 (
@echo Generating imperial tileset atlas.
python3 atlasgen.py "_imperial_atlas.atlas"
)
if %_inputEval% EQU 16 (
@echo Generating kelp atlas.
python3 atlasgen.py "_kelp_atlas.atlas"
)
if %_inputEval% EQU 17 (
@echo Generating limeware atlas.
python3 atlasgen.py "_limeware_atlas.atlas"
)
if %_inputEval% EQU 18 (
@echo Generating mace of Molag Bal atlas.
python3 atlasgen.py "_w_mace_molag_bal_atlas.atlas"
)
if %_inputEval% EQU 19 (
@echo Generating Malacath statue atlas.
python3 atlasgen.py "Separated Dae Stat BATs\_dae_stat_malacath_atlas.atlas"
)
if %_inputEval% EQU 20 (
@echo Generating Molag Bal statue atlas.
python3 atlasgen.py "Separated Dae Stat BATs\_dae_stat_molag_atlas.atlas"
)
if %_inputEval% EQU 21 (
@echo Generating mushrooms atlas.
python3 atlasgen.py "_bc_mushrooms_atlas.atlas"
)
if %_inputEval% EQU 22 (
@echo Generating mushrooms only atlas.
python3 atlasgen.py "_bc_mushroom_only_atlas.atlas"
)
if %_inputEval% EQU 23 (
@echo Generating nordic tileset atlas.
python3 atlasgen.py "_nord_atlas.atlas"
)
if %_inputEval% EQU 24 (
@echo Generating redoran tileset atlas.
python3 atlasgen.py "_redoran_atlas.atlas"
)
if %_inputEval% EQU 25 (
@echo Generating redware atlas.
python3 atlasgen.py "_redware_atlas.atlas"
)
if %_inputEval% EQU 26 (
@echo Generating redware pot atlas.
python3 atlasgen.py "_redware_pot_atlas.atlas"
)
if %_inputEval% EQU 27 (
@echo Generating saints statues atlas.
python3 atlasgen.py "_stat_saints_atlas.atlas"
)
if %_inputEval% EQU 28 (
@echo Generating shack atlas.
python3 atlasgen.py "_shack_atlas.atlas"
)
if %_inputEval% EQU 29 (
@echo Generating Sheogorath statue atlas.
python3 atlasgen.py "Separated Dae Stat BATs\_dae_stat_sheo_atlas.atlas"
)
if %_inputEval% EQU 30 (
@echo Generating ship atlas.
python3 atlasgen.py "_ship_atlas.atlas"
)
if %_inputEval% EQU 31 (
@echo Generating silt strider atlas.
python3 atlasgen.py _silt_strider.atlas
)
if %_inputEval% EQU 32 (
@echo Generating silverware atlas.
python3 atlasgen.py "_silverware_atlas.atlas"
)
if %_inputEval% EQU 33 (
@echo Generating sixth house atlas.
python3 atlasgen.py "_sixth_house_atlas.atlas"
)
if %_inputEval% EQU 34 (
@echo Generating skeleton atlas.
python3 atlasgen.py "_skeleton_atlas.atlas"
)
if %_inputEval% EQU 35 (
@echo Generating urn atlas.
python3 atlasgen.py "_urn_atlas.atlas"
)
if %_inputEval% EQU 36 (
@echo Generating velothi tileset atlas.
python3 atlasgen.py "_velothi_atlas.atlas"
)
if %_inputEval% EQU 37 (
@echo Generating wood docks atlas.
python3 atlasgen.py "_wood_docks.atlas"
)
if %_inputEval% EQU 38 (
@echo Generating woodpoles atlas.
python3 atlasgen.py "_woodpoles_atlas.atlas"
)
if %_inputEval% EQU 39 (
@echo Generating large basket atlas.
python3 atlasgen.py "_furn_basket_atlas.atlas"
)
if %_inputEval% EQU 40 (
@echo Generating Ebony Mail atlas.
python3 atlasgen.py "_a_cuirass_ebon_atlas.atlas"
)
if %_inputEval% EQU 41 (
@echo Generating Helm of Oreyn Bearclaw atlas.
python3 atlasgen.py "_a_helm_bearclaw_atlas.atlas"
)
if %_inputEval% EQU 42 (
@echo Generating Boots of the Apostle atlas.
python3 atlasgen.py _a_boots_apostle.atlas
)
if %_inputEval% EQU 43 (
@echo Generating Redoran Watchman Helm atlas.
python3 atlasgen.py "_a_helm_red_watch_atlas.atlas"
)
if %_inputEval% EQU 98 (
    @echo Starting to build all atlases.
    if exist "_ashtree_atlas.atlas" (
        @echo Generating ashtree atlas.
        python3 atlasgen.py "_ashtree_atlas.atlas"
    )
    if exist "_ac_trees_atlas.atlas" (
        @echo Generating azura's coast tree atlas.
        python3 atlasgen.py "_ac_trees_atlas.atlas"
    )
    if exist "_barnacle_atlas.atlas" (
        @echo Generating barnacle atlas.
        python3 atlasgen.py "_barnacle_atlas.atlas"
    )
    if exist "_bm_cavedoor_atlas.atlas" (
        @echo Generating Bloodmoon cave door atlas.
        python3 atlasgen.py "_bm_cavedoor_atlas.atlas"
    )
    if exist "_colony_atlas.atlas" (
        @echo Generating Bloodmoon colony tileset atlas. This will take a while...
        python3 atlasgen.py "_colony_atlas.atlas"
    )
    if exist "_coins_atlas.atlas" (
        @echo Generating coins atlas.
        python3 atlasgen.py "_coins_atlas.atlas"
    )
    if exist "_nordcommon_atlas.atlas" (
        @echo Generating common atlas.
        python3 atlasgen.py "_nordcommon_atlas.atlas"
    )
    if exist "_furn_de_atlas.atlas" (
        @echo Generating dark elf furniture atlas.
        python3 atlasgen.py "_furn_de_atlas.atlas"
    )
    if exist "_dae_stat_atlas.atlas" (
        @echo Generating daedric statues atlas.
        python3 atlasgen.py "_dae_stat_atlas.atlas"
    )
    if exist "_doors_atlas.atlas" (
        @echo Generating doors atlas.
        python3 atlasgen.py "_doors_atlas.atlas"
    )
    if exist "_dragonstatue_atlas.atlas" (
        @echo Generating dragon statue atlas.
        python3 atlasgen.py "_dragonstatue_atlas.atlas"
    )
    if exist "_emperor_parasol_atlas.atlas" (
        @echo Generating emperor parasol atlas.
        python3 atlasgen.py "_emperor_parasol_atlas.atlas"
    )
    if exist "_bc_fungus_atlas.atlas" (
        @echo Generating fungus atlas.
        python3 atlasgen.py "_bc_fungus_atlas.atlas"
    )
    if exist "_hlaalu_atlas.atlas" (
        @echo Generating hlaalu atlas.
        python3 atlasgen.py "_hlaalu_atlas.atlas"
    )
    if exist "_imperial_atlas.atlas" (
        @echo Generating imperial atlas.
        python3 atlasgen.py "_imperial_atlas.atlas"
    )
    if exist "_kelp_atlas.atlas" (
        @echo Generating kelp atlas.
        python3 atlasgen.py "_kelp_atlas.atlas"
    )
    if exist "_limeware_atlas.atlas" (
        @echo Generating limeware atlas.
        python3 atlasgen.py "_limeware_atlas.atlas"
    )
    if exist "_w_mace_molag_bal_atlas.atlas" (
        @echo Generating Mace of Molag Bal atlas.
        python3 atlasgen.py "_w_mace_molag_bal_atlas.atlas"
    )
    if exist "_bc_mushrooms_atlas.atlas" (
        @echo Generating mushrooms atlas.
        python3 atlasgen.py "_bc_mushrooms_atlas.atlas"
    )
    if exist "_bc_mushrooms_only_atlas.atlas" (
        @echo Generating mushrooms only atlas.
        python3 atlasgen.py "_bc_mushrooms_only_atlas.atlas"
    )
    if exist "_nord_atlas.atlas" (
        @echo Generating nord common atlas.
        python3 atlasgen.py "_nord_atlas.atlas"
    )
    if exist "_redoran_atlas.atlas" (
        @echo Generating redoran atlas.
        python3 atlasgen.py _redoran_atlas.atlas
    )
    if exist "_redware_atlas.atlas" (
        @echo Generating redware atlas.
        python3 atlasgen.py "_redware_atlas.atlas"
    )
    if exist "_redware_pot_atlas.atlas" (
        @echo Generating redware pot atlas.
        python3 atlasgen.py "_redware_pot_atlas.atlas"
    )
    if exist "_shack_atlas.atlas" (
        @echo Generating shack atlas.
        python3 atlasgen.py "_shack_atlas.atlas"
    )
    if exist "_ship_atlas.atlas" (
        @echo Generating ship atlas.
        python3 atlasgen.py "_ship_atlas.atlas"
    )
    if exist "_silt_strider_atlas.atlas" (
        @echo Generating silt strider atlas.
        python3 atlasgen.py "_silt_strider_atlas.atlas"
    )
    if exist "_silverware_atlas.atlas" (
        @echo Generating silverware atlas.
        python3 atlasgen.py "_silverware_atlas.atlas"
    )
    if exist "_sixth_house_atlas.atlas" (
        @echo Generating Sixth House atlas.
        python3 atlasgen.py "_sixth_house_atlas.atlas"
    )
    if exist "_skeleton_atlas.atlas" (
        @echo Generating skeleton atlas.
        python3 atlasgen.py "_skeleton_atlas.atlas"
    )
    if exist "_stat_saints_atlas.atlas" (
        @echo Generating saints statues atlas.
        python3 atlasgen.py "_stat_saints_atlas.atlas"
    )
    if exist "_urn_atlas.atlas" (
        @echo Generating urn atlas.
        python3 atlasgen.py "_urn_atlas.atlas"
    )
    if exist "_velothi_atlas.atlas" (
        @echo Generating velothi tileset atlas.
        python3 atlasgen.py "_velothi_atlas.atlas"
    )
    if exist "_wood_docks.atlas" (
        @echo Generating wood docks atlas.
        python3 atlasgen.py "_wood_docks.atlas"
    )
    if exist "_woodpoles_atlas.atlas" (
        @echo Generating wood poles atlas.
        python3 atlasgen.py "_woodpoles_atlas.atlas"
    )
    if exist "_furn_basket_atlas.atlas" (
        @echo Generating large basket atlas.
        python3 atlasgen.py "_furn_basket_atlas.atlas"
    )
    if exist "_a_cuirass_ebon_atlas.atlas" (
        @echo Generating Ebony Mail atlas.
        python3 atlasgen.py "_a_cuirass_ebon_atlas.atlas"
    )
    if exist "_a_helm_bearclaw_atlas.atlas" (
        @echo Generating Helm of Oreyn Bearclaw atlas.
        python3 atlasgen.py "_a_helm_bearclaw_atlas.atlas"
    )
    if exist "_a_boots_apostle_atlas.atlas" (
        @echo Generating Boots of the Apostle atlas.
        python3 atlasgen.py "_a_boots_apostle_atlas.atlas"
    )
    if exist "_a_helm_red_watch_atlas.atlas" (
        @echo Generating Redoran Watchman Helm atlas.
        python3 atlasgen.py "_a_helm_red_watch_atlas.atlas"
    )
    pause
)

if %_inputEval% EQU 99 (
goto end
)
goto start

:end
exit
