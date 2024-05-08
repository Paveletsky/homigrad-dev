
do
SWEP.PrintName = "Байонет"
SWEP.Instructions = "Армейский штык-нож. Клинок штыка M9 — однолезвийный с пилой на обухе."
SWEP.Category = "Ближний Бой"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/w_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.UseHands = true

SWEP.HoldType = "knife"

SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.Base = "weapon_base"

SWEP.Primary.Sound = Sound( "Weapon_Knife.Single" )
SWEP.Primary.Damage = 25
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay = 0.65
SWEP.Primary.Force = 240

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	if !IsValid(DrawModel) then
		DrawModel = ClientsideModel( self.WorldModel, RENDER_GROUP_OPAQUE_ENTITY );
		DrawModel:SetNoDraw( true );
	else
		DrawModel:SetModel( self.WorldModel )

		local vec = Vector(55,55,55)
		local ang = Vector(-48,-48,-48):Angle()

		cam.Start3D( vec, ang, 20, x, y+35, wide, tall, 5, 4096 )
			cam.IgnoreZ( true )
			render.SuppressEngineLighting( true )

			render.SetLightingOrigin( self:GetPos() )
			render.ResetModelLighting( 50/255, 50/255, 50/255 )
			render.SetColorModulation( 1, 1, 1 )
			render.SetBlend( 255 )

			render.SetModelLighting( 4, 1, 1, 1 )

			DrawModel:SetRenderAngles( Angle( 0, RealTime() * 30 % 360, 0 ) )
			DrawModel:DrawModel()
			DrawModel:SetRenderAngles()

			render.SetColorModulation( 1, 1, 1 )
			render.SetBlend( 1 )
			render.SuppressEngineLighting( false )
			cam.IgnoreZ( false )
		cam.End3D()
	end

	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )

end

function Circle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end

    local a = math.rad( 0 ) -- This is needed for non absolute segment counts
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface.DrawPoly( cir )
end

local tr = {}
function EyeTrace(ply)
	tr.start = ply:GetAttachment(ply:LookupAttachment("eyes")).Pos
	tr.endpos = tr.start + ply:GetAngles():Forward() * 80
	tr.filter = ply
	return util.TraceLine(tr)
end

function SWEP:DrawHUD()
		if not (GetViewEntity() == LocalPlayer()) then return end
		if LocalPlayer():InVehicle() then return end
			local t = {}
			t.start = LocalPlayer():GetAttachment(LocalPlayer():LookupAttachment("eyes")).Pos
			t.endpos = t.start + LocalPlayer():GetAngles():Forward() * 80
			t.filter = self:GetOwner()
			local Tr = util.TraceLine(t)
			local hitPos = Tr.HitPos
			if Tr.Hit then

		local Size = math.Clamp(1 - ((hitPos - self:GetOwner():GetShootPos()):Length() / 80) ^ 2, .1, .3)
		surface.SetDrawColor(Color(200, 200, 200, 200))
		draw.NoTexture()
		Circle(hitPos:ToScreen().x, hitPos:ToScreen().y, 55 * Size, 32)

		surface.SetDrawColor(Color(255, 255, 255, 200))
		draw.NoTexture()
		Circle(hitPos:ToScreen().x, hitPos:ToScreen().y, 40 * Size, 32)
	end
end


function SWEP:Initialize()
self:SetHoldType( "knife" )
self.zalupa = true
-- modelka = self:GetOwner():GetModel()
end


function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime())
	self:SetHoldType("knife")
	if SERVER then
		self:GetOwner():EmitSound("weapons/physgun_off.wav",60)
	end
end

function SWEP:Holster()
	local angZero = Angle(0,0,0)
	local Bruh1 = Angle(-0,-115,15)
	local Bruh2 = Angle(35,0,0)
	local Bruh3 = Angle(5,-0,0)
	local ply = self:GetOwner()	

	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Forearm"),angZero,true )
	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),angZero,true )
	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),angZero,true )
	ply:SetNW2Bool("SUKAZAEBAL", false)
	return true
end

function SWEP:PrimaryAttack()
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay)  

	
	if SERVER then
		local ply = self:GetOwner()	
		if self.zalupa and ply:GetNW2Bool("SUKAZAEBAL") then
			self.zalupa = false
			self:GetOwner().adrenaline =  2
			ply.Organs["artery"] = 0
			self:GetOwner().pain = 0
			ply:SetNW2Bool("SUKAZAEBAL", false)
			-- ply:SetModel("models/outlaw/DoomEternal/DoomSlayerEternal.mdl")
			ply:EmitSound("hmcd/papich.wav", 50)
			timer.Simple(10, function ()
				-- ply:SetModel("models/player/Group02/male_08.mdl")
				-- ply:StopSound("hmcd/doom.wav")
				ply.adrenaline =  0.4
				-- ply.Organs["artery"] = 1
				-- ply.pain = 0
				-- ply.Blood = 5000
				self.zalupa = true
			end)
		end
		self:GetOwner():EmitSound( "weapons/slam/throw.wav",60 )
		self:GetOwner().stamina = math.max(self:GetOwner().stamina - 0.5,0)
		local neck21 = self:GetOwner():LookupBone("ValveBiped.Bip01_Neck1")
		if self:GetOwner():GetNW2Bool("SUKAZAEBAL") then
			local dmginfo = DamageInfo()
			dmginfo:SetDamageType( DMG_SLASH )
			dmginfo:SetAttacker( self:GetOwner() )
			dmginfo:SetInflictor( self )
			dmginfo:SetDamagePosition( self:GetOwner():GetBonePosition(neck21) )
			dmginfo:SetDamageForce( self:GetOwner():GetForward() * self.Primary.Force )
		end
	end
	self:GetOwner():LagCompensation( true )
	local ply = self:GetOwner()

	local tra = {}
	tra.start = ply:GetAttachment(ply:LookupAttachment("eyes")).Pos
	tra.endpos = tra.start + ply:GetAngles():Forward() * 80
	tra.filter = self:GetOwner()
	local Tr = util.TraceLine(tra)
	local t = {}
	local pos1, pos2
	local tr
	if not Tr.Hit then
		t.start = ply:GetAttachment(ply:LookupAttachment("eyes")).Pos
		t.endpos = t.start + ply:GetAngles():Forward() * 80
		t.filter = function(ent) return ent ~= self:GetOwner() and (ent:IsPlayer() or ent:IsRagdoll()) end
		t.mins = -Vector(6,6,6)
		t.maxs = Vector(6,6,6)
		tr = util.TraceHull(t)
	else
		tr = util.TraceLine(tra)
	end

	pos1 = tr.HitPos + tr.HitNormal
	pos2 = tr.HitPos - tr.HitNormal
	if true then
		if SERVER and tr.HitWorld then
			self:GetOwner():EmitSound(  "snd_jack_hmcd_knifehit.wav",60  )
		end

		if IsValid( tr.Entity ) and SERVER then
			local dmginfo = DamageInfo()
			dmginfo:SetDamageType( DMG_SLASH )
			dmginfo:SetAttacker( self:GetOwner() )
			dmginfo:SetInflictor( self )
			dmginfo:SetDamagePosition( tr.HitPos )
			dmginfo:SetDamageForce( self:GetOwner():GetForward() * self.Primary.Force )
			local angle = self:GetOwner():GetAngles().y - tr.Entity:GetAngles().y
			if angle < -180 then angle = 360 + angle end
			local suka = self:GetOwner()
			if suka.adrenaline > 1 then
				dmginfo:SetDamage( self.Primary.Damage * 1.5 * 45 )
			else
				dmginfo:SetDamage( self.Primary.Damage / 1.5 + 10 )
			end

			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
				self:GetOwner():EmitSound( "snd_jack_hmcd_knifestab.wav",60 )
			else
				if tr.Entity:GetClass() == "prop_ragdoll" then
					self:GetOwner():EmitSound(  "snd_jack_hmcd_knifestab.wav",60  )
				else
					self:GetOwner():EmitSound(  "snd_jack_hmcd_knifehit.wav",60  )
				end
			end
			tr.Entity:TakeDamageInfo( dmginfo )
		end
		self:GetOwner():EmitSound( Sound( "Weapon_Knife.Single" ),60 )
	end

	if SERVER and Tr.Hit then
		if IsValid(Tr.Entity) and Tr.Entity:GetClass()=="prop_ragdoll" then
			util.Decal("Impact.Flesh",pos1,pos2)
		else
			util.Decal("ManhackCut",pos1,pos2)
		end
	end

	self:GetOwner():LagCompensation( false )
end

function SWEP:SecondaryAttack()
	-- self:SetNextSecondaryFire( CurTime() )
	local ply = self:GetOwner()
	ply.Zalupa = not ply.Zalupa
	ply:SetNW2Bool("SUKAZAEBAL", ply.Zalupa)
	-- print(ply:GetNW2Bool("SUKAZAEBAL"))
end

function SWEP:Reload()
end

function SWEP:Think()
	do
		local ply = self:GetOwner()

		-- if SERVER then
			local angZero = Angle(0,0,0)
			local Bruh1 = Angle(-0,-115,15)
			local Bruh2 = Angle(35,0,0)
			local Bruh3 = Angle(35,-0,0)
			local ply = self:GetOwner()
			
			if not ply:GetNW2Bool("SUKAZAEBAL") then
				self:SetHoldType( "knife" )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Forearm"),angZero,true )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),angZero,true )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),angZero,true )
				
			else
				self:SetHoldType( "normal" )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Forearm"),Bruh1,true )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Bruh2,true )
				ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),Bruh3,true )
				
			end
		-- end
	end
end
end