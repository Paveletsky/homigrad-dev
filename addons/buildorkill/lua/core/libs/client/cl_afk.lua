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

    draw.Text {
        text = 'Режим бездействия',
        font = 'bkAFKFont',
        pos = { 85, 35 },
        xalign = TEXT_ALIGN_LEFT,
        yalign = TEXT_ALIGN_LEFT,
        color = Color(255,255,255, 240),
    }

    surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Material('pixel_icons/clock.png', 'smooth'))
    surface.DrawTexturedRect(10, 15, 64, 64)
end)

-- go epta
Reset()