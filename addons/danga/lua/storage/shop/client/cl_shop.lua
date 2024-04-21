local PANEL = {}

surface.CreateFont('fdShopSemiFont', {
    font = 'Jost SemiBold',
    extended = true,
    size = 36,
    -- weight = 300,
    -- shadow = true,
})

surface.CreateFont('fdShopFontBig', {
    font = 'Jost Black',
    extended = true,
    size = 48,
    -- weight = 300,
    -- shadow = true,
})

fundot = fundot or {}
fundot.items = {}
function PANEL:Init()

    self:SetSize(730, 450)
    self:MakePopup()
    self:Dock(LEFT)
    -- self:SetPos(20, 20)
    self:SetTitle('')
    self:ShowCloseButton(false)

    self.Cls = self:Add("DButton")
        self.Cls:SetText('×')
        self.Cls:SetTextColor(Color(255, 255, 255))
        self.Cls:SetFontInternal('fdShopFontBig')
        self.Cls:SetPos(self:GetWide()-46, 1)
        self.Cls:SetSize(36, 36)
        self.Cls.Paint = nil
        self.Cls.DoClick = function(this)
            self:Remove()
        end

    self.TabPanel = self:Add("DPropertySheet")
        self.TabPanel:Dock(FILL)
        self.TabPanel:DockMargin(15, 15, 15, 15)
        self.TabPanel.Paint = nil
        self.TabPanel.OnActiveTabChanged = function(old, new)
            self:ShowModelPanel(false)
        end
    
    self.InventoryPanel = self.TabPanel:Add("DPanel")
        self.InventoryPanel.Paint = function() end
        self.InventoryPanel:Dock(FILL)
        self.TabPanel:AddSheet("Инвентарь", self.InventoryPanel, "icon16/user.png")

    self.ShopPanel = self.TabPanel:Add("DPanel")
        self.ShopPanel.Paint = function() end
        self.ShopPanel:Dock(FILL)
        self.TabPanel:AddSheet("Магазин", self.ShopPanel, "icon16/cart.png")

    self.InventoryListView = self.InventoryPanel:Add("DListView")
        self.InventoryListView:Dock(FILL)
        self.InventoryListView:AddColumn("Предметы")

    self.ShopListView = self.ShopPanel:Add("DListView")
        self.ShopListView:Dock(LEFT)
        self.ShopListView:SetWide(200)
        self.ShopListView:AddColumn("")
        self.ShopListView:SetDataHeight(25)
        self.ShopListView:DockMargin(0, -16, 0, 0)

        self.ItemsPanel = self.ShopPanel:Add("DPanel")
        self.ItemsPanel:Dock(FILL)

        self.Paint = function(this, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(255, 255, 255, 255))            
            surface.SetDrawColor(Color(255, 255, 255))
        
            local innerBorderSize = 3
            draw.RoundedBox(10, innerBorderSize, innerBorderSize, w - innerBorderSize * 2, h - innerBorderSize * 2, Color(0, 0, 0, 255))            
        
            draw.RoundedBoxEx(10, 3, 3, w-6, 40, Color(50, 35, 35, 200), 0, 0, 0, 0)

            draw.Text( {
                text = "Хомиградский Йопташоп",
                font = "fdShopFontBig",
                xalign = TEXT_ALIGN_CENTER,
                pos = { w/2, -1 }
            })
        end

    self.ModelPanel = vgui.Create("DPanel", self.ShopPanel)        
        self.ModelPanel:SetSize(0, self:GetTall())
        self.ModelPanel:SetVisible(false)        

    self.Model = self.ModelPanel:Add("fdDAdjustableModelPanel")
    local modelPanel = self.Model
        modelPanel.canControl = true
        modelPanel.camPos = Vector(110, 0, 15)
        modelPanel.mdlOffset = Vector(0, 0, -30.5)
        modelPanel.fovMultiplier = 0.20

        modelPanel:Dock(FILL)
        modelPanel:SetModel(LocalPlayer():GetModel())
        -- modelPanel:SetCamPos(Vector(50, 0, 50))
        -- modelPanel:SetLookAt(Vector(0, 0, 0))
        
    self:Show()  
end



local isShowed = false
function PANEL:ShowModelPanel(catName, show)
    if show then        
        if !isShowed then
            self:SizeTo(self:GetWide()+200, self:GetTall(), 0.1, 0, -1, function()
                isShowed = true
            
                self.ModelPanel:SetVisible(true)
                self.ModelPanel:Dock(RIGHT)
                self.ModelPanel:SizeTo(200, self:GetTall(), 0.1, 0, -1)
            end)
            self.Cls:MoveTo(self.Cls:GetX()+200, self.Cls:GetY(), 0.1, 0, -1)
        end
    else
        if isShowed then
            self:SizeTo(self:GetWide()-200, self:GetTall(), 0.1, 0, -1, function()
                isShowed = false
            end)
            self.Cls:MoveTo(self.Cls:GetX()-200, self.Cls:GetY(), 0.1, 0, -1)
            self.ModelPanel:SizeTo(0, self:GetTall(), 0.1, 0, -1, function()
                self.ModelPanel:SetVisible(false)
            end)
        end
    end
end

function PANEL:Show()
    print("Sending request to the server...")
    net.Start('octoshop.rInventory') 
    net.SendToServer()

    net.Start('octoshop.rShop') 
    net.SendToServer()
end

local animations = {}
local function CreateAnimation(panel, delay)
    local anim = Derma_Anim("AppearAnimation", panel, function(pnl, anim, delta, data)
        pnl:SetAlpha(255 * delta)
        if anim.Finished then
            animations[panel] = nil
        end
    end)
    
    anim:Start(delay)
    animations[panel] = anim
end

local function CreateJumpAnimation(panel)
    local originalY = panel.y
    local jumpDistance = 10
    local jumpTime = 0.2

    local startTime = SysTime()

    panel.Think = function(self)
        local elapsedTime = SysTime() - startTime
        local progress = elapsedTime / jumpTime
        local newY = originalY - jumpDistance * math.sin(progress * math.pi)

        self:SetPos(self.x, newY)

        if progress >= 1 then
            self.Think = nil
        end
    end
end

local PreviewCats = {
    ['На тело'] = true,
    ['Головные уборы'] = true,
}

local function CreateItem(item, grid)
    local itPnl = vgui.Create("DPanel")
        itPnl:SetSize(145, 200)
        grid:AddItem(itPnl)

    local delay = 0.3
    CreateAnimation(itPnl, delay)

    itPnl.OnCursorEntered = function(this)
        CreateJumpAnimation(this)
        this:AlphaTo(240, 0.1, 0)
        this:SetCursor('hand')
    end

    itPnl.OnCursorExited = function(this)
        this:AlphaTo(255, 0.1, 0)
    end

    itPnl.Paint = function(this, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(50, 50, 50, 250))
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(item and item.icon or Material('pixel_icons/emote_question.png', ''))
        surface.DrawTexturedRect((w - 100) / 2, (h - 160) / 2, 100, 100)

        draw.Text( {
            text = item and item.name or "Хуита",
            font = "fdShopSemiFont",
            xalign = TEXT_ALIGN_CENTER,
            pos = { w/2, h - 40 }
        })
    end
end

function PANEL:ShowCategory(catName, cat)
    if PreviewCats[catName] then
        if !self.ModelPanel:IsVisible() then
            self:ShowModelPanel(catName, true)
        end
        
        if catName == "Головные уборы" then
            self.Model:MoveCameraToOffset(Vector(0, 0, 0.5), 0.2)
        else
            self.Model:MoveCameraToOffset(Vector(0, 0, -30.5), 0.2)
        end
    else
        self:ShowModelPanel(catName, false)
    end
    
    local pnl = self.ItemsPanel:Add("DPanel")
        pnl:Dock(FILL)

    local scroll = pnl:Add("DScrollPanel")
        scroll:Dock(FILL)

    local grid = scroll:Add("DGrid")
        grid:Dock(FILL)
        grid:DockMargin(10, 10, 10, 0)
        grid:SetCols(3)
        grid:SetColWide(155)
        grid:SetRowHeight(210)

    for id, item in ipairs(cat) do

        CreateItem(item, grid)

        for i=1, 10 do
            CreateItem(_, grid)
        end

    end

    grid.Think = function(this)
        for panel, anim in pairs(animations) do
            anim:Run()
        end
    end

end


function PANEL:UpdateInv(items)
    -- print("Updating panel with items:", items)
    PrintTable(items)
    if not IsValid(self.InventoryListView) then return end

    self.InventoryListView:Clear()

    for k, v in pairs(items) do
        self.InventoryListView:AddLine(v.name)
    end
end

function PANEL:UpdateShop()
    if not IsValid(self.ShopListView) then return end

    local data = {}
    for key, item in pairs(fundot.items) do
        if not data[item.cat] then
            data[item.cat] = {}
        end
        table.insert(data[item.cat], item)
    end

    self.ShopListView:Clear()

    for k, v in pairs(data) do
        self.ShopListView:AddLine(k)
        self.ShopListView.OnRowSelected = function(panel, rowInd, row)            
            local catName = row:GetColumnText(1)
            
            self:ShowCategory(catName, data[catName])
        end
    end
end

net.Receive('octoshop.rInventory', function(len)

	local data = net.ReadTable()
	fundot.ShopMenu:UpdateInv(data)

end)

net.Receive('octoshop.rInventory', function(len)

	local data = net.ReadTable()
	fundot.ShopMenu:UpdateInv(data)

end)

net.Receive('octoshop.rShop', function(len)

	local data = net.ReadTable()
	for i, item in ipairs(data) do
		fundot.items[item.class] = {
			name = item.name or L.what_it,
			cat = item.cat or L.other,
			desc = item.desc or L.temporary_not_desc,
			price = item.price or 0,
			order = item.order or 999,
			icon = Material(item.icon or 'pixel_icons/emote_question.png', ''),
			color = item.col or Color(102,170,170),
			hidden = item.hidden,
			attributes = item.attributes or {},
			canBuy = item.canBuy,
		}
	end

	fundot.ShopMenu:UpdateShop()

end)

vgui.Register('fdShopPanel', PANEL, 'DFrame')

if fundot.ShopMenu then fundot.ShopMenu:Remove() end
fundot.ShopMenu = vgui.Create('fdShopPanel')