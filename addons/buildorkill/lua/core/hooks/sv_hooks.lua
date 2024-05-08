hook.Add('PlayerInitialSpawn', 'bkPlayerInit', function(client)
	client.bkJoinTime = RealTime()

	if IsValid(client) then
        timer.Simple(1, function()
            hook.Run('PlayerLoaded', client)
            
            netstream.Start(nil, 'bkPlayerSetNoLoading', client:Name())
            netstream.Start(client, 'bkPlayerOnLoad')
        end)
    end
end)

hook.Add('PlayerLoaded', 'bkStartSetups', function(client)
	client:ConCommand('spawnmenu_reload')
end)

netstream.Hook('bkPlayerOnLoad', function(ply)
    if whoLoaded[ply] then return end

    hook.Run('PlayerLoaded', ply)
    whoLoaded[ply] = true
end)

gameevent.Listen( "player_connect" )
hook.Add("player_connect", "bkPlayerOnLoad", function( data )
    local steamid = data.networkid
    local name = data.name
    local id = data.userid

    netstream.Start(nil, 'bkPlayerSetLoading', name)

    timer.Create('bkCheckIsLoadedPlayer_'..id, 400, 1, function()
        if (not player.GetBySteamID(steamid)) then
            netstream.Start(nil, 'bkPlayerSetNoLoading', name)
        end
    end)
end)

hook.Add('PlayerDisconnected', 'bkPlayerOnLoad', function(ply)
    whoLoaded[ply] = nil
    netstream.Start(nil, 'bkPlayerSetNoLoading', ply:Name())
end)

--
--
--

local GM = GAMEMODE or {}

local hitBonus = {
	[1] = {15, 'Бонус %s за убийство в голову!', 'death_bell.wav'},
	[4] = {5, 'Когда-то и этого парня вела дорога приключений, а потом ты прострелил ему колено, держи бонус %s!', 'vo/k_lab2/al_goodboy.wav'},
	[7] = {3, 'Тяжело попасть прямо в мизинец своему сопернику,\nтак еще и убив его этим, лови бонусом %s!', 'wilhelm.wav'},
}

local META = FindMetaTable("Player")
function META:ScreenNotify(text, time, path, fadeIn, fadeOut)
	netstream.Start(self, 'bkScreenNotify', text, time, path, fadeIn, fadeOut)
end

function GM:DoPlayerDeath(client, attacker, dmg) 
	-- if client:IsNPC() or (client == attacker) then
	-- 	return
	-- end

	-- local lastHit 	= client:LastHitGroup()
	-- local bonusData = hitBonus[lastHit]
	
	-- local toPay = 0
	-- -- if (not attacker.NextPresent) or (CurTime() > attacker.NextPresent) then
	-- 		toPay = toPay + 5
	-- 	attacker:ScreenNotify('Неплохо, был бы магазин готов, накинул бы тебе лавэ за килюху', 4, 'vo/k_lab/ba_whoops.wav')

	-- 	if (bonusData) then
	-- 			toPay = toPay + bonusData[1]
	-- 		attacker:ScreenNotify(bonusData[2]:format(bok.util.Declare(bonusData[1], {'очко рейтинга', 'очка рейтинга', 'очков рейтинга'})), 10, bonusData[3])			
	-- 	end

	-- 	-- attacker:AddRating(toPay)
	-- 	attacker.NextPresent = CurTime() + 350
	-- -- end

	-- print('======================================================')
	-- print('[DEATH LOG] ' .. attacker:Name() .. ' разъебал1 ' .. client:Name())
	-- print('======================================================')
end

hook.Add('DoPlayerDeath', 'bkRate', function(client, attacker, dmg)

end)