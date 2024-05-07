darkrp.roles = {
    {
        "Гражданин",
        Color(125, 255, 125),
        models = {},
        sol = 450,
        isGoverment = true,
        notApas = true,
    },
    {
        "Полицейский",
        Color(0, 0, 255),
        models = {"models/monolithservers/mpd/female_01_2.mdl", "models/monolithservers/mpd/female_03_2.mdl", "models/monolithservers/mpd/male_01.mdl", "models/monolithservers/mpd/male_02.mdl",},
        limit = 6,
        cantArest = true,
        isGoverment = true,
        main_weapon = {"weapon_per4ik", "weapon_radio", "weapon_fiveseven", "weapon_taser", "darkrp_stick_arest", "darkrp_doom_ram", "weapon_handcuffs",},
        sol = 550,
        mapss = {
            ["rp_bangclaw"] = {Vector(3998.264648, -1069.034180, 81.333817), Vector(3967.291504, -965.112549, 81.928299), Vector(4042.874023, -952.240479, 81.442993), Vector(3946.373535, -1106.069824, 81.312592),},
        },
    },
    {
        "Мэр",
        Color(255, 0, 0),
        models = {"models/player/breen.mdl"},
        limitC = 1,
        limit = 1,
        canChangeRule = true,
        isGoverment = true,
        cantArest = true,
        main_weapon = {"weapon_per4ik", "weapon_radio", "weapon_fiveseven", "weapon_taser", "darkrp_stick_arest", "darkrp_doom_ram", "weapon_handcuffs",},
        sol = 1450,
        mapss = {
            ["rp_bangclaw"] = {Vector(1234.8834228516, 2608.2275390625, 176.03125), Vector(988.59552001953, 2630.23828125, 176.03125), Vector(979.02935791016, 2273.6215820313, 144.03125),},
        },
    },
    {
        "Бандин",
        Color(155, 155, 155),
        models = {},
        shop = {{"m3super", "weapon_m3super", 1250, "models/pwb2/weapons/w_m4super90.mdl"}, {"Патроны", "ent_jack_gmod_ezammo", 150, "models/Items/BoxSRounds.mdl"},},
        sol = 400,
        mapss = {
            ["rp_bangclaw"] = {Vector(5106.7490234375, -3706.1340332031, 72.03125), Vector(5460.439453125, -3725.2778320313, 72.03125), Vector(5534.0229492188, -4028.8796386719, 72.03125), Vector(5504.8671875, -4189.333984375, 72.03125), Vector(5080.5654296875, -4177.1591796875, 72.03125), Vector(5514.806640625, -1633.8038330078, 72.03125), Vector(5503.3833007813, -1775.7861328125, 72.03125),},
        },
        limit = 8,
    },
    {
        "Вор",
        Color(25, 25, 25),
        models = {},
        sol = 450,
        shop = {{"Взломщик", "darkrp+unlocker_door", 50}, {"m3super", "weapon_m3super", 1250, "models/pwb2/weapons/w_m4super90.mdl"}, {"Патроны", "ent_jack_gmod_ezammo", 150, "models/Items/BoxSRounds.mdl"},},
        mapss = {
            ["rp_bangclaw"] = {Vector(5106.7490234375, -3706.1340332031, 72.03125), Vector(5460.439453125, -3725.2778320313, 72.03125), Vector(5534.0229492188, -4028.8796386719, 72.03125), Vector(5504.8671875, -4189.333984375, 72.03125), Vector(5080.5654296875, -4177.1591796875, 72.03125), Vector(5514.806640625, -1633.8038330078, 72.03125), Vector(5503.3833007813, -1775.7861328125, 72.03125),},
        },
    },
    {
        "Военый",
        Color(0, 80, 4),
        models = {},
        isGoverment = true,
        notApas = true,
        limit = 8,
        shop = {
            {"CZ75", "weapon_p220", 100, "models/pwb/weapons/w_cz75.mdl"},
            {"XM1014", "weapon_xm1014", 250, "models/pwb/weapons/w_xm1014.mdl"},
            {"AK74U", "weapon_ak74u", 450, "models/pwb/weapons/w_aks74u.mdl"},
            {"USP-S", "weapon_hk_usps", 600, "models/weapons/w_bean_beansmusp.mdl"},
            -- {"РГД-5","weapon_hg_rgd5",100},
            -- {"Бомба в пропе","weapon_hidebomb",15000, "models/props_junk/cardboard_jox004a.mdl"},
            -- {"Шахидка","weapon_jahidka",12000,"models/props_junk/cardboard_jox004a.mdl"},
            {"Байонет", "weapon_kabar", 800, "models/weapons/insurgency/w_marinebayonet.mdl"},
            {"Патроны", "ent_jack_gmod_ezammo", 150},
            {"Бронежелет", "ent_jack_gmod_ezarmor_mtorso", 800, "models/player/armor_gjel/gjel.mdl"},
            {"Шлем", "ent_jack_gmod_ezarmor_hhead", 600, "models/player/helmet_psh97_jeta/jeta.mdl"},
        },
        mapss = {
            ["rp_bangclaw"] = {Vector(10502.958984375, -3919.3237304688, 72.03125), Vector(10262.173828125, -3873.9663085938, 72.03125), Vector(10086.051757813, -3701.89453125, 72.03125), Vector(10045.65234375, -3533.5517578125, 72.03125), Vector(10510.630859375, -3399.279296875, 72.03125), Vector(10096.399414063, -3113.5390625, 72.03125),},
        },
    },
    {
        "Вармацефт",
        Color(255, 155, 155),
        models = {},
        isGoverment = true,
        notApas = true,
        shop = {{"Аптечка", "medkit", 35}, {"Бинт", "bandage", 5}, {"Морфий", "morphine", 25}, {"Патроны", "ent_jack_gmod_ezammo", 150}, {"Обезбол", "painkiller", 25}, {"Адреналин", "adrenaline", 55}}
    },
    {
        "Охрана",
        Color(17, 0, 255),
        models = {},
        shop = {{"m9 beretta", "weapon_beretta", 100, "models/pwb/weapons/w_cz75.mdl"}}
    },
    {
        "Врач",
        Color(17, 0, 255),
        models = {},
        notApas = true,
        isGoverment = true,
        shop = {{"Аптечка", "medkit", 100}, {"Большой бинт", "med_band_big", 250}, {"Патроны", "ent_jack_gmod_ezammo", 150}, {"Адреналин", "adrenaline", 450}, {"Морфий", "morphine", 600},}
    },
}

local roles = darkrp.roles
local models = roles[9].models
models[1] = "models/player/Group03m/male_09.mdl"
local models = roles[8].models
models[1] = "models/player/odessa.mdl"
local models = roles[7].models
models[1] = "models/player/magnusson.mdl"
local models = roles[6].models
models[1] = "models/Knyaje Pack/SSO_PolitePeople/SSO_PolitePeople.mdl"
local models = roles[5].models
models[1] = "models/player/guerilla.mdl"
models[2] = "models/player/leet.mdl"
local models = roles[4].models
for i = 1, 9 do
    models[#models + 1] = "models/player/group03/male_0" .. i .. ".mdl"
end

for i = 1, 6 do
    models[#models + 1] = "models/player/group03/female_0" .. i .. ".mdl"
end

models = roles[1].models
for i = 1, 9 do
    models[#models + 1] = "models/player/group01/male_0" .. i .. ".mdl"
end

for i = 1, 6 do
    models[#models + 1] = "models/player/group01/female_0" .. i .. ".mdl"
end

local empty = {}
function darkrp.GetRole(ply)
    local roleID = ply:GetNWInt("DarkRPRole")
    return roles[roleID] or empty, roleID
end

if SERVER then return end
function darkrp.ScoreboardSort(sort)
    local list = {}
    local last = {}
    for i, ply in pairs(team.GetPlayers(1)) do
        local roleID = ply:GetNWInt("DarkRPRole")
        if not roleID then
            last[#last + 1] = ply
            continue
        end

        list[roleID] = list[roleID] or {{}, {}}
        if ply:Alive() then
            list[roleID][1][ply] = true
        else
            list[roleID][2][ply] = true
        end
    end

    for roleID, list in pairs(list) do
        for ply in pairs(list[1]) do
            sort[#sort + 1] = ply
        end

        for ply in pairs(list[2]) do
            sort[#sort + 1] = ply
        end
    end

    for i, ply in pairs(last) do
        sort[#sort + 1] = ply
    end
end

function darkrp.GetTeamName(ply)
    local teamID = ply:Team()
    if teamID == 1 then
        local role = darkrp.GetRole(ply)
        if not role then return "багаюзер" end
        return role[1], role[2]
    end
end