local PANEL = {}

DEFINE_BASECLASS("DButton")

function PANEL:Init()
    self.rnd = 0
end

function PANEL:Paint(w, h)
    local off = h > 20 and 2 or 1
	
    draw.RoundedBox(self.rnd, 0, 1, w, h - off, Color(0, 0, 0, 0))
    
    self:SetMaterial('sbox/armor-bar.png', w - self.rnd, h+5, 5, 0, Color(150, 150, 150, 155))
    self:SetMaterial('sbox/armor-bar.png', w - self.rnd, h, 0, -3, Color(0, 0, 0, self.drkness))

    if self.Disabled then
        draw.RoundedBox(self.rnd, 0, 1, w, h, Color(25,25,25, 0))
    elseif self.Hovered then
        draw.RoundedBox(0, 0, 1, w, h - off, Color(0, 0, 0, self.drkness / 10))
    end

    self:SetFontInternal( "bkFontMini" )
    self:SetFGColor( color_white )
end

function PANEL:SetMaterial(mat, w, h, x, y, col)
    surface.SetMaterial( Material( mat, 'smooth' ) )
    surface.SetDrawColor(col or color_white)
    surface.DrawTexturedRect( x, y, w, h )
end

function PANEL:OnCursorEntered()
    local start = RealTime()            

    self:SetCursor('hand')
    self.Think = function()
        local st = (RealTime() - start) * 15

        self.drkness = Lerp(st, 255, 200)
        self.rnd = Lerp( st, 0, self:GetWide() * .2 ) 
    end
end

function PANEL:OnCursorExited()
    local start = RealTime()            

    self:SetCursor('hand')
    self.Think = function()
        local st = (RealTime() - start) * 5
        self.drkness = Lerp(st, self.drkness, 255)
        self.rnd = Lerp( st, self.rnd, 0 ) 
    end
end

vgui.Register("bkButton", PANEL, "DButton")

-- -- do
--     if LocalPlayer():IsAdmin() then
--         cumtest = cumtest and cumtest:Remove() or vgui.Create('bkSubsMenu')
--     end 
-- -- end
