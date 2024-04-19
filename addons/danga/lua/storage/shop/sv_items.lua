fundot = fundot or {}
fundot.items = {}

fundot.items['coffee'] = {
    cat = 'Другое',
	order = 100,
    name = 'Чашечка кофе',
    desc = [[Если вдруг у тебя нашлись лишние 50 фишек, ты можешь просто подарить чашечку кофе нашему разработчику, чтобы ему было не так тяжело работать в эту ночь над сервером.

Знаем, любовь не продается, но все же ты можешь нам помочь ;)]],
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

fundot.items['coffee2'] = {
    cat = 'Другое',
	order = 100,
    name = 'Чашечка кофе',
    desc = [[Если вдруг у тебя нашлись лишние 50 фишек, ты можешь просто подарить чашечку кофе нашему разработчику, чтобы ему было не так тяжело работать в эту ночь над сервером.

Знаем, любовь не продается, но все же ты можешь нам помочь ;)]],
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

fundot.items['coffee12'] = {
    cat = 'Хуй',
	order = 100,
    name = 'Чашечка кофе',
    desc = [[Если вдруг у тебя нашлись лишние 50 фишек, ты можешь просто подарить чашечку кофе нашему разработчику, чтобы ему было не так тяжело работать в эту ночь над сервером.

Знаем, любовь не продается, но все же ты можешь нам помочь ;)]],
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