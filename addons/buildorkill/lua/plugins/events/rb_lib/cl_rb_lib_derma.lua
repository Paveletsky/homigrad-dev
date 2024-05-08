function CreateCategory(text, icon, parent)
    local category = parent:Add(text)
    category:GetChildren()[1]:SetEnabled(false)
    category:GetChildren()[1]:SetIcon(icon)
    return category
end

function CreateTitle(text, parent)
    local title = vgui.Create("DLabel", parent)
    title:SetText(text)
    title:SetTextColor(Color(255, 255, 255))
    title:SetFont("DermaDefaultBold")
    return title
end

function GetNormalWidthNumSlider(DNumSlider, width, parent, block)
    DNumSlider:GetChildren()[3]:SetTextColor(Color(255, 255, 255))
    DNumSlider:GetChildren()[3]:SetMouseInputEnabled(false)
    DNumSlider:GetChildren()[3]:DockMargin(SizeToScreen('x', 5), 0, SizeToScreen('x', width), 0)
    DNumSlider:GetChildren()[2]:DockMargin(SizeToScreen('x', -width*2), 0, SizeToScreen('x', 20), 0)
    DNumSlider:GetChildren()[1]:DockMargin(SizeToScreen('x', -20), 0, SizeToScreen('x', -10), 0)
end

function SetLimitTextEntry(DTextEntry, limit)
    function DTextEntry:AllowInput(char)
        if string.len(DTextEntry:GetText()) >= limit then
            return true
        end
    end
end

function SetLimitTextNumEntry(DNumEntry, limit)
    function DNumEntry:AllowInput(char)
        char = tonumber(char)
        if !isnumber(char) then return true end
        if string.len(DNumEntry:GetText()) >= limit then
            return true
        end
    end
end

function SetLimitNumEntry(DNumEntry, MinLimit, MaxLimit)
    function DNumEntry:AllowInput(char)
        char = tonumber(char)
        if !isnumber(char) then return true end
        local value = tonumber(DNumEntry:GetValue()..char)
        if value == nil then return false end

        if value > (MaxLimit || value+1) || value < (MinLimit || value-1) then
            return true
        end
    end
end

function SetCheckBoxLink(first, second)
    function first:OnChange(bool)
        if second:GetChecked() == bool || second:GetChecked() == nil then second:SetValue(!bool) end
        if first.ChangeFunction then first.ChangeFunction(bool) end
    end

    function second:OnChange(bool)
        if first:GetChecked() == bool || first:GetChecked() == nil then first:SetValue(!bool) end
        if second.ChangeFunction then second.ChangeFunction(bool) end
    end
end

function StaticCheckBox(DCheckBoxLabel, state)
    DCheckBoxLabel:SetValue(state)
    function DCheckBoxLabel:OnChange(bool)
        if bool != state then DCheckBoxLabel:SetValue(state) end
    end
end