local PANEL = {}

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
    self.ShopListView:Dock(FILL)
    self.ShopListView:AddColumn("Предметы")

    self:Show()
end

function PANEL:Show()
    print("Sending request to the server...")
    net.Start('octoshop.rInventory') 
    net.SendToServer()
end

function PANEL:UpdateInv(items)
    print("Updating panel with items:", items)
    if not IsValid(self.InventoryListView) then return end

    self.InventoryListView:Clear()

    for k, v in pairs(items) do
        self.InventoryListView:AddLine(v.name)
    end
end

function PANEL:UpdateShop(items)
    print("Updating panel with items:", items)
    if not IsValid(self.ListView) then return end

    self.ListView:Clear()

    for k, v in pairs(items) do
        self.ListView:AddLine(v.name)
    end
end

net.Receive('octoshop.rInventory', function(len)

	local data = net.ReadTable()
	fundot.ShopMenu:UpdateInv(data)

end)

vgui.Register('fdShopPanel', PANEL, 'DFrame')

if Entity(1) then

fundot = fundot or {}
if fundot.ShopMenu then fundot.ShopMenu:Remove() end
fundot.ShopMenu = vgui.Create('fdShopPanel')

end