dangautils = dangautils or {}
dangautils.fs = dangautils.fs or {}

dangautils.debug = true

function dangautils.console(...)
    if not dangautils.debug then return end
    MsgN(unpack({...}))
end

function dangautils.fs.Equal(word, min, max, to)
    return word:sub(min, max) == to
end

function dangautils.fs.include(fileName, type)

	if (!fileName) then
		error("[BoK] Файл не найден.")
	end

	if ((type == "sv" or fileName:find("sv_")) and SERVER) then
		return include(fileName)
	elseif (type == "sh" or fileName:find("shared.lua") or fileName:find("sh_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		return include(fileName)
	elseif (type == "cl" or fileName:find("cl_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		else
			return include(fileName)
		end
	end
	
end

function dangautils.fs.includeDir(directory)

	for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		dangautils.fs.include(directory.."/"..v)
	end
    
end

local fs, fl = file.Find('storage/*', 'LUA')
for _, f in pairs(fl) do

	local path = 'storage/'..f
	fs, _ = file.Find(path..'/*', 'LUA')
	for _, f in ipairs(fs) do
		local fullPath = path..'/'..f
		if dangautils.fs.Equal(f, 1, 2, 'cl') then
			dangautils.fs.include(fullPath, 'cl')
			dangautils.console('Dangautils: Clients modules included.')			
		end

		if dangautils.fs.Equal(f, 1, 2, 'sv') then
			dangautils.fs.include(fullPath, 'sv')
			dangautils.console('Dangautils: Servers modules included.')			
		end
		
		if dangautils.fs.Equal(f, 1, 2, 'sh') then
			dangautils.fs.include(fullPath, 'sh')
			dangautils.console('Dangautils: Shareds modules included.')			
		end
	end

end

dangautils.fs.include('incModules.lua', 'sh')

hook.Run('dangautils.run')