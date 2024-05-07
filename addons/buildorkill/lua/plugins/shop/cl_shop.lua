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

surface.CreateFont('fdShopFontRegular', {
    font = 'Jost Regular',
    extended = true,
    size = 22,
    -- weight = 300,
    -- shadow = true,
})

fundot = fundot or {}
fundot.items = {}
fundot.balance = 'загружается'

bok.util.Include('plugins/accs/sh_accs.lua')

function PANEL:Init()
    self.PreviewAccessory = {}
    self.isShowed = false

    self:SetSize(790, 450)
    self:MakePopup()
    self:Dock(FILL)
    self:DockMargin(-5, 0, -5, -5)
    self:SetTitle('')
    self:SetDraggable(false)
    self:ShowCloseButton(false)
    self:SetBackgroundBlur(true)

    self.Cls = self:Add("DButton")
        self.Cls:SetText('×')
        self.Cls:SetTextColor(Color(255, 255, 255))
        self.Cls:SetFontInternal('fdShopFontBig')
        self.Cls:SetPos(ScrW()-46, 1)
        self.Cls:SetSize(36, 36)
        self.Cls.Paint = nil
        self.Cls.DoClick = function(this)
            self:Remove()
        end

    self.TabPanel = self:Add("DPropertySheet")
        self.TabPanel:Dock(FILL)
        -- self.TabPanel:DockPadding(0, 30, 0, 0)
        self.TabPanel:DockMargin(15, 25, 15, 15)
        self.TabPanel.Paint = nil
        self.TabPanel:SetAlpha(200)
        self.TabPanel.OnActiveTabChanged = function(old, new)
            self:ShowModelPanel(false)
        end
    
    self.InventoryPanel = self.TabPanel:Add("DPanel")
        self.InventoryPanel.Paint = function() end
        self.InventoryPanel:Dock(FILL)
        -- self.InventoryPanel.Paint = function(this, w, h)
        --     draw.RoundedBox(1, 0, 0, w, h, Color(0, 0, 0, 5))
        -- end
        -- self.InventoryPanel:SetAlpha(25)
        self.TabPanel:AddSheet("Инвентарь", self.InventoryPanel, "icon16/user.png")

    self.ShopPanel = self.TabPanel:Add("DPanel")
        self.ShopPanel.Paint = function() end
        self.ShopPanel:Dock(FILL)
        self.TabPanel:AddSheet("Магазин", self.ShopPanel, "icon16/cart.png")

    self.InventoryListView = self.InventoryPanel:Add("DListView")
        self.InventoryListView:Dock(FILL)
        self.InventoryListView:AddColumn("Предметы")
        self.InventoryListView:DockMargin(0, -16, 0, 0)
        self.InventoryListView:SetDataHeight(75)

    self.ShopListView = self.ShopPanel:Add("DListView")
        self.ShopListView:Dock(LEFT)
        self.ShopListView:SetWide(270)
        self.ShopListView:AddColumn("")
        self.ShopListView:SetDataHeight(35)        
        self.ShopListView:DockMargin(0, -16, 0, 0)

        self.ItemsPanel = self.ShopPanel:Add("DPanel")
        self.ItemsPanel:Dock(FILL)        
        
        self.Paint = function(this, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(0, 0, 0, 250))            
            draw.RoundedBoxEx(10, 3, 0, w-6, 40, Color(50, 35, 35, 235), 0, 0, 0, 0)

            draw.Text( {
                text = "Йопташоп | Баланс " .. fundot.balance,
                font = "fdShopFontBig",
                xalign = TEXT_ALIGN_CENTER,
                pos = { w/2, -1 }
            })
        end

        local TopUp = self:Add("DButton")
        TopUp:SetText('Пополнить баланс')
        TopUp:SetTextColor(Color(255, 255, 255))
        TopUp:SetFontInternal('fdShopSemiFont')
        TopUp:SetPos(15, 5)
        TopUp:SetSize(250, 36)
        TopUp.DoClick = function(this)
            self:Remove()
            LocalPlayer():ChatPrint('<wrong><font=fdShopFontBig>Баланс пополняется через менеджера сервера. Найти его можно в дискорд сервере')
            -- bok.gui.Notify('Баланс пополняется через менеджера "Биржевой маклер". В дискорд сервере.', 10, 'ui/hint.wav')
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
        
        function UpdatePreviewModel()
            if #self.PreviewAccessory > 0 then
                local AccData = self.PreviewAccessory[1]['children'][1]['self']

                modelPanel.hatModel = ClientsideModel(AccData['Model'])
                modelPanel.hatModel:SetParent(self.Model.Entity)

                modelPanel.PostDrawModel = function(this)
                    local ply = modelPanel.Entity
        
                    local attachId = ply:LookupAttachment(AccData['Bone'])
                    local attachPos = ply:GetAttachment(attachId)
                    if not attachPos then return end
                    local ang = attachPos.Ang + AccData['Angles'] 
                    local pos = attachPos.Pos + AccData['Position']
                
                    this.hatModel:SetModelScale(AccData['Size'] or 1, 0)
                    this.hatModel:SetRenderOrigin(pos)
                    this.hatModel:SetRenderAngles(ang)
                    this.hatModel:DrawModel()
                end
            end
        end

    self:Show()  
end

local function SetListViewFont(listView, font)
    for _, line in ipairs(listView:GetLines()) do
        for _, column in ipairs(line.Columns) do
            column:SetFont(font)
        end
    end
end

function PANEL:ShowModelPanel(catName, show)
    if show then        
        if !self.isShowed then
            self:SizeTo(self:GetWide()+600, self:GetTall(), 0.1, 0, -1, function()
                self.isShowed = true
            
                self.ModelPanel:SetVisible(true)
                self.ModelPanel:Dock(RIGHT)
                self.ModelPanel:SizeTo(600, self:GetTall(), 0.1, 0, -1)
            end)
            -- self.Cls:MoveTo(self.Cls:GetX()+600, self.Cls:GetY(), 0.1, 0, -1)
        end
    else
        if self.isShowed then
            self:SizeTo(self:GetWide()-600, self:GetTall(), 0.1, 0, -1, function()
                self.isShowed = false
            end)
            -- self.Cls:MoveTo(self.Cls:GetX()-600, self.Cls:GetY(), 0.1, 0, -1)
            self.ModelPanel:SizeTo(0, self:GetTall(), 0.1, 0, -1, function()
                self.ModelPanel:SetVisible(false)
            end)
        end
    end
end

function PANEL:Show()
    print("Sending request to the server...")
    net.Start('fundot.rInventory') 
    net.SendToServer()

    net.Start('fundot.rShop') 
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
    ['Тело'] = true,
    ['Головные уборы'] = true,
}

local selectedItem = nil
local function CreateItem(self, item, grid)
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

    itPnl.OnMousePressed = function(this)
        if selectedItem == this then
            local menu = DermaMenu()
                menu:AddOption( "Купить", function() 
                    if item.canBuy then
                        net.Start('fundot.purchase')
                            net.WriteString(item.class)
                        net.SendToServer()
                    end
                end)
            menu:Open()
        end
        
        selectedItem = this
        self.PreviewAccessory = item.PAC3 and fundot.accs[item.PAC3] or {}
        UpdatePreviewModel()
    end

    itPnl.OnCursorExited = function(this)
        this:AlphaTo(255, 0.1, 0)
    end

    itPnl.Paint = function(this, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(50, 50, 50, selectedItem == this and 125 or 250))
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(item and item.icon or Material('pixel_icons/emote_question.png', ''))
        surface.DrawTexturedRect((w - 100) / 2, (h - 160) / 2, 100, 100)

        draw.Text( {
            text = item and item.name or "Хуита",
            font = "fdShopSemiFont",
            xalign = TEXT_ALIGN_CENTER,
            pos = { w/2, h - 60 }
        })

        draw.Text( {
            text = item and item.price .. 'P' or "0P",
            font = "fdShopSemiFont",
            xalign = TEXT_ALIGN_CENTER,
            pos = { w/2, h - 35 }
        })
    end
end

function PANEL:ShowCategory(catName, cat)
    if PreviewCats[catName] then
        if !self.ModelPanel:IsVisible() then
            self:ShowModelPanel(catName, true)
        end
        
        if catName == "Головные уборы" then
            self.Model:MoveCameraToOffset(Vector(0, 0, -30), 0.2, 90)
        else
            self.Model:MoveCameraToOffset(Vector(0, 0, -15), 0.2)
        end
    else
        self:ShowModelPanel(catName, true )
    end
    
    if (self.CurrentCat) then
        self.CurrentCat:Remove()
    end

    self.CurrentCat = self.ItemsPanel:Add("DPanel") 
    local pnl = self.CurrentCat
        pnl:Dock(FILL)

    local scroll = pnl:Add("DScrollPanel")
        scroll:Dock(FILL)

    self.GridItems = scroll:Add("DGrid")
    local grid = self.GridItems
        grid:Dock(FILL)
        grid:DockMargin(10, 10, 10, 0)
        grid:SetCols(6)
        grid:SetColWide(165)
        grid:SetRowHeight(210)

    self.RebuildGrid = function(this)
        this:SetCols(self.CurrentCat:GetWide() / 6)
    end
        
    for id, item in ipairs(cat) do
        CreateItem(self, item, grid)
    end

    grid.Think = function(this)
        for panel, anim in pairs(animations) do
            anim:Run()
        end
    end

end


function PANEL:UpdateInv(items)
    if not IsValid(self.InventoryListView) then return end

    self.InventoryListView:Clear()

    for k, v in pairs(items) do
        local itemLine = self.InventoryListView:AddLine(v.name)
        local itemPanel = itemLine:Add("DPanel")
        itemPanel:Dock(RIGHT)
        itemPanel:SetWide(300)

        itemLine.data = v
        itemPanel.Paint = function(this, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(Material(v.icon or 'pixel_icons/emote_question.png', ''))
            surface.DrawTexturedRect((w - 64) - 15, (h - 64) / 2, 64, 64)    
            
            if v.active then
                draw.WordBox( 5, w-90, (h-29)/2, "Активировано", "fdShopFontRegular", Color( 56, 121, 47), Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT)
            end

            if v.canUnequip then
                draw.WordBox( 5, w-200, (h-29)/2, "Надето", "fdShopFontRegular", Color( 47, 121, 109), Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT)
            end
        end

        itemLine.OnCursorEntered = function(this)
            surface.PlaySound('ui/buttonrollover.wav')
            this:SetCursor('hand')
        end

        self.InventoryListView.OnRowSelected = function(this, rowIndex, row)
            local m = DermaMenu()
            local item = row.data

            if item.canUse then
                m:AddOption('Юзануть', function()                    
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('use')
                    net.SendToServer()
                end):SetIcon('icon16/user.png')
            end

            if item.canEquip then
                m:AddOption('Надеть', function()
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('equip')
                    net.SendToServer()
                end):SetIcon('icon16/lightbulb.png')
            end

            if item.canUnequip then
                m:AddOption('Снять', function()
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('unequip')
                    net.SendToServer()
                end):SetIcon('icon16/lightbulb_off.png')
            end

            m:Open()
        end
    end

    SetListViewFont(self.InventoryListView, 'fdShopFontBig')
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

    SetListViewFont(self.ShopListView, 'fdShopSemiFont')
end

net.Receive('fundot.rBalance', function(len, ply)

	fundot.balance = net.ReadUInt(32) or 0

end)

net.Receive('fundot.rInventory', function(len)

	local data = net.ReadTable()
	fundot.ShopMenu:UpdateInv(data)

end)

net.Receive('fundot.rInventory', function(len)

	local data = net.ReadTable()
	fundot.ShopMenu:UpdateInv(data)

end)

net.Receive('fundot.rShop', function(len)
	local data = net.ReadTable()
	for i, item in ipairs(data) do
		fundot.items[item.class] = {
			name = item.name or L.what_it,
			cat = item.cat or L.other,
            class = item.class or nil,
			desc = item.desc or L.temporary_not_desc,
			price = item.price or 0,
			order = item.order or 999,
            PAC3 = item.PAC3 or 'ХУЙ',
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