dangautils.fs.include('sh_init.lua', 'sh')

fundot.items = {}

fundot.items['premium'] = {
    cat = 'Привелегии',
	order = 100,
    name = 'Премиум',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 50,
    icon = 'pixel_icons/clothes_coat.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['skullmask'] = {
    cat = 'Головные уборы',
	order = 100,
    name = 'Черепок',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 50,
    PAC3 = 'skull_mask',
    icon = 'pixel_icons/cross.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['backpack'] = {
    cat = 'Тело',
	order = 100,
    name = 'Рюкзак',
    desc = [[]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 50,
    -- icon = 'octoteam/icons/cup2.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['tophat'] = {
    cat = 'Головные уборы',
	order = 100,
    name = 'Шляпа',
    desc = [[]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 50,
    PAC3 = 'tophat',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}