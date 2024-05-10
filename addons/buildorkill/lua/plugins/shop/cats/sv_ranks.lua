local ActivateRank = function(item)
	local ply = item:GetOwner()

	RunConsoleCommand('ulx', 'adduserid', ply:SteamID(), item.class)

	item:SetData('active', true)
	item:SetData('usesLeft', 0)
	item:SetExpireIn(60 * 60 * 24 * 30)

	ply:osNetInv()
end

local RankTaken = function(item) 
	RunConsoleCommand('ulx', 'removeuserid', item:GetOwner():SteamID())
	
	item:GetOwner():osNetInv()
end

fundot.registerItem('premium', {
    cat = 'Ранги',
	order = 100,
    name = 'Премиум',
    desc = [[Ты крутой перчик, для тебя всегда зарезервирован слот при фуловом онлайне;
А также роль "Блатной" в дискорд сервере;

Телепорт:
    - !bring
    - !goto
    - !return

Утилиты:
    - !csay (вывод сообщения на экран)
    - !god

Голосование:
    - !votekick (кик игрока)	

Прочее:
    - Трогать игроков
    - !noclip]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 300,
    icon = 'pixel_icons/filed_bow_tie.png',
	CanBuy = true,
	CanUse = function(self) return fundot.CanUseIsActive(self) end,
	OnTaken = function(self) RankTaken(self) end,
    Use = function(self) ActivateRank(self) end,
})

fundot.registerItem('admin', {
    cat = 'Ранги',
	order = 100,
    name = 'Админ',
    desc = [[Для тех кто хочет быть самым крутым среди всех;
Роль "Админ" в дискорд сервере;
Разрешено разбирать жалобы на игроков;

Веселье:
    - !ssp (создание точки для телепорта);
    - !sit (телепорт на точку);
    - !god (бессмертие);
    - !jail (сажать в клетку);
    - !unjail;
    - !slay (убить игрока);
    - !setmodel;

Телепорт:
    - доступ ко всем командам из вкладки;

Утилиты:
    - доступ ко всем командам из вкладки;
    - бан игроков максимум на 2 дня;

Голосование:
    - доступ ко всем командам из вкладки;

Прочее:
    - Трогать игроков;
    - !noclip;]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 1000,
    icon = 'pixel_icons/jewel.png',
	CanBuy = true,
	CanUse = function(self) return fundot.CanUseIsActive(self) end,
	OnTaken = function(self) RankTaken(self) end,
    Use = function(self) ActivateRank(self) end,
})

fundot.registerItem('downer', {
    cat = 'Ранги',
	order = 100,
    name = 'Овнер',
    desc = [[Ты ахуенен. 
Тебе доступно всё кроме вкладок: 
    - управления группами;
    - настроек сервера; 
    - RCON команд;]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 2000,
    icon = 'pixel_icons/xmas_star.png',
	CanBuy = true,
	CanUse = function(self) return fundot.CanUseIsActive(self) end,
	OnTaken = function(self) RankTaken(self) end,
    Use = function(self) ActivateRank(self) end,
})