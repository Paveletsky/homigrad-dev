Discord.commands['status'] = function()
    local plys = player.GetCount() .. '/' .. game.MaxPlayers()
    local plyList = ''
    local plysTable = player.GetAll()

    if #plysTable > 0 then
        for num, ply in ipairs(plysTable) do
            plyList = plyList .. ply:Nick() .. '\n'
        end
    else plyList = 'никого ¯\\_(ツ)_/¯' end

    local form = {
        ['embeds'] = {{
            ['color'] = 5793266,
            ['title'] = GetHostName(),
            ['description'] = [[
**Подключиться** - steam://connect/]] .. game.GetIPAddress() .. [[

**Карта сейчас** - ]] .. game.GetMap() .. [[

**Игроков** - ]] .. plys .. [[
            ]],
            ['fields'] = {{
                ['name'] = 'Список игроков',
                ['value'] = plyList
            }}
        }}
    }

    Discord.send(form)
end

Discord.commands['ping'] = function()
    local form = {
        ['content'] = ':ping_pong: pong'
    }

    Discord.send(form)
end

Discord.commands['console'] = function(msg)
	--print(table.HasValue(msg.d.member.roles,"1180203549448216596"))
    if not (table.HasValue(msg.d.member.roles,"1203972902295445554")) then
		local form = {
        	['content'] = 'У тебя нет доступка к этой команде... 🤡'
    	}
		Discord.send(form)
 		return 
    end

    local form = {
        ['content'] = 'Использую в консоли: '..string.sub( msg.d.content, 10 )
    }
	game.ConsoleCommand(string.sub( msg.d.content, 10 ).."\n")
	--1154045242845167616
    Discord.send(form)
end

Discord.commands['banid'] = function(msg)
	--print(table.HasValue(msg.d.member.roles,"1154045242845167616"))
    if not (table.HasValue(msg.d.member.roles,"1203972902295445554")) then
		local form = {
        	['content'] = 'У тебя нет доступка к этой команде... 🤡'
    	}
		Discord.send(form)
 		return 
    end

    local form = {
        ['content'] = 'Пытаюсь забанить: '..string.sub( msg.d.content, 7 )
    }
	game.ConsoleCommand("ulx "..string.sub( msg.d.content, 2 ).."\n")
	--1154045242845167616
    Discord.send(form)
end

Discord.commands['ban'] = function(msg)
	--print(table.HasValue(msg.d.member.roles,"1154045242845167616"))
    if not (table.HasValue(msg.d.member.roles,"1203972902295445554")) then
		local form = {
        	['content'] = 'У тебя нет доступка к этой команде... 🤡'
    	}
		Discord.send(form)
 		return 
    end

    local form = {
        ['content'] = 'Пытаюсь забанить: '..string.sub( msg.d.content, 5 )
    }
	game.ConsoleCommand("ulx "..string.sub( msg.d.content, 2 ).."\n")
	--1154045242845167616
    Discord.send(form)
end

Discord.commands['kick'] = function(msg)
	--print(table.HasValue(msg.d.member.roles,"1154045242845167616"))
    if not (table.HasValue(msg.d.member.roles,"1203972902295445554")) then
		local form = {
        	['content'] = 'У тебя нет доступка к этой команде... 🤡'
    	}
		Discord.send(form)
 		return 
    end

    local form = {
        ['content'] = 'Пытаюсь забанить: '..string.sub( msg.d.content, 5 )
    }
    
	game.ConsoleCommand("ulx "..string.sub( msg.d.content, 2 ).."\n")
	
    Discord.send(form)
end