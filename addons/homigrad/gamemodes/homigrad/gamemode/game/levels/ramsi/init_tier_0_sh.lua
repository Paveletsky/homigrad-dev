table.insert(LevelList, "ramsi")
ramsi = {}
ramsi.Name = "Пацанские тёрки"

ramsi.red = {"Октяборьские",Color(66, 135, 245),
	weapons = {
		"weapon_hands",
		"med_band_small"
	},
	main_weapon = {
		"weapon_molotok",	
		"med_band_big",
		"med_band_small",
		"weapon_per4ik",
		"weapon_molotok",
		"med_band_big",
		"med_band_small",
		"weapon_per4ik"
	},
	secondary_weapon = {"weapon_hg_metalbat", "weapon_knife", "weapon_bat","weapon_pipe", "weapon_hg_metalbat", "weapon_bat","weapon_pipe","weapon_hg_metalbat", "weapon_bat","weapon_pipe"},
	models = {
		"models/player/Group02/male_02.mdl",
		"models/player/Group02/male_04.mdl",
		"models/player/Group02/male_06.mdl",
		"models/player/Group02/male_08.mdl",
		-- "models/player/joe/k_pm.mdl",
	}
}


ramsi.blue = {"Шароваровы",Color(105, 196, 59),
	weapons = {
		"weapon_hands",
		"med_band_small"
	},
	main_weapon = {
		"weapon_molotok",	
		"med_band_big",
		"med_band_small",
		"weapon_per4ik",
		"weapon_molotok",
		"med_band_big",
		"med_band_small",
		"weapon_per4ik"
	},

	secondary_weapon = {"weapon_hg_metalbat", "weapon_knife", "weapon_bat","weapon_pipe", "weapon_hg_metalbat", "weapon_bat","weapon_pipe","weapon_hg_metalbat", "weapon_bat","weapon_pipe"},
	models = {
		"models/player/Group02/male_02.mdl",
		"models/player/Group02/male_04.mdl",
		"models/player/Group02/male_06.mdl",
		"models/player/Group02/male_08.mdl",
		-- "models/player/joe/k_pm.mdl",
	}
}

ramsi.teamEncoder = {
	[1] = "red",
	[2] = "blue"
}

function ramsi.StartRound()
	game.CleanUpMap(false)

	team.SetColor(1,ramsi.red[2])
	team.SetColor(2,ramsi.blue[2])

	if CLIENT then

		ramsi.StartRoundCL()
		return
	end

	ramsi.StartRoundSV()
end

ramsi.SupportCenter = true

ramsi.NoSelectRandom = false