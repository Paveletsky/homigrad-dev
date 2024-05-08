local KeyLast   = 0 
local IsAFK     = false

local function Reset()
	netstream.Start('bkAFKState', false) IsAFK = false
end

hook.Add('PlayerButtonDown', 'bkIsAFK', function(client, key)
	KeyLast = CurTime()
    
	if IsAFK then 
        Reset()
    end
end)

timer.Create('bkAFKTimer', 1, 0, function()
	if (not IsAFK) and (CurTime() > KeyLast + 30) then 
        netstream.Start('bkAFKState', true) IsAFK = true
    end
end)

-- paint
hook.Add('HUDPaint', 'bkIsAFK', function()
    if (not IsAFK) then
        return
    end

    draw.RoundedBox(5, 5, 15, 210, 70, Color(0, 0, 0, 150))
    
    draw.Text {
        text = 'Ты в АФК',
        font = 'fdShopSemiFont',
        pos = { 80, 31 },
        xalign = TEXT_ALIGN_LEFT,
        yalign = TEXT_ALIGN_LEFT,
        color = Color(255,255,255, 240),
    }

    surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Material('pixel_icons/clock.png', ''))
    surface.DrawTexturedRect(10, 17, 64, 64)
end)

-- go epta
Reset()