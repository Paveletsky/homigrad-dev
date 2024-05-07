darkrp = darkrp or {}

darkrp.pages = darkrp.pages or {}
local pages = darkrp.pages
pages[1] = {"Роли",function(panel)
    local leftPanel = vgui.Create("DPanel",panel)
    leftPanel:SetPos(0,0)
    leftPanel:SetSize(panel:GetWide() / 1.5 - 5,panel:GetTall())

    leftPanel.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(61,61,61))
    end

    local leftScroll = vgui.Create("DScrollPanel",leftPanel)
    leftScroll:Dock(FILL)

    local SelectRole,SelectRoleID,viewModel,viewModelSlider
    for i,role in pairs(darkrp.roles) do
        local button = vgui.Create("DButton",leftScroll)
        button:SetSize(leftPanel:GetWide(),30)
        button:SetPos(0, (i - .6) * button:GetTall()* 1.2)
        button:SetText(role[1])
        button:SetTextColor(Color(250,255,250))

        button.Paint = function (self, w, h)
            if self:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, Color(110,109,109))
            else 
                draw.RoundedBox(0, 0, 0, w, h, Color(68,68,68)) 
            end
        end

        button.DoClick = function()
            SelectRole = role
            SelectRoleID = i

            local models = SelectRole.models
            local id = math.random(1,#models)

            viewModel:SetModel(models[id])
            function viewModel.Entity:GetPlayerColor() return SelectRole[2]:ToVector() end

            viewModelSlider:SetMax(#models)
            viewModelSlider:SetValue(id)
        end
    end

    local rightPanel = vgui.Create("DPanel",panel)
    rightPanel:SetPos(leftPanel:GetWide() + 5,0)
    rightPanel:SetSize(panel:GetWide() - leftPanel:GetWide(),panel:GetTall())
    rightPanel:SetBackgroundColor(Color(82,82,82))

    local panel = vgui.Create("DPanel",rightPanel)
    panel:SetSize(rightPanel:GetWide(),rightPanel:GetTall() / 1.5)
    panel:SetBackgroundColor(Color(82,82,82))

    viewModel = vgui.Create("DModelPanel",panel)
    viewModel:Dock(FILL)
    viewModel:SetModel("")
    function viewModel:LayoutEntity(ent) return end

    viewModelSlider = vgui.Create("DNumSlider",rightPanel)
    viewModelSlider:SetSize(250,25)
    viewModelSlider:SetPos(panel:GetWide() / 2 - viewModelSlider:GetWide() / 2,panel:GetTall() + 25)
    viewModelSlider:SetText("")
    viewModelSlider:SetMin(1)
    viewModelSlider:SetMax(1)
    viewModelSlider:SetDecimals(0)
    viewModelSlider.OnValueChanged = function(self,value)
        if not SelectRole then return  end

        value = math.Round(value)

        print(SelectRole.models[value])
        viewModel:SetModel(SelectRole.models[value])
        function viewModel.Entity:GetPlayerColor() return SelectRole[2]:ToVector() end
    end

    local button = vgui.Create("DButton",rightPanel)
    button:SetText("Выбрать")
    button:SetSize(rightPanel:GetWide() / 2,30)
    button:SetPos(button:GetWide() / 2,rightPanel:GetTall()/1.25)

    button.DoClick = function()
        net.Start("darkrp role")
        net.WriteInt(SelectRoleID,16)
        net.WriteInt(viewModelSlider:GetValue(),16)
        net.SendToServer()

        darkrpMenu:Remove()
    end
end}

local empty = {}
pages[2] = {"Магазин",function(panel)
    local leftPanel = vgui.Create("DPanel",panel)
    leftPanel:SetPos(0,0)
    leftPanel:SetSize(panel:GetWide() / 1.5 - 5,panel:GetTall())
    leftPanel.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(61,61,61))
    end
    local leftScroll = vgui.Create("DScrollPanel",leftPanel)
    leftScroll:Dock(FILL)

    local select,selectID,viewModel,buttonBuy
    local list = darkrp.GetRole(LocalPlayer()).shop

    for i,item in pairs(list or empty) do
        local button = vgui.Create("DButton",leftScroll)
        button:SetSize(leftPanel:GetWide(),30)
        button:SetPos(0,(i - .6) * button:GetTall() *1.2)
        button:SetText(item[1])
        button:SetTextColor(Color(250,255,250))
        button.Paint = function (self, w, h)
            if self:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, Color(110,109,109))
            else 
                draw.RoundedBox(0, 0, 0, w, h, Color(68,68,68)) 
            end
        end

        button.DoClick = function()
            select = item
            selectID = i

            viewModel:SetModel(item[4] or "models/props_junk/cardboard_box001a_gib01.mdl" )
            viewModel:GetEntity():SetModelScale(2)
            
            buttonBuy:SetText("Купить за '" .. item[3] .. "$'")
        end
    end

    local rightPanel = vgui.Create("DPanel",panel)
    rightPanel:SetPos(leftPanel:GetWide() + 5,0)
    rightPanel:SetSize(panel:GetWide() - leftPanel:GetWide(),panel:GetTall())
    rightPanel:SetBackgroundColor(Color(125,125,125))

    local panel = vgui.Create("DPanel",rightPanel)
    panel:SetSize(rightPanel:GetWide(),rightPanel:GetTall() / 1.5)
    panel.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(61,61,61))
    end

    viewModel = vgui.Create("DModelPanel",panel)
    viewModel:Dock(FILL)
    viewModel:SetModel("")
    function viewModel:LayoutEntity( Entity ) return end
    function viewModel:PaintOver(w,h)
        
    end

    buttonBuy = vgui.Create("DButton",rightPanel)
    buttonBuy:SetText("Купить")
    buttonBuy:SetSize(rightPanel:GetWide() / 2,30)
    buttonBuy:SetPos(buttonBuy:GetWide() / 2,rightPanel:GetTall()/1.25)

    buttonBuy.DoClick = function()
        net.Start("darkrp shop buy")
        net.WriteInt(selectID,16)
        net.SendToServer()
    end
end}

local function setPage(value)
    local panel = darkrpMenu.panel

    panel:Clear()

    pages[value][2](panel)
end

function darkrp.OpenMenu()
    if IsValid(darkrpMenu) then darkrpMenu:Remove() end

    darkrpMenu = vgui.Create("DFrame")
    darkrpMenu:SetSize(ScrW() / 1.5,ScrH() / 1.5)
    darkrpMenu:Center()
    darkrpMenu:SetTitle("AllahRP")
    darkrpMenu:SetDraggable(false)
    darkrpMenu:MakePopup()

    darkrpMenu.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22))
    end

    local count = 0

    for i,pages in pairs(darkrp.pages) do
        if pages[3] and pages[3] == false then continue end

        local button = vgui.Create("DButton",darkrpMenu)
        button:SetText(pages[1])
        button:SetSize(90,25)
        button:SetPos(darkrpMenu:GetWide()/2 + 45 - count * button:GetWide(),25)
        button:SetTextColor(Color(250,255,250))

        button.Paint = function (self, w, h)
            if not self:IsHovered() then
                draw.RoundedBox(6, 0, 0, w, h, Color(14,78,6))
            else
                draw.RoundedBox(6, 0, 0, w, h, Color(27,139,13))
            end
        end

        button.DoClick = function() setPage(i) end

        count = count + 1.2
    end

    local panel = vgui.Create("DPanel",darkrpMenu)
    panel:SetPos(15,60)
    panel:SetSize(darkrpMenu:GetWide() - panel.x * 2,darkrpMenu:GetTall() - panel.y - 5)
    panel:SetBackgroundColor(Color(65,60,60))
    darkrpMenu.panel = panel
    pages[1][2](panel)
end

local old = false

hook.Add("Think","govnokoddarkrp",function()
    if roundActiveName ~= "darkrp" then return end

    local active = input.IsKeyDown(KEY_F4)
    if active ~= old then
        old = active

        if active then
            if not IsValid(darkrpMenu) then
                darkrp.OpenMenu()
            else
                darkrpMenu:Remove()
            end
        end
    end
end)