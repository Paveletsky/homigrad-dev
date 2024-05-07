hook.Add( 'Think', "dangahud.run.hud", function()
    hook.Remove( 'Think', 'dangahud.run.hud')

    local we, active = _, true
    function resTime(time)
        local m, s = math.floor(time / 60) % 60, math.floor(time) % 60
        return string.format('Перезагрузка сервера через %02i:%02i', m, s)
    end   

    function vgui.bkNotify( text, time, callback, draw )
        if timer.Exists('dangahud.show.notify') then 
            timer.Remove( 'dangahud.show.notify' ) 
            timer.Remove( 'timer.mono.notify' )
        end
        
        timer.Create( 'dangahud.show.notify', 1, 1, function()
            if cv then cv:Remove() end
            if tx then tx:Remove() end

            tx = vgui.Create 'DFrame'
                tx:SetTitle( 'Оповещение' )
                tx:SetSize( 600, 100 + #tostring(text) * .25 )
                tx:SetAlpha( 240 )
                tx:SetDraggable(false)
                -- tx:ShowCloseButton(false)
                tx:SetPos( ScrW() * .99 + 90, ScrH() * .1)
            tx:MoveTo( ScrW() - tx:GetWide(), ScrH() * .1, 2, 1, .1)
            
            LocalPlayer():EmitSound( 'garrysmod/save_load1.wav', 75, 100, 0.1, CHAN_AUTO)

            local tex = tx:Add 'RichText'
            tex:Dock(FILL)
            if isfunction( text ) then
                tex.Think = text
            else
                tex:SetText( text )        
            end

            if isfunction(draw) then
                draw(tx)
            end

            function tex:PerformLayout()
                self:SetFontInternal( "CloseCaption_Normal" )
                self:SetFGColor( color_white )
            end

            timer.Create( 'timer.mono.notify', time, 1, function() 
                tx:AlphaTo( 0, 0.3, 0, function() tx:Remove() end)
                if callback then callback() end
            end)

            tx.OnClose = function(this)
                timer.Remove('timer.mono.notify')
            end
        end)
    end

    netstream.Hook( 'bkServerRestart', function( delay )
        local restart_timer = CurTime() + delay
    
        vgui.bkNotify( function( self )
            to_left = restart_timer - CurTime()
            text = resTime(math.max(to_left, 0))
            
            self:SetText(text)
        end, delay, nil, nil) 
    end)
end)

local queue = {}
function bok.gui.Notify(text, time, path, fadeIn, fadeOut)
    local StartTime = CurTime()
    local TimeEnd   = StartTime + time

    if (bok.gui.CurrentNotify) then
            table.insert(queue, {text, time, path, fadeIn, fadeOut})
        return
    end    

    local function NextNotify()
        local id = table.GetFirstKey(queue)

        if (queue[id]) then
                bok.gui.Notify(unpack(queue[id]))
            queue[id] = nil
        end
    end
        
    bok.gui.CurrentNotify = text

    surface.PlaySound(path or '')

    local alpha = 0
    local enter = string.Explode('\n', text)

    hook.Add('HUDPaint', 'bkNotify', function()
        local off_x, off_y = 30, 0

        table.foreach(enter, function(key, text)
                draw.WordBox(4, ScrW() - off_x, 30 + off_y, text, "bkAFKFont", Color( 2, 2, 2, alpha / 2 ), Color( 255, 255, 255, alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
            off_y = off_y + 38
        end)

        if (CurTime() >= TimeEnd) then
            alpha = math.Approach(alpha, 0, fadeOut or 10)

            if (alpha == 0) then
                hook.Remove('HUDPaint', 'bkNotify')

                bok.gui.CurrentNotify = nil

                timer.Simple(1, function()
                    NextNotify()    
                end)
            end
        else
            alpha = math.Approach(alpha, 255, fadeIn or 6)
        end
    end)
end