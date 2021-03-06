name = "Canned Food"
description = "Store your food safely forever!"
author = "Tony" -- https://steamcommunity.com/profiles/76561198002269576
version = "1.16b"
forumthread = ""
api_version = 10
all_clients_require_mod = true
dst_compatible = true
client_only_mod = false
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"canned", "food"}

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function setTab(k)
    local name = {"Custom", "Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function setTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local tab = {} for k=1,7,1 do tab[k] = setTab(k) end
local tech = {} for k=1,7,1 do tech[k] = setTech(k) end
local ingredient = {} for k=1,20,1 do ingredient[k] = setCount(k) end
local toggle = {{description = "Yes", data = true}, {description = "No", data = false},}

local function rawIngredients(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgRaw"..name, label = "Raw "..ext, options = ingredient, default = 10, hover = "The amount of items required to craft a can."}
end

local function cannedIngredients(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgCanned"..name, label = ""..ext.." from can", options = ingredient, default = 7, hover = "The amount of items you get from opening a can. Same goes for directly cooking a can."}
end

local function preparedFoods(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgCanned"..name, label = ""..ext.." to and from can", options = ingredient, default = 1, hover = "The amount of items required to craft a can as well as what you get from opening it."}
end

local dstPrefabs = {
    {"Bananas"},
    {"Berries"},
    {"BerriesJuicy", "Juicy Berries"},
    {"BlueShrooms", "Blue Mushrooms"},
    {"Cactus", "Cactus Flesh"},
    {"Carrots"},
    {"Corn"},
    {"Durians"},
    {"Dragonfruits"},
    {"Eels"},
    {"Eggplants"},
    {"Fish"},
    {"GreenShrooms", "Green Mushrooms"},
    {"Honey"},
    {"Pomegranates"},
    {"Pumpkins"},
    {"RedShrooms", "Red Mushrooms"},
    {"Watermelons"},
    -- light
    {"GlowBerries", "Glow Berries"},
    {"LesserGlowBerries", "Lesser Glow Berries"},
    {"LightBulbs", "Light Bulbs"},
    -- update v1.0.6
    {"Garlic"},
    {"Onions"},
    {"Peppers"},
    {"Potatoes"},
    {"TomaRoots", "Toma Roots"},
    {"StoneFruits", "Stone Fruits"},
    {"Succulents"},
    {"CactusFlowers", "Cactus Flowers"},
    {"Asparagus"},
    {"Lichens"},
    -- prepared
    -- {"Meatballs"},
    -- {"MeatyStew", "Meaty Stew"},
    -- {"MandrakeSoup", "Mandrake Soup"},
}

local bbtPrefabs = { -- Birds and Berries and Trees and Flowers for Friends
    {"Apples"},
    {"Blueberries"},
    {"Greenberries"},
    {"Pineapples"},
}

local mfrPrefabs = { -- More Fruits
    {"Grapes"},
    {"Lemons"},
    {"Limes"},
    {"Oranges"},
    {"Tomatoes"},
    {"Strawberries"},
}

local function addDivider(name, title)
    return {name = "cfg"..name.."Title", label = title, options = {{description = "", data = false},}, default = false}
end

options = {
    addDivider("CNF", "Canned Food Settings"),
    {name = "cfgRecipeTab", label = "Recipe Tab", options = tab, default = 1, hover = "The crafting tab on which the recipe is found."},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = tech, default = 2, hover = "The research building required to see/craft the recipe."},
    {name = "cfgAddHoney", label = "Honey Required", options = toggle, default = true, hover = "Toggle whether Honey is required or not."},
    {name = "cfgHoney", label = "How Much Honey", options = ingredient, default = 10, hover = "The amount of Honey required to craft."},
    {name = "cfgAddNitre", label = "Nitre Required", options = toggle, default = true, hover = "Toggle whether Nitre is required or not."},
    {name = "cfgNitre", label = "How Much Nitre", options = ingredient, default = 1, hover = "The amount of Nitre required to craft."}
}

local function addOptions(table)
    for k=1, #table, 1 do -- raw and canned ingredients
        desc = table[k][2] ~= nil
        options[#options+1] = rawIngredients(table[k][1], desc and table[k][2])
        options[#options+1] = cannedIngredients(table[k][1], desc and table[k][2])
    end
end

addOptions(dstPrefabs)

options[#options+1] = addDivider("PRP", "Prepared Foods")
options[#options+1] = preparedFoods("Meatballs")
options[#options+1] = preparedFoods("MeatyStew", "Meaty Stew")
options[#options+1] = preparedFoods("MandrakeSoup", "Mandrake Soup")

options[#options+1] = addDivider("BBT", "Birds and Berries and Trees")
addOptions(bbtPrefabs)

options[#options+1] = addDivider("MFR", "More Fruits")
addOptions(mfrPrefabs)

configuration_options = options