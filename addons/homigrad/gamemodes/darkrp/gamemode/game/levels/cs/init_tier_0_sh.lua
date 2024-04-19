-- table.insert(LevelList,"css")

css = {}
css.Name = "Conter-Strike: Source Govno"

css.blue = {"Контр-Терористы",Color(79,59,87),
	weapons = {"weapon_megamedkit","weapon_binokle","weapon_hg_hatchet","weapon_hands","med_band_big","med_band_small","medkit","painkiller","weapon_handcuffs","weapon_radio"},
	main_weapon = {"weapon_m4a1","weapon_mp7","weapon_galil"},
	secondary_weapon = {"weapon_hk_usp", "weapon_deagle"},
	models = {
		"models/player/riot.mdl",
		-- "models/player/swat.mdl",
		-- "models/player/gasmask.mdl",
		-- "models/player/urban.mdl",
	}
}


css.red = {"Террористы",Color(146,146,121),
	weapons = {"weapon_megamedkit","weapon_binokle","weapon_hands","weapon_hg_hatchet","bandage","med_band_big","med_band_small","painkiller","weapon_handcuffs","weapon_radio"},
	main_weapon = {"weapon_galilsar", "weapon_mp5", "weapon_m3super"},
	secondary_weapon = {"weapon_beretta","weapon_fiveseven","weapon_beretta"},
	models = {
		"models/player/phoenix.mdl",
		"models/player/leet.mdl",
		"models/player/guerilla.mdl",
	}
}

css.teamEncoder = {
	[1] = "red",
	[2] = "blue"
}

function css.StartRound()
	game.CleanUpMap(false)

	team.SetColor(1,css.red[2])
	team.SetColor(2,css.blue[2])

	if CLIENT then

		css.StartRoundCL()
		return
	end

	css.StartRoundSV()
end
css.RoundRandomDefalut = 1
css.SupportCenter = true
