require("chttp")

local tmpAvatars = {}
-- for bots
tmpAvatars['0'] = 'https://images-ext-2.discordapp.net/external/YwK72LAZl5Vw_SEO2s5NWMwXY4hDB1VJ-aAZqV0fkyo/https/i.pinimg.com/236x/28/29/90/2829903219dd1c4b94e0a3528862a940.jpg'

local IsValid = IsValid
local util_TableToJSON = util.TableToJSON
local util_SteamIDTo64 = util.SteamIDTo64
local http_Fetch = http.Fetch
local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create
local string_find = string.find

function Discord.send(form) 
	if type( form ) ~= "table" then Error( '[Discord] invalid type!' ) return end

	CHTTP({
		["failed"] = function( msg )
			print( "[Discord] "..msg )
		end,
		["method"] = "POST",
		["url"] = Discord.webhook,
		["body"] = util_TableToJSON(form),
		["type"] = "application/json; charset=utf-8"
	})
end

local function getAvatar(id, co)
	http_Fetch( "https://steamcommunity.com/profiles/"..id.."?xml=1", 
	function(body)
		local _, _, url = string_find(body, '<avatarFull>.*.(https://.*)]].*\n.*<vac')
		tmpAvatars[id] = url

		coroutine_resume(co)
	end, 
	function (msg)
		Error("[Discord] error getting avatar ("..msg..")")
	end )
end

local function formMsg( ply, str )
	local id = tostring( ply:SteamID64() )

	local co = coroutine_create( function() 
		local form = {
			["username"] = ply:Nick(),
			["content"] = str,
			["avatar_url"] = tmpAvatars[id],
			["allowed_mentions"] = {
				["parse"] = {}
			},
		}
		
		Discord.send(form)
	end )

	if tmpAvatars[id] == nil then 
		getAvatar( id, co )
	else 
		coroutine_resume( co )
	end
end

local function playerConnect( ply )
	local steamid64 = util_SteamIDTo64( ply.networkid )

	local co = coroutine_create( function()
		local form = {
			["username"] = Discord.hookname,
			["embeds"] = {{
				["author"] = {
					["name"] = ply.name .. " подключается...",
					["icon_url"] = tmpAvatars[steamid64],
					["url"] = 'https://steamcommunity.com/profiles/' .. steamid64,
				},
				["color"] = 16763979,
				["footer"] = {
					["text"] = ply.networkid,
				},
			}},
			["allowed_mentions"] = {
				["parse"] = {}
			},
		}

		Discord.send(form)
	end)

	if tmpAvatars[steamid64] == nil then 
		getAvatar( steamid64, co )
	else 
		coroutine_resume( co )
	end
end

local function plyFrstSpawn(ply)
	if IsValid(ply) then
		local steamid = ply:SteamID()
		local steamid64 = util_SteamIDTo64( steamid )

		local co = coroutine_create(function()
			local form = {
				["username"] = Discord.hookname,
				["embeds"] = {{
					["author"] = {
						["name"] = ply:Nick() .. " подключился",
						["icon_url"] = tmpAvatars[steamid64],
						["url"] = 'https://steamcommunity.com/profiles/' .. steamid64,
					},
					["color"] = 4915018,
					["footer"] = {
						["text"] = steamid,
					},
				}},
				["allowed_mentions"] = {
					["parse"] = {}
				},
			}

			Discord.send(form)
		end)

		if tmpAvatars[steamid64] == nil then 
			getAvatar( steamid64, co )
		else 
			coroutine_resume( co )
		end
	end
end

local function plyDisconnect(ply)
	local steamid64 = util_SteamIDTo64( ply.networkid )

	local co = coroutine_create(function()
		local form = {
			["username"] = Discord.hookname,
			["embeds"] = {{
				["author"] = {
					["name"] = ply.name .. " отключился",
					["icon_url"] = tmpAvatars[steamid64],
					["url"] = 'https://steamcommunity.com/profiles/' .. steamid64,
				},
				["description"] = '```' .. ply.reason .. '```',
				["color"] = 16730698,
				["footer"] = {
					["text"] = ply.networkid,
				},
			}},
			["allowed_mentions"] = {
				["parse"] = {}
			},
		}

		Discord.send(form)

		tmpAvatars[steamid64] = nil
	end)

	if tmpAvatars[steamid64] == nil then 
		getAvatar( steamid64, co )
	else 
		coroutine_resume( co )
	end

end

function Discord.sendMessage(ply, text)
	local ava = "https://images-ext-1.discordapp.net/external/Rh-5faDyrf5e0vAauS4VcbdFXNOFbQB_ewo9eHnkP90/https/avatars.cloudflare.steamstatic.com/1fff9a6f88748f69076a8140e3239e6e985a3d97_full.jpg"
	local form = {
			["username"] = Discord.hookname,
			["embeds"] = {{
				["author"] = {
					["name"] = ply:Name(),
					["icon_url"] = tmpAvatars[ply:SteamID64()],
					["url"] = 'https://steamcommunity.com/profiles/' .. ply:SteamID64(),
				},
				["color"] = 2550255,
				["footer"] = {
					["text"] = text,
				},
			}},
			["allowed_mentions"] = {
				["parse"] = {}
			},
		}
		
	CHTTP({
		["failed"] = function( msg )
			print( "[Discord] "..msg )
		end,
		["method"] = "POST",
		["url"] = Discord.webhook,
		["body"] = util_TableToJSON(form),
		["type"] = "application/json; charset=utf-8"
	})

	Discord.sendAD(form)
end

function Discord.sendMessage2(ply, text)
	local ava = "https://images-ext-1.discordapp.net/external/Rh-5faDyrf5e0vAauS4VcbdFXNOFbQB_ewo9eHnkP90/https/avatars.cloudflare.steamstatic.com/1fff9a6f88748f69076a8140e3239e6e985a3d97_full.jpg"
	local form = {
		["username"] = Discord.hookname,
		["embeds"] = {
			{
				["author"] = {
					["name"] = ply:Name(),
					["icon_url"] = tmpAvatars[ply:SteamID64()],
					["url"] = 'https://steamcommunity.com/profiles/' .. ply:SteamID64(),
				},
				["color"] = 2550255,
				["footer"] = {
					["text"] = text,
				},
			}
		},
		["allowed_mentions"] = {
			["parse"] = {}
		},
	}

	CHTTP({
		["failed"] = function(msg) print("[Discord] " .. msg) end,
		["method"] = "POST",
		["url"] = Discord.webhook,
		["body"] = util_TableToJSON(form),
		["type"] = "application/json; charset=utf-8"
	})
end

function Discord.log(ply, text, embedColor)
	local ava = "https://images-ext-1.discordapp.net/external/Rh-5faDyrf5e0vAauS4VcbdFXNOFbQB_ewo9eHnkP90/https/avatars.cloudflare.steamstatic.com/1fff9a6f88748f69076a8140e3239e6e985a3d97_full.jpg"
    local form = {
        ['embeds'] = {{
            ['color'] = 5793266,
            ['title'] = 'Урон',
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

	CHTTP({
		["failed"] = function(msg) print("[Discord] " .. msg) end,
		["method"] = "POST",
		["url"] = Discord.webhook,
		["body"] = util_TableToJSON(form),
		["type"] = "application/json; charset=utf-8"
	})
end







hook.Add("PlayerSay", "!!discord_sendmsg", formMsg)
gameevent.Listen( "player_connect" )
hook.Add("player_connect", "!!discord_plyConnect", playerConnect)
hook.Add("PlayerInitialSpawn", "!!discordPlyFrstSpawn", plyFrstSpawn)
gameevent.Listen( "player_disconnect" )
hook.Add("player_disconnect", "!!discord_onDisconnect", plyDisconnect)
hook.Add("Initialize", "!!discord_srvStarted", function() 
	local form = {
		["username"] = Discord.hookname,
		["embeds"] = {{
			["title"] = "Сервер запущен!",
			["description"] = "Карта сейчас - " .. game.GetMap(),
			["color"] = 5793266
		}}
	}

	Discord.send(form)
	hook.Remove("Initialize", "!!discord_srvStarted")
end)