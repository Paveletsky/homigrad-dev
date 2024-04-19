dangavote = dangavote or {}
COMMANDS = COMMANDS or {}

dangavote.playersWhoVoted = {}
dangavote.voteIsActive = false

dangavote.maps = {
    homigrad = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct1', 'gm_constr12uct', 'gm_co2nstruct', 'gm_cons3truct', 'gm_c4onstruct', 'zs_dockhouse' } },
    dm = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm1 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm2 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm3 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm4 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm5 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },
    dm6 = { icon = 'sbox/menu/vote/sbox_panel', list = { 'gm_construct', 'gm_danga'} },

}

resource.AddWorkshop('2664787711')

local cache, winner = {}, {}
function dangavote.voteGamemode()

    cache = {}

    local timeToEnd = 55
    for gm, map in pairs(dangavote.maps) do
        cache[gm] = {}  
    end

    for id, gm in pairs(cache) do
        gm.votes = 0
        gm.whoVoted = gm.whoVoted or {}
    end
	
    local votes = {}
    if timer.Exists('dangavote.gamemode') then timer.Remove('dangavote.gamemode') end
    timer.Create('dangavote.gamemode', timeToEnd, 1, function()
        for id, gm in pairs(cache) do
            table.insert(votes, gm.votes)
            if math.max(unpack(votes)) == gm.votes then
                winner.gm = id
            end
        end

        dangavote.voteMap(winner.gm)
    end)

    dangavote.voteIsActive = true
    netstream.Start(nil, 'dangavote.start', timeToEnd, cache, dangavote.maps)

end

function dangavote.voteMap(gamemode)

    cache = {}
    
    local timeToEnd = 15
    for gm, map in pairs(dangavote.maps[gamemode].list or dangavote.maps['homicide'].list) do
        cache[map] = {}  
    end

    for id, map in pairs(cache) do
        map.votes = 0
        map.whoVoted = map.whoVoted or {}
    end
	
    local votes = {}
    if timer.Exists('dangavote.gamemode') then timer.Remove('dangavote.gamemode') end
    timer.Create('dangavote.gamemode', timeToEnd, 1, function()
        for id, map in pairs(cache) do
            table.insert(votes, map.votes)
            if math.max(unpack(votes)) == map.votes then
                winner.map = id
            end
        end
        dangavote.endVote()
        dangavote.voteIsActive = false
    end)

    netstream.Start(nil, 'dangavote.start', timeToEnd, cache, dangavote.maps)

end

function dangavote.voteFor(ply, key)
    
    local gm = cache[key]
	if gm and table.HasValue(gm.whoVoted, ply) then 
        return 
    end

    for k, v in pairs(cache) do
		if k ~= key and table.HasValue(v.whoVoted, ply) then
			table.RemoveByValue(v.whoVoted, ply)
			v.votes = v.votes - 1
            netstream.Start(nil, 'dangavote.syncVotes', k, gm.votes)
		end
	end

	gm.votes = gm.votes + 1
	gm.whoVoted[#gm.whoVoted + 1] = ply 

    netstream.Start(nil, 'dangavote.syncVotes', key, gm.votes, gm.whoVoted)
    PrintTable(cache)

end
netstream.Hook('dangavote.voteFor', dangavote.voteFor)

function dangavote.endVote()
    dangavote.killVote()

    if winner.map == game.GetMap() and roundActiveName == winner.gm then

        PrintMessageChat(3, "Продолжаем на этой карте, режим остается.")        
        SetActiveNextRound(winner.gm)

    elseif winner.map != game.GetMap() then

        RunConsoleCommand('changelevel', winner.map)
        SetActiveNextRound(winner.gm)

    else
        
        SetActiveNextRound(winner.gm)
        PrintMessageChat(3, "Следующий режим на этой карте: " .. winner.gm)

    end

end

function dangavote.killVote()
	local msg = 'Голосование было завершено!'

	netstream.Start(nil, 'killvote', msg)
	timer.Destroy('dangavote.gamemode')

    if (#dangavote.playersWhoVoted > 1) then
        table.remove(dangavote.playersWhoVoted)
    
        for k, v in pairs(dangavote.maps) do
            table.remove(v.playerWhoVoted)
            v.countVotes = 0
        end
    end
	
	dangavote.voteIsActive = false
end


function dangavote.pushPlayerToList(ply)
	if table.HasValue(dangavote.playersWhoVoted, ply:SteamID()) then return end
	
	dangavote.playersWhoVoted[#dangavote.playersWhoVoted + 1] = ply:SteamID()
end

COMMANDS.monovote = nil
-- COMMANDS.monovote = {
--     function(ply, args)

--         local percent = math.Round(player.GetCount() / 1.5)
--         local args
    
--         if dangavote.voteIsActive then
--             if ply:IsAdmin() then
--                 dangavote.killVote()
--             end

--             return
--         end
--         dangavote.voteGamemode()
--         if #dangavote.playersWhoVoted < percent then
--             if table.HasValue(dangavote.playersWhoVoted, ply:SteamID()) then 
--                 return 
--             end
--             dangavote.pushPlayerToList(ply)
    
--             args = ply:Name() .. ' за запуск игры, давайте, поднажмите! ;)'
    
--             if #dangavote.playersWhoVoted >= percent then
--                 netstream.Start(nil, 'fundot.chat.send', nil, args)
--                 dangavote.voteGamemode()
--                 return
--             end
--         else
--             dangavote.voteGamemode()
--             return
--         end
    
--     end
-- }
