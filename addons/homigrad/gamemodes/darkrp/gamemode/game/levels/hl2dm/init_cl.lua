hl2dm.GetTeamName = tdm.GetTeamName

local playsound = false
function hl2dm.StartRoundCL()
    playsound = true
end

function hl2dm.HUDPaint_RoundLeft(white)
    local lply = LocalPlayer()
	local name,color = hl2dm.GetTeamName(lply)

	local startRound = roundTimeStart + 7 - CurTime()
    if startRound > 0 and lply:Alive() then
        if playsound then
            playsound = false
            surface.PlaySound("snd_jack_hmcd_deathmatch.mp3")
        end
        lply:ScreenFade(SCREENFADE.IN,Color(0,0,0,255),0.5,0.5)


        --[[surface.SetFont("HomigradFontBig")
        surface.SetTextColor(color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255)
        surface.SetTextPos(ScrW() / 2 - 40,ScrH() / 2)

        surface.DrawText("Вы " .. name)]]--
        draw.DrawText( name and "Ваша команда " .. name or "Наблюдай", "HomigradFontBig", ScrW() / 2, ScrH() / 2, color and Color( color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255 ) or Color(143,109,109, math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        draw.DrawText( name and "HL2 DM" or "Ты спектатор хуле", "HomigradFontBig", ScrW() / 2, ScrH() / 8, color and Color( color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255 ) or Color(143,109,109, math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        --draw.DrawText( roundTypes[roundType], "HomigradFontBig", ScrW() / 2, ScrH() / 5, Color( 55,55,155,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )

        draw.DrawText( "Нейтрализуйте вражескую команду, спасайте своих...", "HomigradFontBig", ScrW() / 2, ScrH() / 1.2, Color( 55,55,55,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        return
    end
end



-- LocalPlayer():ConCommand("bind mouse5 kick_nig")