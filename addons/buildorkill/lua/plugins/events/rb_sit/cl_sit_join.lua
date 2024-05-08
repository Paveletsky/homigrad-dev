local Menu = {}
Menu.Frame = nil

Menu.Standart = function()
    Menu.w, Menu.h = SizeToScreen('x', 600), SizeToScreen('y', 400)
    Menu.x, Menu.y = CenterScreen(Menu.w, Menu.h)
end

Menu.Close = function()
    local QueryPanel = Derma_Query("Вы уверены, что хотите завершить процесс \""..Menu.Frame:GetTitle().."\" ?", rb_lib.query_title1,
        "Да", function()
            hook.Run("rb_block_cursor", false)
            Menu.Frame:Close()
        end, "Нет"
    )
    QueryPanel:SetIcon("icon16/error.png")
end

hook.Add("rb_block_cursor", "zalupa", function() print("hello world!") end)

local function sit_join(sit)
    if IsValid(Menu.Frame) then
        Menu.Close()
        return
    end

    hook.Run("rb_block_cursor", true)

    Menu.Standart()
    local Frame = vgui.Create("DFrame")
    Frame:SetSize(Menu.w, Menu.h)
    Frame:SetPos(Menu.x, Menu.y)
    Frame:SetTitle("Вход в ситуацию")
    Frame:SetIcon("icon16/group_go.png")
    Frame:SetDraggable(false)
    Frame:MakePopup()
    Frame:SetBackgroundBlur(true)

    Frame:GetChildren()[4]:SetFont("DermaDefaultBold")

    Frame:GetChildren()[1].DoClick = function()
        Menu.Close()
        return
    end
    
    Frame:GetChildren()[2]:SetEnabled(true)
    Frame:GetChildren()[2].DoClick = function()
        Frame:SetPos(Menu.x, Menu.y)
    end

    Frame:GetChildren()[3]:SetEnabled(true)
    Frame:GetChildren()[3].DoClick = function()
        Frame:SetPos(Menu.x, ScreenHeight-SizeToScreen('y', 20))
    end

    local MainPanel = Frame:Add("DCategoryList")
    MainPanel:DockMargin(0, 0, Menu.w/2, SizeToScreen('y', 30))
    MainPanel:Dock(FILL)
    local MainCategory = CreateCategory("Основное", "icon16/world.png", MainPanel)
    MainCategory:Dock(TOP)

    local NameTextEntryTitle = CreateTitle("Название ситуации", MainCategory)
    NameTextEntryTitle:Dock(TOP)

    local NameTextEntry = vgui.Create("DTextEntry", MainCategory)
    NameTextEntry:Dock(TOP)
    NameTextEntry:SetEditable(false)
    NameTextEntry:SetValue(sit.name)

    local DescTextEntryTitle = CreateTitle("Описание ситуации", MainCategory)
    DescTextEntryTitle:Dock(TOP)

    local DescTextEntry = vgui.Create("DTextEntry", MainCategory)
    DescTextEntry:Dock(TOP)
    DescTextEntry:SetMultiline(true)
    DescTextEntry:SetHeight(SizeToScreen('y', 250))
    DescTextEntry:SetEditable(false)
    DescTextEntry:SetValue(sit.desc)

    local SecondPanel = Frame:Add("DCategoryList")
    SecondPanel:DockMargin(Menu.w/2, 0, 0, SizeToScreen('y', 30))
    SecondPanel:Dock(FILL)
    local SecondCategory = CreateCategory("Другое", "icon16/world.png", SecondPanel)
    SecondCategory:Dock(TOP)

    local MaxPlyNumSliderTitle = CreateTitle("Максимальное количество участников", SecondCategory)
    MaxPlyNumSliderTitle:Dock(TOP)

    local MaxPlyNumSlider = vgui.Create("DNumSlider", SecondCategory)
    MaxPlyNumSlider:DockMargin(0, SizeToScreen('y', -5), 0, 0)
    MaxPlyNumSlider:Dock(TOP)
    MaxPlyNumSlider:SetText("Количество")
    MaxPlyNumSlider:SetMin(1)
    MaxPlyNumSlider:SetMax(game.MaxPlayers())
    MaxPlyNumSlider:SetDefaultValue(game.MaxPlayers())
    MaxPlyNumSlider:ResetToDefaultValue()
    MaxPlyNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(MaxPlyNumSlider, 35, Frame)
    MaxPlyNumSlider:SetEnabled(false)
    MaxPlyNumSlider:SetValue(sit.player_count)

    local CanCategory = CreateCategory("Привилегии участников", "icon16/rainbow.png", SecondPanel)
    CanCategory:DockMargin(0, 0, 0, SizeToScreen('y',5))
    CanCategory:Dock(TOP)

    local PerkCheckBoxTitle = CreateTitle("Основные", CanCategory)
    PerkCheckBoxTitle:Dock(TOP)

    local PerkNoclipCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkNoclipCheckBox:SetTextColor(Color(255, 255, 255))
    PerkNoclipCheckBox:Dock(TOP)
    PerkNoclipCheckBox:SetText("Ноуклип")
    StaticCheckBox(PerkNoclipCheckBox, sit.noclip)

    local PerkRespawnCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkRespawnCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    PerkRespawnCheckBox:SetTextColor(Color(255, 255, 255))
    PerkRespawnCheckBox:Dock(TOP)
    PerkRespawnCheckBox:SetText("Респавн внутри ситуации")
    StaticCheckBox(PerkRespawnCheckBox, sit.respawn)

    local PerkToolsCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkToolsCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    PerkToolsCheckBox:SetTextColor(Color(255, 255, 255))
    PerkToolsCheckBox:Dock(TOP)
    PerkToolsCheckBox:SetText("Инструменты (физ-ган, тулган)")
    StaticCheckBox(PerkToolsCheckBox, sit.tools)

    local SpawnCheckBoxTitle = CreateTitle("Разрешенный спавн", CanCategory)
    SpawnCheckBoxTitle:Dock(TOP)

    local SpawnPropCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnPropCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnPropCheckBox:Dock(TOP)
    SpawnPropCheckBox:SetText("Пропы")
    StaticCheckBox(SpawnPropCheckBox, sit.props)

    local SpawnEntityCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnEntityCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnEntityCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnEntityCheckBox:Dock(TOP)
    SpawnEntityCheckBox:SetText("Энтити")
    StaticCheckBox(SpawnEntityCheckBox, sit.entities)

    local SpawnNpcCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnNpcCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnNpcCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnNpcCheckBox:Dock(TOP)
    SpawnNpcCheckBox:SetText("NPC")
    StaticCheckBox(SpawnNpcCheckBox, sit.npc)

    local SpawnWeaponCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnWeaponCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnWeaponCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnWeaponCheckBox:Dock(TOP)
    SpawnWeaponCheckBox:SetText("Оружие")
    StaticCheckBox(SpawnWeaponCheckBox, sit.weapons)

    local SpawnCarCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnCarCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnCarCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnCarCheckBox:Dock(TOP)
    SpawnCarCheckBox:SetText("Машины")
    StaticCheckBox(SpawnCarCheckBox, sit.vehicles)

    local PlyCategory = CreateCategory("Участники", "icon16/group.png", SecondPanel)
    PlyCategory:Dock(TOP)

    local HpPlyNumEntryTitle = CreateTitle("Здоровье", PlyCategory)
    HpPlyNumEntryTitle:Dock(TOP)

    local HpPlyNumEntry = vgui.Create("DTextEntry", PlyCategory)
    HpPlyNumEntry:Dock(TOP)
    HpPlyNumEntry:SetEditable(false)
    HpPlyNumEntry:SetValue(sit.hp)

    local ArmorPlyNumEntryTitle = CreateTitle("Броня", PlyCategory)
    ArmorPlyNumEntryTitle:Dock(TOP)

    local ArmorPlyNumEntry = vgui.Create("DTextEntry", PlyCategory)
    ArmorPlyNumEntry:Dock(TOP)
    ArmorPlyNumEntry:SetEditable(false)
    ArmorPlyNumEntry:SetValue(sit.armor)

    local SpeedPlyNumSliderTitle = CreateTitle("Скорость", PlyCategory)
    SpeedPlyNumSliderTitle:Dock(TOP)

    local SpeedPlyNumSlider = vgui.Create("DNumSlider", PlyCategory)
    SpeedPlyNumSlider:DockMargin(0, SizeToScreen('y', -5), 0, 0)
    SpeedPlyNumSlider:Dock(TOP)
    SpeedPlyNumSlider:SetText("Процент")
    SpeedPlyNumSlider:SetMin(10)
    SpeedPlyNumSlider:SetMax(200)
    SpeedPlyNumSlider:SetDefaultValue(100)
    SpeedPlyNumSlider:ResetToDefaultValue()
    SpeedPlyNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(SpeedPlyNumSlider, 55, Frame)
    SpeedPlyNumSlider:SetEnabled(false)
    SpeedPlyNumSlider:SetValue(sit.speed)

    local AcceptButton = Frame:Add("DButton")
    AcceptButton:DockMargin(0, Menu.h - SizeToScreen('y', 60), Menu.w/2, 0)
    AcceptButton:Dock(FILL)
    AcceptButton:SetIcon("icon16/accept.png")
    AcceptButton:SetText("Вступить")
    AcceptButton:SetPaintBackgroundEnabled(true)

    function AcceptButton:ApplySchemeSettings()
        self:SetBGColor(Color(80, 255, 64, 80))
    end

    local DeniedButton = Frame:Add("DButton")
    DeniedButton:DockMargin(Menu.w/2, Menu.h - SizeToScreen('y', 60), 0, 0)
    DeniedButton:Dock(FILL)
    DeniedButton:SetIcon("icon16/delete.png")
    DeniedButton:SetText("Отказаться")
    DeniedButton:SetPaintBackgroundEnabled(true)

    function DeniedButton:ApplySchemeSettings()
        self:SetBGColor(Color(255, 64, 64, 80))
    end

    Menu.Frame = Frame
end

net.Receive("rb_sit_join", function()
    local act = net.ReadString()
    local sit = net.ReadTable()
    if act == "JoinSit" then
        if sit.type_local && password != "" then
            local StringRequestPanel = Derma_StringRequest(
                rb_lib.query_title1, 
                "Введите пароль, чтобы войти", "",
                function(password)
                    if password == tostring(sit.password) then
                        sit_join(sit)
                    else
                        local MessagePanel = Derma_Message("Вы ввели неверный пароль", rb_lib.query_title3,
                            "Закрыть"
                        )
                        MessagePanel:SetIcon("icon16/error.png")
                    end
                end, nil,
                "Ввести", "Отмена"
            )
            StringRequestPanel:SetIcon("icon16/error.png")
            SetLimitTextNumEntry(StringRequestPanel:GetChildren()[5]:GetChildren()[2], 9)
        else
            sit_join(sit)
        end
    end
end)