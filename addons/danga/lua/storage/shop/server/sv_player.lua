util.AddNetworkString 'octoshop.rBalance'
util.AddNetworkString 'octoshop.rInventory'
util.AddNetworkString 'octoshop.rShop'
util.AddNetworkString 'octoshop.useCoupon'

local meta = FindMetaTable 'Player'

function meta:osGetItems()

	return self.osItems or {}

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
				self:ChatPrint("Баланс обновлен: " .. data.balance - self.osBalance)
			end

			self.osBalance = data.balance
			self:osNetBalance()
			print('Updated balance for ' .. tostring(self) .. ': ' .. self.osBalance)
		else
			print('Failed to update balance for ' .. tostring(self))
		end
	end)

end

function meta:osNetBalance()

	net.Start('octoshop.rBalance')
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
			canEquip = item:CanEquip(),
			canUnequip = item:CanUnequip(),
			equipped = item:IsEquipped(),
			expire = item:GetExpire(),
			active = item:GetData('active'),
			data = item.data,
		})
	end

	net.Start('octoshop.rInventory')
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
			cat = item.cat,
			desc = item.desc,
			PAC3 = item.PAC3,
			price = item.price,
			order = item.order,
			icon = item.icon,
			hidden = item.hidden,
			attributes = item.attributes,
			canBuy = isfunction(canBuy) and canBuy(self) or canBuy,
		})
	end

	net.Start('octoshop.rShop')
		net.WriteTable(toSend)
	net.Send(self)

end

net.Receive('octoshop.rShop', function(len, ply)

	ply:osNetShop()

end)

net.Receive('octoshop.rInventory', function(len, ply)

	ply:osSyncBalance()
	ply:osNetInv()

end)

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

hook.Add('player.loaded', 'octoshop', meta.osSyncPlayerData)