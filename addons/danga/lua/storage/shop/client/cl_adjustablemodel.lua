local e = {}

function e:Init()
    self:Dock(FILL)
    self.vRawCamPos = self.vRawCamPos or Vector()
    self.tgtLookAngle = self.tgtLookAngle or Angle()
    self.camPos = self.camPos or Vector(50, 100, 20)
    self.mdlOffset = self.mdlOffset or Vector()
end

function e:UpdatePos()
    local e = self.Entity:OBBCenter() - self.mdlOffset
    self.vRawCamPos = e - self.aLookAngle:Forward() * (e - self.vRawCamPos):Length()
    if self.camOffset then
        local e = self.camOffset
        self.vCamPos = self.vRawCamPos + self.aLookAngle:Right() * e.x + self.aLookAngle:Forward() * e.y + self.aLookAngle:Up() * e.z
    else
        self.vCamPos = self.vRawCamPos
    end
end

function e:SetModel(...)
    self.BaseClass.SetModel(self, ...)
    local e = self.Entity
    e:SetPos(-e:OBBCenter() + (self.mdlOffset or Vector()))
    self:SetCamPos(self.camPos)
    self.vRawCamPos = self.camPos
    self:SetLookAng((-self.camPos):Angle())
    self.tgtLookAngle = self.aLookAngle
    self:SetFOV(30 * (self.fovMultiplier or 1))
    self:UpdatePos()
end

function e:FirstPersonControls()
    if not self.canControl then return end
    local o, e = self:CaptureMouse()
    local n = self:GetFOV() / 180
    o = o * -0.5 * n
    e = e * 0.5 * n
    if self.MouseKey == MOUSE_LEFT then
        self:SetCursor('blank')
        self.tgtLookAngle = self.tgtLookAngle + Angle(e * 4, o * 4, 0)
        self.tgtLookAngle.p = math.Clamp(self.tgtLookAngle.p, -89, 89)
    end
end

function e:Think()
    self.BaseClass.Think(self)
    if self.canControl and IsValid(self.Entity) and self.aLookAngle ~= self.tgtLookAngle then
        self.aLookAngle = LerpAngle(FrameTime() * 8, self.aLookAngle, self.tgtLookAngle)
        self:UpdatePos()
    end
end

function e:OnMouseReleased(e)
    self.BaseClass.OnMouseReleased(self, e)
    self:SetCursor('hand')
end

function e:OnMouseWheeled(o)
    local e = self:GetFOV()
    if o > 0 then
        e = e / 1.15
    else
        e = e * 1.15
    end
    self:SetFOV(math.Clamp(e, 3, 100))
end

function e:LayoutEntity()
end

function e:FixPosition()
    local e = self.Entity:OBBCenter() - (self.mdlOffset or vector_zero)
    self.vCamPos = e - self.aLookAngle:Forward() * (e - self.vCamPos):Length()
end

function e:MoveCameraToOffset(newOffset, duration)
    if not duration or duration <= 0 then
        self.mdlOffset = newOffset
        self:UpdatePos()
        return
    end
    
    local startTime = CurTime()
    local startPos = self.mdlOffset
    local endTime = startTime + duration
    
    timer.Create("CameraMoveTimer", 0.01, math.ceil(duration / 0.01), function()
        local t = (CurTime() - startTime) / duration
        if t >= 1 then
            self.mdlOffset = newOffset
            self:UpdatePos()
            timer.Remove("CameraMoveTimer")
        else
            self.mdlOffset = LerpVector(t, startPos, newOffset)
            self:UpdatePos()
        end
    end)
end

vgui.Register('fdDAdjustableModelPanel', e, 'DAdjustableModelPanel')