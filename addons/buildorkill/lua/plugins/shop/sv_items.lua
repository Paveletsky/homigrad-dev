fundot.items = {}

local function isActive(item)
	return item:GetData('active')
end

fundot.items['shpac'] = {
    cat = 'Привелегии',
	order = 100,
    name = 'Шпакер',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 150,
    icon = 'pixel_icons/3d_glasses.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['premium'] = {
    cat = 'Привелегии',
	order = 100,
    name = 'Премиум',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 150,
    icon = 'pixel_icons/filed_bow_tie.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['admin'] = {
    cat = 'Привелегии',
	order = 100,
    name = 'Админ',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 350,
    icon = 'pixel_icons/clothes_coat.png',
	CanBuy = true,
    CanUse = true,
    Use = function(self)
        local ply = self:GetOwner()

        self:Remove()
    end,
}

fundot.items['superadmin'] = {
    cat = 'Привелегии',
	order = 100,
    name = 'Овнер',
    desc = [[Будешь крутышом]],
	attributes = {
		{'Что это?', 'icon16/heart.png', 'Хорошее дело'},
	},
    price = 800,
    icon = 'pixel_icons/xmas_star.png',
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
	CanUse = function(self) return !self:GetData('active') and true or false end,
	Use = function(self)
		self:SetData('active', true)
		self:SetData('usesLeft', 0)
		self:SetExpireIn(60 * 60 * 24 * 30)
		local ply = self:GetOwner()
		ply:osNetInv()
		ply:ChatPrint('Активировал')
	end,
	Equip = function(self)        
		local ply = self:GetOwner()
        if ply:GetNetVar('IsAccEquipped') then
            return ply:ChatPrint('На тебе уже есть аксессуар.')
        end

		ply:AddPart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', true)
		self:SetData('equipped', true)
		ply:osNetInv()
	end,
	Unequip = function(self)
		local ply = self:GetOwner()
		ply:RemovePart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', nil)
		self:SetData('equipped', nil)
		ply:osNetInv()
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
	CanUse = function(self) return !self:GetData('active') and true or false end,
	Use = function(self)
		self:SetData('active', true)
		self:SetData('usesLeft', 0)
		self:SetExpireIn(60 * 60 * 24 * 30)
		local ply = self:GetOwner()
		ply:osNetInv()
		ply:ChatPrint('Активировал')
	end,
	Equip = function(self)        
		local ply = self:GetOwner()
        if ply:GetNetVar('IsAccEquipped') then
            return ply:ChatPrint('На тебе уже есть аксессуар.')
        end

		ply:AddPart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', true)
		self:SetData('equipped', true)
		ply:osNetInv()
	end,
	Unequip = function(self)
		local ply = self:GetOwner()
		ply:RemovePart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', nil)
		self:SetData('equipped', nil)
		ply:osNetInv()
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
    CanEquip = true,
	CanUse = function(self) return !self:GetData('active') and true or false end,
	Use = function(self)
		self:SetData('active', true)
		self:SetData('usesLeft', 0)
		self:SetExpireIn(60 * 60 * 24 * 30)
		local ply = self:GetOwner()
		ply:osNetInv()
		ply:ChatPrint('Активировал')
	end,
	Equip = function(self)        
		local ply = self:GetOwner()
        if ply:GetNetVar('IsAccEquipped') then
            return ply:ChatPrint('На тебе уже есть аксессуар.')
        end

		ply:AddPart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', true)
		self:SetData('equipped', true)
		ply:osNetInv()
	end,
	Unequip = function(self)
		local ply = self:GetOwner()
		ply:RemovePart(self.classTable.PAC3)
        ply:SetNetVar('IsAccEquipped', nil)
		self:SetData('equipped', nil)
		ply:osNetInv()
	end,
}