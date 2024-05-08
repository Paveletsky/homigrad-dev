local Menu = {}
Menu.Frame = nil

Menu.Standart = function()
    Menu.w, Menu.h = SizeToScreen('x', 300), SizeToScreen('y', 500)
    Menu.x, Menu.y = CenterScreen(Menu.w, Menu.h)
end

Menu.BlockCursor = function(cursor)
    if IsValid(Menu.Frame) then
        Menu.Frame:SetMouseInputEnabled(cursor)
        Menu.Frame:SetKeyboardInputEnabled(cursor)
    end
end

Menu.Close = function()
    local QueryPanel = Derma_Query("Вы уверены, что хотите завершить процесс \""..Menu.Frame:GetTitle().."\" ?", rb_lib.query_title1,
        "Да", function()
            hook.Run("rb_block_cursor", false)
            Menu.Frame:Close()
        end, "Нет"
    )
    QueryPanel:SetIcon("icon16/error.png")
    local AcceptButton = QueryPanel:GetChildren()[6]:GetChildren()[1]
    rb_lib.query_button_delay(AcceptButton, 3)
end

Menu.RandomPlaceholder = {
    ["Серьезная авария"] = "Двойное ДТП на трассе 58",
    ["День рождения"] = "Сегодня у вашего общего друга ДР!",
    ["Пожар на АЗС"] = "Возьмите на себя роль пожарного и...",
    ["Нападения Альянса"] = "Силы Комбайнов напали на сопротивление!",
    ["Голодные игры"] = "50 участников - 1 победитель!",
    ["Баскетбол"] = "Кольцо, мяч, тусовка - баскетбол!",
    ["Заминирование"] = "Синий или красный провод?",
    ["Кухня вечером"] = "Уютный вечерний разговор на кухне",
    ["Театр"] = "Театральная постановка на тему \"Дружбы\"",
    ["Пещерный завал"] = "Груды камней обрушились и закрыли проход",
}

local function sit_create(ply)
    if IsValid(Menu.Frame) then
        Menu.Close()
        return
    end

    --[[ if ply:GetNWBool("rb_OwnSit", false) then
        local QueryPanel = Derma_Query("Вы уже создали ситуацию. Управлять ей вы можете, нажав F2", rb_lib.query_title1,
            "Ок"
        )
        QueryPanel:SetIcon("icon16/error.png")
        return
    end ]]

    local SitData = {}
    local CheckConditions = function() return end

    hook.Run("rb_block_cursor", true)

    Menu.Standart()
    local Frame = vgui.Create("DFrame")
    Frame:SetSize(Menu.w, Menu.h)
    Frame:SetPos(Menu.x, Menu.y)
    Frame:SetTitle("Создание ситуации")
    Frame:SetIcon("icon16/package_add.png")
    Frame:MakePopup()

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
        hook.Run("rb_block_cursor", false)
        Frame:SetPos(Menu.x, ScreenHeight-SizeToScreen('y', 20))
    end

    local BorderPos = LocalPlayer():GetPos()
    local BorderAng = Angle(0, 0, 0)
    local BorderSize = 30
    local BorderMaxs = Vector(BorderSize, BorderSize, BorderSize)
    local BorderMins = BorderMaxs * -1
    local BorderColor = Color(255, 255, 255)
    local BorderZ = true

    local function BorderNormalPos()
        return BorderPos+(BorderAng:Up()*BorderSize)
    end

    local function BorderUpdate()
        BorderPos = LocalPlayer():GetPos()
    end

    local SettingsPanel = Frame:Add("DCategoryList")
    SettingsPanel:Dock(FILL)
    local MainCategory = CreateCategory("Основное", "icon16/world.png", SettingsPanel)
    MainCategory:Dock(TOP)

    local RandomSitDesc, RandomSitName = table.Random(Menu.RandomPlaceholder)

    local NameTextEntryTitle = CreateTitle("Название ситуации*", MainCategory)
    NameTextEntryTitle:Dock(TOP)

    local NameTextEntry = vgui.Create("DTextEntry", MainCategory)
    NameTextEntry:Dock(TOP)
    NameTextEntry:SetPlaceholderText(RandomSitName)
    NameTextEntry:SetUpdateOnType(true)
    SetLimitTextEntry(NameTextEntry, 60)
    
    SitData["name"] = NameTextEntry

    local DescTextEntryTitle = CreateTitle("Описание ситуации", MainCategory)
    DescTextEntryTitle:Dock(TOP)

    local DescTextEntry = vgui.Create("DTextEntry", MainCategory)
    DescTextEntry:Dock(TOP)
    DescTextEntry:SetPlaceholderText(RandomSitDesc)
    DescTextEntry:SetMultiline(true)
    DescTextEntry:SetHeight(SizeToScreen('y', 100))
    SetLimitTextEntry(DescTextEntry, 250)

    SitData["desc"] = DescTextEntry

    local TypeCheckBoxTitle = CreateTitle("Тип ситуации*", MainCategory)
    TypeCheckBoxTitle:Dock(TOP)

    local PasswordTextEntry = vgui.Create("DTextEntry", MainCategory)
    PasswordTextEntry:SetVisible(false)

    local TypeCheckBoxLocal = vgui.Create("DCheckBoxLabel", MainCategory)
    TypeCheckBoxLocal:SetTextColor(Color(255, 255, 255))
    TypeCheckBoxLocal:Dock(TOP)
    TypeCheckBoxLocal:SetText("Локальная")
    TypeCheckBoxLocal:SetTooltip("Локальная ситуация доступна только ограниченному кругу лиц по предоставленному паролю.")
    TypeCheckBoxLocal.ChangeFunction = function(bool)
        PasswordTextEntry:SetEnabled(bool)
        CheckConditions()
    end

    SitData["type_local"] = TypeCheckBoxLocal

    local TypeCheckBoxGlobal = vgui.Create("DCheckBoxLabel", MainCategory)
    TypeCheckBoxGlobal:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    TypeCheckBoxGlobal:SetTextColor(Color(255, 255, 255))
    TypeCheckBoxGlobal:Dock(TOP)
    TypeCheckBoxGlobal:SetText("Глобальная")
    TypeCheckBoxGlobal:SetTooltip("Глобальная ситуация доступна всем.")
    
    SitData["type_global"] = TypeCheckBoxGlobal

    SetCheckBoxLink(TypeCheckBoxLocal, TypeCheckBoxGlobal)

    local PasswordTextEntryTitle = CreateTitle("Пароль*", MainCategory)
    PasswordTextEntryTitle:Dock(TOP)

    PasswordTextEntry = vgui.Create("DTextEntry", MainCategory)
    PasswordTextEntry:SetEnabled(false)
    PasswordTextEntry:SetVisible(true)
    PasswordTextEntry:SetUpdateOnType(true)
    PasswordTextEntry:Dock(TOP)
    SetLimitTextNumEntry(PasswordTextEntry, 9)

    SitData["password"] = PasswordTextEntry

    local MaxPlyNumSliderTitle = CreateTitle("Максимальное количество участников", MainCategory)
    MaxPlyNumSliderTitle:Dock(TOP)

    local MaxPlyNumSlider = vgui.Create("DNumSlider", MainCategory)
    MaxPlyNumSlider:DockMargin(0, SizeToScreen('y', -5), 0, 0)
    MaxPlyNumSlider:Dock(TOP)
    MaxPlyNumSlider:SetText("Количество")
    MaxPlyNumSlider:SetMin(1)
    MaxPlyNumSlider:SetMax(game.MaxPlayers())
    MaxPlyNumSlider:SetDefaultValue(game.MaxPlayers())
    MaxPlyNumSlider:ResetToDefaultValue()
    MaxPlyNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(MaxPlyNumSlider, 35, Frame)

    SitData["player_count"] = MaxPlyNumSlider

    local BorderCategory = CreateCategory("Граница", "icon16/shading.png", SettingsPanel)
    BorderCategory:Dock(TOP)

    local BorderZCheckBoxTitle = CreateTitle("Режим отображения", BorderCategory)
    BorderZCheckBoxTitle:Dock(TOP)

    local BorderZCheckBox = vgui.Create("DCheckBoxLabel", BorderCategory)
    BorderZCheckBox:SetTextColor(Color(255, 255, 255))
    BorderZCheckBox:Dock(TOP)
    BorderZCheckBox:SetText("Виден везде")

    function BorderZCheckBox:OnChange(bool)
        BorderZ = !BorderZ
    end

    local BorderSizeNumSliderTitle = CreateTitle("Размер", BorderCategory)
    BorderSizeNumSliderTitle:Dock(TOP)

    local WidthPlusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    WidthPlusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -5), 0, 0)
    WidthPlusBorderSizeNumSlider:Dock(TOP)
    WidthPlusBorderSizeNumSlider:SetText("Ширина (+)")
    WidthPlusBorderSizeNumSlider:SetMin(30)
    WidthPlusBorderSizeNumSlider:SetMax(2000)
    WidthPlusBorderSizeNumSlider:SetDefaultValue(WidthPlusBorderSizeNumSlider:GetMin())
    WidthPlusBorderSizeNumSlider:ResetToDefaultValue()
    WidthPlusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(WidthPlusBorderSizeNumSlider, 50, Frame)

    function WidthPlusBorderSizeNumSlider:OnValueChanged(value)
        BorderMaxs.x = BorderSize + (value - 30)
    end

    local WidthMinusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    WidthMinusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    WidthMinusBorderSizeNumSlider:Dock(TOP)
    WidthMinusBorderSizeNumSlider:SetText("Ширина (-)")
    WidthMinusBorderSizeNumSlider:SetMin(30)
    WidthMinusBorderSizeNumSlider:SetMax(2000)
    WidthMinusBorderSizeNumSlider:SetDefaultValue(WidthMinusBorderSizeNumSlider:GetMin())
    WidthMinusBorderSizeNumSlider:ResetToDefaultValue()
    WidthMinusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(WidthMinusBorderSizeNumSlider, 50, Frame)

    function WidthMinusBorderSizeNumSlider:OnValueChanged(value)
        BorderMins.x = (-1*BorderSize) - (value - 30)
    end

    local LengthPlusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    LengthPlusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    LengthPlusBorderSizeNumSlider:Dock(TOP)
    LengthPlusBorderSizeNumSlider:SetText("Длина (+)")
    LengthPlusBorderSizeNumSlider:SetMin(30)
    LengthPlusBorderSizeNumSlider:SetMax(2000)
    LengthPlusBorderSizeNumSlider:SetDefaultValue(LengthPlusBorderSizeNumSlider:GetMin())
    LengthPlusBorderSizeNumSlider:ResetToDefaultValue()
    LengthPlusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(LengthPlusBorderSizeNumSlider, 50, Frame)

    function LengthPlusBorderSizeNumSlider:OnValueChanged(value)
        BorderMaxs.y = BorderSize + (value - 30)
    end

    local LengthMinusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    LengthMinusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    LengthMinusBorderSizeNumSlider:Dock(TOP)
    LengthMinusBorderSizeNumSlider:SetText("Длина (-)")
    LengthMinusBorderSizeNumSlider:SetMin(30)
    LengthMinusBorderSizeNumSlider:SetMax(2000)
    LengthMinusBorderSizeNumSlider:SetDefaultValue(LengthMinusBorderSizeNumSlider:GetMin())
    LengthMinusBorderSizeNumSlider:ResetToDefaultValue()
    LengthMinusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(LengthMinusBorderSizeNumSlider, 50, Frame)

    function LengthMinusBorderSizeNumSlider:OnValueChanged(value)
        BorderMins.y = (-1*BorderSize) - (value - 30)
    end

    local HeightPlusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    HeightPlusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    HeightPlusBorderSizeNumSlider:Dock(TOP)
    HeightPlusBorderSizeNumSlider:SetText("Высота")
    HeightPlusBorderSizeNumSlider:SetMin(30)
    HeightPlusBorderSizeNumSlider:SetMax(2000)
    HeightPlusBorderSizeNumSlider:SetDefaultValue(HeightPlusBorderSizeNumSlider:GetMin())
    HeightPlusBorderSizeNumSlider:ResetToDefaultValue()
    HeightPlusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(HeightPlusBorderSizeNumSlider, 50, Frame)

    local PlusScale = 1
    local MinusScale = 1

    function HeightPlusBorderSizeNumSlider:OnValueChanged(value)
        BorderMaxs.z = BorderSize + (value - 30)
    end

    local HeightMinusBorderSizeNumSlider = vgui.Create("DNumSlider", BorderCategory)
    HeightMinusBorderSizeNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    HeightMinusBorderSizeNumSlider:Dock(TOP)
    HeightMinusBorderSizeNumSlider:SetText("Глубина")
    HeightMinusBorderSizeNumSlider:SetMin(30)
    HeightMinusBorderSizeNumSlider:SetMax(2000)
    HeightMinusBorderSizeNumSlider:SetDefaultValue(HeightMinusBorderSizeNumSlider:GetMin())
    HeightMinusBorderSizeNumSlider:ResetToDefaultValue()
    HeightMinusBorderSizeNumSlider:SetDecimals(0)
    GetNormalWidthNumSlider(HeightMinusBorderSizeNumSlider, 50, Frame)

    function HeightMinusBorderSizeNumSlider:OnValueChanged(value)
        BorderMins.z = (-1*BorderSize) - (value - 30)
    end

    local FogCheckBoxTitle = CreateTitle("Туман", BorderCategory)
    FogCheckBoxTitle:Dock(TOP)

    local FogCheckBox = vgui.Create("DCheckBoxLabel", BorderCategory)
    FogCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    FogCheckBox:SetTextColor(Color(255, 255, 255, 255))
    FogCheckBox:Dock(TOP)
    FogCheckBox:SetText("Включить туман")

    local FogColorMixerTitle = CreateTitle("Цвет тумана", BorderCategory)
    FogColorMixerTitle:Dock(TOP)

    local FogColorMixer = vgui.Create("DColorMixer", BorderCategory)
    FogColorMixer:Dock(TOP)
    FogColorMixer:SetEnabled(false)
    FogColorMixer:SetPalette(false)
    FogColorMixer:SetAlphaBar(false)
    FogColorMixer:SetColor(Color(255, 255, 255))
    FogColorMixer:SetHeight(SizeToScreen('y', 100))

    function FogColorMixer:ValueChanged(color)
        BorderColor = color
    end

    function FogCheckBox:OnChange(bool)
        FogColorMixer:SetEnabled(bool)
    end

    local RefreshCenterButton = vgui.Create("DButton", BorderCategory)
    RefreshCenterButton:Dock(TOP)
    RefreshCenterButton:DockMargin(0, SizeToScreen('y', 5), 0, SizeToScreen('y', 5))
    RefreshCenterButton:SetIcon("icon16/arrow_rotate_anticlockwise.png")
    RefreshCenterButton:SetText("Обновить центр границы")

    function RefreshCenterButton:DoClick()
        BorderUpdate()
    end

    local CanCategory = CreateCategory("Привилегии участников", "icon16/rainbow.png", SettingsPanel)
    CanCategory:DockMargin(0, 0, 0, SizeToScreen('y',5))
    CanCategory:Dock(TOP)

    local PerkCheckBoxTitle = CreateTitle("Основные", CanCategory)
    PerkCheckBoxTitle:Dock(TOP)

    local PerkNoclipCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkNoclipCheckBox:SetTextColor(Color(255, 255, 255))
    PerkNoclipCheckBox:Dock(TOP)
    PerkNoclipCheckBox:SetText("Ноуклип")

    SitData["noclip"] = PerkNoclipCheckBox

    local PerkRespawnCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkRespawnCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    PerkRespawnCheckBox:SetTextColor(Color(255, 255, 255))
    PerkRespawnCheckBox:Dock(TOP)
    PerkRespawnCheckBox:SetText("Респавн внутри ситуации")

    SitData["respawn"] = PerkRespawnCheckBox

    local PerkToolsCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    PerkToolsCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    PerkToolsCheckBox:SetTextColor(Color(255, 255, 255))
    PerkToolsCheckBox:Dock(TOP)
    PerkToolsCheckBox:SetText("Инструменты (физ-ган, тулган)")

    SitData["tools"] = PerkToolsCheckBox

    local SpawnCheckBoxTitle = CreateTitle("Разрешенный спавн", CanCategory)
    SpawnCheckBoxTitle:Dock(TOP)

    local SpawnPropCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnPropCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnPropCheckBox:Dock(TOP)
    SpawnPropCheckBox:SetText("Пропы")

    SitData["props"] = SpawnPropCheckBox

    local SpawnEntityCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnEntityCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnEntityCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnEntityCheckBox:Dock(TOP)
    SpawnEntityCheckBox:SetText("Энтити")

    SitData["entities"] = SpawnEntityCheckBox

    local SpawnNpcCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnNpcCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnNpcCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnNpcCheckBox:Dock(TOP)
    SpawnNpcCheckBox:SetText("NPC")

    SitData["npc"] = SpawnNpcCheckBox

    local SpawnWeaponCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnWeaponCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnWeaponCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnWeaponCheckBox:Dock(TOP)
    SpawnWeaponCheckBox:SetText("Оружие")

    SitData["weapons"] = SpawnWeaponCheckBox

    local SpawnCarCheckBox = vgui.Create("DCheckBoxLabel", CanCategory)
    SpawnCarCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    SpawnCarCheckBox:SetTextColor(Color(255, 255, 255))
    SpawnCarCheckBox:Dock(TOP)
    SpawnCarCheckBox:SetText("Машины")

    SitData["vehicles"] = SpawnCarCheckBox

    local PlyCategory = CreateCategory("Участники", "icon16/group.png", SettingsPanel)
    PlyCategory:Dock(TOP)

    local HpPlyNumEntryTitle = CreateTitle("Здоровье", PlyCategory)
    HpPlyNumEntryTitle:Dock(TOP)

    local HpPlyNumEntry = vgui.Create("DTextEntry", PlyCategory)
    HpPlyNumEntry:Dock(TOP)
    HpPlyNumEntry:SetValue(100)
    SetLimitNumEntry(HpPlyNumEntry, 1, 255)

    SitData["hp"] = HpPlyNumEntry

    local ArmorPlyNumEntryTitle = CreateTitle("Броня", PlyCategory)
    ArmorPlyNumEntryTitle:Dock(TOP)

    local ArmorPlyNumEntry = vgui.Create("DTextEntry", PlyCategory)
    ArmorPlyNumEntry:Dock(TOP)
    ArmorPlyNumEntry:SetValue(0)
    SetLimitNumEntry(ArmorPlyNumEntry, 0, 255)

    SitData["armor"] = ArmorPlyNumEntry

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

    SitData["speed"] = SpeedPlyNumSlider

    local LimitNumSliderTitle = CreateTitle("Лимиты", PlyCategory)
    LimitNumSliderTitle:Dock(TOP)

    local LimitPropNumSlider = vgui.Create("DNumSlider", PlyCategory)
    LimitPropNumSlider:DockMargin(0, SizeToScreen('y', -5), 0, 0)
    LimitPropNumSlider:Dock(TOP)
    LimitPropNumSlider:SetText("Пропы")
    LimitPropNumSlider:SetMin(1)
    LimitPropNumSlider:SetMax(100)
    LimitPropNumSlider:SetDefaultValue(50)
    LimitPropNumSlider:ResetToDefaultValue()
    LimitPropNumSlider:SetDecimals(0)
    LimitPropNumSlider:SetEnabled(false)
    GetNormalWidthNumSlider(LimitPropNumSlider, 60, Frame)

    function SpawnPropCheckBox:OnChange(bool)
        LimitPropNumSlider:SetEnabled(bool)
    end

    local LimitEntityNumSlider = vgui.Create("DNumSlider", PlyCategory)
    LimitEntityNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    LimitEntityNumSlider:Dock(TOP)
    LimitEntityNumSlider:SetText("Энтити")
    LimitEntityNumSlider:SetMin(1)
    LimitEntityNumSlider:SetMax(10)
    LimitEntityNumSlider:SetDefaultValue(5)
    LimitEntityNumSlider:ResetToDefaultValue()
    LimitEntityNumSlider:SetDecimals(0)
    LimitEntityNumSlider:SetEnabled(false)
    GetNormalWidthNumSlider(LimitEntityNumSlider, 60, Frame)

    function SpawnEntityCheckBox:OnChange(bool)
        LimitEntityNumSlider:SetEnabled(bool)
    end

    local LimitNpcNumSlider = vgui.Create("DNumSlider", PlyCategory)
    LimitNpcNumSlider:DockMargin(0, SizeToScreen('y', -10), 0, 0)
    LimitNpcNumSlider:Dock(TOP)
    LimitNpcNumSlider:SetText("NPC")
    LimitNpcNumSlider:SetMin(1)
    LimitNpcNumSlider:SetMax(2)
    LimitNpcNumSlider:SetDefaultValue(1)
    LimitNpcNumSlider:ResetToDefaultValue()
    LimitNpcNumSlider:SetDecimals(0)
    LimitNpcNumSlider:SetEnabled(false)
    GetNormalWidthNumSlider(LimitNpcNumSlider, 60, Frame)

    function SpawnNpcCheckBox:OnChange(bool)
        LimitNpcNumSlider:SetEnabled(bool)
    end

    local AddCategory = CreateCategory("Дополнительно", "icon16/plugin_add.png", SettingsPanel)
    AddCategory:Dock(TOP)

    local FuncCheckBoxTitle = CreateTitle("Функции", AddCategory)
    FuncCheckBoxTitle:Dock(TOP)

    local Func3DVoiceCheckBox = vgui.Create("DCheckBoxLabel", AddCategory)
    Func3DVoiceCheckBox:SetTextColor(Color(255, 255, 255))
    Func3DVoiceCheckBox:Dock(TOP)
    Func3DVoiceCheckBox:SetText("Супер-3D Voice")

    local FuncAudioHPCheckBox = vgui.Create("DCheckBoxLabel", AddCategory)
    FuncAudioHPCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    FuncAudioHPCheckBox:SetTextColor(Color(255, 255, 255))
    FuncAudioHPCheckBox:Dock(TOP)
    FuncAudioHPCheckBox:SetText("Аудио-Здоровье")

    local FuncVisualHPCheckBox = vgui.Create("DCheckBoxLabel", AddCategory)
    FuncVisualHPCheckBox:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    FuncVisualHPCheckBox:SetTextColor(Color(255, 255, 255))
    FuncVisualHPCheckBox:Dock(TOP)
    FuncVisualHPCheckBox:SetText("Визуальное-Здоровье")

    local FinalCategory = CreateCategory("Последние штрихи", "icon16/cake.png", SettingsPanel)
    FinalCategory:Dock(TOP)

    local FormalTitle = CreateTitle("Формальности", FinalCategory)
    FormalTitle:Dock(TOP)

    local FormalCheckBox = vgui.Create("DCheckBoxLabel", FinalCategory)
    FormalCheckBox:SetTextColor(Color(255, 255, 255))
    FormalCheckBox:Dock(TOP)
    FormalCheckBox:SetText("Я принимаю все выбранные мной настройки")
    FormalCheckBox:SetTooltip("Обязательно проверьте заполнили ли вы обязательные поля!")

    local FormalButton = vgui.Create("DButton", FinalCategory)
    FormalButton:DockMargin(0, SizeToScreen('y', 5), 0, 0)
    FormalButton:SetTextColor(Color(255, 255, 255))
    FormalButton:Dock(TOP)
    FormalButton:SetText("Создать ситуацию")
    FormalButton:SetIcon("icon16/accept.png")
    FormalButton:SetEnabled(false)

    CheckConditions = function ()
        if !(NameTextEntry:GetText() != "" && (TypeCheckBoxGlobal:GetChecked() || (TypeCheckBoxLocal:GetChecked() && PasswordTextEntry:GetText() != ""))) then
            if FormalCheckBox:GetChecked() == true then
                FormalCheckBox:SetValue(!FormalCheckBox:GetChecked())
                return false
            end
        else
            return true
        end
    end

    function FormalCheckBox:OnChange(bool)
        if CheckConditions() then
            FormalButton:SetEnabled(bool)
        else
            FormalButton:SetEnabled(false)
        end
    end
    
    function NameTextEntry:OnValueChange(text)
        CheckConditions()
    end
    function PasswordTextEntry:OnValueChange(text)
        CheckConditions()
    end

    function FormalButton:DoClick()
        local SortSitData = {}
        for k, v in pairs(SitData) do
            local value
            if v:GetName() == "DCheckBoxLabel" then
                value = v:GetChecked()
                if value == nil then value = false end
            else
                value = v:GetValue()
            end

            if isnumber(value) then value = math.Round(value) end

            SortSitData[k] = value
        end

        net.Start("rb_sit_server")
            net.WriteString("CheckCreateSit")
            net.WriteTable({
                pos = BorderNormalPos(),
                mins = BorderMins,
                maxs = BorderMaxs,
            })
        net.SendToServer()

        local CreateMessagePanel = Derma_Message("Подождите, ситуация создается...", rb_lib.query_title1, "Продолжить")
        CreateMessagePanel:SetIcon("icon16/clock.png")
        local CreateMessageTitle = CreateMessagePanel:GetChildren()[4]
        local CreateMessageText = CreateMessagePanel:GetChildren()[5]:GetChildren()[1]
        local ContinueButton = CreateMessagePanel:GetChildren()[6]:GetChildren()[1]
        ContinueButton:SetEnabled(false)

        timer.Create("rb_timer_create", 2, 1, function()
            CreateMessageTitle:SetText(rb_lib.query_title2)
            CreateMessageText:SetText("Поздравляем, вы создали ситуацию!")
            CreateMessagePanel:SetIcon("icon16/award_star_bronze_1.png")
            ContinueButton:SetEnabled(true)

            hook.Run("rb_block_cursor", false)
            Frame:Close()

            print("\n[RB_DEBUG] You have created a situation:")
            PrintTable(SortSitData, 1)

            net.Start("rb_sit_server")
                net.WriteString("CreateSit")
                net.WriteTable({
                    pos = BorderNormalPos(),
                    mins = BorderMins,
                    maxs = BorderMaxs,
                    sit = SortSitData
                })
            net.SendToServer()
        end)

        net.Receive("rb_sit_client", function()
            local act = net.ReadString()
            if act == "ErrorCreateSit" then
                CreateMessageTitle:SetText(rb_lib.query_title3)
                CreateMessageText:SetText("Ваша ситуация пересекается с другой")
                CreateMessagePanel:SetIcon("icon16/error.png")
                ContinueButton:SetEnabled(true)
                timer.Remove("rb_timer_create")
            end
        end)        
    end

    hook.Add("PostDrawTranslucentRenderables", Frame, function()
        render.DrawWireframeBox(BorderNormalPos(), BorderAng, BorderMins, BorderMaxs, BorderColor, BorderZ)
    end)

    function Frame:OnKeyCodePressed(key)
        local bind = input.LookupKeyBinding(key)
        if bind == "gm_showhelp" then
            rb_lib.ShowHelp(LocalPlayer())
        elseif bind == "gm_showspare1" then
            rb_lib.ShowSpare1(LocalPlayer())
        end
    end
    Menu.Frame = Frame
end

hook.Add("rb_block_cursor", "sit_create", Menu.BlockCursor)

concommand.Add("rb_sit_create", sit_create)

concommand.Add("rb_sit_delete", function()
    net.Start("rb_sit_server")
        net.WriteString("DeleteSit")
    net.SendToServer()
end)