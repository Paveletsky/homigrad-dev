hook.Add("PlayerDisconnected","setguilt-fornoobs",function(ply)
    ply:SetPData("Guilt",ply.Guilt)
end)

gameevent.Listen("player_connect")
hook.Add("player_connect","AnnounceConnection",function(data)
    local ply = Entity(data.index)

	if ply.bot == 0 then
        local guilt = ply:GetPData("Guilt")
        ply.Guilt = math.min(guilt,200)
    end
end)

dataRound = dataRound
endDataRound = endDataRound
net.Receive("round_state",function()
    roundActive = net.ReadBool()
    local data = net.ReadTable()

    if roundActive == true then
        dataRound = data

        local func = TableRound().StartRound
        if func then func(data) end
    else
        endDataRound = data

        local func = TableRound().EndRound
        if func then func(data.lastWinner,data) end
    end
end)

local function Rule( name )
    local name1 = string.lower(name)
    if name1 == "jailbreak" then
        name1 = "jb"
    else
        return LocalPlayer():ChatPrint("На этот режим пока нет правил :/")
    end

    local frame = vgui.Create( "DFrame" )
    frame:SetTitle( name )
    frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
    frame:Center()
    frame:MakePopup()

    local html = vgui.Create( "HTML", frame )
    html:Dock( FILL )
    html:OpenURL( "https://homigrad.ru/rules/"..name1 )

end


net.Receive("Info_ChatCommand_mamuebal", function(len) 
    local name,nextName = TableRound().Name,TableRound(roundActiveNameNext).Name
    Rule(name)
end)
local name,nextName = TableRound().Name,TableRound(roundActiveNameNext).Name
-- Rule(name)