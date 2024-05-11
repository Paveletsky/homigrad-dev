local UseFunc = function(item)
    item:SetData('active', true)
    item:SetData('usesLeft', 0)
    item:SetExpireIn(60 * 60 * 24 * 30)

    local ply = item:GetOwner()

    ply:osNetInv()
end

local EquipFunc = function(item)        
    local ply = item:GetOwner()
    if ply:GetNetVar('IsAccEquipped') then
        return ply:ChatPrint('На тебе уже есть аксессуар.')
    end

    ply:AddPart(item.classTable.PAC3)
    ply:SetNetVar('IsAccEquipped', true)

    item:SetData('equipped', true)
    ply:osNetInv()
end

local UnequipFunc = function(item)
    local ply = item:GetOwner()

    ply:RemovePart(item.classTable.PAC3)
    ply:SetNetVar('IsAccEquipped', nil)

    item:SetData('equipped', nil)
    ply:osNetInv()
end

fundot.registerItem('testoutfit', {
    cat = 'Костюмы',
	order = 100,
    name = 'Тестовый костюм',
    desc = [[]],
	attributes = {	},
    price = 50,
    PAC3 = 'test',
	CanBuy = false,
    CanEquip = true,
	CanUse = function(self) return !self:GetData('active') and true or false end,
	Use = UseFunc,
	Equip = EquipFunc,
	Unequip = UnequipFunc,
})