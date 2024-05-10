AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/hunter/plates/plate.mdl")
    self:SetSolid(SOLID_BBOX)
    self:SetAngles(Angle(0, 0, 0))
    self:DrawShadow(false)
    self:SetTrigger(true)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

    hook.Add("PhysgunPickup", self, function(ply, ent)
        if ent == self then
            return false
        end
    end)
end