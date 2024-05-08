concommand.Add("rb_sit_list", function() 
    hook.Run("rb_block_cursor", true)
end)

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
    local QueryPanel = Derma_Query("Вы уверены, что хотите завершить процесс \"Создание ситуации\" ?", rb_lib.query_title1,
        "Да", function()
            hook.Run("rb_block_cursor", false)
            Menu.Frame:Close()
        end, "Нет"
    )
    QueryPanel:SetIcon("icon16/error.png")
    local AcceptButton = QueryPanel:GetChildren()[6]:GetChildren()[1]
    //rb_lib.query_button_delay(AcceptButton, 5)
end