surface.CreateFont( "dadasdASDas4125321", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 35,
	weight = 700,
} )

surface.CreateFont( "DoorTextMaMa", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 700,
} )

surface.CreateFont( "dadasdASDas4125", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 35,
	weight = 700,
} )

function darkrp.Scoreboard_Status(ply)
    if ply:Alive() then return "Живой",ScoreboardGreen else return "Мёртв",ScoreboardRed,ScoreboardRed end
end

function darkrp.StartRoundCL()
    sound.PlayURL("https://i.nambavan.ru/stream","mono noblock",function(snd)
        bhop = snd

        snd:SetVolume(0.1)
    end) 

    for name in pairs(darkrp.doors) do
        for i,ent in pairs(ents.FindByClass(name)) do
            ent.buy = nil
        end
    end
    
end



local staticWhite = Color(255,255,255)

function darkrp.HUDPaint_RoundLeft(white)
    local lply = LocalPlayer()

    if lply:Alive() then
        local time = lply:GetNWFloat("DeathWait") - CurTime() or 0

        if time > 0 and not time == string then
            draw.SimpleText("Осталось : " .. time .. " секунд.","dadasdASDas4125321",ScrW() / 2,ScrH() - 160, white,1, 1)
        end
    else
        local time = lply:GetNWFloat("DeathWait",0) - CurTime()

        if time > 0 then
            draw.SimpleText(string.FormattedTime( time, "%02i:%02i:%02i" ),"dadasdASDas4125321",ScrW() / 2+4,ScrH() - 158 ,Color(0,0,0),TEXT_ALIGN_CENTER)
            draw.SimpleText(string.FormattedTime( time, "%02i:%02i:%02i" ),"dadasdASDas4125321",ScrW() / 2,ScrH() - 160 ,Color(255,85,85),TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Нажми на что-нибудь что-бы возродится.","dadasdASDas4125",ScrW() / 2+4,ScrH() - 158,Color(0,0,0),TEXT_ALIGN_CENTER)
            draw.SimpleText("Нажми на что-нибудь что-бы возродится.","dadasdASDas4125",ScrW() / 2,ScrH() - 160,staticWhite,TEXT_ALIGN_CENTER)
        end
    end

    draw.SimpleText(math.Round( darkrp.GetMoney(lply) ) .. "$","HomigradFont",ScrW()/2,ScrH()-10,white,1,1)

end
do
    function darkrp.PostDrawOpaqueRenderables_RoundLeft(xz)
        local trace = LocalPlayer():GetEyeTrace()
        local ent = LocalPlayer():GetEyeTrace().Entity
        if not IsValid(ent) then return end
        if ent:GetClass() == "prop_door_rotating" then
            local pos = trace.HitPos
            pos.x = pos.x
            pos.y = pos.y
            pos.z = pos.z

            local angle = trace.HitNormal:Angle()
            angle.x = angle.x 
            angle.y = angle.y +90
            angle.z = angle.z +90

            net.Receive("DoorsRefresh2", function (len, ply)
                local ent1 = net.ReadEntity()
                local ent2 = net.ReadTable()
                ent.buy = ent1.buy or ent2
                ent.buy = ent2
            end)

            

            -- cam.Start3D2D( pos, angle, 0.2 )
            --     draw.SimpleText( IsValid(ent.buy) and ent.buy.owner:Name() or "Свободно", "DoorTextMaMa", 0,0, IsValid(ent.buy) and ent.buy.owner:GetColor() or Color(255,255,255), 1, 1)
            -- cam.End3D2D()
        end
        
    end
end

function darkrp.EndRound()
    darkrp.OnContextMenuClose()
end

concommand.Add("getsp", function(ply)
    local trace = LocalPlayer():GetEyeTrace()
    local pos = trace.HitPos
    -- pos = tostring(pos)
    pos = "Vector( " .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. " ),"

    print(pos)
    SetClipboardText( tostring(pos) )
end)