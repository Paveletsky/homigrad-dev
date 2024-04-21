dangautils.fs.include('server/sv_item.lua', 'sv')
dangautils.fs.include('server/sv_player.lua', 'sv')

dangautils.fs.include('client/cl_init.lua', 'cl')
dangautils.fs.include('client/cl_shop.lua', 'cl')
dangautils.fs.include('client/cl_adjustablemodel.lua', 'cl')

fundot = fundot or {}
fundot.items = fundot.items or {}
fundot.accsCats = {"Головные уборы", "На тело"}

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

fundot.items['cap'] = {
    cat = 'Головные уборы',
	order = 100,
    name = 'Кепка',
    desc = [[Будешь крутышом]],
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

fundot.items['backpack'] = {
    cat = 'На тело',
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