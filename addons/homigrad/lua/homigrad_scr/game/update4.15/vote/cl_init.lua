surface.CreateFont('player.name', {
    font = 'Marske',
    extended = true,
    size = 26,
    weight = 300,
    shadow = true,
    scanlines = 1,
})

local time = 0
local function votemenu(timeEnd, items, allMaps)

    if LocalPlayer():SteamID() != 'STEAM_0:0:30588797' then
        return
    end

    for k, v in pairs(items) do
        v.votes = 0
        v.whoVoted = {}
    end

    time = CurTime() + timeEnd

    if IsValid(menu) then menu:Remove() end
    menu = vgui.Create 'DFrame'
    menu:Dock(FILL)
    menu:SetTitle ''
    menu:MakePopup()
    menu:SetDraggable(false)
    menu:ShowCloseButton()
    menu:SetBackgroundBlur(true)
    menu:SetAlpha(200)
    menu:Center()

    local topPnl = menu:Add 'DPanel'
    topPnl:SetWide(ScrW())
    topPnl:SetTall(250)
    topPnl:SetPos(0, -ScrH())
    -- topPnl:SetZPos(1)
    topPnl.Paint = function(self, w, h)
        -- for i = 1, 2 do
            surface.SetMaterial( Material('sbox/menu/vote/upper.png') )
            surface.SetDrawColor( 0, 0, 0 )
            surface.DrawTexturedRect(0, 0, w, h)
        -- end
    end

	local label = menu:Add 'DLabel'
	label:Dock(TOP)
    label:SetTall(30)
	label:DockMargin(0, 10, 0, 0)
    label:SetContentAlignment(2)
	label:SetFont('player.name')
	label.Think = function(self)
        local timeleft = time - CurTime()
        local text = string.FormattedTime(timeleft, '%02i:%02i')
        label:SetText('Конец голосования через: ' .. text)
    end

    local downPnl = menu:Add 'DPanel'
    downPnl:SetWide(ScrW())
    downPnl:SetTall(400)
    downPnl:SetPos(0, ScrH())
    -- downPnl:SetZPos(1)
    downPnl.Paint = function(self, w, h)
        -- for i = 1, 2 do
            surface.SetMaterial( Material('sbox/menu/vote/down.png') )
            surface.SetDrawColor( 0, 0, 0, 230)
            surface.DrawTexturedRect(0, 0, w, h)
        -- end
    end

    topPnl:MoveTo(0, topPnl:GetTall() * .0, 0.5, 0, .1, function()
        downPnl:MoveTo(0, ScrH() - downPnl:GetTall(), 0.3, 0, .1, function()
            local off, choice = 40, _

            DHorizontalScroller = menu:Add('DHorizontalScroller')
            DHorizontalScroller:Dock( FILL )
            DHorizontalScroller:DockMargin(0, 100, 0, 200)
            DHorizontalScroller:SetOverlap( -35 )
            DHorizontalScroller.PaintOver = nil

            local scrollPanel = DHorizontalScroller:GetCanvas()
            local targetX = 0
            local currentX = 0
            local velocity = 0
            
            
            scrollPanel.OnMouseWheeled = function(self, delta)
                velocity = delta * 2000 -- Умножаем на значение, чтобы увеличить скорость
                targetX = targetX + delta * 200 -- Обновляем цель движения
            end

            local revolverSound = Sound("danganronpa/revl_drum.mp3")
            local scrollerSound = nil
            local isScrolling = false

            local scrollSpeed
            local pitch 

            local spr = menu:Add 'DSprite'
            spr:SetMaterial(Material( 'sbox/drum.png', 'noclamp smooth' ))
            spr:SetSize(300, 300)
            spr:SetPos(ScrW() - 100, ScrH() - 100)
            spr:SetColor(Color(15, 15, 15))

            local spr2 = menu:Add 'DSprite'
            spr2:SetMaterial(Material( 'sbox/drum.png', 'noclamp smooth' ))
            spr2:SetSize(250, 250)
            spr2:SetPos(70, 70)
            spr2:SetColor(Color(15, 15, 15))

            local prevRotationAngle = 0
            local currentRotationAngle = 0

            scrollPanel.Think = function(self)
                local newX = Lerp(FrameTime() * 5, currentX, targetX)
                DHorizontalScroller.pnlCanvas:SetPos(newX, 0)
                currentX = newX

                scrollSpeed = math.abs(velocity)
                pitch = math.Clamp(70 + scrollSpeed * 0.1, 190, 210)

                -- Применяем ускорение
                currentX = currentX + velocity * FrameTime()
                velocity = velocity * 0.95-- Здесь можно настроить коэффициент замедления ускорения    
            
                
                -- Вычисляем угол поворота барабана револьвера на основе скорости прокрутки
                local targetRotationAngle = ((scrollSpeed * 0.09) + FrameTime() * 360) -- Умножаем на FrameTime() для плавного вращения
                currentRotationAngle = Lerp(0.1, currentRotationAngle, targetRotationAngle)

                -- Устанавливаем угол поворота барабана револьвера
                spr:SetRotation(-currentRotationAngle)
                spr2:SetRotation(currentRotationAngle * 2)
                prevRotationAngle = currentRotationAngle
            end

            hook.Add("StartCommand", "ScrollingSound", function(cmd)
            end)

            for id, item in SortedPairs(items) do

                local pnl = vgui.Create('DButton', DHorizontalScroller)
                local mat = allMaps[id] and allMaps[id].icon .. '.png' or 'cybercurt/introbg.png'

                pnl:SetText ''     
                pnl:SetWide(500)
                pnl:SetZPos(2)
                -- pnl:SetPos(ScrW(), ScrH() / 2 - pnl:GetTall() /2)
                -- pnl:MoveTo(ScrW() / 2 - pnl:GetWide() + off, ScrH() / 2 - pnl:GetTall() /2, 0.5, 0, .1)
                pnl.Paint = function(self, w, h)
                    for i = 1, 2 do
                        surface.SetMaterial( Material(mat, 'noclamp smooth') )
                        surface.SetDrawColor( 255, 255, 255, 255)
                        surface.DrawTexturedRect(0, 0, w, h)
                    end

                    draw.SimpleText('Голоса: ' .. item.votes, 'player.name', 10, 20, color_white)
                    draw.SimpleText(id, 'player.name', 10, 50, color_white)
                end

                pnl.OnCursorEntered = function(self)
                    print(scrollSpeed < 1000)
                    -- self:SizeTo(pnl:GetWide() - 30, pnl:GetTall() - 30, 0.5, 0, .1)
                    LocalPlayer():EmitSound( "danganronpa/revl_drum.mp3", _, scrollSpeed > 1000 and pitch / 1.2 or 100 )
                end

                pnl.OnCursorExited = function(self)
                    -- self:SizeTo(459, 609, 0.5, 0, .1)
                end

                pnl.DoClick = function(self)
                    netstream.Start('dangavote.voteFor', id)
                    LocalPlayer():EmitSound( "danganronpa/panel/button_select.mp3" )
                end
                
                DHorizontalScroller:AddPanel(pnl)

                netstream.Hook('dangavote.syncVotes', function(key, votes, whoVoted)
                    items[key].votes = votes
                    items[key].whoVoted = whoVoted
                end)

                off = off + 500
            end
        end)
    end)
    
    netstream.Hook('killvote', function(msg)

        if IsValid(menu) then
            label.Think = nil
            label:SetText(msg)
        end

        timer.Simple(0, function()
            if IsValid(menu) then
                menu:Remove()
            end
        end)

    end)


    -- for id, item in pairs(items) do
    --     local pnl = menu:Add 'DButton'
    --     pnl:Dock(LEFT)
    --     pnl:SetText ''
    --     pnl:SetWide(300)
    --     pnl:DockMargin(10, 0, 0, 0)
    --     pnl.Paint = function(self, w, h)
    --         draw.SimpleText(id, 'Trebuchet24', pnl:GetWide()/2 - #id, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    --         draw.SimpleText(item.votes, 'Trebuchet24', pnl:GetWide()/2 - #id, 30, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    --         draw.RoundedBox(0, 0, 0, w, h, color_black)
    --     end
    --     pnl.DoClick = function(self)
    --         netstream.Start('dangavote.voteFor', id)
    --     end
    -- end

end

netstream.Hook('dangavote.start', votemenu)

local function notify()

    if IsValid(menu) then return end

    menu = vgui.Create 'DFrame'
    menu:SetTitle ''
    menu:SetDraggable(false)
    menu:ShowCloseButton()
    menu:SetAlpha(240)
    menu:SetKeyBoardInputEnabled(false)

    menu:SetSize(200, 300)
    menu:SetWide(200)

    menu:AlignLeft(2)
    menu:AlignBottom(2)

    p = menu:Add 'DPanel'
    p:Dock(FILL)

    sound.PlayFile( "sound/danganronpa/games_notify.mp3", "noplay", function( station, errCode, errStr )
        if ( IsValid( station ) ) then
            g_station = station
            station:SetVolume( 4 )
            station:Play()
        else
            print( "Error playing sound!", errCode, errStr )
        end
    end)

    danganim.monokuma.spoke( p, {
        {'sbox/monokuma/sitting/sprite3.png', 0, 1},
        {'sbox/monokuma/sitting/sprite6.png', 0.7},
        {'sbox/monokuma/staying/sprite12.png', 1, 150},
        {'sbox/monokuma/staying/sprite11.png', 2.2, 150},
        {'sbox/monokuma/staying/sprite4.png', 0.6, 150},
        {'sbox/monokuma/staying/sprite5.png', 2.1, 150},
    }, function()
        menu.tx = vgui.Create 'DFrame'
        menu.tx:SetTitle( '' )
        menu.tx:SetSize( 0, 100 )
        menu.tx:SetAlpha( 240 )
        menu.tx:SetDraggable(false)
        menu.tx:ShowCloseButton(false)
        menu.tx:SetPos( menu:GetX() + menu:GetWide(), menu:GetY() )
        menu.tx:SizeTo( 500, 100, 1, 0, .1 )
        
        local tex = menu.tx:Add 'RichText'
        tex:Dock(FILL)
        tex:SetText( 'Жми кнопку чтобы начать голосование за выбор игры!' ) 
        
        local but = menu.tx:Add 'DButton'
        but:Dock(BOTTOM)
        but:SetText('Голосовать')
        but.DoClick = function(self)
            RunConsoleCommand('say', '/monovote')
        end
        
        function tex:PerformLayout()
            self:SetFontInternal( "player.name" )
            self:SetFGColor( color_white )
        end

        timer.Create('mononotify.vote', 5, 1, function()
            danganim.monokuma.spoke( p, { {'sbox/monokuma/staying/sprite10.png', 0, 1} } )

            menu.tx:SizeTo( 0, 100, 0.3, 0, .1, function()
                menu.tx:Remove()
            end)
            menu:AlphaTo( 0, 0.4, 0, function()
                menu:Remove()
            end)
        end)
    end)    
    
end
-- notify()