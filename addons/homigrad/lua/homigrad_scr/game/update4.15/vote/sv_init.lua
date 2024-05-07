dangavote = dangavote or {}
COMMANDS = COMMANDS or {}

dangavote.playersWhoVoted = {}
dangavote.voteIsActive = false

local maps = {} 
for k, v in pairs(file.Find("maps/*.bsp", "GAME")) do
    v = v:sub(1, v:find("%.bsp$") - 1) 
    maps[k] = v
end

dangavote.maps = {
    homicide = { icon = 'votes-posters/levels/homicide', list = { 'gm_construct1', 'gm_constr12uct', 'gm_co2nstruct', 'gm_cons3truct', 'gm_c4onstruct', 'zs_dockhouse' } },
    tdm = { icon = 'votes-posters/levels/tdm', list = { 'gm_construct', 'gm_danga'} },
    hl2dm = { icon = 'votes-posters/levels/hl2dm', list = { 'gm_construct', 'gm_danga'} },
    swo = { icon = 'votes-posters/levels/swo', list = { 'gm_construct', 'gm_danga'} },
    boysbattle = { icon = 'votes-posters/levels/boysbattle', list = { 'gm_construct', 'gm_danga'} },
}

resource.AddWorkshop('2664787711')

local cache, winner = {}, {}
function dangavote.voteGamemode()

    cache = {}

    local timeToEnd = 25
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
    for gm, map in pairs(maps or dangavote.maps['homicide'].list) do
        cache[map] = {}  
    end

    dangavote.maps.VoteMap = true 

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

COMMANDS.vote = {
    function(ply, args)
        local percent = math.Round(player.GetCount() / 1.5)
        local args

        if dangavote.voteIsActive then
            if ply:IsAdmin() then
                dangavote.killVote()
                dangavote.playersWhoVoted = {}
            end
            return
        end
        
        if #dangavote.playersWhoVoted < percent then            
            if table.HasValue(dangavote.playersWhoVoted, ply:SteamID()) then 
                return ply:ChatPrint('<flash>Ты уже проголосовал, тюбик.')
            end

            dangavote.pushPlayerToList(ply)
    
            if #dangavote.playersWhoVoted >= percent then                
                dangavote.voteGamemode()                
            else
                args = '<wrong><font=fdShopSemiFont>'.. ply:Name() .. ' хочет голосования: ' .. #dangavote.playersWhoVoted .. '/' .. percent .. ' (F4 > Смена режима)'

                table.foreach(player.GetAll(), function(k, client)
                    client:ChatPrint(args)
                end)
            end            
        else
            dangavote.voteGamemode()
        end        
    end,
}
