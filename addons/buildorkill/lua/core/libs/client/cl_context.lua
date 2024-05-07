local function OpenContextMenu(ply, argm, cmd)
    local options = 1
    bok.gui.contextMenu = vgui.Create('DFrame')
    
    local pnl = bok.gui.contextMenu
        pnl:MakePopup()
        pnl:SetKeyBoardInputEnabled(false)

        pnl:ShowCloseButton(false)
        pnl:SetDraggable(false)
    pnl:SetTitle('')

    -- options
    local function AddOption(name, callback)
        local but = pnl:Add('DButton')
        but:Dock(TOP)
        but:SetTall(40)
        but:SetText(name or 'Загадочная кнопка')

        but.PerformLayout = function(this)
            this:SetFontInternal( "bkFontChatMain" )
        end

        but.DoClick = function(this)
            if isfunction(callback) then
                callback()
            end
        end

        options = options + 1
    end

    local wep = ply:GetActiveWeapon()

    if ply:Alive() then
        if wep:GetClass()!="weapon_hands" then
            AddOption("Выкинуть", function()
                LocalPlayer():ConCommand("say *drop")
            end)
        end

        if wep:Clip1()>0 then
            AddOption("Разрядить",function()
                net.Start("Unload")
                net.WriteEntity(wep)
                net.SendToServer()
            end)
        end
    end

    AddOption('Активировать Маску/Забрало', function()
        LocalPlayer():ConCommand("jmod_ez_toggleeyes")
    end)

    AddOption('Меню брони', function()
        LocalPlayer():ConCommand("jmod_ez_inv")
    end)
    
    AddOption('Меню патрон', function()
        LocalPlayer():ConCommand("hg_ammomenu")
    end)

    pnl:SetSize(500, 40 * options)

    local x, y = (ScrW()/2-pnl:GetWide()/2), (ScrH()-pnl:GetTall()-20)
    pnl:SetPos(x, ScrH())
    pnl:SetAlpha(0)

    -- anim
    pnl:MoveTo(x, y, 0.8, 0, .1)
    
    pnl:AlphaTo(255, .1, 0)
end

concommand.Add("bk_cmenu", OpenContextMenu)