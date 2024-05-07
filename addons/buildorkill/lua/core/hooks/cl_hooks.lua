bok.gui = bok.gui or {client = LocalPlayer()}

function VerticalScale( size )
    return size * ( math.floor(ScrH()/360.0) )
end

VScale = VerticalScale

function ScreenScaleMin( size )
    return math.min(SScale(size), VScale(size))
end

SScaleMin = ScreenScaleMin

surface.CreateFont("bkFontChatMain", {
    font = 'Roboto Regular',
    size = math.max(ScreenScale(6), 12),
    extended = true,
    weight = 400,
    antialias = true,
    outline = true,
})

surface.CreateFont('bkFontGuildOnPlayer', {
    font = 'NewZelekProConnected',
    extended = true,
    size = 18,
    weight = 300,
    shadow = true,
    scanlines = 2,
})

surface.CreateFont("bkFontDoorTitle", {
    font = 'Roboto Regular',
    size = 250,
    extended = true,
    weight = 400,
    antialias = true,
    outline = true,
})

surface.CreateFont("bkFontMini", {
    font = 'Marske',
    size = 11,
    extended = true,
    antialias = true,
})

surface.CreateFont("bkFontMedium", {
    font = 'Marske',
    size = 18,
    extended = true,
    antialias = true,
})

surface.CreateFont("bkAFKFont", {
    font = 'Marske',
    size = 24,
    extended = true,
    weight = 800,
    antialias = true,
    outline = true,
    scanlines = 3,
})


--
--
--

hook.Add('Think', 'bkPlayerOnLoad', function()
    hook.Remove('Think', 'bkPlayerOnLoad')

    netstream.Start('bkPlayerOnLoad')
end)

netstream.Hook('bkPlayerSetLoading', function(name)
    whoLoaded[name] = true
end)

netstream.Hook('bkPlayerSetNoLoading', function(name)
    whoLoaded[name] = nil
end)

netstream.Hook('bkPlayerOnLoad', function()
    hook.Run('PlayerLoaded', LocalPlayer())
end)


--
--
--
hook.Add( "PlayerBindPress", "PlayerBindPressExample", function( ply, bind, pressed )
	if ( string.find( bind, "gm_showspare2" ) ) then
        if not ValidPanel(PIS.RadialMenu) then PIS:OpenRadialMenu() else PIS.RadialMenu:Close() end
    end
end )

hook.Add ("OnContextMenuOpen", "bkContextMenu", function()
    LocalPlayer():ConCommand("bk_cmenu")
end)

hook.Add ("OnContextMenuClose", "bkContextMenu", function()
    if (bok.gui.contextMenu) then
        if bok.gui.mmd then
            bok.gui.mmd:Remove()            
        end

        bok.gui.contextMenu:Remove()
    end
end)

local temp = {
    {' Полигон ', Vector(8943, 9185, -12258), Angle(0, 90, 90)},
    {' Строительная зона ', Vector(8943, 9252, -12258), Angle(0, 90, 90)},
}

hook.Add("PostDrawOpaqueRenderables", "bkDoorText", function()
    local ply = LocalPlayer()

    local pos, ang  = Vector(8943, 9185, -12258), Angle(0, 90, 90)
    local dist      = ply:GetPos():Distance(pos) / 1000
    local alpha     = math.Clamp(dist, 0, 1) * 255

    for _, prop in ipairs(temp) do
        cam.Start3D2D( prop[2], prop[3], 0.025 )
            draw.WordBox(24, 0, 0, prop[1], 'bkFontDoorTitle', Color(0, 0, 0, 255), Color(255, 255, 255, 255-alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D() 
    end
end)

local WepToIgnore = {
    ['weapon_physgun'] = true,
    ['gmod_tool'] = true,
    ['weapon_hands'] = true,
}

hook.Add("PlayerBindPress", "DisableQEBindings", function(ply, bind, pressed)
    if IsValid(ply) and ply:Alive() and ply:IsPlayer() then
        local weapon = ply:GetActiveWeapon()
        local ent = ply:GetEyeTrace().Entity
        local distance = ply:GetPos():Distance(ent:GetPos())

        if IsValid(weapon) and weapon:IsWeapon() and !WepToIgnore[weapon:GetClass()] then                            
            if distance < 100 and ent:GetClass() != 'worldspawn' then return end

            if bind == "+menu" then
                PressedAlt1 = PressedAlt1 == '-alt1' and '+alt1' or '-alt1'
                ply:ConCommand(PressedAlt1)

                if !pressed then
                    PressedAlt1 = '-alt1'
                    ply:ConCommand('-alt1')
                end

                return true
            end
             
            if bind == "+use" then
                PressedAlt2 = PressedAlt2 == '-alt2' and '+alt2' or '-alt2'
                ply:ConCommand(PressedAlt2)
            
                if !pressed then
                    PressedAlt2 = '-alt2'
                    ply:ConCommand('-alt2')
                end

                return true
            end
        end
    end
end)