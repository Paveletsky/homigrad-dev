print("loading govorilka by sekta")

if SERVER then util.AddNetworkString("govorilka-tts") end
govorilka = govorilka or {}
--sv convars
govorilkaenable = CreateConVar("sv_govorilka_enabled","1",FCVAR_ARCHIVE)
govorilka.lang = "ru"
govorilkaglobal = CreateConVar("sv_govorilka_global","0",FCVAR_ARCHIVE)
govorilkaenablechattts = CreateConVar("sv_govorilka_chattts_enabled","1",FCVAR_ARCHIVE)
--cl convars
clgovorilkaenable = CreateClientConVar("cl_govorilka_enabled","1",FCVAR_ARCHIVE)
clgovorilkaenablechattts = CreateClientConVar("cl_govorilka_chattts_enabled","1",FCVAR_ARCHIVE)

local char_to_hex = function(c) return string.format("%%%02X", string.byte(c)) end
local function urlencode(url)
	return url:gsub("\n", "\r\n")
		:gsub("([^%w ])", char_to_hex)
		:gsub(" ", "+")
end

-- _g - Google ver.
-- _y - Yandex ver.
sektattsbase_g = {}

if SERVER then
    function sektattsbase_g.TTS(text)
        net.Start("govorilka-tts")
        net.WriteFloat(1)
        net.WriteString(text)
        net.Broadcast()
    end

    local meta = FindMetaTable("Player")
    function meta:TTS(text)
        net.Start("govorilka-tts")
        net.WriteFloat(1)
        net.WriteString(text)
        net.Send(self)
    end

    function sektattsbase_g.LocalTTS(text,pos)
        net.Start("govorilka-tts")
        net.WriteFloat(2)
        net.WriteString(text)
        net.WriteVector(pos)
        net.SendPAS(pos)
    end

    function sektattsbase_g.EntTTS(text,ent)
        net.Start("govorilka-tts")
        net.WriteFloat(3)
        net.WriteString(text)
        net.WriteEntity(ent)
        net.Broadcast()
    end

    hook.Add("PlayerSay","govorilka.chat",function(ply,text,team)
        if not team and (govorilkaenablechattts:GetString()=="1" or clgovorilkaenablechattts:GetString()=="1") then
            -- Check if the player has the 'ulx vip' role or higher
            if ply:IsUserGroup("vip") or ply:IsAdmin() or ply:IsSuperAdmin() then
                if govorilkaglobal:GetString()=="1" then
                    sektattsbase_g.TTS(text)
                else
                    sektattsbase_g.EntTTS(text,ply)
                end
            end
        end
    end)    
end

if CLIENT then
    function sektattsbase_g.TTS(text)
        sound.PlayURL("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. urlencode(text) .. "&tl=" .. govorilka.lang,"mono",function(station,err,errcode)
            if IsValid(station) then
                station:Play()
            end
        end)
    end

    function sektattsbase_g.LocalTTS(text,pos)
        sound.PlayURL("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. urlencode(text) .. "&tl=" .. govorilka.lang,"3d",function(station,err,errcode)
            if IsValid(station) then
                station:SetPos(pos)
                station:Play()
            end
        end)
    end

    function sektattsbase_g.EntTTS(text,ent)
        if IsValid(ent) then
            sound.PlayURL("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. urlencode(text) .. "&tl=" .. govorilka.lang,"3d",function(station,err,errcode)
                print(errcode)
                if IsValid(station) then
                    station:SetPos(ent:GetPos())
                    station:Play()
                    local id = "tts_ent."..math.random(1,10000000)
                    hook.Add("Think",id,function()
                        if IsValid(ent) then station:SetPos(ent:GetPos()) end
                        if !IsValid(station) then hook.Remove("Think",id) end
                    end)
                end
            end)
        end
    end

    net.Receive("govorilka-tts",function()
        if clgovorilkaenable:GetString()=="0" or govorilkaenable:GetString()=="0" then return end
        local mode = net.ReadFloat()
        local text = net.ReadString()
        if mode==1 then
            sektattsbase_g.TTS(text)
        elseif mode==2 then
            local pos = net.ReadVector()
            sektattsbase_g.LocalTTS(text,pos)
        elseif mode==3 then
            local ent = net.ReadEntity()
            sektattsbase_g.EntTTS(text,ent)
        end
    end)
end
