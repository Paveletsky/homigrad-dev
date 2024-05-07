
bok.plugin = bok.plugin or {}
bok.plugin.list = bok.plugin.list or {}

bok.util.Include("core/meta/sh_tool.lua")

function bok.plugin.Load(name, path)
	bok.util.IncludeDir(path)
	bok.util.IncludeDir(path .. '/derma')
	bok.plugin.LoadEntities(path .. "/entities")

	bok.plugin.list[name] = true

	hook.Run("PluginLoaded", name)
end

function bok.plugin.LoadEntities(path)
	local bLoadedTools
	local files, folders

	local function IncludeFiles(path2, bClientside)
		if (SERVER and !bClientside) then
			if (file.Exists(path2.."init.lua", "LUA")) then
				bok.util.Include(path2.."init.lua", "server")
			elseif (file.Exists(path2.."shared.lua", "LUA")) then
				bok.util.Include(path2.."shared.lua")
			end

			if (file.Exists(path2.."cl_init.lua", "LUA")) then
				bok.util.Include(path2.."cl_init.lua", "client")
			end
		elseif (file.Exists(path2.."cl_init.lua", "LUA")) then
			bok.util.Include(path2.."cl_init.lua", "client")
		elseif (file.Exists(path2.."shared.lua", "LUA")) then
			bok.util.Include(path2.."shared.lua")
		end
	end

	local function EntRequest(folder, variable, register, default, clientOnly, create, complete)
		files, folders = file.Find(path.."/"..folder.."/*", "LUA")
		default = default or {}

		for _, v in ipairs(folders) do
			local path2 = path.."/"..folder.."/"..v.."/"
			v = bok.util.GetFilePrefix(v)

			_G[variable] = table.Copy(default)

			if (!isfunction(create)) then
				_G[variable].ClassName = v
			else
				create(v)
			end

			IncludeFiles(path2, clientOnly)

			if (clientOnly) then
				if (CLIENT) then
					register(_G[variable], v)
				end
			else
				register(_G[variable], v)
			end

			if (isfunction(complete)) then
				complete(_G[variable])
			end

			_G[variable] = nil
		end

		for _, v in ipairs(files) do
			local niceName = bok.util.GetFilePrefix(string.StripExtension(v))

			_G[variable] = table.Copy(default)

			if (!isfunction(create)) then
				_G[variable].ClassName = niceName
			else
				create(niceName)
			end

			bok.util.Include(path.."/"..folder.."/"..v, clientOnly and "client" or "shared")

			if (clientOnly) then
				if (CLIENT) then
					register(_G[variable], niceName)
				end
			else
				register(_G[variable], niceName)
			end

			if (isfunction(complete)) then
				complete(_G[variable])
			end

			_G[variable] = nil
		end
	end

	local function RegisterTool(tool, className)
		local gmodTool = weapons.GetStored("gmod_tool")

		if (className:sub(1, 3) == "sh_") then
			className = className:sub(4)
		end

		if (gmodTool) then
			gmodTool.Tool[className] = tool
		else
			ErrorNoHalt(string.format("'%s' не может быть тулом", className))
		end

		bLoadedTools = true
	end

	EntRequest("entities", "ENT", scripted_ents.Register, {
		Type = "anim",
		Base = "base_gmodentity",
		Spawnable = true
	}, false, nil, function(ent)
		if (SERVER and ent.Holdable == true) then
			bok.allowedHoldableClasses[ent.ClassName] = true
		end
	end)

	EntRequest("weapons", "SWEP", weapons.Register, {
		Primary = {},
		Secondary = {},
		Base = "weapon_base"
	})

	EntRequest("tools", "TOOL", RegisterTool, {}, false, function(className)
		if (className:sub(1, 3) == "sh_") then
			className = className:sub(4)
		end

		TOOL = bok.meta.tool:Create()
		TOOL.Mode = className
		TOOL:CreateConVars()
	end)

	EntRequest("effects", "EFFECT", effects and effects.Register, nil, true)

	if (CLIENT and bLoadedTools) then
		RunConsoleCommand("spawnmenu_reload")
	end
end

function bok.plugin.Initialize()
	bok.plugin.LoadFromDir("plugins")
end

local disabled = {
	['gm_bok_ex_construct'] = {
		['m9k'] = true,
	},

	['gm_bigcity_improved'] = {
		['arccw'] = true,
	},

	['gm_bok_warmap'] = {
		['arccw'] = true,
	},
}

function bok.plugin.LoadFromDir(directory)
	local files, folders = file.Find(directory.."/*", "LUA")

	for _, v in ipairs(folders) do
		-- if not disabled[game.GetMap()][v] then
			bok.plugin.Load(v, directory.."/"..v)
		-- end
	end
end