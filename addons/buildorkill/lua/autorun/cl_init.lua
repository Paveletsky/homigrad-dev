bok = bok or { util = {}, gui = {}, meta = {} }

-- подключение базовых файлов
include("core/sh_util.lua")
include("shared.lua")

function bok.gui.button(pnl, txt, click)
    local b = vgui.Create 'bkButton'
    if pnl.AddItem then pnl:AddItem(b) else pnl:Add(b) end
    b:Dock(TOP)
    b:DockMargin(0, 5, 0, 0)
    b:SetTall(21)
    b:SetText(txt)
    b.DoClick = click

    return b
end

function bok.gui.label(pnl, txt)
    local t = vgui.Create 'DLabel'
    if pnl.AddItem then pnl:AddItem(t) else pnl:Add(t) end
    t:Dock(TOP)
    t:SetFont( 'bkFontMedium' )
    t:SetTall(30)
    t:SetContentAlignment(2)
    t:SetText(txt)

    return t
end

function bok.gui.ScreenNotify(text)
    hook.Run('Wardrobe_Notification', text)
end

netstream.Hook('bkSurfaceSoundPlay', function(path)
    surface.PlaySound(path)
end)

netstream.Hook('bkScreenNotify', function(text, time, path, fadeIn, fadeOut)
    bok.gui.Notify(text, time, path, fadeIn, fadeOut)
end)