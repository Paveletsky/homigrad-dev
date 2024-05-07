hook.Add('dangautils.db.init', 'dangashop.db', function()

	dangautils.db:RunQuery([[
		CREATE TABLE IF NOT EXISTS homiusers (
			id INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
			steamID VARCHAR(30) NOT NULL,
			data TEXT NOT NULL,
				PRIMARY KEY (id),
				UNIQUE (steamID)
		) ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci
	]])

	dangautils.db:RunQuery([[
		CREATE TABLE IF NOT EXISTS fundot_shop_users (
			id INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
			steamID VARCHAR(30) NOT NULL,
			steamID64 VARCHAR(20) NOT NULL,
			balance INT(10) NOT NULL,
			totalTopup INT(10) NOT NULL,
			totalSpent INT(10) NOT NULL,
			totalPurchases INT(10) NOT NULL,
				PRIMARY KEY (id),
				UNIQUE (steamID)
		) ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci
	]])

	dangautils.db:RunQuery([[
		CREATE TABLE IF NOT EXISTS fundot_shop_items (
			id INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
			userID INT(8) UNSIGNED NOT NULL,
			itemName VARCHAR(255) NOT NULL,
			itemClass VARCHAR(30) NOT NULL,
			data TEXT,
				PRIMARY KEY (id),
			CONSTRAINT Cons_OS_Items_Fundot
				FOREIGN KEY (userID) REFERENCES fundot_shop_items(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		) ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci
	]])

	dangautils.db:RunQuery([[
		CREATE TABLE IF NOT EXISTS fundot_shop_purchases (
			id INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
			userID INT(8) UNSIGNED NOT NULL,
			serverID VARCHAR(30) NOT NULL,
			itemID INT(8) UNSIGNED NOT NULL,
			itemClass VARCHAR(30) NOT NULL,
			price INT(10) NOT NULL,
				PRIMARY KEY (id),
				UNIQUE (userID)
		) ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci
	]])

end)
-- hook.Run('dangautils.db.init')

util.AddNetworkString 'fundot.action'
util.AddNetworkString 'fundot.purchase'

include('sv_items.lua')

local dataSync = {}
local function syncItemsData()

	for id, item in pairs(dataSync) do
		dangautils.db:PrepareQuery([[
			UPDATE fundot_shop_items
				SET data = ?, itemName = ?
				WHERE id = ?
		]], { util.TableToJSON(item.data), item.name, item.id }, function(q, st, data)
			if st then
				print('Item data updated for ID: ' .. item.id)
			else
				print('Failed to update item data for ID: ' .. item.id .. ', error:')
				print(data)
			end
		end)

		dataSync[id] = nil
	end

end
hook.Add('Think', 'fundot.dataSync', syncItemsData)

local osItem = {}
osItem.__index = osItem

function osItem:New(class, owner, callback)

	if not class or not fundot.items[class] or not IsValid(owner) or not owner.osID then
		print('Could not create item "' .. class .. '" for ' .. tostring(owner))
		return false
	end

	local item = {
		class = class,
		classTable = fundot.items[class],
		name = fundot.items[class].name,
		owner = owner,
		data = {}
	} setmetatable(item, osItem)

	dangautils.db:PrepareQuery([[
		INSERT INTO fundot_shop_items(userID, itemName, itemClass, data)
			VALUES(?,?,?,?)
	]], {
		owner.osID,
		fundot.items[class].name,
		class,
		'[]',
	}, function(q, st, data)
		if not item or not IsValid(owner) then return end
		if st then
			item.id = q:lastInsert()
			print('Created item "' .. class .. '" for ' .. tostring(owner) .. ', ID: ' .. item.id)
			owner.osItems[item.id] = item
			local shouldDo = true
			if isfunction(callback) then if callback(item) then shouldDo = false end end
			if shouldDo then item:OnGiven() end
			owner:osNetInv()
		else
			print('Could not save created item "' .. class .. '" for ' .. tostring(owner) .. ', removing...')
			item:Remove()
		end
	end)

	return item

end

function osItem:CreateDromData(owner, data)

	if not data.id or not data.class or not fundot.items[data.class] or not IsValid(owner) or not owner.osID then
		print('Could not load item "' .. data.class .. '", ID: ' .. data.id .. ' for ' .. tostring(owner))
		return false
	end

	local item = {
		id = data.id,
		class = data.class,
		classTable = fundot.items[data.class],
		name = data.name or fundot.items[data.class].name,
		owner = owner,
		data = data.data or {},
	} setmetatable(item, osItem)

	owner.osItems[item.id] = item
	-- print('Loaded item "' .. data.class .. '", ID: ' .. data.id .. ' for ' .. tostring(owner))
	item:OnGiven()

	return item

end

function osItem:Remove(noDB)

	if not noDB then
		dangautils.db:PrepareQuery([[
			DELETE FROM fundot_shop_items
			WHERE id = ?
		]], { self.id })
	end

	local owner = self:GetOwner()
	if IsValid(owner) and istable(owner.osItems) then
		if owner.osItems[self.id] then
			self:OnTaken()
			self.removed = true
			owner.osItems[self.id] = nil
			owner:osNetInv()
		else
			return false
		end
	end

	print('Removed item "' .. self.class .. '", ID: ' .. self.id)
	return true

end

function osItem:Move(newOwner, noDB)

	if not IsValid(newOwner) or not istable(newOwner.osItems) or not newOwner.osID then return false end

	local oldOwner = self:GetOwner()
	if IsValid(oldOwner) and istable(oldOwner.osItems) then
		if oldOwner.osItems[self.id] then
			self:OnTaken()
			oldOwner.osItems[self.id] = nil
		else
			return false
		end
	end

	if not noDB then
		dangautils.db:PrepareQuery([[
			UPDATE fundot_shop_items
				SET userID = ?
				WHERE id = ?
		]], { newOwner.osID, self.id })
	end

	newOwner.osItems[self.id] = self
	self.owner = newOwner
	self:OnGiven()

	oldOwner:osNetInv()
	newOwner:osNetInv()

	return true

end

function osItem:Validate()

	if not IsValid(self.owner) or not self.owner.osID then
		return self:Remove()
	end

	dangautils.db:PrepareQuery([[
		SELECT id, userID FROM fundot_shop_items
			WHERE id = ?
	]], { self.id }, function(q, st, data)
		data = istable(data) and data[1]
		if not data or data.userID ~= self.owner.osID then
			self:Remove()
		end
	end)

	return self

end

function osItem:GetClassTable()

	return self.classTable

end

function osItem:OnGiven()

	if self:GetData('expire') and os.time() >= self:GetData('expire') then
		print(self:GetOwner(), 'warning', 'L.fundot_item_expired' .. self.name ..'L.fundot_item_expired2')
		self:Remove()
		return
	end

	local class = self:GetClassTable()
	if isfunction(class.OnGiven) then
		class.OnGiven(self)
	end

	return self

end

function osItem:OnTaken()

	local class = self:GetClassTable()
	if isfunction(class.OnTaken) then
		class.OnTaken(self)
	end

end

function osItem:OnBuy()

	local class = self:GetClassTable()
	if isfunction(class.OnBuy) then
		class.OnBuy(self)
	end

	return self

end

function osItem:CanUse()

	local class = self:GetClassTable()
	local can = class.CanUse
	if isfunction(class.CanUse) then can = class.CanUse(self) end

	return can

end

function osItem:Use(force)

	if force or self:CanUse() then
		local class = self:GetClassTable()
		if isfunction(class.Use) then
			class.Use(self)
		end
	end

	return self

end

function osItem:IsEquipped()

	return self:GetData('equipped')

end

function osItem:CanEquip(isUnequip)

	if self:IsEquipped() and not isUnequip then return false end

	local class = self:GetClassTable()
	local can = class.CanEquip
	if isfunction(class.CanEquip) then can = class.CanEquip(self) end

	return can

end

function osItem:Equip(force)

	if force or self:CanEquip() then
		local class = self:GetClassTable()
		if isfunction(class.Equip) then
			class.Equip(self)
		end
	end

	return self

end

function osItem:CanUnequip()

	if not self:IsEquipped() then return false end

	local class = self:GetClassTable()
	local can = class.CanUnequip
	if isfunction(class.CanUnequip) then can = class.CanUnequip(self) end

	if can == nil then
		can = self:CanEquip(true)
	end

	return can

end

function osItem:Unequip(force)

	if force or self:CanUnequip() then
		local class = self:GetClassTable()
		if isfunction(class.Unequip) then
			class.Unequip(self)
		end
	end

	return self

end

function osItem:CanTrade()

	if self:GetData('notrade') then return false end

	local class = self:GetClassTable()
	local can = class.CanTrade
	if isfunction(class.CanTrade) then can = class.CanTrade(self) end

	return can

end

function osItem:SetExpire(time)

	self:SetData('expire', time)
	return self

end

function osItem:SetExpireIn(time)

	self:SetExpire(os.time() + time)
	return self

end

function osItem:GetExpire()

	return self:GetData('expire')

end

function osItem:SetData(key, value)

	self.data[key] = value
	if self.id then
		dataSync[self.id] = self
	else
		timer.Simple(0.1, function() self:SetData(key, value) end)
	end
	return self

end

function osItem:GetData(key)

	return self.data[key]

end

function osItem:GetOwner()

	return self.owner

end

--
-- PLAYER EXTENSION
--

local ply = FindMetaTable 'Player'

function ply:osSyncItems()

	print('Items sync started for ' .. tostring(self))
	if istable(self.osItems) then
		table.Empty(self.osItems)
	else
		self.osItems = {}
	end

	dangautils.db:PrepareQuery([[
		SELECT id, itemName, itemClass, data FROM fundot_shop_items
			WHERE userID = ?
	]], { self.osID }, function(q, st, data)
		if st then
			for _, itemData in pairs(data) do
				osItem:CreateDromData(self, {
					id = itemData.id,
					class = itemData.itemClass,
					name = itemData.itemName,
					data = util.JSONToTable(itemData.data),
				})
			end

			print('Loaded items for ' .. tostring(self))
		else
			return print('Could not load items for ' .. tostring(self))
		end
	end)

end

function ply:osGetItems()

	return self.osItems

end

function ply:osGetItem(id)

	local inv = self:osGetItems()
	if not istable(inv) then return false end

	if isnumber(id) then
		return inv[id]
	elseif isstring(id) then
		for k, v in pairs(inv) do
			if v.class == id then return inv[k] end
		end
	end

	return false

end

function ply:osGiveItem(class, callback)

	return osItem:New(class, self, callback)

end

function ply:osTakeItem(id, noDB)

	local item = self:osGetItem(id)
	if item then
		return item:Remove(noDB)
	else
		return false
	end

end

function ply:osMoveItem(id, newOwner, noDB)

	local item = ply:osGetItem(id)
	if item then
		return item:Move(newOwner, noDB)
	else
		return false
	end

end

function ply:osPurchaseItem(class)

	local classTable = fundot.items[class]

	if not classTable or not (isfunction(classTable.CanBuy) and classTable.CanBuy(self) or classTable.CanBuy) then
		print(self, 'warning', 'L.fundot_you_cant_buy')
		return false
	end

	if not self:osAddMoney(-classTable.price) then
		print(self, 'warning', 'L.fundot_not_enough')
		self:osNetBalance()
		return false
	end

	self:osGiveItem(class, function(item)
		item:OnBuy()
		print(self, 'L.fundot_you_bought' .. classTable.name)

		dangautils.db:PrepareQuery([[
			UPDATE fundot_shop_users
				SET totalPurchases = totalPurchases + 1, totalSpent = totalSpent + ?
				WHERE id = ?
		]], {
			classTable.price,
			self.osID,
		})
	end)

end

-- Entity(1):osSyncPlayerData()
-- Entity(1):osGiveItem('tophat')

net.Receive('fundot.purchase', function(len, ply)

	local class = net.ReadString()
	ply:osPurchaseItem(class)

end)

net.Receive('fundot.action', function(len, ply)

	local id = net.ReadUInt(32)
	local action = net.ReadString()

	local item = ply:osGetItem(id)
	if not item then
		print(ply, 'L.fundot_error')
		ply:osNetInv()
		return
	end

	if action == 'use' then
		if item:CanUse() then
			item:Use()
		else
			print(ply, 'L.fundot_error_use')
		end
	elseif action == 'equip' then
		if item:CanEquip() then
			item:Equip()
		else
			print(ply, 'L.fundot_error_equip')
		end
	elseif action == 'unequip' then
		if item:CanUnequip() then
			item:Unequip()
		else
			print(ply, 'L.fundot_error_unequip')
		end
	elseif action == 'trade' then
		local newOwner = net.ReadEntity()
		if item:CanTrade() then
			if IsValid(newOwner) and newOwner:IsPlayer() and newOwner.osID then
				item:Move(newOwner)
				print(ply, 'L.fundot_you_give' .. item.name .. 'L.fundot_you_give2' .. newOwner:Name())
				print(newOwner, 'L.fundot_you_take' .. item.name .. 'L.fundot_you_take2' .. ply:Name())
			else
				print(ply, 'L.fundot_error_receiver')
			end
		else
			print(ply, 'L.fundot_give_error')
		end
	elseif action == 'sell' then
		if item:CanSell() then
			print(ply, 'ooc', 'L.fundot_soon_do')
		else
			print(ply, 'L.fundot_you_cant_sell')
		end
	end

end)
