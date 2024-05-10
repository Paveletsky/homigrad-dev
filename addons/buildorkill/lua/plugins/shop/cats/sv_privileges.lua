local CATEGORY_NAME = 'Привелегии'

local ActivateAccess = function(item)
	item:SetData('active', true)
	item:SetData('usesLeft', 0)
	item:SetExpireIn(60 * 60 * 24 * 30)

	local ply = item:GetOwner()

    if istable(item.classTable.cami) then
        table.foreach(item.classTable.cami, function(id, access)
            RunConsoleCommand('ulx', 'userallowid', ply:SteamID(), access)
        end)
    end

    ply:osNetInv()
end

local AccessTaken = function(item)
    local ply = item:GetOwner()
    
    if istable(item.classTable.cami) then
        table.foreach(item.classTable.cami, function(id, access)
            RunConsoleCommand('ulx', 'userdenyid', ply:SteamID(), access, 1)
        end)
    end

    netstream.Start(ply, 'HG:Notify', 'Срок привелегии "'..item.name..'" истек.', 5, 'ui/hint.wav' )
    ply:osNetInv()
end

fundot.registerItem('shpac', {
    cat = CATEGORY_NAME,
	order = 100,
    name = 'Шпакер',
    cami = {'Доступ к pac3'},
    desc = [[Открывает доступ к инструменту PAC3.]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 200,
    icon = 'pixel_icons/3d_glasses.png',
	CanBuy = true,
    CanUse = function(self) return fundot.CanUseIsActive(self) end,
    OnTaken = function(self) AccessTaken(self) end,
    Use = function(self)
        return ActivateAccess(self)
    end,
})

fundot.registerItem('muter', {
    cat = CATEGORY_NAME,
	order = 100,
    name = 'Мутник',
    cami = {'ulx gag', 'ulx mute', 'ulx ungag', 'ulx unmute'},
    desc = [[Хочешь самоутвердиться за счет войсспамеров? 
Открывает доступ к командам:
    - !gag
    - !ungag
    - !mute
    - !unmute]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
        {'Тестовый аттрибут', 'pixel_icons/kettle.png'},
        {'Тестовый аттрибут2', 'pixel_icons/kettle.png'},
	},
    price = 150,
    icon = 'pixel_icons/robber.png',
	CanBuy = true,
    CanUse = function(self) return fundot.CanUseIsActive(self) end,
    OnTaken = function(self) AccessTaken(self) end,
    Use = function(self)
        return ActivateAccess(self)
    end,
})

fundot.registerItem('models', {
    cat = CATEGORY_NAME,
	order = 100,
    name = 'Модник',
    cami = {'Доступ к моделям'},
    desc = [[Открывает доступ к смене моделей в F4 > Развлечения > Выбор модели.
За дополнительную плату можно добавить свою модель из воркшопа. Обращаться к менеджерам сервера в дискорде.]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 150,
    icon = 'pixel_icons/formal_outfit.png',
	CanBuy = true,
    CanUse = function(self) return fundot.CanUseIsActive(self) end,
    OnTaken = function(self) AccessTaken(self) end,
    Use = function(self)
        return ActivateAccess(self)
    end,
})

fundot.registerItem('levels', {
    cat = CATEGORY_NAME,
	order = 100,
    name = 'Режимы',
    cami = {'Смена режимов'},
    desc = [[Сможешь менять режимы без голосования:
    - !levels (список режимов)
    - !levelnext (выбор следующего режима)
    - !levelend (завершить активный режим)]],
	attributes = {
		{'На месяц', 'pixel_icons/hand_watches_classic.png'},
	},
    price = 50,
    icon = 'pixel_icons/list_view.png',
	CanBuy = true,
    CanUse = function(self) return fundot.CanUseIsActive(self) end,
    OnTaken = function(self) AccessTaken(self) end,
    Use = function(self)
        return ActivateAccess(self)
    end,
})

fundot.registerItem('ban', {
    cat = CATEGORY_NAME,
	order = 100,
    name = 'ЗАБАНИТЬ',
    cami = {'Доступ к моделям'},
    desc = [[Забань того, кто надоел/взбесил/неугодил
На забаненого и тебя не будет распространяться правила оскорблений в дискорд-сервере.
Подробности привелегии уточняй у менеджеров сервера.]],
	attributes = {
	},
    price = 5000,
    icon = 'pixel_icons/jackolantern.png',
	CanBuy = false,
    CanUse = function(self) return fundot.CanUseIsActive(self) end,
    -- OnTaken = function(self) AccessTaken(self) end,
    Use = function(self)
        -- return ActivateAccess(self)
    end,
})