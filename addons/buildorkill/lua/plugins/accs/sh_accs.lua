if (!pace) then return end

ix = ix or {}
ix.pac = ix.pac or {}
ix.pac.list = ix.pac.list or {}

fundot = fundot or {}
fundot.accs = fundot.accs or {}

PLUGIN = GAMEMODE or {}

CAMI.RegisterPrivilege({
	Name = "Helix - Manage PAC",
	MinAccess = "superadmin"
})

-- this stores pac3 part information to plugin's table'
function ix.pac.RegisterPart(id, outfit)
	fundot.accs[id] = outfit
end

bok.util.IncludeDir("plugins/accs/config/pac3")

-- Fixing the PAC3's default stuffs to fit on Helix.
if (CLIENT) then
	-- Disable the "in editor" HUD element.
	hook.Add("InitializedPlugins", "PAC3Fixer", function()
		hook.Remove("HUDPaint", "pac_in_editor")
	end)

	-- Remove PAC3 LoadParts
	function pace.LoadParts(name, clear, override_part) end

	-- Prohibits players from deleting their own PAC3 outfit.
	concommand.Add("pac_clear_parts", function()
		RunConsoleCommand("pac_restart")
	end)

	-- you need the proper permission to open the editor
	function PLUGIN:PrePACEditorOpen()
		if !LocalPlayer():IsSuperAdmin() then
			bok.gui.Notify('Доступно по подписке "Шпакер". Магазин в F4.', 3, 'vo/k_lab/ba_whoops.wav')
			return false
		end
	end
end

function PLUGIN:pac_CanWearParts(client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage PAC", nil)) then
		return false
	end
end

local meta = FindMetaTable("Player")

-- Get Player's PAC3 Parts.
function meta:GetParts()
	if (!pac) then return end

	return self:GetNetVar("parts", {})
end
-- Entity(1):SetNetVar("parts", {})
-- PrintTable(Entity(1):GetParts())

if (SERVER) then
	util.AddNetworkString("ixPartWear")
	util.AddNetworkString("ixPartRemove")
	util.AddNetworkString("ixPartReset")

	function meta:AddPart(uniqueID, item)
		if (!pac) then return end

		local curParts = self:GetParts()

		-- wear the parts.
		net.Start("ixPartWear")
			net.WriteEntity(self)
			net.WriteString(uniqueID)
		net.Broadcast()

		curParts[uniqueID] = true

		self:SetNetVar("parts", curParts)
	end

	function meta:RemovePart(uniqueID)
		if (!pac) then return end

		local curParts = self:GetParts()

		-- remove the parts.
		net.Start("ixPartRemove")
			net.WriteEntity(self)
			net.WriteString(uniqueID)
		net.Broadcast()

		curParts[uniqueID] = nil

		self:SetNetVar("parts", curParts)
	end

	function meta:ResetParts()
		if (!pac) then return end

		net.Start("ixPartReset")
			net.WriteEntity(self)
			net.WriteTable(self:GetParts())
		net.Broadcast()

		self:SetNetVar("parts", {})
	end

	function PLUGIN:PlayerSwitchWeapon(client, oldWeapon, newWeapon)
		local oldItem = IsValid(oldWeapon) and oldWeapon.ixItem
		local newItem = IsValid(newWeapon) and newWeapon.ixItem

		if (oldItem and oldItem.isWeapon and oldItem:GetData("equip") and oldItem.pacData) then
			oldItem:WearPAC(client)
		end

		if (newItem and newItem.isWeapon and newItem.pacData) then
			newItem:RemovePAC(client)
		end
	end
else
	local function AttachPart(client, uniqueID)
		local pacData = fundot.accs[uniqueID]

		if (pacData) then

			if (isfunction(client.AttachPACPart)) then
				client:AttachPACPart(pacData)
			else
				pac.SetupENT(client)

				timer.Simple(0.1, function()
					if (IsValid(client) and isfunction(client.AttachPACPart)) then
						client:AttachPACPart(pacData)
					end
				end)
			end
		end
	end

	fundot.AttachPAC = AttachPart

	local function RemovePart(client, uniqueID)
		local pacData = fundot.accs[uniqueID]

		if (pacData) then
			if (isfunction(client.RemovePACPart)) then
				client:RemovePACPart(pacData)
			else
				pac.SetupENT(client)
			end
		end
	end

	hook.Add("Think", "ix_pacupdate", function()
		if (!pac) then
			hook.Remove("Think", "ix_pacupdate")
			return
		end

		if (IsValid(pac.LocalPlayer)) then
			for _, v in ipairs(player.GetAll()) do

				local parts = v:GetParts()

				for k2, _ in pairs(parts) do
					AttachPart(v, k2)
				end
				
			end

			hook.Remove("Think", "ix_pacupdate")
		end
	end)

	net.Receive("ixPartWear", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uid = net.ReadString()

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		AttachPart(wearer, uid)
	end)

	net.Receive("ixPartRemove", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uid = net.ReadString()

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		RemovePart(wearer, uid)
	end)

	net.Receive("ixPartReset", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uidList = net.ReadTable()

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		for k, _ in pairs(uidList) do
			RemovePart(wearer, k)
		end
	end)

	function PLUGIN:DrawPlayerRagdoll(entity)
		local ply = entity.objCache

		if (IsValid(ply)) then
			if (!entity.overridePAC3) then
				if ply.pac_parts then
					for _, part in pairs(ply.pac_parts) do
						if part.last_owner and part.last_owner:IsValid() then
							hook.Run("OnPAC3PartTransferred", part)
							part:SetOwner(entity)
							part.last_owner = entity
						end
					end
				end
				ply.pac_playerspawn = pac.RealTime -- used for events

				entity.overridePAC3 = true
			end
		end
	end

	

	-- function PLUGIN:OnEntityCreated(entity)
	-- 	local class = entity:GetClass()

	-- 	-- For safe progress, I skip one frame.
	-- 	timer.Simple(0.01, function()
	-- 		if (class == "prop_ragdoll") then
	-- 			if (entity:GetNetVar("player")) then
	-- 				entity.RenderOverride = function()
	-- 					entity.objCache = entity:GetNetVar("player")
	-- 					entity:DrawModel()

	-- 					hook.Run("DrawPlayerRagdoll", entity)
	-- 				end
	-- 			end
	-- 		end

	-- 		if (class:find("HL2MPRagdoll")) then
	-- 			for _, v in ipairs(player.GetAll()) do
	-- 				if (v:GetRagdollEntity() == entity) then
	-- 					entity.objCache = v
	-- 				end
	-- 			end

	-- 			entity.RenderOverride = function()
	-- 				entity:DrawModel()

	-- 				hook.Run("DrawPlayerRagdoll", entity)
	-- 			end
	-- 		end
	-- 	end)
	-- end
end
