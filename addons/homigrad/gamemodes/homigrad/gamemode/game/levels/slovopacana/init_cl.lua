slovopacana.GetTeamName = tdm.GetTeamName

local playsound = false
local bhop
function slovopacana.StartRoundCL()

end


function slovopacana.HUDPaint_RoundLeft(white)
    local lply = LocalPlayer()
	local name,color = slovopacana.GetTeamName(lply)

	local startRound = roundTimeStart + 5 - CurTime()
    if startRound > 0 and lply:Alive() then
        if playsound then
        end
        lply:ScreenFade(SCREENFADE.IN,Color(0,0,0,255),0.5,0.5)


        --[[surface.SetFont("HomigradFontBig")
        surface.SetTextColor(color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255)
        surface.SetTextPos(ScrW() / 2 - 40,ScrH() / 2)

        surface.DrawText("Вы " .. name)]]--
        draw.DrawText( name, "fdShopFontBig", ScrW() / 2, ScrH() / 2, Color( color.r,color.g,color.b,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        --draw.DrawText( roundTypes[roundType], "HomigradFontBig", ScrW() / 2, ScrH() / 5, Color( 55,55,155,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        if name == "Октяборьские" then
            draw.DrawText( "Спросите за базар у чушпанов", "fdShopFontBig", ScrW() / 2, ScrH() - 75, Color( 255,255,255,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        else
            draw.DrawText( "Выбейте дурь из чушпанов", "fdShopFontBig", ScrW() / 2, ScrH() - 75, Color( 255,255,255,math.Clamp(startRound - 0.5,0,1) * 255 ), TEXT_ALIGN_CENTER )
        end
        return
    end

    --draw.SimpleText(acurcetime,"HomigradFont",ScrW()/2,ScrH()-25,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end