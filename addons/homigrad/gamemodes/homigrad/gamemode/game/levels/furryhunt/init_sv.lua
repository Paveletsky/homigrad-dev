function hunting.StartRoundSV(data)
	tdm.RemoveItems()
	tdm.DirectOtherTeam(1, 2)

	-- AutoBalanceTwoTeam()

	roundTimeStart = CurTime()
	roundTime = 60 * (2 + math.min(#player.GetAll() / 16, 2))
	roundTimeLoot = 30

	local players = team.GetPlayers(2)
	for i, ply in pairs(players) do
		ply.exit = false
		
		if ply.huntingForceT then
			ply.huntingForceT = nil
			ply:SetTeam(1)
		end
	end

	players = team.GetPlayers(2)
	local count = math.min(math.Round(#players / 8, 0))
	for i = 1, count do
		local ply, key = table.Random(players)
		players[key] = nil
		ply:SetTeam(1)
	end

	local spawnsT, spawnsCT = tdm.SpawnsTwoCommand()
	tdm.SpawnCommand(team.GetPlayers(1), spawnsT)
	tdm.SpawnCommand(team.GetPlayers(2), spawnsCT)

	hunting.police = false

	tdm.CenterInit()

	return {
		roundTimeLoot = roundTimeLoot
	}
end

function hunting.RoundEndCheck()
	if roundTimeStart + roundTime < CurTime() then
		if not hunting.police then
			hunting.police = true
			
			if hunting.roundType == 1 then
				PrintMessage(3, "Рейнджеры прибыли.")
			else
				PrintMessage(3, "Рейнджеры прибыли.")
			end

			local aviable = ReadDataMap("spawnpoints_ss_police")
			local ctPlayers = tdm.GetListMul(player.GetAll(), 1, function(ply) return not ply:Alive() and not ply.roleT and ply:Team() ~= 1002 end)
			local playsound = true

			tdm.SpawnCommand(ctPlayers, aviable, function(ply)
				timer.Simple(0, function()
					ply:SetPlayerClass("contr")
					if playsound then
						ply:EmitSound("police_arrive")
						playsound = false
					end
				end)
			end)
		end
	end

	local TAlive = tdm.GetCountLive(team.GetPlayers(1))
	local CTAlive, CTExit = 0, 0
	local OAlive = 0
	CTAlive = tdm.GetCountLive(team.GetPlayers(2), function(ply)
		if ply.exit then
			CTExit = CTExit + 1
			return false
		end
	end)

	local list = ReadDataMap("spawnpoints_ss_exit")
	if hunting.police then
		for i, ply in pairs(team.GetPlayers(2)) do
			if not ply:Alive() or ply.exit then continue end
			for i, point in pairs(list) do
				if ply:GetPos():Distance(point[1]) < (point[3] or 250) then
					ply.exit = true
					ply:KillSilent()
					CTExit = CTExit + 1
					PrintMessage(3, "Фурри сбежал, осталось " .. (CTAlive - 1) .. " фурричей")
				end
			end
		end
	end

	OAlive = tdm.GetCountLive(team.GetPlayers(3))
	if CTExit > 0 and CTAlive == 0 then
		EndRound(2)
		return
	end

	if OAlive == 0 and TAlive == 0 and CTAlive == 0 then
		EndRound()
		return
	end

	if OAlive == 0 and TAlive == 0 then
		EndRound(2)
		return
	end

	if CTAlive == 0 then
		EndRound(1)
		return
	end

	if TAlive == 0 then
		EndRound(2)
		return
	end
end

function hunting.EndRound(winner)
	tdm.EndRoundMessage(winner)
end

function hunting.PlayerSpawn(ply, teamID)
	local teamTbl = hunting[hunting.teamEncoder[teamID]]
	local color = teamTbl[2]
	ply:SetModel(teamTbl.models[math.random(#teamTbl.models)])
	ply:SetPlayerColor(color:ToVector())
	for i, weapon in pairs(teamTbl.weapons) do
		ply:Give(weapon)
	end

	tdm.GiveSwep(ply, teamTbl.main_weapon, teamID == 1 and 16 or 4)
	tdm.GiveSwep(ply, teamTbl.secondary_weapon, teamID == 1 and 8 or 2)
	if math.random(1, 4) == 4 then ply:Give("weapon_per4ik") end
	if math.random(1, 8) == 8 then ply:Give("adrinaline") end
	if math.random(1, 7) == 7 then ply:Give("painkiller") end
	if math.random(1, 6) == 6 then ply:Give("medkit") end
	if math.random(1, 5) == 5 then ply:Give("med_band_big") end
	if math.random(1, 8) == 8 then ply:Give("morphine") end
	local r = math.random(1, 3)
	ply:Give(r == 1 and "food_fishcan" or r == 2 and "food_spongebob_home" or r == 3 and "food_lays")
	if math.random(1, 3) == 3 then ply:Give("food_monster") end
	if math.random(1, 5) == 5 then ply:Give("weapon_bat") end
	timer.Simple(5, function()
		if teamID == 1 then
			JMod.EZ_Equip_Armor(ply, "Medium-Helmet", Color(0,0,0,0))
			JMod.EZ_Equip_Armor(ply, "Light-Vest", Color(0,0,0,0))		
		elseif teamID == 2 then
			ply:SetPlayerColor(Color(math.random(160), math.random(160), math.random(160)):ToVector())
		end
	end)

	ply.allowFlashlights = false
end

function hunting.PlayerInitialSpawn(ply)
	ply:SetTeam(2)
end

function hunting.PlayerCanJoinTeam(ply, teamID)
	ply.huntingForceT = nil
	if teamID == 3 then
		if ply:IsAdmin() then
			ply:ChatPrint("Милости прошу")
			ply:Spawn()
			return true
		else
			ply:ChatPrint("Иди нахуй")
			return false
		end
	end

	if teamID == 1 then
		if ply:IsAdmin() then
			ply.huntingForceT = true
			ply:ChatPrint("Милости прошу")
			return true
		else
			ply:ChatPrint("Пашол нахуй")
			return false
		end
	end

	if teamID == 2 then
		if ply:Team() == 1 then
			if ply:IsAdmin() then
				ply:ChatPrint("ладно.")
				return true
			else
				ply:ChatPrint("Просижовай жопу до конца раунда, лох.")
				return false
			end
		end
		return true
	end
end

local common = {"food_lays", "weapon_pipe", "weapon_bat", "med_band_big", "med_band_small", "medkit", "food_monster", "food_fishcan", "food_spongebob_home"}
local uncommon = {"medkit", "weapon_molotok", "painkiller"}
local rare = {"weapon_glock18", "weapon_gurkha", "weapon_t", "weapon_per4ik"}
function hunting.ShouldSpawnLoot()
	if roundTimeStart + roundTimeLoot - CurTime() > 0 then return false end
	local chance = math.random(100)
	if chance < 5 then
		return true, rare[math.random(#rare)]
	elseif chance < 30 then
		return true, uncommon[math.random(#uncommon)]
	elseif chance < 70 then
		return true, common[math.random(#common)]
	else
		return false
	end
end

function hunting.PlayerDeath(ply, inf, att)
	return false
end

function hunting.GuiltLogic(ply, att, dmgInfo)
	if att.isContr and ply:Team() == 2 then return dmgInfo:GetDamage() * 3 end
end

function hunting.NoSelectRandom()

end