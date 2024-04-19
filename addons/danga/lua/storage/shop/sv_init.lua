hook.Add('dangautils.db.init', 'dangashop.db', function()

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

end)

dangautils.fs.include('sv_items.lua', 'sv')
local meta = FindMetaTable 'Player'

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
		INSERT INTO fundot_shop_items (userID, itemName, itemClass, data)
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
			owner.osItems[item.id] = item
			local shouldDo = true
			if isfunction(callback) then if callback(item) then shouldDo = false end end
			if shouldDo then item:OnGiven() end
			owner:osNetInv()
		else
			item:Remove()
		end
	end)

	return item

end

function osItem:IsEquipped()

	return self:GetData('equipped')

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

function osItem:CanEquip(isUnequip)

	if self:IsEquipped() and not isUnequip then return false end

	local class = self:GetClassTable()
	local can = class.CanEquip
	if isfunction(class.CanEquip) then can = class.CanEquip(self) end

	return can

end

function osItem:CanUse()

	local class = self:GetClassTable()
	local can = class.CanUse
	if isfunction(class.CanUse) then can = class.CanUse(self) end

	return can

end

function osItem:CreateDromData(owner, data)

	if not data.id or not data.class or not fundot.items[data.class] or not IsValid(owner) or not owner.osID then
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
	-- fundot.msg('Loaded item "' .. data.class .. '", ID: ' .. data.id .. ' for ' .. tostring(owner))
	item:OnGiven()

	return item

end

function osItem:OnBuy()

	local class = self:GetClassTable()
	if isfunction(class.OnBuy) then
		class.OnBuy(self)
	end

	return self

end


-- print('хуй')
-- Entity(1):osGiveItem('coffee')
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

function meta:osPurchaseItem(class)

	local classTable = fundot.items[class]

	if not classTable or not (isfunction(classTable.CanBuy) and classTable.CanBuy(self) or classTable.CanBuy) then
		self:ChatPrint('Ты не можешь купить это.')
		return false
	end

	if not self:osAddMoney(-classTable.price) then
		self:ChatPrint('Нет денег, ты что бомж?')
		self:osNetBalance()
		return false
	end

	self:osGiveItem(class, function(item)
		item:OnBuy()
		self:ChatPrint("Ты купил " .. classTable.name)

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
net.Receive('octoshop.purchase', function(len, ply)

	local class = net.ReadString()
	ply:osPurchaseItem(class)

end)

function meta:osGiveItem(class, callback)

	return osItem:New(class, self, callback)

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

function osItem:GetClassTable()

	return self.classTable

end

function osItem:OnGiven()

	if self:GetData('expire') and os.time() >= self:GetData('expire') then
		print(self:GetOwner(), 'warning', L.octoshop_item_expired .. self.name ..L.octoshop_item_expired2)
		self:Remove()
		return
	end

	local class = self:GetClassTable()
	if isfunction(class.OnGiven) then
		class.OnGiven(self)
	end

	return self

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

local meta = FindMetaTable 'Player'

function meta:osSyncItems()

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
