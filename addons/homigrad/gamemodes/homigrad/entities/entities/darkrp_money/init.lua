include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_lab/clipboard.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    local phys = self:GetPhysicsObject()

    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:Use(ply)
    -- if ply:KeyDown(IN_WALK) then
        darkrp.AddMoney(ply,self:GetNWInt("Amount",0))
        darkrp.Notify("Ты поднял: " .. self:GetNWInt("Amount",0) .. "$",NOTIFY_GENERIC,5,ply)
        self:Remove()
    -- elseif not self:IsPlayerHolding() then
        -- ply:PickupObject(self)
    -- end
end
