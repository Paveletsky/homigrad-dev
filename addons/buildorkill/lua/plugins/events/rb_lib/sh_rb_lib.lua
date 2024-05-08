rb_lib = {
    ShowHelp = function(ply)
        ply:ConCommand("rb_sit_create")
    end,
    ShowTeam = function(ply)
        ply:ConCommand("rb_sit_list")
    end,
    ShowSpare1 = function(ply)
        ply:ConCommand("rb_block_cursor")
    end,
    query_title1 = "Обратите внимание...",
    query_title2 = "Всё получилось!",
    query_title3 = "Ошибка...",
    query_button_delay = function(button, delay)
        local buttonTextDefalut = button:GetText()
        button:SetEnabled(false)
    
        local function delayButton()
            if IsValid(button) then
                if delay > 0 then
                    button:SetText(buttonTextDefalut .. " (" .. tostring(delay) .. ")")
                    delay = delay - 1
                else
                    button:SetText(buttonTextDefalut)
                    button:SetEnabled(true)
                end
            end
        end
        delayButton()
    
        timer.Create("query_button_delay", 1, delay+1, delayButton)
    end,
}