function bok.util.Declare(value, words)
	local orig = value
	value = math.abs(value) % 100
	local num = value % 10

	if value >= 10 and value <= 20 then return orig .. ' ' .. words[3] end
	if num > 1 and num < 5 then return orig .. ' ' .. words[2] end
	if num == 1 then return orig .. ' ' .. words[1] end

	return orig .. ' ' .. words[3]
end

function bok.util.Include(fileName, type)
	if (!fileName) then
		error("[BoK] Файл не найден.")
	end

	if ((type == "server" or fileName:find("sv_")) and SERVER) then
		return include(fileName)
	elseif (type == "shared" or fileName:find("shared.lua") or fileName:find("sh_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		return include(fileName)
	elseif (type == "client" or fileName:find("cl_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		else
			return include(fileName)
		end
	else
		bok.util.Include(fileName, 'shared')
	end
end

function bok.util.GetFilePrefix(name)
	local prefix = name:sub(1, 3)

	return (prefix == "sh_" or prefix == "sv_" or prefix == "cl_") and name:sub(4) or name
end

function bok.util.IncludeDir(directory)
	for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		bok.util.Include(directory.."/"..v)
	end
end

function string:IsSteamID32(str)
	return self:match('^STEAM_%d:%d:%d+$')
end