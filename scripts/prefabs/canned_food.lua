local getConfig = GetModConfigData

local bbt = KnownModIndex:IsModEnabled("workshop-522117250") -- Check if Birds and Berries and Trees and Flowers for Friends is enabled
local mfr = KnownModIndex:IsModEnabled("workshop-861013495") -- Check if More Fruits is enabled

local function makeCannedFood(prefab, raw, cfg, cooked)
    -- local mult = getConfig("cfgCanned"..cfg, "workshop-2709418733")
    local mult = getConfig("cfgCanned"..cfg, "DontStarveCannedFood")
    
    local assets = {
        Asset("ATLAS", "images/inventoryimages/"..prefab..".xml"),
        Asset("IMAGE", "images/inventoryimages/"..prefab..".tex"),
        Asset("ANIM", "anim/canned_food.zip"),
    }

    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddNetwork()
        MakeInventoryPhysics(inst)
        inst.entity:AddAnimState()
        inst.AnimState:SetBank("canned_food")
        inst.AnimState:SetBuild("canned_food")
        inst.AnimState:PlayAnimation(prefab)
    
        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end
    
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefab..".xml"
        inst.components.inventoryitem.cangoincontainer = true
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
        if cooked ~= nil then
            inst:AddComponent("cookable")
            inst.components.cookable.oncooked = function ()
                local x, y, z = inst.Transform:GetWorldPosition()
                local player = FindClosestPlayerInRange(x, y, z, 2)
                for k = 1, mult , 1 do
                    player.components.inventory:GiveItem(SpawnPrefab(cooked))
                end
            end
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("cannedfood")
        inst.components.cannedfood.output = raw
        inst.components.cannedfood.outputAmount = mult

        return inst
    end

    return Prefab("canned_"..prefab, fn, assets)
end

return
    makeCannedFood("asparagus",             "asparagus",                "Asparagus",            "asparagus_cooked"),
    makeCannedFood("bananas",               "cave_banana",              "Bananas",              "cave_banana_cooked"),
    makeCannedFood("berries",               "berries",                  "Berries",              "berries_cooked"),
    makeCannedFood("berries_juicy",         "berries_juicy",            "BerriesJuicy",         "berries_juicy_cooked"),
    makeCannedFood("blue_shrooms",          "blue_cap",                 "BlueShrooms",          "blue_cap_cooked"),
    makeCannedFood("cactus",                "cactus_meat",              "Cactus",               "cactus_meat_cooked"),
    makeCannedFood("cactus_flowers",        "cactus_flower",            "CactusFlowers"),
    makeCannedFood("carrots",               "carrot",                   "Carrots",              "carrot_cooked"),
    makeCannedFood("corn",                  "corn",                     "Corn",                 "corn_cooked"),
    makeCannedFood("dragonfruits",          "dragonfruit",              "Dragonfruits",         "dragonfruit_cooked"),
    makeCannedFood("durians",               "durian",                   "Durians",              "durian_cooked"),
    makeCannedFood("eels",                  "eel",                      "Eels",                 "eel_cooked"),
    makeCannedFood("eggplants",             "eggplant",                 "Eggplants",            "eggplant_cooked"),
    makeCannedFood("figs",                  "fig",                      "Figs",                 "fig_cooked"),
    makeCannedFood("fish",                  "fish",                     "Fish",                 "fish_cooked"),
    makeCannedFood("garlic",                "garlic",                   "Garlic",               "garlic_cooked"),
    makeCannedFood("glowberries",           "wormlight",                "GlowBerries"),
    makeCannedFood("green_shrooms",         "green_cap",                "GreenShrooms",         "green_cap_cooked"),
    makeCannedFood("honey",                 "honey",                    "Honey"),
    makeCannedFood("kelp",                  "kelp",                     "KelpFronds",           "kelp_cooked"),
    makeCannedFood("lesser_glowberries",    "wormlight_lesser",         "LesserGlowBerries"),
    makeCannedFood("lichens",               "cutlichen",                "Lichens"),
    makeCannedFood("lightbulbs",            "lightbulb",                "LightBulbs"),
    makeCannedFood("mandrake_soup",         "mandrakesoup",             "MandrakeSoup"),
    makeCannedFood("meatballs",             "meatballs",                "Meatballs"),
    makeCannedFood("meaty_stew",            "bonestew",                 "MeatyStew"),
    makeCannedFood("moon_shrooms",          "moon_cap",                 "MoonShrooms",          "moon_cap_cooked"),
    makeCannedFood("onions",                "onion",                    "Onions",               "onion_cooked"),
    makeCannedFood("peppers",               "pepper",                   "Peppers",              "pepper_cooked"),
    makeCannedFood("pomegranates",          "pomegranate",              "Pomegranates",         "pomegranate_cooked"),
    makeCannedFood("potatoes",              "potato",                   "Potatoes",             "potato_cooked"),
    makeCannedFood("pumpkins",              "pumpkin",                  "Pumpkins",             "pumpkin_cooked"),
    makeCannedFood("red_shrooms",           "red_cap",                  "RedShrooms",           "red_cap_cooked"),
    makeCannedFood("stone_fruits",          "rock_avocado_fruit_ripe",  "StoneFruits",          "rock_avocado_fruit_ripe_cooked"),
    makeCannedFood("succulents",            "succulent_picked",         "Succulents"),
    makeCannedFood("toma_roots",            "tomato",                   "TomaRoots",            "tomato_cooked"),
    makeCannedFood("watermelons",           "watermelon",               "Watermelons",          "watermelon_cooked"),

    makeCannedFood("meat",                  "meat",                     "Meat",                 "cookedmeat"),
    makeCannedFood("monster_meat",          "monstermeat",              "MonsterMeat",          "cookedmonstermeat"),
    makeCannedFood("frog_legs",             "froglegs",                 "FrogLegs",             "froglegs_cooked"),
    makeCannedFood("morsels",               "smallmeat",                "Morsels",              "cookedsmallmeat"),
    makeCannedFood("raw_fish",              "fishmeat",                 "RawFish",              "fishmeat_cooked"),
    makeCannedFood("leafy_meat",            "plantmeat",                "LeafyMeat",            "plantmeat_cooked"),
    makeCannedFood("fish_morsels",          "fishmeat_small",           "FishMorsels",          "fishmeat_small_cooked"),

    bbt and makeCannedFood("apples",        "treeapple",    "Apples") or nil,
    bbt and makeCannedFood("blueberries",   "berrybl",      "Blueberries",      "berrybl_cooked") or nil,
    bbt and makeCannedFood("greenberries",  "berrygr",      "Greenberries",     "berrygr_cooked") or nil,
    bbt and makeCannedFood("pineapples",    "pappfruit",    "Pineapples",       "pappfruit_cooked") or nil,

    mfr and makeCannedFood("grapes",        "grapebbit",    "Grapes",           "grapebbit_cooked") or nil,
    mfr and makeCannedFood("lemons",        "lemonitem",    "Lemons") or nil,
    mfr and makeCannedFood("limes",         "limelitem",    "Limes") or nil,
    mfr and makeCannedFood("oranges",       "orangeitm",    "Oranges") or nil,
    mfr and makeCannedFood("strawberries",  "strawbbit",    "Strawberries",     "strawbbit_cooked") or nil,
    mfr and makeCannedFood("tomatoes",      "tomatobit",    "Tomatoes",         "tomatobit_cooked") or nil