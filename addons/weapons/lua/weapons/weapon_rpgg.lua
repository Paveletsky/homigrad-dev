SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "РПГ"
SWEP.Author 				= "Homigrad"
SWEP.Instructions			= "Ручной противотанковый гранатомёт"
SWEP.Category 				= "Оружие"
SWEP.WepSelectIcon			= "pwb/sprites/m134"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Ammo = "RPG_Round"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.TwoHands = true
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "rpg"

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/weapons/insurgency/w_rpg7.mdl"
SWEP.WorldModel				= "models/weapons/insurgency/w_rpg7.mdl"


if SERVER then
    function SWEP:GetPosAng()
        local owner = self:GetOwner()
        local Pos,Ang = owner:GetBonePosition(owner:LookupBone("ValveBiped.Bip01_R_Hand"))
        if not Pos then return end
        
        Pos:Add(Ang:Forward() * self.dwmForward)
        Pos:Add(Ang:Right() * self.dwmRight)
        Pos:Add(Ang:Up() * self.dwmUp)


        Ang:RotateAroundAxis(Ang:Up(),self.dwmAUp)
        Ang:RotateAroundAxis(Ang:Right(),self.dwmARight)
        Ang:RotateAroundAxis(Ang:Forward(),self.dwmAForward)

        return Pos,Ang
    end
else
    function SWEP:SetPosAng(Pos,Ang)
        self.Pos = Pos
        self.Ang = Ang
    end
    function SWEP:GetPosAng()
        return self.Pos,self.Ang
    end
end

function SWEP:PrimaryAttack()
    if self:Clip1() <= 0 then return end
    local shotpos = self:GetOwner():GetPos()+Vector(0,0,50) + self:GetOwner():EyeAngles():Forward()*60 +self:GetOwner():EyeAngles():Right()*5
    if SERVER then 
        local rocket = ents.Create( "gb_rocket_rp3" )
        rocket:SetPos(shotpos)
        rocket:SetAngles( self:GetOwner():EyeAngles()+Angle(5,5,0) )
        rocket:Spawn()
        rocket:Launch()
    end
    self:TakePrimaryAmmo(1)
end

--models/weapons/insurgency/w_rpg7.mdl
--models/weapons/insurgency/w_rpg7_projectile.mdl

SWEP.vbwPos = Vector(5,-4,-4)