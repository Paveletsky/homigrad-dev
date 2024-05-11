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

surface.CreateFont('fdShopFontTooltip', {
    font = 'Jost Regular',
    extended = true,
    size = 30,
    -- weight = 300,
    -- shadow = true,
})

fundot = fundot or {}
fundot.items = {}
fundot.balance = 'загружается'
fundot.ShopTitle = ''

bok.util.Include('plugins/accs/sh_accs.lua')

function PANEL:Init()
    self.PreviewAccessory = {}
    self.isShowed = false

    self:SetSize(900, 650)
    self:MakePopup()
    self:SetPos(-ScrW(), 750 - (ScrH() / 2))
    self:MoveTo(20, 750 - (ScrH() / 2), 1, 0, .1)
    -- self:Dock(FILL)
    -- self:DockMargin(-5, 0, -5, -5)
    self:SetTitle('')
    self:SetDraggable(false)
    self:ShowCloseButton(false)
    self:SetBackgroundBlur(true)

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
        self.TabPanel:DockMargin(15, 25, 15, 15)
        self.TabPanel.Paint = nil
        self.TabPanel:SetAlpha(200)
        self.TabPanel.OnActiveTabChanged = function(old, new)
            -- self:ShowModelPanel(false)
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
        self.InventoryListView:SetMultiSelect(false)

    self.ShopListView = self.ShopPanel:Add("DListView")
        self.ShopListView:Dock(LEFT)
        self.ShopListView:SetWide(270)
        self.ShopListView:AddColumn("")
        self.ShopListView:SetDataHeight(35)        
        self.ShopListView:DockMargin(0, -16, 0, 0)
        self.ShopListView:SetMultiSelect(false)

        self.ItemsPanel = self.ShopPanel:Add("DPanel")
        self.ItemsPanel:Dock(FILL)        
        
        self.Paint = function(this, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(0, 0, 0, 250))            
            draw.RoundedBoxEx(10, 3, 0, w-6, 40, Color(50, 35, 35, 235), 0, 0, 0, 0)

            fundot.ShopTitle = fundot.balance == 'загружается' and "Йопташоп | Загрузка.." or "Йопташоп | Баланс " .. fundot.balance .. 'руб.'
            draw.Text( {
                text = fundot.ShopTitle,
                font = "fdShopFontBig",
                xalign = TEXT_ALIGN_CENTER,
                pos = { w/2, -1 }
            })
        end

        local TopUp = self:Add("DButton")
        TopUp:SetText('Пополнить')
        TopUp:SetTextColor(Color(80, 201, 0))
        TopUp:SetFontInternal('fdShopFontRegular')
        TopUp:SetPos(15, 10)
        TopUp:SetImage('pixel_icons/coin3.png')
        TopUp:SetSize(140, 25)
        TopUp.DoClick = function(this)
            self:Remove()
            LocalPlayer():ChatPrint('<wrong><font=fdShopFontBig>Баланс пополняется через менеджера сервера. Найти его можно в дискорд сервере')
        end

    self.ModelPanel = vgui.Create("DPanel", self.ShopPanel)        
        self.ModelPanel:SetSize(0, self:GetTall())
        self.ModelPanel:SetVisible(false)        

    self.OnRemove = function()
        fundot.CameraToBody(false)

        if self.inPACPreview then
            pace.ClearParts()
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

function PANEL:Show()
    print("Sending request to the server...")
    net.Start('HG:RequestInventory') 
    net.SendToServer()

    net.Start('HG:RequestShop') 
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
    local jumpDistance = 3
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
    ['Костюмы'] = true,
}

local selectedItem = nil
local function CreateItem(self, item, grid)
    local itPnl = vgui.Create("DPanel")
        itPnl:SetSize(145, 200)
        grid:AddItem(itPnl)
    
    local attrCache = {}

    if (not item.canBuy) then
        item.attributes[0] = {'Нельзя купить', 'pixel_icons/round_cancel.png'}
    end

    table.foreach(item.attributes, function(id, data)
        attrCache[id] = {x = 3}
        
        if (id > 1) then
            attrCache[id].x = attrCache[id-1].x + 26 + 5
        end

        local attr = itPnl:Add("DImageButton")
        attr:SetSize(26, 26)
        attr:SetPos(attrCache[id].x, 3)
        attr:SetTooltip(data[1])
        attr:SetImage(data[2]) 
    end)
    
    local delay = 0.3
    CreateAnimation(itPnl, delay)

    itPnl.OnCursorEntered = function(this)
        CreateJumpAnimation(this)
        this:AlphaTo(240, 0.1, 0)
        this:SetCursor('hand')

        self.PreviewAccessory = item.PAC3 and fundot.accs[item.PAC3] or {}
    end

    itPnl.OnMousePressed = function(this)
        local menu = DermaMenu()

            if item.canBuy then
                menu:AddOption( "Купить", function()     
                        net.Start('fundot.purchase')
                            net.WriteString(item.class)
                        net.SendToServer()                
                end):SetIcon('pixel_icons/money_hand.png')
            end

            if (item.PAC3) then 
                menu:AddOption( "Примерить", function() 
                    self.inPACPreview = true
                    pace.LoadPartsFromTable(fundot.accs[item.PAC3], true)
                end):SetIcon('pixel_icons/man_mpolice.png')
            end
        
            menu:Open()
        
        selectedItem = this
    end

    itPnl.OnCursorExited = function(this)
        this:AlphaTo(255, 0.1, 0)
    end

    itPnl:SetTooltip( item.desc )
    
    itPnl.Paint = function(this, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(50, 50, 50, selectedItem == this and 125 or 250))
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(item and item.icon or Material('pixel_icons/emote_question.png', ''))
        surface.DrawTexturedRect((w - 100) / 2, (h - 160) / 2, 100, 100)

                       surface.SetFont("fdShopSemiFont")
        local tW, tH = surface.GetTextSize(item.name)

        local words = {}
        local i = 0

        if tW > 130 then            
            for word in item.name:gmatch("%S+") do
                table.insert(words, word)
                -- не больше двух строк
                if #words > 2 then continue end

                draw.Text( {
                    text = word,
                    font = "fdShopSemiFont",
                    xalign = TEXT_ALIGN_CENTER,
                    pos = { w/2, i ~= 1 and h - 90 or h - 60 }
                })

                i = i + 1
            end
        else
            draw.Text( {
                text = item and item.name or "Хуита",
                font = "fdShopSemiFont",
                xalign = TEXT_ALIGN_CENTER,
                pos = { w/2, h - 60 }
            })
        end

        -- draw.WordBox(
        --     5, w/2, h-35, (item and item.price .. "P" or "0P"), "fdShopSemiFont", Color(84, 117, 145), color_white, TEXT_ALIGN_CENTER
        -- )

        draw.Text( {
            text = item and item.price .. 'P' or "0P",
            font = "fdShopSemiFont",
            xalign = TEXT_ALIGN_CENTER,
            pos = { w/2, h - 35 }
        })
    end
end

function PANEL:ShowCategory(catName, cat)
    if (self.CurrentCat) then
        self.CurrentCat:Remove()
    end

    self.CurrentCat = self.ItemsPanel:Add("DPanel") 
    local pnl = self.CurrentCat
        pnl:Dock(FILL)

        local l = pnl:Add("DLabel")
            l:Dock(BOTTOM)
            l:SetTall(45)
            l:SetFont('Trebuchet24')
            l:SetText('Нажми на пробел для предпросмотра')
            l:SetContentAlignment(5)
            l:SetVisible(false)

        if PreviewCats[catName] then
            if fundot.animActive then return end       
            fundot.CameraToBody(true)
            self:AlphaTo(200, 0.2, 0)
            l:SetVisible(true)
        else
            self:AlphaTo(255, 0.2, 0)
            fundot.CameraToBody(false)
            l:SetVisible(false)
            
            if self.inPACPreview then
                pace.ClearParts()
            end
        end
        
        local isActive = false
        local OriginalPosX, OriginalPosY = self:GetPos()
    
        self.OnKeyCodePressed = function(self, keyCode)
            if keyCode == KEY_SPACE then
                self:MoveTo(!isActive and -ScrW() + self:GetWide() + 200 or OriginalPosX, OriginalPosY, 1, 0, .1)
                self:SetMouseInputEnabled(isActive)
    
                isActive = !isActive
            end
        end

    local scroll = pnl:Add("DScrollPanel")
        scroll:Dock(FILL)

    self.GridItems = scroll:Add("DGrid")
    local grid = self.GridItems
        grid:Dock(FILL)
        grid:DockMargin(20, 20, 20, 0)
        grid:SetCols(3)
        grid:SetColWide(160)
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

local function GetExpireColor(expireTime)
    local timeLeft = expireTime - os.time()
    local maxTime = 60 * 60 * 24 * 30

    local percentElapsed = math.min(timeLeft / maxTime, 1)
    local hue = percentElapsed * 120 -- Приводим значение hue к диапазону от 0 до 120

    return HSVToColor(hue, 0.9, 0.5)
end

local StatusLabels = {}
local function DrawStatus(id, data)
    StatusLabels[id] = data

    if id ~= 0 then
        surface.SetFont( 'fdShopFontRegular' )  
        local textWidth, textHeight = surface.GetTextSize(StatusLabels[id-1].text)
        data.x = StatusLabels[id-1].x - textWidth - 15
    end

    draw.WordBox(5, data.x, data.y, 
        data.text, 'fdShopFontRegular', 
        data.boxClr, data.txtClr, 
        data.xAlign, data.yAlign
    )
end

function PANEL:UpdateInv(items)
    if not IsValid(self.InventoryListView) then return end

    self.InventoryListView:Clear()

    for k, v in pairs(items) do
        local itemLine = self.InventoryListView:AddLine(v.name)
        local itemPanel = itemLine:Add("DPanel")

        itemPanel:Dock(FILL)
        itemPanel:SetMouseInputEnabled(false)

        itemLine.data = v        
        itemPanel.Paint = function(this, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(Material(v.icon or 'pixel_icons/emote_question.png', ''))
            surface.DrawTexturedRect((w - 64) - 15, (h - 64) / 2, 64, 64)    

            if v.active then
                DrawStatus(0, {
                    x = 768,
                    y = (h-29)/2,
                    text = "Активировано",
                    boxClr = Color( 56, 121, 47),
                    txtClr = Color(255, 255, 255),
                    xAlign = TEXT_ALIGN_RIGHT,
                    yAlign = nil
                })
            end

            if v.data.expire then
                local expireColor = GetExpireColor(v.data.expire)
                DrawStatus(1, {
                    x = 768,
                    y = (h-29)/2,
                    text = os.date("До %m/%d %H:%M", v.data.expire),
                    boxClr = expireColor,
                    txtClr = Color(255, 255, 255),
                    xAlign = TEXT_ALIGN_RIGHT,
                    yAlign = nil
                })
            end

            if v.canUnequip then
                DrawStatus(1, {
                    x = 768,
                    y = (h-29)/2,
                    text = "Надето",
                    boxClr = Color( 47, 121, 109),
                    txtClr = Color(255, 255, 255),
                    xAlign = TEXT_ALIGN_RIGHT,
                    yAlign = nil
                })
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
                m:AddOption('Использовать', function()                    
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('use')
                    net.SendToServer()
                end):SetIcon('pixel_icons/hand.png')
            end

            if item.canEquip then
                m:AddOption('Надеть', function()
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('equip')
                    net.SendToServer()
                end):SetIcon('pixel_icons/round_add.png')
            end

            if item.canUnequip then
                m:AddOption('Снять', function()
                    net.Start('fundot.action' )
                        net.WriteUInt(item.id, 32)
                        net.WriteString('unequip')
                    net.SendToServer()
                end):SetIcon('pixel_icons/round_minus.png')
            end

            m:AddOption('Удалить', function()
                Derma_Query( "Уверен что хочешь удалить этот предмет?", "Подтвердить действие", 
                    "Удалить",
                    function() 
                        net.Start('fundot.action' )
                            net.WriteUInt(item.id, 32)
                            net.WriteString('remove')
                        net.SendToServer()
                    end,
                    "Нет",
                    function() end
                )
            end):SetIcon('pixel_icons/round_warning.png')

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

net.Receive('HG:RequestBalance', function(len, ply)
	fundot.balance = net.ReadUInt(32) or 0
end)

net.Receive('HG:RequestInventory', function(len)
	local data = net.ReadTable()

    if (fundot.ShopMenu) then
        PrintTable(data)
	    fundot.ShopMenu:UpdateInv(data)
    end
end)

net.Receive('HG:RequestShop', function(len)
	local data = net.ReadTable()
    
	for i, item in ipairs(data) do
		fundot.items[item.class] = {
			name = item.name or L.what_it,
			cat = item.cat or L.other,
            class = item.class or nil,
			desc = item.desc or L.temporary_not_desc,
			price = item.price or 0,
			order = item.order or 999,
            PAC3 = item.PAC3 or nil,
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