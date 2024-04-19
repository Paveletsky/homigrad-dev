local surface_CreateFont = CLIENT and surface.CreateFont
local AccessorFunc = AccessorFunc
local vgui_Create = CLIENT and vgui.Create
local derma_SkinHook = CLIENT and derma.SkinHook
local math_max = math.max
local math_min = math.min
local RealTime = RealTime
local Lerp = Lerp
local math_Clamp = math.Clamp
local gui_MouseY = CLIENT and gui.MouseY
local derma_DefineControl = CLIENT and derma.DefineControl
A_AM.ActMod.LuaFon = true
if SERVER then return end
surface_CreateFont("ActMod_close", {
    font = "Roboto Bk",
    extended = false,
    bold = true,
    size = 25,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

surface_CreateFont("ActMod_a1", {
    font = "Roboto",
    extended = false,
    bold = true,
    size = 25,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = false
})

surface_CreateFont("ActMod_a2", {
    font = "CloseCaption_Bold",
    extended = false,
    bold = true,
    size = 20,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true
})

surface_CreateFont("ActMod_a3", {
    font = "Roboto",
    extended = false,
    bold = true,
    size = 20,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true
})

surface_CreateFont("ActMod_a4", {
    font = "CloseCaption_Bold",
    extended = false,
    bold = true,
    size = 12,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true
})

surface_CreateFont("ActMod_a5", {
    font = "",
    extended = false,
    size = 17,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = false,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = true,
    additive = false,
    outline = false,
})

surface_CreateFont("ActMod_a6", {
    font = "",
    extended = false,
    size = 25,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = false,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = true,
    additive = false,
    outline = false,
})

surface_CreateFont("ActMod_e1", {
    font = "CloseCaption_Bold",
    extended = false,
    bold = true,
    size = 16,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true
})

local PANEL = {}
AccessorFunc(PANEL, "m_HideButtons", "HideButtons")
function PANEL:Init()
    self.Offset = 0
    self.Scroll = 0
    self.CanvasSize = 1
    self.BarSize = 1
    self.btnUp = vgui_Create("DButton", self)
    self.btnUp:SetText("")
    self.btnUp.DoClick = function(self) self:GetParent():AddScroll(-1) end
    self.btnUp.Paint = function(panel, w, h) derma_SkinHook("Paint", "ButtonUp", panel, w, h) end
    self.btnDown = vgui_Create("DButton", self)
    self.btnDown:SetText("")
    self.btnDown.DoClick = function(self) self:GetParent():AddScroll(1) end
    self.btnDown.Paint = function(panel, w, h) derma_SkinHook("Paint", "ButtonDown", panel, w, h) end
    self.btnGrip = vgui_Create("DScrollBarGrip", self)
    self:SetSize(15, 15)
    self:SetHideButtons(false)
end

function PANEL:SetEnabled(b)
    if not b then
        self.Offset = 0
        self:SetScroll(0)
        self.HasChanged = true
    end

    self:SetMouseInputEnabled(b)
    self:SetVisible(b)
    if self.Enabled ~= b then
        self:GetParent():InvalidateLayout()
        if self:GetParent().OnScrollbarAppear then self:GetParent():OnScrollbarAppear() end
    end

    self.Enabled = b
end

function PANEL:Value()
    return self.Pos
end

function PANEL:BarScale()
    if self.BarSize == 0 then return 1 end
    return self.BarSize / (self.CanvasSize + self.BarSize)
end

function PANEL:SetUp(_barsize_, _canvassize_)
    self.BarSize = _barsize_
    self.CanvasSize = math_max(_canvassize_ - _barsize_, 1)
    self:SetEnabled(_canvassize_ > _barsize_)
    self:InvalidateLayout()
end

function PANEL:OnMouseWheeled(dlta)
    if not self:IsVisible() then return false end
    return self:AddScroll(dlta * -2)
end

local length, ease, amount = 0.5, 0.25, 30
local function sign(num)
    return num > 0
end

local function getBiggerPos(signOld, signNew, old, new)
    if signOld ~= signNew then return new end
    if signNew then
        return math_max(old, new)
    else
        return math_min(old, new)
    end
end

local tScroll = 0
local newerT = 0
function PANEL:AddScroll(dlta)
    self.Old_Pos = nil
    self.Old_Sign = nil
    local OldScroll = self:GetScroll()
    dlta = dlta * amount
    local anim = self:NewAnimation(length, 0, ease)
    anim.StartPos = OldScroll
    anim.TargetPos = OldScroll + dlta + tScroll
    tScroll = tScroll + dlta
    local ctime = RealTime()
    local doing_scroll = true
    newerT = ctime
    anim.Think = function(anim, pnl, fraction)
        local nowpos = Lerp(fraction, anim.StartPos, anim.TargetPos)
        if ctime == newerT then
            self:SetScroll(getBiggerPos(self.Old_Sign, sign(dlta), self.Old_Pos, nowpos))
            tScroll = tScroll - (tScroll * fraction)
        end

        if doing_scroll then
            self.Old_Sign = sign(dlta)
            self.Old_Pos = nowpos
        end

        if ctime ~= newerT then doing_scroll = false end
    end
    return math_Clamp(self:GetScroll() + tScroll, 0, self.CanvasSize) ~= self:GetScroll()
end

function PANEL:SetScroll(scrll)
    if not self.Enabled then
        self.Scroll = 0
        return
    end

    self.Scroll = math_Clamp(scrll, 0, self.CanvasSize)
    self:InvalidateLayout()
    local func = self:GetParent().OnVScroll
    if func then
        func(self:GetParent(), self:GetOffset())
    else
        self:GetParent():InvalidateLayout()
    end
end

function PANEL:AnimateTo(scrll, length, delay, ease)
    local anim = self:NewAnimation(length, delay, ease)
    anim.StartPos = self.Scroll
    anim.TargetPos = scrll
    anim.Think = function(anim, pnl, fraction) pnl:SetScroll(Lerp(fraction, anim.StartPos, anim.TargetPos)) end
end

function PANEL:GetScroll()
    if not self.Enabled then self.Scroll = 0 end
    return self.Scroll
end

function PANEL:GetOffset()
    if not self.Enabled then return 0 end
    return self.Scroll * -1
end

function PANEL:Think()
end

function PANEL:Paint(w, h)
    derma_SkinHook("Paint", "VScrollBar", self, w, h)
    return true
end

function PANEL:OnMousePressed()
    local x, y = self:CursorPos()
    local PageSize = self.BarSize
    if y > self.btnGrip.y then
        self:SetScroll(self:GetScroll() + PageSize)
    else
        self:SetScroll(self:GetScroll() - PageSize)
    end
end

function PANEL:OnMouseReleased()
    self.Dragging = false
    self.DraggingCanvas = nil
    self:MouseCapture(false)
    self.btnGrip.Depressed = false
end

function PANEL:OnCursorMoved(x, y)
    if not self.Enabled then return end
    if not self.Dragging then return end
    local x, y = self:ScreenToLocal(0, gui_MouseY())
    y = y - self.btnUp:GetTall()
    y = y - self.HoldPos
    local BtnHeight = self:GetWide()
    if self:GetHideButtons() then BtnHeight = 0 end
    local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()
    y = y / TrackSize
    self:SetScroll(y * self.CanvasSize)
end

function PANEL:Grip()
    if not self.Enabled then return end
    if self.BarSize == 0 then return end
    self:MouseCapture(true)
    self.Dragging = true
    local x, y = self.btnGrip:ScreenToLocal(0, gui_MouseY())
    self.HoldPos = y
    self.btnGrip.Depressed = true
end

function PANEL:PerformLayout()
    local Wide = self:GetWide()
    local BtnHeight = Wide
    if self:GetHideButtons() then BtnHeight = 0 end
    local Scroll = self:GetScroll() / self.CanvasSize
    local BarSize = math_max(self:BarScale() * (self:GetTall() - (BtnHeight * 2)), 10)
    local Track = self:GetTall() - (BtnHeight * 2) - BarSize
    Track = Track + 1
    Scroll = Scroll * Track
    self.btnGrip:SetPos(0, BtnHeight + Scroll)
    self.btnGrip:SetSize(Wide, BarSize)
    if BtnHeight > 0 then
        self.btnUp:SetPos(0, 0, Wide, Wide)
        self.btnUp:SetSize(Wide, BtnHeight)
        self.btnDown:SetPos(0, self:GetTall() - BtnHeight)
        self.btnDown:SetSize(Wide, BtnHeight)
        self.btnUp:SetVisible(true)
        self.btnDown:SetVisible(true)
    else
        self.btnUp:SetVisible(false)
        self.btnDown:SetVisible(false)
        self.btnDown:SetSize(Wide, BtnHeight)
        self.btnUp:SetSize(Wide, BtnHeight)
    end
end

derma_DefineControl("AM4_DVScrollBar", "AM4 Scrollbar", PANEL, "Panel")
local PANEL = {}
AccessorFunc(PANEL, "Padding", "Padding")
AccessorFunc(PANEL, "pnlCanvas", "Canvas")
function PANEL:Init()
    self.pnlCanvas = vgui_Create("Panel", self)
    self.pnlCanvas.OnMousePressed = function(self, code) self:GetParent():OnMousePressed(code) end
    self.pnlCanvas:SetMouseInputEnabled(true)
    self.pnlCanvas.PerformLayout = function(pnl)
        self:PerformLayoutInternal()
        self:InvalidateParent()
    end

    self.VBar = vgui_Create("AM4_DVScrollBar", self)
    self.VBar:Dock(RIGHT)
    self:SetPadding(0)
    self:SetMouseInputEnabled(true)
    self:SetPaintBackgroundEnabled(false)
    self:SetPaintBorderEnabled(false)
    self:SetPaintBackground(false)
end

function PANEL:AddItem(pnl)
    pnl:SetParent(self:GetCanvas())
end

function PANEL:OnChildAdded(child)
    self:AddItem(child)
end

function PANEL:SizeToContents()
    self:SetSize(self.pnlCanvas:GetSize())
end

function PANEL:GetVBar()
    return self.VBar
end

function PANEL:GetCanvas()
    return self.pnlCanvas
end

function PANEL:InnerWidth()
    return self:GetCanvas():GetWide()
end

function PANEL:Rebuild()
    self:GetCanvas():SizeToChildren(false, true)
    if self.m_bNoSizing and self:GetCanvas():GetTall() < self:GetTall() then self:GetCanvas():SetPos(0, (self:GetTall() - self:GetCanvas():GetTall()) * 0.5) end
end

function PANEL:OnMouseWheeled(dlta)
    return self.VBar:OnMouseWheeled(dlta)
end

function PANEL:OnVScroll(iOffset)
    self.pnlCanvas:SetPos(0, iOffset)
end

function PANEL:ScrollToChild(panel)
    self:InvalidateLayout(true)
    local x, y = self.pnlCanvas:GetChildPosition(panel)
    local w, h = panel:GetSize()
    y = y + h * 0.5
    y = y - self:GetTall() * 0.5
    self.VBar:AnimateTo(y, 0.5, 0, 0.5)
end

function PANEL:PerformLayoutInternal()
    local Tall = self.pnlCanvas:GetTall()
    local Wide = self:GetWide()
    local YPos = 0
    self:Rebuild()
    self.VBar:SetUp(self:GetTall(), self.pnlCanvas:GetTall())
    YPos = self.VBar:GetOffset()
    if self.VBar.Enabled then Wide = Wide - self.VBar:GetWide() end
    self.pnlCanvas:SetPos(0, YPos)
    self.pnlCanvas:SetWide(Wide)
    self:Rebuild()
    if Tall ~= self.pnlCanvas:GetTall() then self.VBar:SetScroll(self.VBar:GetScroll()) end
end

function PANEL:PerformLayout()
    self:PerformLayoutInternal()
end

function PANEL:Clear()
    return self.pnlCanvas:Clear()
end

derma_DefineControl("AM4_DScrollPanel", "", PANEL, "DPanel")