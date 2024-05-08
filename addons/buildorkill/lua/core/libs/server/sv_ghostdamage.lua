local previousDrivers = {}
hook.Add( "PlayerLeaveVehicle", "bkGhostMode", function( driver, vehicle )
	previousDrivers[vehicle] = driver

	timer.Create( "build_pvp:vehicle"..vehicle:GetCreationID(), 4, 1, function()
		previousDrivers[vehicle] = nil
	end )
end )

hook.Add( "PlayerEnteredVehicle", "bkGhostMode", function( driver, vehicle )
	previousDrivers[vehicle] = nil
end )

local function GetVehicleAttacker( attacker )
	if IsValid( attacker ) then
		if attacker:IsVehicle() then
			local vehicle = attacker
			attacker = vehicle:GetDriver()
			if not IsValid( attacker ) then
				attacker = previousDrivers[vehicle]
			end
			attacker = IsValid( attacker ) and attacker or nil
		end
	else
		attacker = nil
	end
	return attacker
end

hook.Add( "EntityTakeDamage", "bkGhostMode", function( target, dmg )
	if IsValid( target ) and target:IsPlayer() then
		local attacker = GetVehicleAttacker(dmg:GetAttacker())

		if (attacker and attacker:IsPlayer()) and (attacker.isGhost or attacker:InSafeZone()) or (target:InSafeZone()) then
			dmg:SetDamage( 0 )
			return true
		end
	end
end )

hook.Add( "PlayerShouldTakeDamage", "bkGhostMode", function( ply, attacker )
	attacker = GetVehicleAttacker(attacker)

	if attacker and attacker:IsPlayer() and (attacker.isGhost or attacker:InSafeZone()) or (ply:InSafeZone()) then
		return false
	end
end)

hook.Add( "ScalePlayerDamage", "bkGhostMode", function( ply, hitgroup, dmginfo )
	local attacker = GetVehicleAttacker(dmginfo:GetAttacker())

	if attacker and attacker:IsPlayer() and (attacker.isGhost or attacker:InSafeZone()) or (ply:InSafeZone()) then
		dmginfo:SetDamage( 0 )
		return true
	end
end)

hook.Remove("ScalePlayerDamage", "bkGhostMode")
hook.Remove("PlayerShouldTakeDamage", "bkGhostMode")
hook.Remove("EntityTakeDamage", "bkGhostMode")
hook.Remove("PlayerEnteredVehicle", "bkGhostMode")
hook.Remove("PlayerLeaveVehicle", "bkGhostMode")
