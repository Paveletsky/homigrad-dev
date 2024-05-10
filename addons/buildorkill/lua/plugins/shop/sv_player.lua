util.AddNetworkString 'HG:RequestBalance'
util.AddNetworkString 'HG:RequestInventory'
util.AddNetworkString 'HG:RequestShop'
util.AddNetworkString 'fundot.useCoupon'

local meta = FindMetaTable 'Player'

function meta:osCooldown(delay, ignoreCheck)

	local canDo = ignoreCheck or not self.osNextAction or CurTime() > self.osNextAction
	if not canDo then
		print(self, 'warning', 'L.too_fast')
	else
		self.osNextAction = CurTime() + delay
	end

	return canDo

end

function meta:osSyncPlayerData()

	dangautils.db:PrepareQuery([[
		SELECT id, balance FROM fundot_shop_users
			WHERE steamID = ?
	]], {
		self:SteamID()
	}, function(q, st, data)
		if not IsValid(self) then return end

		data = istable(data) and data[1]
		if data then
			-- load data
			self.osID = data.id
			self.osBalance = data.balance
			self:osSyncItems()
		else
			-- new player
			print('New player: ' .. tostring(self))
			dangautils.db:PrepareQuery([[
				INSERT INTO fundot_shop_users (steamID, steamID64, balance, totalTopup, totalSpent, totalPurchases)
				VALUES (?, ?, 0, 0, 0, 0)
			]], {
				self:SteamID(),
				self:SteamID64(),
			}, function(q, st, data)
				if not IsValid(self) then return end

				if st then
					self:osSyncPlayerData()
				else
					print('ERROR: Could not initialize player: ' .. tostring(self))
					-- ply:Kick('Мы не смогли загрузить твои данные из магазина. Похоже на хакерские проделки, дружище')
				end
			end)
		end
	end)

end
hook.Add('HG:PlayerLoaded', 'fundot', meta.osSyncPlayerData)

function meta:osGetMoney()

	self.osBalance = self.osBalance or 0
	return self.osBalance

end

function meta:osHasMoney(val)

	return self:osGetMoney() >= val

end

function meta:osAddMoney(val)

	if not self.osID then return false end
	if not self:osHasMoney(-val) then return false end

	self.osBalance = self.osBalance + val
	dangautils.db:PrepareQuery([[
		UPDATE fundot_shop_users
			SET balance = balance + ?
			WHERE id = ?
	]], { val, self.osID }, function(q, st, data)
		if not IsValid(self) then return end
		if st then
			self:osSyncBalance()
		else
			print('Failed to update balance for ' .. tostring(self))
		end
	end)

	return true

end

function meta:osSyncBalance()

	if not self.osID then return false end

	dangautils.db:PrepareQuery([[
		SELECT id, balance FROM fundot_shop_users
		WHERE id = ?
	]], { self.osID }, function(q, st, data)
		if not IsValid(self) then return end
		data = istable(data) and data[1]
		if data then
			if self.osBalance and self.osBalance < data.balance then
				-- print(self, 'ooc', L.fundot_update_balance .. fundot.formatMoney(data.balance - self.osBalance))
			end

			self.osBalance = data.balance
			self:osNetBalance()
			print('Updated balance for ' .. tostring(self) .. ': ' .. (self.osBalance))
		else
			print('Failed to update balance for ' .. tostring(self))
		end
	end)

end

function meta:osNetBalance()

	net.Start('HG:RequestBalance')
		net.WriteUInt(self.osBalance or 0, 32)
	net.Send(self)

end

function meta:osNetInv()

	local toSend = {}
	for itemID, item in pairs(self:osGetItems()) do
		table.insert(toSend, {
			id = itemID,
			class = item.class,
			name = item.name,
			canUse = item:CanUse(),
			PAC3 = item.PAC3,
			canEquip = item:CanEquip(),
			canUnequip = item:CanUnequip(),
			canTrade = item:CanTrade(),
			equipped = item:IsEquipped(),
			expire = item:GetExpire(),
			active = item:GetData('active'),
			data = item.data,
			icon = item.classTable.icon,
		})
	end

	net.Start('HG:RequestInventory')
		net.WriteTable(toSend)
	net.Send(self)

end

function meta:osNetShop()

	local toSend = {}
	for class, item in pairs(fundot.items) do
		local canBuy = item.CanBuy
		table.insert(toSend, {
			class = class,
			name = item.name,
			PAC3 = item.PAC3,
			cat = item.cat,
			desc = item.desc,
			price = item.price,
			order = item.order,
			icon = item.icon,
			hidden = item.hidden,
			attributes = item.attributes,
			canBuy = isfunction(canBuy) and canBuy(self) or canBuy,
		})
	end

	net.Start('HG:RequestShop')
		net.WriteTable(toSend)
	net.Send(self)

end

net.Receive('HG:RequestShop', function(len, ply)

	-- local cd = ply:osCooldown(3)
	-- if not cd then return end

	ply:osNetShop()

end)

net.Receive('HG:RequestInventory', function(len, ply)

	-- local cd = ply:osCooldown(3)
	-- if not cd then return end

	ply:osSyncBalance()
	ply:osNetInv()

end)