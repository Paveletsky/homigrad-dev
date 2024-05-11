bok = bok or { util = {}, meta = {} }

-- отпкидываем игрокам файлы
AddCSLuaFile("core/sh_util.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- подключаем утилиты
include("core/sh_util.lua")
include("shared.lua")

netstream.Hook('bkAFKState', function(ply, afk)
	ply:SetNetVar('IsAFK', afk)
end)