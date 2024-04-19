Discord.commands['status'] = function()
    local plys = player.GetCount() .. '/' .. game.MaxPlayers()
    local plyList = ''
    local plysTable = player.GetAll()

    local zalupa = {
        user = " 🤓 ",
        admin =  " 🍓 ",
        dadmin =  " 🧨 ",
        stajer =  " ⚗ ",
        moderator = " 👀 ",
        stmoderator = " 🙆‍♂️ ",
        dsuperadmin = " ✨ ",
        superadmin =  " 💣 "
    }

    if #plysTable > 0 then
        for num, ply in ipairs(plysTable) do
            local cho = ply:GetUserGroup()
            plyList = plyList .. zalupa[cho] .. ply:Name() .. '\n'
        end
    else 
        plyList = 'кириковато...' 
    end

    local form = {
        ['embeds'] = {{
            ['color'] = 26558,
            ['title'] = "🎉 ".. GetHostName() .. " ✨",
            ['description'] = [[
# [Подключится](steam://connect/45.136.205.248:27022)

```]] .. game.GetMap() .. [[``` **Игроков** - `]] .. plys .. [[`
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