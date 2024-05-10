
PIS.Config = {}
PIS.Config.Pings = {}
PIS.Config.PingsSorted = {}
PIS.Config.PingSets = {}

local Color = Color 

local yellow = 	Color(200, 200, 30)
local red = 	Color(200, 30, 30)
local blue = 	Color(30, 30, 200)
local ocean = 	Color(0,133,255)
local green = 	Color(30,200,30)
local info = 	Color(92, 107, 192)
local white = 	Color(255,255,255)
local black = 	Color(0,0,0)
local redy = 	Color(236, 136, 22)
local greeny = Color(87, 255, 3)
local violet = Color(160, 0 , 160)

function PIS.Config:AddMenu(id, mat, text, col, commands,cc)
	self.Pings[id] = {
		mat = mat,
		text = text,
		color = col,
		commands = commands,
		customcheck = cc,
		id = id
	}

	table.insert(self.PingsSorted, id)
end

PIS.Config.Colors = {
	Green = Color(46, 204, 113),
	Red = Color(230, 58, 64)
}
PIS.Config.BackgroundColor = Color(44, 44, 44)
PIS.Config.HighlightTabColor = Color(200, 25, 35)
PIS.Config.HighlightColor = Color(193, 70, 40)

PIS.Config.DefaultSettings = {
	PingSound = 1,
	PingOffscreen = 1,
	PingPulsating = 2,
	PingOverhead = 1,
	PingIconSet = 1,
	Scale = 1,
	DetectionScale = 1,
	PingAvatarVertices = 30,
	WheelDelay = 0.1,
	WheelKey = MOUSE_MIDDLE,
	InteractionKey = KEY_F,
	WheelBlur = 1,
	WheelScale = 1,
	WheelMonochrome = 1
}


PIS.Config.WheelColors = {
	[1] = { "Disabled", "none" },
	[2] = { "White", color_white },
	[3] = { "Blue", blue },
	[4] = { "Red", red },
	[5] = { "Green", Color(128, 177, 11) }
}


--[[

Синтаксис AddMenu:

1. id - делать таким же, как и название
2. иконка - писать только название, берется из materials/ping_system/
3. название - чек 1
4. цвет иконки - цвета есть на самом верху, но ничего не мешает тебе сделать их самому с помощью Color 
5. действие: если сделать это массивом (чек Деньги), то кнопка будет включать в себя меню, если функцией - одно действие
6(необ). customCheck - в каких случаях игроку доступна кнопка

]]



local LeadCP = {}

PIS.Config:AddMenu("other", "pixel_icons/confetti", "Развлечение", info, {
	{name = "PAC3", mat = "icon64/pac3", col = white, func = function() 
		LocalPlayer():ConCommand("pac_editor")
	end},
	
	{name = "Выбор модели",	mat = "pixel_icons/formal_outfit", col = white, func = function() RunConsoleCommand("playermodel_selector") end},
})

PIS.Config:AddMenu("links", "pixel_icons/evidence", "Ссылки", info, {
	{name = "Дискорд", 	mat = "pixel_icons/bubble_info", col = white, func = function() gui.OpenURL( "https://discord.gg/txwFXfZ44s" ) end},
	{name = "Сайт", mat = "pixel_icons/electronics", col = white, func = function() gui.OpenURL( "https://oldhomigrad.ru/" ) end}, 
})

PIS.Config:AddMenu("shop", "pixel_icons/shop2", "Магазин", info, function()
	if fundot.ShopMenu then fundot.ShopMenu:Remove() end
	fundot.ShopMenu = vgui.Create('fdShopPanel')
end)

-- PIS.Config:AddMenu("clans", "pixel_icons/megaphone_", "Смена режима", info, function()
-- 	LocalPlayer():ConCommand("hg_say vote")
-- end)