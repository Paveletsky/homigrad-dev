local testsWidth = 1280
local testsHeight = 720

ScreenWidth = ScrW()
ScreenHeight = ScrH()

local Cursor = {}
Cursor.Block = false

hook.Add("OnScreenSizeChanged", "ScreenSizeChange", function()
    ScreenWidth = ScrW()
    ScreenHeight = ScrH()
end)

function CenterScreen(w, h)
    return (ScreenWidth/2)-(w/2), (ScreenHeight/2)-(h/2)
end

function SizeToScreen(dir, num)
    if dir == 'x' then
        return ScreenWidth * num / testsWidth
    elseif dir == 'y' then
        return ScreenHeight * num / testsHeight
    elseif dir == 'xy' then
        return (ScreenWidth + ScreenHeight) * num / (testsWidth + testsHeight)
    end
end

function rb_block_cursor(cursor)
    if cursor != !Cursor.Block then
        Cursor.Block = cursor
    else
        Cursor.Block = !Cursor.Block
    end
    
    gui.EnableScreenClicker(Cursor.Block)
end

hook.Add("rb_block_cursor", "rb_block_cursor", rb_block_cursor)

concommand.Add("rb_block_cursor", function() hook.Run("rb_block_cursor", !Cursor.Block) end)