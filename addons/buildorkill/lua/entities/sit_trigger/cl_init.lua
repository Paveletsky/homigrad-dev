include("shared.lua")

function ENT:Draw()
    local active_weapon = LocalPlayer():GetActiveWeapon()
    if IsValid(active_weapon) and active_weapon:GetClass() == "weapon_physgun" then
        self:SetMaterial("models/wireframe")
        self:DestroyShadow()
        self:DrawModel()
        self:RemoveAllDecals()
        self:SetColor(Color(212, 255, 223))
    end
end