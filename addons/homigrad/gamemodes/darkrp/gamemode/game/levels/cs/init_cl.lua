css.GetTeamName = tdm.GetTeamName

local playsound = false
function css.StartRoundCL()
    playsound = true
end

function css.HUDPaint_RoundLeft(white)
    local lply = LocalPlayer()
	local name,color = css.GetTeamName(lply)

	local startRound = roundTimeStart + 7 - CurTime()
    if startRound > 0 and lply:Alive() then
        if playsound then
            playsound = false
            local g_station = nil
            -- sound.PlayURL ( "https://oldhomigrad.ru/cs" .. math.random(1,2) .. ".wav", "mono", function( station )
            --     if ( IsValid( station ) ) then

            --         station:SetPos( LocalPlayer():GetPos() )
                
            --         station:Play()

            --         -- Keep a reference to the audio object, so it doesn't get garbage collected which will stop the sound
            --         g_station = station
                
            --     else

            --         LocalPlayer():ChatPrint( "Invalid URL!" )

            --     end
            -- end )
        end
        lply:ScreenFade(SCREENFADE.IN,Color(0,0,0,255),0.5,0.5)


        --[[surface.SetFont("HomigradFontBig")
        surface.SetTextColor(color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255)
        surface.SetTextPos(ScrW() / 2 - 40,ScrH() / 2)

        surface.DrawText("Вы " .. name)]]--
        -- draw.DrawText( "Ваша команда " .. name, "HomigradFontBig", ScrW() / 2, ScrH() / 2, Color( color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        -- draw.DrawText( "Conter-Strike: Source Govno", "HomigradFontBig", ScrW() / 2, ScrH() / 8, Color( 155,155,55,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        --draw.DrawText( roundTypes[roundType], "HomigradFontBig", ScrW() / 2, ScrH() / 5, Color( 55,55,155,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )

        -- draw.DrawText( "Нейтрализуйте вражескую команду", "HomigradFontBig", ScrW() / 2, ScrH() / 1.2, Color( 55,55,55,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        return
    end
end