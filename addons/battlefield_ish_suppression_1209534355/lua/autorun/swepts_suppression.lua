function ApplySuppressionEffect(bhit)
	if true then return end
	for _,v in pairs(ents.FindInSphere(bhit, 70)) do
		if v:IsPlayer() and v:Alive() then
			v:SetNWInt("SharpenAMT", math.Clamp(v:GetNWInt("SharpenAMT"), 0, 2) + 0.1)
			sound.Play("bul_snap/supersonic_snap_" .. math.random(1,12) .. ".wav", bhit, 75, 100, 1)
			timer.Remove(v:Name() .. "sharpenreset")
			timer.Create(v:Name() .. "sharpenreset", 2, 1, function()
				for i=1,(v:GetNWInt("SharpenAMT") / 0.05) + 1 do
					timer.Simple(0.1 * i, function()
						v:SetNWInt("SharpenAMT", math.Clamp(v:GetNWInt("SharpenAMT") - 0.1, 0, 100000))
					end)
				end
				v:EmitSound("player/suit_sprint.wav")
			end) --end timer function
		end --end alive test
	end --end for
end -- end function

local ENTITY = FindMetaTable( "Entity" )
ENTITY.oFireBullets = ENTITY.oFireBullets or ENTITY.FireBullets

function ENTITY:FireBullets( bul, she )

	local oldcb = bul.Callback
	bul.Callback = function( at, tr, dm )
		if oldcb then oldcb( at, tr, dm ) end
		if SERVER then ApplySuppressionEffect(tr.HitPos) end
	end

	return self:oFireBullets( bul, she )
	
end

--[[
hook.Add("EntityFireBullets", "SharpenWhenShotNear", function(ent, bul)

	if SERVER then
	
		local atk, trac, dmg = nil, nil, nil
		
		function bul:Callback(at, tr, dm)
			atk, trac, dmg = at, tr, dm
			print( "callback" )
			ApplySuppressionEffect(tr:GetDamagePosition())
		end --what a load of ass
		
	end
end)]]

hook.Add("RenderScreenspaceEffects", "ApplySuppression", function()

	DrawSharpen(5, LocalPlayer():GetNWInt("SharpenAMT"))
	
end)

hook.Add("PlayerInitialSpawn", "SetUpSharpenNWInt", function(ply)

	ply:SetNWInt("SharpenAMT", 0)

end)

hook.Add("PlayerDeath", "RemoveSharpenOnDeath", function(ply, i, a)

	ply:SetNWInt("SharpenAMT", 0)

end)