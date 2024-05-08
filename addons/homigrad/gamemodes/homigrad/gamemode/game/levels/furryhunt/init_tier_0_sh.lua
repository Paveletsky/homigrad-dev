table.insert(LevelList, "hunting")

hunting = {}
hunting.Name = "Furry Hunting"

hunting.red = {
    "Браконьер",
    Color(255, 153, 0),
    weapons = {"weapon_radio", "weapon_gurkha", "weapon_hands", "med_band_big", "med_band_small", "medkit", "painkiller", "weapon_jahidka", "weapon_hg_rgd5"},
    main_weapon = {"weapon_m3super", "weapon_remington870", "weapon_xm1014"},
    secondary_weapon = {"weapon_p220", "weapon_deagle", "weapon_glock"},
    models = {
        'models/player/tac_op1.mdl',
        'models/player/tac_op2.mdl',
        'models/player/tac_op3.mdl',
        'models/player/tac_op4.mdl',
        'models/player/tac_op5.mdl',
        'models/player/tac_op6.mdl',
        'models/player/tac_op7.mdl',
        'models/player/tac_op8.mdl',
        'models/player/tac_op9.mdl',
    }
}

hunting.green = {
    "Фурри",
    Color(165, 55, 255),
    weapons = {"weapon_hands", 'weapon_zswep'},
    models = {
        'models/eradium/changed/tigersharkboi_c.mdl',
        'models/eradium/changed/tigersharkboi.mdl',
        'models/binarys_wolf/player/binarys_wolf_player.mdl',
        'models/eradium/spectrum.mdl',
    },
}

hunting.blue = {
    "Рейнджеры",
    Color(47, 197, 34),
    weapons = {"weapon_radio", "weapon_hands", "weapon_kabar", "med_band_big", "med_band_small", "medkit", "painkiller", "weapon_hg_f1", "weapon_handcuffs", "weapon_taser", "weapon_hg_flashbang"},
    main_weapon = {"weapon_mk18", "weapon_m4a1", "weapon_m3super", "weapon_mp7", "weapon_xm1014", "weapon_fal", "weapon_galilsar", "weapon_m249", "weapon_mp5", "weapon_mp40"},
    secondary_weapon = {"weapon_beretta", "weapon_fiveseven", "weapon_hk_usp"},
    models = {
        'models/player/combine_shock_trooper3.mdl',
        'models/player/combine_shock_trooper3.mdl',
        'models/player/combine_shock_trooper2.mdl',
        'models/player/combine_shock_trooper1.mdl',
    }
}

hunting.teamEncoder = {
    [1] = "red",
    [2] = "green",
    [3] = "blue"
}

function hunting.StartRound(data)
    team.SetColor(1, hunting.red[2])
    team.SetColor(2, hunting.green[2])
    team.SetColor(3, hunting.blue[2])
    game.CleanUpMap(false)
    if CLIENT then
        roundTimeLoot = data.roundTimeLoot
        timer.Simple(4, function() RunConsoleCommand("stopsound") end)
        return
    end
    return hunting.StartRoundSV()
end

hunting.RoundRandomDefalut = 4
hunting.NoSelectRandom = true
hunting.SupportCenter = true