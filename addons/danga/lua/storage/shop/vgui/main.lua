local PANEL = {}

fundot = fundot or {}
fundot.shopitems = fundot.shopitems or {} 

surface.CreateFont('fdShopSemiFont', {
    font = 'Jost SemiBold',
    extended = true,
    size = 36,
    -- weight = 300,
    -- shadow = true,
})


function PANEL:Init()

    self:SetSize(700, 400)
    self:Center()
    self:MakePopup()
    self:SetTitle('Хуй')

    self.TabPanel = self:Add("DPropertySheet")
        self.TabPanel:Dock(FILL)

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

    self:Show()
end

function PANEL:Show()
    print("Sending request to the server...")
    net.Start('octoshop.rInventory') 
    net.SendToServer()

    net.Start('octoshop.rShop') 
    net.SendToServer()
end

function PANEL:PushShopItem(item)
    local pnl = self.ShopItemsPanel:Add("DPanel")
        pnl:Dock(FILL)

    local name = pnl:Add("DLabel")
        name:Dock(TOP)
        name:SetText(item.name)
        name:SetTextColor(color_red)
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
            self.Think = nil -- Останавливаем анимацию после завершения
        end
    end
end

function PANEL:ShowCategory(cat)
    local pnl = self.ItemsPanel:Add("DPanel")
        pnl:Dock(FILL)

    local scroll = pnl:Add("DScrollPanel")
        scroll:Dock(FILL)

    local grid = scroll:Add("DGrid")
        grid:Dock(FILL)
        grid:DockMargin(10, 10, 10, 0)
        grid:SetCols( 3 )
        grid:SetColWide(155)
        grid:SetRowHeight(210)


    for id, item in ipairs(cat) do
            -- for i = 1, 5 do
                local itPnl = vgui.Create( "DPanel" )
                    itPnl:SetSize( 145, 200 )
                    grid:AddItem( itPnl )

                    local delay =  0.3
                    CreateAnimation(itPnl, delay)

                    itPnl.OnCursorEntered = function(this)
                        CreateJumpAnimation(this)
                    end

                    itPnl.Paint = function(this, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(50, 50, 50, 240))
                        
                        surface.SetDrawColor(255, 255, 255)
                        surface.SetMaterial(item.icon)
                        surface.DrawTexturedRect((w - 100) / 2, (h - 160) / 2, 100, 100)
                    end
            -- end
    end

    grid.Think = function(this)
        for panel, anim in pairs(animations) do
            anim:Run()
        end        
    end
end

function PANEL:UpdateInv(items)
    -- print("Updating panel with items:", items)
    if not IsValid(self.InventoryListView) then return end

    self.InventoryListView:Clear()

    for k, v in pairs(items) do
        self.InventoryListView:AddLine(v.name)
    end
end

function PANEL:UpdateShop()
    if not IsValid(self.ShopListView) then return end

    local data = {}
    for key, item in pairs(fundot.shopitems) do
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
            
            self:ShowCategory(data[catName])
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

vgui.Register('fdShopPanel', PANEL, 'DFrame')

if Entity(1) then

    if fundot.ShopMenu then fundot.ShopMenu:Remove() end
    fundot.ShopMenu = vgui.Create('fdShopPanel')

end

net.Receive('octoshop.rShop', function(len)

	local data = net.ReadTable()
	for i, item in ipairs(data) do
		fundot.shopitems[item.class] = {
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