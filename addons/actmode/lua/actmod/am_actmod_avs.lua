A_AM.ActMod.LuaAvs = true
local AGetMapNow = game.GetMap()
if SERVER then
    util.AddNetworkString("AM_ClToSv_")
    util.AddNetworkString("AM_SvToCl_")
    util.AddNetworkString("AM_SvToCl_1")
    net.Receive("AM_ClToSv_", function()
        local ply = net.ReadEntity()
        local txt = net.ReadString()
        local tab = net.ReadTable()
        if IsValid(ply) then if txt == "SetTabPly" then ply.GetTable_Avs = tab end end
    end)

    function A_AM.ActMod.ActMod_Avs_KNPC(npc, ply, inflictor)
        if ply.GetTable_Avs then
            if IsValid(npc) and npc:IsNPC() and IsValid(ply) and ply:IsPlayer() and inflictor and (IsValid(inflictor) and inflictor:IsPlayer() and inflictor == ply or not inflictor:IsPlayer()) then
                local pgaw, aAI = ply:GetActiveWeapon(), GetConVar("ai_disabled"):GetInt() == 0 and GetConVar("ai_ignoreplayers"):GetInt() == 0
                if ply.GetTable_Avs["Avs_a2_2"] and ply.GetTable_Avs["Avs_a2_2"]["ok"] == "no" then
                    if npc:GetClass() == "npc_antlionguard" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_crowbar" then
                        net.Start("AM_SvToCl_")
                        net.WriteEntity(ply)
                        net.WriteString("QXZzX2EyXzI=")
                        net.WriteString("n")
                        net.Send(ply)
                    end
                end

                if ply.GetTable_Avs["Avs_a2_3"] and ply.GetTable_Avs["Avs_a2_3"]["ok"] == "no" then
                    if npc:GetClass() == "npc_combine_s" and npc:GetPos():Distance(ply:EyePos()) > 5000 and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_pistol" then
                        net.Start("AM_SvToCl_")
                        net.WriteEntity(ply)
                        net.WriteString("QXZzX2EyXzM=")
                        net.WriteString("n")
                        net.Send(ply)
                    end
                end

                if ply.ActMod_TabTSrvr == 0 and aAI and ply.GetTable_Avs["Avs_a1_1"] and ply.GetTable_Avs["Avs_a1_1"]["ok"] == "no" and ply.GetTable_Avs["Avs_a1_1"]["ing"] < 50 then
                    if npc:GetClass() == "npc_zombie" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_fists" then
                        if ply.GetTable_Avs["Avs_a1_1"]["ing"] >= 50 then
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2ExXzE=")
                            net.WriteString("nil")
                            net.Send(ply)
                        elseif ply.GetTable_Avs["Avs_a1_1"]["ing"] < 50 then
                            ply.GetTable_Avs["Avs_a1_1"]["ing"] = ply.GetTable_Avs["Avs_a1_1"]["ing"] + 1
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2ExXzE=")
                            if ply.GetTable_Avs["Avs_a1_1"]["ing"] < 50 and isnumber(ply.GetTable_Avs["Avs_a1_1"]["ing"]) then net.WriteString(tostring(ply.GetTable_Avs["Avs_a1_1"]["ing"])) end
                            net.Send(ply)
                        end
                    end
                end

                if ply.ActMod_TabTSrvr == 0 and aAI and ply.GetTable_Avs["Avs_a3_7"] and ply.GetTable_Avs["Avs_a3_7"]["ok"] == "no" and ply.GetTable_Avs["Avs_a3_7"]["ing"] < 250 then
                    if npc:GetClass() == "npc_zombie" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_smg1" then
                        if ply.GetTable_Avs["Avs_a3_7"]["ing"] >= 250 then
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EzXzc=")
                            net.WriteString("nil")
                            net.Send(ply)
                        elseif ply.GetTable_Avs["Avs_a3_7"]["ing"] < 250 then
                            ply.GetTable_Avs["Avs_a3_7"]["ing"] = ply.GetTable_Avs["Avs_a3_7"]["ing"] + 1
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EzXzc=")
                            if ply.GetTable_Avs["Avs_a3_7"]["ing"] < 250 and isnumber(ply.GetTable_Avs["Avs_a3_7"]["ing"]) then net.WriteString(tostring(ply.GetTable_Avs["Avs_a3_7"]["ing"])) end
                            net.Send(ply)
                        end
                    end
                end

                if aAI and ply.GetTable_Avs["Avs_a2_9"] and ply.GetTable_Avs["Avs_a2_9"]["ok"] == "no" and ply.GetTable_Avs["Avs_a2_9"]["ing"] < 25 then
                    if npc:GetClass() == "npc_manhack" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_stunstick" then
                        if ply.GetTable_Avs["Avs_a2_9"]["ing"] >= 25 then
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EyXzk=")
                            net.WriteString("nil")
                            net.Send(ply)
                        elseif ply.GetTable_Avs["Avs_a2_9"]["ing"] < 25 then
                            ply.GetTable_Avs["Avs_a2_9"]["ing"] = ply.GetTable_Avs["Avs_a2_9"]["ing"] + 1
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EyXzk=")
                            if ply.GetTable_Avs["Avs_a2_9"]["ing"] < 25 and isnumber(ply.GetTable_Avs["Avs_a2_9"]["ing"]) then net.WriteString(tostring(ply.GetTable_Avs["Avs_a2_9"]["ing"])) end
                            net.Send(ply)
                        end
                    end
                end

                if aAI and ply.GetTable_Avs["Avs_a2_8"] and ply.GetTable_Avs["Avs_a2_8"]["ok"] == "no" and ply.GetTable_Avs["Avs_a2_8"]["ing"] < 15 then
                    if npc:GetClass() == "npc_headcrab" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_physcannon" then
                        if ply.GetTable_Avs["Avs_a2_8"]["ing"] >= 15 then
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EyXzg=")
                            net.WriteString("nil")
                            net.Send(ply)
                        elseif ply.GetTable_Avs["Avs_a2_8"]["ing"] < 15 then
                            ply.GetTable_Avs["Avs_a2_8"]["ing"] = ply.GetTable_Avs["Avs_a2_8"]["ing"] + 1
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EyXzg=")
                            if ply.GetTable_Avs["Avs_a2_8"]["ing"] < 15 and isnumber(ply.GetTable_Avs["Avs_a2_8"]["ing"]) then net.WriteString(tostring(ply.GetTable_Avs["Avs_a2_8"]["ing"])) end
                            net.Send(ply)
                        end
                    end
                end

                if aAI and ply.GetTable_Avs["Avs_a3_5"] and ply.GetTable_Avs["Avs_a3_5"]["ok"] == "no" and ply.GetTable_Avs["Avs_a3_5"]["ing"] < 13 then
                    if npc:GetClass() == "npc_poisonzombie" and (inflictor:GetClass() == "npc_tripmine" or inflictor:GetClass() == "npc_satchel") then
                        if ply.GetTable_Avs["Avs_a3_5"]["ing"] >= 13 then
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EzXzU=")
                            net.WriteString("nil")
                            net.Send(ply)
                        elseif ply.GetTable_Avs["Avs_a3_5"]["ing"] < 13 then
                            ply.GetTable_Avs["Avs_a3_5"]["ing"] = ply.GetTable_Avs["Avs_a3_5"]["ing"] + 1
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EzXzU=")
                            if ply.GetTable_Avs["Avs_a3_5"]["ing"] < 13 and isnumber(ply.GetTable_Avs["Avs_a3_5"]["ing"]) then net.WriteString(tostring(ply.GetTable_Avs["Avs_a3_5"]["ing"])) end
                            net.Send(ply)
                        end
                    end
                end
            end
        end
    end

    hook.Add("ActMod-Theatrical_MMD_End", "ActMod_Avs__Theatrical_MMD", function(ply, d_nam)
        if IsValid(ply) and ply:IsPlayer() then
            if ply.GetTable_Avs then
                if ply.GetTable_Avs["Avs_a2_6"] and ply.GetTable_Avs["Avs_a2_6"]["ok"] == "no" and d_nam == "Chaos Medley" then
                    net.Start("AM_SvToCl_")
                    net.WriteEntity(ply)
                    net.WriteString("QXZzX2EyXzY=")
                    net.WriteString("n")
                    net.Send(ply)
                end

                if ply.GetTable_Avs["Avs_a3_3"] and ply.GetTable_Avs["Avs_a3_3"]["ok"] == "no" and d_nam == "PV120 - Shake it" then
                    net.Start("AM_SvToCl_")
                    net.WriteEntity(ply)
                    net.WriteString("QXZzX2EzXzM=")
                    net.WriteString("n")
                    net.Send(ply)
                end
            end
        end
    end)

    local function aCOnInBox(pl, Ps0, aP1, aP2, aP3)
        local asG = false
        if (aaBPefw or 0) < CurTime() and GetConVar("nall_show_ents") and GetConVar("nall_show_ents"):GetInt() == 2 then
            aaBPefw = CurTime() + 0.25
            local saaw = {
                ["g0"] = Ps0,
                ["g1"] = Vector(aP1, aP2, aP3),
                ["g2"] = Vector(-aP1, -aP2, -aP3)
            }

            net.Start("AM_SvToCl_1")
            net.WriteEntity(pl)
            net.WriteString("SetT")
            net.WriteTable(saaw)
            net.Send(pl)
            saaw = nil
        end

        for id, ent in pairs(ents.FindInBox(Ps0 + Vector(aP1, aP2, aP3), Ps0 + Vector(-aP1, -aP2, -aP3))) do
            if ent:IsPlayer() and ent == pl then asG = true end
        end
        return asG
    end

    function A_AM.ActMod.ActMod_Sv_Avs()
        for _, ply in pairs(player.GetAll()) do
            if ply.GetTable_Avs then
                if AGetMapNow == "am4-game_lv1" and ply.GetTable_Avs["Avs_a3_1"] and ply.GetTable_Avs["Avs_a3_1"]["ok"] == "no" then
                    if not ply.ATmp_Avs_a3_1 then ply.ATmp_Avs_a3_1 = 0 end
                    if ply.ATmp_Avs_a3_1 > 2 and aCOnInBox(ply, Vector(-8, -7, 0), 110, 110, 55) == true then ply.ATmp_Avs_a3_1 = 1 end
                    if ply.ATmp_Avs_a3_1 == 0 and aCOnInBox(ply, Vector(-8, -7, 0), 110, 110, 55) == true then
                        ply.ATmp_Avs_a3_1 = 1
                    elseif ply.ATmp_Avs_a3_1 == 1 and aCOnInBox(ply, Vector(-12320, 1472, 25), 200, 160, 55) == true then
                        ply.ATmp_Avs_a3_1 = 2
                    elseif ply.ATmp_Avs_a3_1 == 2 and aCOnInBox(ply, Vector(-1490, 1474, 80), 150, 160, 80) == true then
                        ply.ATmp_Avs_a3_1 = 3
                    elseif ply.ATmp_Avs_a3_1 == 3 and aCOnInBox(ply, Vector(11710.49, 1471.97, 40), 220, 170, 50) == true then
                        ply.ATmp_Avs_a3_1 = 4
                    elseif ply.ATmp_Avs_a3_1 == 4 and aCOnInBox(ply, Vector(2940, -1304.43, -818), 400, 400, 100) == true then
                        ply.ATmp_Avs_a3_1 = nil
                        if (ply.TrAgin or 0) < CurTime() then
                            ply.TrAgin = CurTime() + 1.5
                            net.Start("AM_SvToCl_")
                            net.WriteEntity(ply)
                            net.WriteString("QXZzX2EzXzE=")
                            net.WriteString("n")
                            net.Send(ply)
                        end
                    end
                elseif AGetMapNow == "gm_construct" and ply.GetTable_Avs["Avs_a3_2"] and ply.GetTable_Avs["Avs_a3_2"]["ok"] == "no" then
                    if aCOnInBox(ply, Vector(-3000, -1245, -32), 103, 160, 62) == true then
                        local pgaw = ply:GetActiveWeapon() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "aact_weapact"
                        if ply:A_ActMod_IsActing() and pgaw and ply:A_ActModString() == "amod_dance_california_girls._so_..png" then
                            if (ply.TrAgin or 0) < CurTime() then
                                ply.TrAgin = CurTime() + 1.5
                                net.Start("AM_SvToCl_")
                                net.WriteEntity(ply)
                                net.WriteString("QXZzX2EzXzI=")
                                net.WriteString("n")
                                net.Send(ply)
                            end
                        end
                    end
                end
            end
        end

        if A_AM.ActMod.HookThinkSv ~= true then A_AM.ActMod.HookThinkSv = true end
    end
end

if CLIENT then
    A_AM.ActMod.Aptmp = {
        ["Avs_a1_1"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "hud/killicons/default",
            ["lng"] = "50"
        },
        ["Avs_a1_2"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "icon16/time.png",
            ["lng"] = "LAchievements_a1_m2"
        },
        ["Avs_a1_3"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "icon64/tool.png",
            ["lng"] = "LAchievements_a1_m3"
        },
        ["Avs_a2_1"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "/amod_mmd_dance_specialist._so_..png",
            ["lng"] = "LAchievements_a2_m1",
            ["isiAct"] = true
        },
        ["Avs_a2_2"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "entities/npc_antlionguard.png",
            ["lng"] = "LAchievements_a2_m2"
        },
        ["Avs_a2_3"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "entities/combineelite.png",
            ["lng"] = "LAchievements_a2_m3"
        },
        ["Avs_a2_4"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/GDiva_image.png",
            ["lng"] = "LAchievements_a2_m4"
        },
        ["Avs_a2_5"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/GDiva_image.png",
            ["lng"] = "LAchievements_a2_m5"
        },
        ["Avs_a2_6"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/TheatricalMMD_1.png",
            ["lng"] = "LAchievements_a2_m6"
        },
        ["Avs_a2_7"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "/f_thumbsup.png",
            ["lng"] = "LAchievements_a2_m7",
            ["isiAct"] = true
        },
        ["Avs_a2_8"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "entities/npc_headcrab.png",
            ["lng"] = "LAchievements_a2_m8"
        },
        ["Avs_a2_9"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "entities/npc_manhack.png",
            ["lng"] = "LAchievements_a2_m9"
        },
        ["Avs_a3_1"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/amap_gamerenl1.png",
            ["lng"] = "LAchievements_a3_m1"
        },
        ["Avs_a3_2"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/a3_2.png",
            ["lng"] = "LAchievements_a3_m2"
        },
        ["Avs_a3_3"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/TheatricalMMD_2.png",
            ["lng"] = "LAchievements_a2_m6"
        },
        ["Avs_a3_4"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/v_1.png",
            ["lng"] = "LAchievements_a3_m4"
        },
        ["Avs_a3_5"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "entities/npc_poisonzombie.png",
            ["lng"] = "LAchievements_a3_m5"
        },
        ["Avs_a3_6"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "/amod_am4_levepalestina._so_..png",
            ["lng"] = "LAchievements_a2_m7",
            ["isiAct"] = true
        },
        ["Avs_a3_7"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "hud/killicons/default",
            ["lng"] = "250"
        },
        ["Avs_a3_8"] = {
            ["ok"] = "no",
            ["ing"] = 0,
            ["png"] = "actmod/imenu/v_fl.png",
            ["lng"] = "LAchievements_a3_m8"
        }
    }

    timer.Simple(1, function()
        timer.Simple(0.2, function()
            A_AM.ActMod.Aptmp["Avs_a1_1"] = {
                ["ok"] = "no",
                ["ing"] = 0,
                ["png"] = "hud/killicons/default",
                ["lng"] = string.format(aR:T("LAchievements_a1_m1"), "50")
            }

            A_AM.ActMod.Aptmp["Avs_a3_7"] = {
                ["ok"] = "no",
                ["ing"] = 0,
                ["png"] = "hud/killicons/default",
                ["lng"] = string.format(aR:T("LAchievements_a1_m1"), "250")
            }
        end)
    end)

    local function ReString(st, tam4)
        local ReNamAct = st or "-_none_-"
        if string.find(ReNamAct, ".png") then ReNamAct = string.Replace(ReNamAct, ".png", "") end
        if string.find(ReNamAct, "._c1_.") then ReNamAct = string.Replace(ReNamAct, "._c1_.", "") end
        if string.find(ReNamAct, "._c2_.") then ReNamAct = string.Replace(ReNamAct, "._c2_.", "") end
        if string.find(ReNamAct, "._mo_.") then ReNamAct = string.Replace(ReNamAct, "._mo_.", "") end
        if string.find(ReNamAct, "._ef_.") then ReNamAct = string.Replace(ReNamAct, "._ef_.", "") end
        if string.find(ReNamAct, "._so_.") then ReNamAct = string.Replace(ReNamAct, "._so_.", "") end
        if tam4 then
            if string.find(ReNamAct, "amod_mmd_") then ReNamAct = string.Replace(ReNamAct, "amod_mmd_", "") end
            if string.find(ReNamAct, "amod_fortnite_") then ReNamAct = string.Replace(ReNamAct, "amod_fortnite_", "") end
            if string.find(ReNamAct, "amod_") then ReNamAct = string.Replace(ReNamAct, "amod_", "") end
            if string.find(ReNamAct, "wos_tf2_") then ReNamAct = string.Replace(ReNamAct, "wos_tf2_", "") end
        end
        return ReNamAct
    end

    local function RvString(ara)
        local ReName_ = ara
        if string.find(string.sub(ReName_, 1, 2), "f_") and not string.find(ReName_, "amod") then
            ReName_ = string.Replace(ReName_, "f_", "")
        elseif string.find(string.sub(ReName_, 1, 14), "amod_fortnite_") then
            ReName_ = string.Replace(ReName_, "amod_fortnite_", "")
        elseif string.find(string.sub(ReName_, 1, 9), "amod_mmd_") then
            ReName_ = string.Replace(ReName_, "amod_mmd_", "")
        elseif string.find(string.sub(ReName_, 1, 5), "amod_") then
            ReName_ = string.Replace(ReName_, "amod_", "")
        elseif string.find(string.sub(ReName_, 1, 8), "wos_tf2_") then
            ReName_ = string.Replace(ReName_, "wos_tf2_", "")
        end
        return ReName_
    end

    local function AShowB(ply, paa, atxt, tp)
        local OAvs = vgui.Create("ActMod_Avs_Done")
        local bF = A_AM.ActMod.Settings["IconsActs"]
        OAvs.GetPly = ply
        if A_AM.ActMod.Aptmp[paa] and A_AM.ActMod.Aptmp[paa]["png"] then
            if A_AM.ActMod.Aptmp[paa]["isiAct"] then
                OAvs.pag = bF .. A_AM.ActMod.Aptmp[paa]["png"]
                OAvs.pagT = true
            else
                OAvs.pag = A_AM.ActMod.Aptmp[paa]["png"]
            end
        end

        if A_AM.ActMod.Aptmp[paa] and A_AM.ActMod.Aptmp[paa]["lng"] then OAvs.nna = aR:T(paa == "Avs_a2_5" and "LAchievements_a2_m4" or A_AM.ActMod.Aptmp[paa]["lng"]) .. (atxt or "") end
        OAvs.Typ = tp or 1
        if OAvs.Typ == 2 then
            surface.PlaySound("actmod/s/swip2.mp3")
        else
            surface.PlaySound("actmod/s/s1.wav")
        end
        return OAvs
    end

    function A_AM.ActMod:AZtxt(zZ, tt)
        local Tmz = 0
        if zZ then
            local Tal = vgui.Create('DLabel')
            Tal:SetAlpha(0)
            Tal:SetText(zZ)
            Tal:SetFont(tt)
            Tal:SizeToContents()
            Tmz = Tal:GetWide()
            Tal:Remove()
            Tal = nil
        end
        return Tmz
    end

    local function AG_Anyl(ply, txt)
        ply.GetTable_Avs = ply.GetTable_Avs or A_AM.ActMod.Aptmp
        for k, v in pairs(txt) do
            if string.sub(k, 1, 5) == "Avs_a" then
                if ply.GetTable_Avs[k] then
                    if ply.GetTable_Avs[k]["ok"] then ply.GetTable_Avs[k]["ok"] = txt[k]["ok"] end
                    if ply.GetTable_Avs[k]["ing"] then ply.GetTable_Avs[k]["ing"] = txt[k]["ing"] end
                else
                    local atxt, aaing = "no", 0
                    if txt[k]["ok"] then atxt = txt[k]["ok"] end
                    if txt[k]["ing"] then aaing = txt[k]["ing"] end
                    ply.GetTable_Avs[k] = {
                        ["ok"] = atxt,
                        ["ing"] = aaing
                    }
                end
            end
        end

        for k, v in pairs(ply.GetTable_Avs) do
            if txt[k] then
                if txt[k]["ok"] then v["ok"] = txt[k]["ok"] end
                if txt[k]["ing"] then v["ing"] = txt[k]["ing"] end
            end
        end

        net.Start("AM_ClToSv_")
        net.WriteEntity(ply)
        net.WriteString("SetTabPly")
        net.WriteTable(ply.GetTable_Avs)
        net.SendToServer()
        ply.ErorrTable_Avs = 0
    end

    local function AG_BED(AY, txt)
        return A_AM.ActMod:A_BED(AY, txt)
    end

    local function AS_DatA(ty, txt, Aing)
        local A1txt = file.Read(AG_BED(2, "bm5sai5qc29u"), "DATA")
        local commit = util.JSONToTable(AG_BED(2, A1txt))
        local aok = true
        if ty == "ALL_Avs_a" then
            for k, v in pairs(commit) do
                if string.sub(k, 1, 5) == "Avs_a" then
                    if txt and v["ok"] then v["ok"] = txt end
                    if Aing and v["ing"] then v["ing"] = tonumber(Aing) end
                end
            end
        else
            if commit[ty] then
                if txt then commit[ty]["ok"] = txt end
                if Aing then commit[ty]["ing"] = tonumber(Aing) end
            else
                aok = false
                local atxt = "no"
                local aaing = 0
                if txt then atxt = txt end
                if Aing then aaing = Aing end
                commit[ty] = {
                    ["ok"] = atxt,
                    ["ing"] = aaing
                }

                aok = true
            end
        end

        if aok == true then
            file.Write(AG_BED(2, "bm5sai5qc29u"), AG_BED(1, util.TableToJSON(commit, true)))
            A1txt = nil
            commit = nil
            timer.Simple(0.2, function() if IsValid(LocalPlayer()) then AG_Anyl(LocalPlayer(), util.JSONToTable(AG_BED(2, file.Read(AG_BED(2, "bm5sai5qc29u"), "DATA")))) end end)
        end
    end

    local function a_IsNumber(tnbr)
        return isnumber(tonumber(tnbr))
    end

    local function AG_CDet()
        file.Write(AG_BED(2, "bm5sai5qc29u"), AG_BED(1, A_AM.ActMod.Aatmp))
        timer.Create("Acl_t1", 0.2, 1, function() if IsValid(LocalPlayer()) then A_AM.ActMod:A_ReGD() end end)
    end

    local function AG_Delt(Re)
        file.Delete(AG_BED(2, "bm5sai5qc29u"), "DATA")
        if Re then AG_CDet() end
    end

    local function AG_DatA(ty, txt, stxt, aing)
        if file.Exists(AG_BED(2, "bm5sai5qc29u"), "DATA") then
            local tmp = file.Read(AG_BED(2, "bm5sai5qc29u"), "DATA")
            local commit = util.JSONToTable(AG_BED(2, tmp))
            if not commit then
                AG_Delt(true)
                return 0
            end

            if AG_BED(1, commit.inopn) ~= "QWN0TW9kIFtBTTRd" then
                AG_Delt(true)
                return 0
            end

            if not commit.IDPly then
                AG_Delt(true)
                return 0
            end

            if AG_BED(1, commit.IDPly) ~= AG_BED(1, LocalPlayer():SteamID64()) then
                AG_Delt(true)
                return 0
            end

            if ty == 6 then
                return AG_Anyl(LocalPlayer(), commit)
            elseif ty == 5 then
                if commit then
                    local ao = 0
                    for k, v in pairs(commit) do
                        if v["ok"] == "Done" then ao = ao + 1 end
                    end
                    return ao
                end
            elseif ty == 1 then
                AS_DatA(txt, stxt, aing)
            elseif ty == 2 then
                if commit[txt] then
                    return commit[txt]["ok"]
                else
                    AS_DatA(txt)
                end
            elseif ty == 7 then
                if commit[txt] then
                    if a_IsNumber(commit[txt]["ing"]) == true then
                        return commit[txt]["ing"]
                    else
                        AG_Delt(true)
                        return 0
                    end
                end
            elseif ty == 0 then
                if commit then return commit end
            elseif ty == 11 then
                if commit then
                    local ao = 0
                    for k, v in pairs(commit) do
                        if v["ok"] == "yes" then ao = ao + 1 end
                    end
                    return ao
                end
            end
        else
            LocalPlayer().GetTable_Avs = A_AM.ActMod.Aptmp
        end
        return 0
    end

    local function ANo_Avs_ok(ply, txt)
        if txt then return not ply.GetTable_Avs or (ply.GetTable_Avs and ply.GetTable_Avs["Avs_" .. txt] and ply.GetTable_Avs["Avs_" .. txt]["ok"] == "no") end
        return false
    end

    function A_AM.ActMod:A_ReGD()
        AG_DatA(6)
    end

    function A_AM.ActMod:AG_DatA(a1, a2, a3, a4)
        return AG_DatA(a1, a2, a3, a4 and tonumber(a4))
    end

    function A_AM.ActMod:AG_Dat2(H1, H2, H3, H4)
        return AG_DatA(a1, a2, a3, a4)
    end

    function A_AM.ActMod:AShowB(a1, a2, a3, a4)
        AShowB(a1, a2, a3, a4)
    end

    net.Receive("AM_SvToCl_", function()
        local ply = net.ReadEntity()
        local txt = net.ReadString()
        local stxt = net.ReadString()
        local showB = false
        local txtB = ""
        if string.find(txt, ".show.") then
            txt = string.Replace(txt, ".show.", "")
            showB = true
            if txt == "QXZzX2ExXzM=" then txtB = "  " .. string.format(aR:T("LAchievements_a2_i4t"), " " .. stxt .. " / 3 ") end
        end

        if stxt ~= "n" then stxt = tonumber(stxt) end
        if IsValid(ply) then
            if txt and AG_DatA(2, AG_BED(2, txt)) == "no" then
                if stxt and isnumber(tonumber(stxt)) then
                    AG_DatA(1, AG_BED(2, txt), nil, stxt)
                    if showB == true then AShowB(ply, AG_BED(2, txt), txtB, 2) end
                else
                    AG_DatA(1, AG_BED(2, txt), "yes")
                    AShowB(ply, AG_BED(2, txt))
                end
            end
        end
    end)

    net.Receive("AM_SvToCl_1", function()
        local ply = net.ReadEntity()
        local txt = net.ReadString()
        local tan = net.ReadTable()
        if IsValid(ply) then
            if txt == "SetT" then
                ply.ddd__A1 = {
                    ["g0"] = tan["g0"],
                    ["g1"] = tan["g1"],
                    ["g2"] = tan["g2"]
                }
            end
        end
    end)

    local function AGaaT(ply, tp)
        if tp and (istable(tp) and A_AM.ActMod:ATabData(tp, ply:A_ActModString()) == true or isstring(tp) and ply:A_ActModString() == tp) then return true end
        return false
    end

    function A_AM.ActMod.ActMod_Cl_Avs(ply)
        if IsValid(ply) and A_AM.ActMod.svOn == true then
            if (ply.ActMod_Avs_re_time or 0) < CurTime() then
                ply.ActMod_Avs_re_time = CurTime() + 7
                AG_DatA(6)
            end

            if ply.GetTable_Avs then
                if ANo_Avs_ok(ply, "a2_1") == true then
                    if ply:A_ActMod_IsActing() and AG_BED(1, ply:A_ActModString()) == "YW1vZF9tbWRfZGFuY2Vfc3BlY2lhbGlzdC5fc29fLi5wbmc=" then
                        if (ply.ActMod_Avs__a2_1_time or 0) < CurTime() then
                            ply.ActMod_Avs__a2_1_time = CurTime() + 1
                            if not ply.ActMod_Avs__a2_1_ing then ply.ActMod_Avs__a2_1_ing = 0 end
                            if ply.ActMod_Avs__a2_1_ing >= 123 then
                                AG_DatA(1, AG_BED(2, "QXZzX2EyXzE="), "yes")
                                AShowB(ply, "Avs_a2_1")
                            elseif ply.ActMod_Avs__a2_1_ing < 123 then
                                ply.ActMod_Avs__a2_1_ing = ply.ActMod_Avs__a2_1_ing + 1
                            end
                        end
                    end
                elseif ply.ActMod_Avs__a2_1_ing then
                    ply.ActMod_Avs__a2_1_ing = nil
                    ply.ActMod_Avs__a2_1_time = nil
                end

                if ANo_Avs_ok(ply, "a3_6") == true then
                    if ply:A_ActMod_IsActing() and AG_BED(1, ply:A_ActModString()) == "YW1vZF9hbTRfbGV2ZXBhbGVzdGluYS5fc29fLi5wbmc=" then
                        if (ply.ActMod_Avs__a3_6_time or 0) < CurTime() then
                            ply.ActMod_Avs__a3_6_time = CurTime() + 1
                            if not ply.ActMod_Avs__a3_6_ing then ply.ActMod_Avs__a3_6_ing = 0 end
                            if ply.ActMod_Avs__a3_6_ing >= 60 then
                                AG_DatA(1, AG_BED(2, "QXZzX2EzXzY="), "yes")
                                AShowB(ply, "Avs_a3_6")
                            elseif ply.ActMod_Avs__a3_6_ing < 60 then
                                ply.ActMod_Avs__a3_6_ing = ply.ActMod_Avs__a3_6_ing + 1
                            end
                        end
                    end
                elseif ply.ActMod_Avs__a3_6_ing then
                    ply.ActMod_Avs__a3_6_ing = nil
                    ply.ActMod_Avs__a3_6_time = nil
                end

                if ply.ActMod_TabTSrvr == 0 and ANo_Avs_ok(ply, "a1_2") == true then
                    if ply:A_ActMod_IsActing() then
                        if (ply.ActMod_Avs__a1_2_time or 0) < CurTime() then
                            if ANo_Avs_ok(ply, "a1_2") == false then
                                ply.ActMod_Avs__a1_2_time = nil
                            else
                                ply.ActMod_Avs__a1_2_time = CurTime() + 60
                                if AG_DatA(7, "Avs_a1_2") >= 35 then
                                    AG_DatA(1, AG_BED(2, "QXZzX2ExXzI="), "yes")
                                    AShowB(ply, "Avs_a1_2")
                                elseif AG_DatA(7, "Avs_a1_2") < 35 then
                                    if AG_DatA(7, "Avs_a1_2") >= 34 then
                                        AG_DatA(1, AG_BED(2, "QXZzX2ExXzI="), "yes")
                                        AShowB(ply, "Avs_a1_2")
                                    else
                                        AG_DatA(1, AG_BED(2, "QXZzX2ExXzI="), nil, AG_DatA(7, "Avs_a1_2") + 1)
                                    end
                                end
                            end
                        end
                    end
                end

                if ANo_Avs_ok(ply, "a2_7") == true then
                    if ply:A_ActMod_IsActing() and AGaaT(ply, {"f_thumbsup._so_..png", "f_thumbsup.png", "amod_mixamo_gesture_9.png"}) == true then
                        if (ply.ActMod_Avs__a2_7_time or 0) < CurTime() then
                            ply.ActMod_Avs__a2_7_time = CurTime() + 1
                            local aRa = util.TraceHull({
                                start = ply:EyePos(),
                                endpos = ply:EyePos() + ply:GetForward() * 100,
                                mask = MASK_SHOT,
                                filter = function(ent) if ent:IsWorld() or (ent:IsPlayer() and not ent:IsBot() and ent ~= ply) then return true end end,
                                mins = Vector(-8, -8, -8),
                                maxs = Vector(8, 8, 8)
                            })

                            if not ply.ActMod_Avs__a2_7_ing then ply.ActMod_Avs__a2_7_ing = 0 end
                            local tr_C = aRa and IsValid(aRa.Entity) and aRa.Entity:GetClass()
                            if tr_C == "player" then
                                if ply.ActMod_Avs__a2_7_ing >= 2 then
                                    AG_DatA(1, "Avs_a2_7", "yes")
                                    AShowB(ply, "Avs_a2_7")
                                    ply.ActMod_Avs__a2_7_ing = 0
                                elseif ply.ActMod_Avs__a2_7_ing < 2 then
                                    ply.ActMod_Avs__a2_7_ing = ply.ActMod_Avs__a2_7_ing + 1
                                end
                            end
                        end
                    elseif ply.ActMod_Avs__a2_7_ing then
                        ply.ActMod_Avs__a2_7_ing = nil
                        ply.ActMod_Avs__a2_7_time = nil
                    end
                elseif ply.ActMod_Avs__a2_7_ing then
                    ply.ActMod_Avs__a2_7_ing = nil
                    ply.ActMod_Avs__a2_7_time = nil
                end
            end
        end
    end

    local function AInt1()
        if A_AM.ActMod:GetInfAddon("2896053995") == 3 then
            hook.Add("garrydiva-chartend", "ActMod_Avs_GDiva", function(chart, score, maxscore)
                local ply = LocalPlayer()
                if ANo_Avs_ok(ply, "a2_4") == true then
                    if score >= 130000 and AG_DatA(7, "Avs_a2_4") <= 3 then
                        AG_DatA(1, AG_BED(2, "QXZzX2EyXzQ="), nil, AG_DatA(7, "Avs_a2_4") + 1)
                        if AG_DatA(7, "Avs_a2_4") >= 3 then
                            AG_DatA(1, AG_BED(2, "QXZzX2EyXzQ="), "yes")
                            AShowB(ply, "Avs_a2_4", "GDiva-> [ 130,000 ] ")
                        else
                            AShowB(ply, "Avs_a2_4", "GDiva-> [ 130,000 ]   " .. string.format(aR:T("LAchievements_a2_i4t"), " " .. AG_DatA(7, "Avs_a2_4") .. " / 3  "), 2)
                        end
                    end
                end

                if ANo_Avs_ok(ply, "a2_5") == true then
                    if score >= 90000 then
                        AG_DatA(1, AG_BED(2, "QXZzX2EyXzU="), "yes")
                        AShowB(ply, AG_BED(2, "QXZzX2EyXzU="), "GDiva-> [ 90,000 ] ")
                    end
                end
            end)
        end
    end

    AInt1()
    local function aChMap(pl, txt, tmap)
        if game.SinglePlayer() then
            Derma_Query(string.format(aR:T("LAchievements_H0TMap"), txt), "ActMod :", aR:T("LORTR_No"), function() end, aR:T("LORTR_Yes"), function() pl:ConCommand("map " .. tmap .. "\n") end)
        elseif not game.SinglePlayer() and pl.ActMod_PlyIsHost == true then
            Derma_Query(aR:T("LAchievements_H1TMap") .. "\n" .. string.format(aR:T("LAchievements_H0TMap"), txt), "ActMod :", aR:T("LORTR_No"), function() end, aR:T("LORTR_Yes"), function()
                net.Start("A_AM.ActMod.ClToSv")
                net.WriteString("CHangeMap_ " .. tmap)
                net.SendToServer()
            end)
        elseif not game.SinglePlayer() and game.MaxPlayers() > 1 then
            Derma_Query(aR:T("LAchievements_H2TMap") .. "\n" .. string.format(aR:T("LAchievements_H0TMap"), txt), "ActMod :", aR:T("LORTR_No"), function() end, aR:T("LORTR_Yes"), function() RunConsoleCommand("map", tmap) end)
        end
    end

    local function title(list, text)
        local label = list:Add('DLabel')
        if text == "A" then
            label:SetText("")
        else
            label:SetText(text or "")
        end

        label:SetFont('ActMod_a2')
        label:SetTextColor(color_white)
        label:SetExpensiveShadow(2, color_black)
        label:SetContentAlignment(5)
        label:Dock(TOP)
        label:DockMargin(0, 0, 0, 3)
        if text then
            local Tmz = 50
            if text ~= "A" then
                local Tal = vgui.Create('DLabel', label)
                Tal:SetAlpha(0)
                Tal:SetText(text)
                Tal:SetFont('ActMod_a2')
                Tal:SizeToContents()
                Tmz = Tal:GetWide() + 20
                Tal:Remove()
                Tal = nil
            end

            label.Paint = function(ss, w, h)
                if text == "A" then
                    draw.RoundedBox(5, 0, 0, w, h, Color(0, 50, 50, 150))
                elseif text then
                    draw.RoundedBox(5, w / 2 - Tmz / 2, 0, Tmz, h, Color(0, 50, 50, 150))
                end
            end
        end
        return label
    end

    local function ic_dit(plist, datta, sl)
        local pnl = plist:Add('DButton')
        pnl:SetTall(60)
        pnl:SetText("")
        pnl:Dock(TOP)
        pnl:DockMargin(0, 0, 0, 3)
        pnl.tt = CurTime() + 0.1
        pnl.Alpa = 0
        sl.alltask = sl.alltask + 1
        local Think_ing
        local Think_ok = AG_DatA(2, datta.ok)
        local AidW
        local Alpa, Zlpa = 300, 0
        if datta.idW then
            local Aags
            if datta.idW == "2580513967" then Aags = true end
            AidW = A_AM.ActMod:GetInfAddon(datta.idW, Aags)
            Aags = nil
        end

        if datta.oning and Think_ok == "no" then Think_ing = AG_DatA(7, datta.ok) end
        pnl.Think = function(ss)
            if (pnl.tt or 0) < CurTime() then
                pnl.tt = CurTime() + 0.5
                Think_ok = AG_DatA(2, datta.ok)
                if datta.oning and Think_ok == "no" then Think_ing = AG_DatA(7, datta.ok) end
                if Think_ok == "Done" or Think_ok == "yes" or (Think_ok == "no" and datta.copy) or (datta.idW and (datta.idW == "2567449282" and AidW == 0 or datta.idW ~= "2567449282")) or datta.conntSv or datta.ongame then
                    pnl:SetMouseInputEnabled(true)
                else
                    pnl:SetMouseInputEnabled(false)
                end
            end

            if Think_ok == "Done" then
                if ss:IsHovered() and ss.Alpa < 255 then
                    ss.Alpa = math.min(255, ss.Alpa + 650 * FrameTime())
                elseif not ss:IsHovered() then
                    if ss.Alpa > 0 then
                        ss.Alpa = math.max(0, ss.Alpa - 600 * FrameTime())
                    else
                        if Zlpa > 0 then Zlpa = 0 end
                        if Alpa ~= 0 then Alpa = 300 end
                    end
                end
            end
        end

        local uicon = ""
        local hecode = ""
        local bF = A_AM.ActMod.Settings["IconsActs"] .. "/"
        if A_AM.ActMod.ActLck[datta.ok] then
            uicon = bF .. A_AM.ActMod.ActLck[datta.ok]["T1"]
            if A_AM.ActMod.ActLck[datta.ok]["T2"] ~= "" then hecode = AG_BED(1, A_AM.ActMod.ActLck[datta.ok]["T2"] .. A_AM.ActMod.ActLck[datta.ok]["T1"]) end
        end

        local sln = string.len(bF) + 1
        local shv = ReString(string.sub(uicon, sln - 1))
        local si_Gmod_Taunt = (string.find(shv, "taunt_") or string.find(shv, "zombie_")) and not string.find(shv, "amod_") and not string.find(shv, "wos_tf2_")
        local si_AM4_Amod = string.find(shv, "amod_") and not string.find(shv, "amod_pubg_") and not string.find(shv, "amod_mmd_") and not string.find(shv, "amod_fortnite_")
        local si_AM4_pubg = string.find(shv, "amod_pubg_")
        local si_AM4_MMD = string.find(shv, "amod_mmd_")
        local si_AM4_Fortnite = string.find(shv, "amod_fortnite_")
        local si_CTA_MMD = string.find(shv, "original_dance")
        local si_CTA_Fortnite = string.find(shv, "f_") and not string.find(shv, "original_dance") and not string.find(shv, "amod_")
        local si_CTA_TF2 = string.find(shv, "wos_tf2_")
        local NIcon
        local LIcon
        if si_Gmod_Taunt then
            LIcon = "actmod/imenu/is_gmod.png"
            NIcon = "AM4"
        elseif si_AM4_Amod then
            LIcon = "actmod/imenu/is_am4.png"
            NIcon = "AM4"
        elseif si_AM4_pubg then
            LIcon = "actmod/imenu/is_pubg.png"
            NIcon = "AM4"
        elseif si_AM4_MMD then
            LIcon = "actmod/imenu/is_mmd2.png"
            NIcon = "AM4"
        elseif si_AM4_Fortnite then
            LIcon = "actmod/imenu/Is_fortnite.png"
            NIcon = "AM4"
        elseif si_CTA_MMD then
            LIcon = "actmod/imenu/is_mmd.png"
            NIcon = "CTA"
        elseif si_CTA_Fortnite then
            LIcon = "actmod/imenu/Is_fortnite.png"
            NIcon = "CTA"
        elseif si_CTA_TF2 then
            LIcon = "actmod/imenu/is_team_fortress2.png"
            NIcon = "TF2"
        else
            LIcon = "icon64/tool.png"
            NIcon = "None"
        end

        pnl.Paint = function(ss, w, h)
            if Think_ok == "Done" then
                draw.RoundedBox(4, 0, 0, w, h, Color(50, 120, 80, 255))
            elseif Think_ok == "yes" then
                local acw = math.max(0, math.min(50, 20 + (50 * math.sin(CurTime() * 7))))
                if ss:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, ss:IsDown() and Color(150, 200, 110, 255) or Color(80, 140, 150, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(50 + acw * 1.1, 120 + acw * 0.5, 80, 255))
                end
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 30, 100, 105))
            end

            surface.SetDrawColor(Color(0, 50, 150, 255))
            surface.SetMaterial(Material("gui/gradient"))
            surface.DrawTexturedRect(0, 0, w, h)
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material(datta.icon, "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, h, h)
            if Think_ok == "Done" then
                surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                surface.DrawTexturedRect(w - (h / 2 + 5), 5, h / 2, h / 2)
            end

            if Think_ok == "yes" then
                draw.SimpleTextOutlined(aR:T("LAchievements_PrsHere"), "ActMod_a1", w - 5, 5, Color(255, 255, 0, 255), 2, 0, math.max(0, math.min(2, 5 * math.sin(CurTime() * 6))), Color(255, 255, 255, math.max(0, math.min(255, 255 * math.sin(CurTime() * 6)))))
            elseif Think_ok == "no" then
                if datta.ongame then if datta.ok == "Avs_a1_3" then draw.SimpleText("[ " .. aR:T("LAchievements_PTPlay") .. " ]", "ActMod_a4", w - 5, 10, Color(200, 255, 230, 200 + (55 * math.sin(CurTime() * 3))), 2) end end
                if AidW == 0 then
                    draw.SimpleText("[ " .. aR:T("LAchievements_NAddon") .. " ]", "ActMod_a4", w - 5, 10, Color(255, 120, 40, 200 + (55 * math.sin(CurTime() * 3))), 2)
                elseif AidW == 1 then
                    draw.SimpleText("[ " .. aR:T("LAchievements_EnAdon") .. " ]", "ActMod_a4", w - 5, 10, Color(255, 200, 100, 200 + (55 * math.sin(CurTime() * 3))), 2)
                elseif AidW == 2 then
                    draw.SimpleText("[ " .. aR:T("LAchievements_ReMGam") .. " ]", "ActMod_a4", w - 5, 10, Color(225, 200, 255, 200 + (55 * math.sin(CurTime() * 3))), 2)
                elseif AidW == 3 then
                    if datta.idW == "2896053995" then
                        draw.SimpleText("[ " .. aR:T("LAchievements_PTPlay") .. " ]", "ActMod_a4", w - 5, 10, Color(200, 255, 230, 200 + (55 * math.sin(CurTime() * 3))), 2)
                    elseif datta.idW == "2580513967" and AGetMapNow ~= "am4-game_lv1" then
                        draw.SimpleText("[ " .. aR:T("LAchievements_PGTMap") .. " ]", "ActMod_a4", w - 5, 10, Color(200, 255, 230, 200 + (55 * math.sin(CurTime() * 3))), 2)
                    end
                elseif datta.conntSv then
                    draw.SimpleText("[ " .. aR:T("LAchievements_PGTaSv") .. " ]", "ActMod_a4", w - 5, 10, Color(200, 255, 230, 200 + (55 * math.sin(CurTime() * 3))), 2)
                elseif ss:IsHovered() and datta.copy then
                    draw.SimpleText("[ " .. aR:T("LAchievements_CopyNa") .. " ]", "ActMod_a4", w - 5, 10, Color(200, 255, 255, 200 + (55 * math.sin(CurTime() * 3))), 2)
                end

                if datta.oning then
                    if datta.ok == "Avs_a1_3" then
                        draw.SimpleText(string.format(aR:T("LAchievements_a2_i4t"), tostring(Think_ing) .. " / 3 "), "ActMod_a3", w - 5, 30, Color(200, 200, 150, 255), 2)
                    elseif datta.ok == "Avs_a2_4" then
                        draw.SimpleText(string.format(aR:T("LAchievements_a2_i4t"), tostring(Think_ing) .. " / 3 "), "ActMod_a3", w - 5, 30, Color(200, 200, 150, 255), 2)
                    else
                        draw.SimpleText(tostring(Think_ing) .. " / " .. datta.oning .. " ", "ActMod_a3", w - 5, 30, Color(200, 200, 150, 255), 2)
                    end
                end
            end

            draw.SimpleText(datta.nemu, "ActMod_a6", h + 5, 5, Color(255, 255, 215, 255))
            draw.SimpleText(datta.missin, "ActMod_a3", h + 5, 35, Color(255, 255, 215, 255))
            if Think_ok == "Done" and ss.Alpa > 0 then
                local Alpa2 = 255 * ss.Alpa / 100
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 20, 100, Alpa2))
                surface.SetDrawColor(Color(50, 150, 200, ss.Alpa))
                surface.SetMaterial(Material("gui/gradient"))
                surface.DrawTexturedRect(0, 0, w, h)
                if uicon ~= "" then
                    if Alpa > -300 then
                        Alpa = math.max(-300, Alpa - 70 * FrameTime())
                        Zlpa = math.min(h, Zlpa + 70 * FrameTime())
                    elseif Alpa <= -300 then
                        Alpa = 300
                        Zlpa = 0
                    end

                    surface.SetDrawColor(Color(255, 255, 255, math.max(0, math.min(ss.Alpa, 255 * Alpa / 255))))
                    surface.SetMaterial(Material("actmod/eff_particle/p_ring_wave"))
                    surface.DrawTexturedRect(h / 2 - Zlpa / 2, h / 2 - Zlpa / 2, Zlpa, Zlpa)
                    surface.SetDrawColor(Color(255, 255, 255, math.max(0, math.min(ss.Alpa, (Zlpa * 2) * Alpa / 150))))
                    surface.SetMaterial(Material("actmod/eff_particle/p_glow_01"))
                    surface.DrawTexturedRect(0, 0, h, h)
                    surface.SetDrawColor(Color(255, 255, 255, 255 * ss.Alpa / 150))
                    surface.SetMaterial(Material(uicon, "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, h, h)
                    draw.SimpleText(A_AM.ActMod:ReNameAct(RvString(ReString(string.sub(uicon, sln)))), "ActMod_a6", h + 5, 5, Color(255, 255, 215, ss.Alpa))
                    draw.SimpleText(ReString(string.sub(uicon, sln)), "ActMod_a1", h + 6, 36, Color(5, 40, 50, ss.Alpa))
                    draw.SimpleText(ReString(string.sub(uicon, sln)), "ActMod_a1", h + 5, 35, Color(255, 255, 215, ss.Alpa))
                    surface.SetDrawColor(Color(255, 255, 255, ss.Alpa))
                    surface.SetMaterial(Material(LIcon, "noclamp smooth"))
                    surface.DrawTexturedRect(w - h / 1.5 - 5, h / 2 - h / 3, h / 1.5, h / 1.5)
                    draw.SimpleText("[ " .. NIcon .. " ]", "ActMod_a1", w - h / 1.5 - 10, h / 2, Color(255, 255, 215, ss.Alpa), 2, 1)
                end
            end
        end

        pnl.DoClick = function(p)
            if Think_ok == "yes" then
                A_AM.ActMod:vShowunLock(1, datta.ok)
            elseif Think_ok == "Done" then
                A_AM.ActMod:Chicon(plist, A_AM.ActMod.ActLck[datta.ok]["T1"], true)
            elseif Think_ok == "no" then
                if AidW == 0 then
                    gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=" .. datta.idW)
                elseif AidW == 3 then
                    if datta.idW == "2896053995" then
                        if IsValid(sl) then sl:Remove() end
                        LocalPlayer():ConCommand("garrydiva_chartmenu\n")
                    elseif datta.idW == "2580513967" and AGetMapNow ~= "am4-game_lv1" then
                        aChMap(LocalPlayer(), "GameRun Lv1", "am4-game_lv1")
                    end
                elseif datta.conntSv then
                    local ASv_N, ASv_C, ASv_O = "[AM4]", datta.conntSv, "unknown"
                    if LocalPlayer().ActMod_TabS1 and LocalPlayer().ActMod_TabS1["SVAM4_On"] then
                        if LocalPlayer().ActMod_TabS1["SVAM4_Name"] then ASv_N = LocalPlayer().ActMod_TabS1["SVAM4_Name"] end
                        if LocalPlayer().ActMod_TabS1["SVAM4_Connect"] then ASv_C = LocalPlayer().ActMod_TabS1["SVAM4_Connect"] end
                        if LocalPlayer().ActMod_TabS1["SVAM4_On"] then ASv_O = LocalPlayer().ActMod_TabS1["SVAM4_On"] end
                    end

                    Derma_Query(string.format(aR:T("LAchievements_PGToSv"), ASv_N) .. "\n\nName : " .. ASv_N .. "\nAddress : " .. ASv_C .. "\nStatus : " .. ASv_O, "ActMod :", aR:T("LORTR_No"), function() end, aR:T("LORTR_Yes"), function() RunConsoleCommand("connect", ASv_C) end)
                elseif datta.ongame then
                    if datta.ok == "Avs_a1_3" then
                        if IsValid(sl) then sl:Remove() end
                        A_AM.ActMod:MunGam1Box()
                    elseif datta.ok == "Avs_a3_4" then
                        if IsValid(sl) then sl:Remove() end
                        A_AM.ActMod:MListHlp(103)
                    end
                end
            end
        end

        pnl.DoRightClick = function(p)
            if Think_ok == "Done" then
                surface.PlaySound("actmod/s/bell1.wav")
                if hecode ~= "" then
                    Derma_Query(aR:T("LAchievements_shCpl2") .. "  " .. A_AM.ActMod:ReNameAct(RvString(ReString(string.sub(uicon, sln)))) .. "\n" .. aR:T("LAchievements_Name") .. "  " .. ReString(string.sub(uicon, 15)) .. "\n" .. aR:T("LAchievements_heCode") .. "  " .. hecode, aR:T("LAchievements") .. " :", aR:T("LReplace_txt_REmott4"), function() end, aR:T("LReplace_txt_CopyName"), function() SetClipboardText(ReString(string.sub(uicon, sln))) end, aR:T("LReplace_txt_CopyCode"), function() SetClipboardText(hecode) end)
                else
                    Derma_Query(aR:T("LAchievements_shCpl") .. "  " .. A_AM.ActMod:ReNameAct(RvString(ReString(string.sub(uicon, sln)))) .. "\n" .. aR:T("LAchievements_Name") .. "  " .. ReString(string.sub(uicon, 15)), aR:T("LAchievements") .. " :", aR:T("LReplace_txt_REmott4"), function() end, aR:T("LReplace_txt_CopyName"), function() SetClipboardText(ReString(string.sub(uicon, sln))) end)
                end
            elseif datta.copy and Think_ok == "no" then
                surface.PlaySound("actmod/s/copy1.wav")
                SetClipboardText(datta.copy)
                if IsValid(pnl.txh) then pnl.txh:Remove() end
                pnl.txh = vgui.Create("DLabel", pnl)
                pnl.txh:SetSize(pnl:GetWide() / 2, pnl:GetTall())
                pnl.txh:SetPos(pnl.txh:GetWide() / 2, 0)
                pnl.txh:SetText("")
                pnl.txh:SetAlpha(255)
                pnl.txh:AlphaTo(0, 0.5, 0.3, function(s) if IsValid(pnl.txh) then pnl.txh:Remove() end end)
                pnl.txh.Paint = function(s, w, h)
                    draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(20, 90, 200, 255))
                    draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end
    end

    function A_AM.ActMod:vShowunLock(sa, SDat)
        local bF = A_AM.ActMod.Settings["IconsActs"]
        local uicon = ""
        local hecode = ""
        local addZ = 0
        if A_AM.ActMod.ActLck[SDat] then
            local reNme
            for k2, v2 in ipairs(file.Find("materials/" .. bF .. "/*", "GAME")) do
                if not reNme and string.find(v2, A_AM.ActMod.ActLck[SDat]["T1"], nil, true) then
                    if string.find(v2, "._so_.", nil, true) and string.find(v2, "._ef_.", nil, true) and string.find(v2, "._mo_.", nil, true) then
                        reNme = v2
                    elseif string.find(v2, "._so_.", nil, true) and string.find(v2, "._ef_.", nil, true) then
                        reNme = v2
                    elseif string.find(v2, "._so_.", nil, true) then
                        reNme = v2
                    elseif string.find(v2, "._ef_.", nil, true) then
                        reNme = v2
                    else
                        reNme = v2
                    end
                end
            end

            uicon = bF .. "/" .. reNme
            if A_AM.ActMod.ActLck[SDat]["T2"] ~= "" then
                addZ = 60
                hecode = AG_BED(1, A_AM.ActMod.ActLck[SDat]["T2"] .. A_AM.ActMod.ActLck[SDat]["T1"])
            end
        end

        if SDat then AG_DatA(1, SDat, "yes") end
        local A0lpa = 200
        local Alpa = 300
        local Zlpa = 0
        local Zlpa2 = 50
        local StZ = false
        local rh0 = vgui.Create("DPanel")
        rh0:SetSize(ScrW(), ScrH())
        rh0:SetText("")
        rh0:MakePopup()
        rh0.Paint = function(s, w, h)
            if A0lpa > 0 then
                A0lpa = math.max(0, A0lpa - 80 * FrameTime())
                draw.RoundedBox(0, 0, 0, w, h, Color(240, 245, 255, A0lpa))
            end

            draw.RoundedBox(0, 0, 0, w, h, Color(10, 30, 50, 200))
        end

        local rh = vgui.Create("DPanel", rh0)
        rh.OnRemove = function(pan) if IsValid(rh0) then rh0:Remove() end end
        rh:SetSize(200, 300 + addZ)
        rh:Center()
        rh:SetText("")
        rh:SetAlpha(0)
        rh:AlphaTo(255, 0.3, 0, function(s) if IsValid(rh) then StZ = true end end)
        rh.Done = false
        rh.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(40, 100, 120, 255))
            draw.RoundedBox(10, 5, 5, w - 10, h - 10, Color(40, 100, 150, 255))
            surface.SetDrawColor(Color(255, 255, 255, 100))
            surface.SetMaterial(Material("gui/gradient_up"))
            surface.DrawTexturedRect(5, 5, w - 10, h - 10)
            if Alpa > -300 then
                if StZ == true then
                    Alpa = math.max(-300, Alpa - 200 * FrameTime())
                    Zlpa = math.min(s:GetWide(), Zlpa + 380 * FrameTime())
                end
            elseif Alpa <= -300 and rh.Done == false then
                Alpa = 300
                Zlpa = 0
            end

            if Alpa > 0 then
                Zlpa2 = math.min(s:GetWide(), Zlpa2 + 210 * FrameTime())
            elseif Alpa < 0 then
                Zlpa2 = math.max(s:GetWide() / 2, Zlpa2 - 70 * FrameTime())
            end

            surface.SetDrawColor(Color(255, 255, 255, math.max(0, math.min(255, 255 * Alpa / 255))))
            surface.SetMaterial(Material("actmod/eff_particle/p_ring_wave"))
            surface.DrawTexturedRect(s:GetWide() / 2 - Zlpa / 2, s:GetWide() / 2 - Zlpa / 2, Zlpa, Zlpa)
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material("actmod/eff_particle/p_glow_01"))
            surface.DrawTexturedRect(s:GetWide() / 2 - Zlpa2 / 2, s:GetWide() / 2 - Zlpa2 / 2, Zlpa2, Zlpa2)
            surface.SetMaterial(Material(uicon, "noclamp smooth"))
            surface.DrawTexturedRect(10, 10, s:GetWide() - 20, s:GetWide() - 20)
            draw.RoundedBox(10, 20, h - 100 - addZ, w - 40, 50, Color(30, 50, 60, 255))
            draw.SimpleText(aR:T("LAchievements_UnLocked"), "ActMod_a1", s:GetWide() / 2, h - 85 - addZ, Color(255, 255, 215, 255), 1, 1)
            draw.SimpleText(A_AM.ActMod:ReNameAct(RvString(ReString(string.sub(uicon, 15)))), "ActMod_a4", s:GetWide() / 2, h - 63 - addZ, Color(255, 255, 215, 255), 1, 1)
            if addZ ~= 0 then
                draw.RoundedBox(10, 20, h - 100, w - 40, 50, Color(30, 50, 60, 255))
                draw.SimpleText(aR:T("LAchievements_heCode"), "ActMod_a2", 28, h - 90, Color(255, 255, 215, 255), 0, 1)
                draw.SimpleText(string.sub(hecode, 1, 25), "ActMod_a4", s:GetWide() / 2, h - 72, Color(255, 255, 215, 255), 1, 1)
                draw.SimpleText(string.sub(hecode, 26), "ActMod_a4", s:GetWide() / 2, h - 60, Color(255, 255, 215, 255), 1, 1)
            end

            if rh.Done == true then draw.SimpleText(aR:T("LReplace_txt_Done"), "ActMod_a1", s:GetWide() / 2, h - 30, Color(255, 255, 215, 255), 1, 1) end
        end

        rh.SBut = vgui.Create("DButton", rh)
        rh.SBut:SetText(aR:T("ALanguage_ok"))
        rh.SBut:SetFont("ActMod_a1")
        rh.SBut:SetTextColor(Color(20, 5, 5))
        rh.SBut:SetSize(100, 25)
        rh.SBut:SetPos(rh:GetWide() / 2 - rh.SBut:GetWide() / 2, rh:GetTall() - 40)
        rh.SBut:SetCursor("arrow")
        rh.SBut:SetDisabled(true)
        rh.SBut.OnOk = false
        rh.SBut:SetAlpha(0)
        rh.SBut:AlphaTo(255, 1, 1.4, function(s)
            if IsValid(rh) then
                rh.SBut:SetDisabled(false)
                rh.SBut:SetCursor("hand")
            end
        end)

        rh.SBut.Paint = function(ss, w, h)
            if not ss:IsEnabled() then
                draw.RoundedBox(10, 0, 0, w, h, Color(100, 100, 100, 255))
            elseif ss:IsHovered() then
                draw.RoundedBox(10, 0, 0, w, h, ss:IsDown() and Color(70, 120, 180, 255) or Color(70, 180, 100, 255))
            else
                draw.RoundedBox(10, 0, 0, w, h, Color(50, 150, 70, 255))
            end
        end

        rh.SBut.DoClick = function()
            surface.PlaySound("garrysmod/balloon_pop_cute.wav")
            rh.Done = true
            rh:AlphaTo(0, 0.5, 0.2, function(s) if IsValid(rh) then rh:Remove() end end)
            if SDat then AG_DatA(1, SDat, "Done") end
            if IsValid(rh.SBut) then rh.SBut:Remove() end
            if IsValid(rh.CBut) then rh.CBut:Remove() end
            if IsValid(rh.DBut) then rh.CBut:Remove() end
        end

        rh.CBut = vgui.Create("DButton", rh)
        rh.CBut:SetText("")
        rh.CBut:SetSize(rh:GetWide() - 40, 50)
        rh.CBut:SetPos(20, rh:GetTall() - 100 - addZ)
        rh.CBut.Paint = function(ss, w, h) end
        rh.CBut.DoClick = function()
            surface.PlaySound("actmod/s/copy1.wav")
            SetClipboardText(ReString(string.sub(uicon, 15)))
            if IsValid(rh.txh) then rh.txh:Remove() end
            rh.txh = vgui.Create("DLabel", rh.CBut)
            rh.txh:SetSize(rh.CBut:GetWide(), rh.CBut:GetTall())
            rh.txh:SetPos(0, 0)
            rh.txh:SetText("")
            rh.txh:SetAlpha(255)
            rh.txh:AlphaTo(0, 0.5, 0.5, function(s) if IsValid(rh.txh) then rh.txh:Remove() end end)
            rh.txh.Paint = function(s, w, h)
                draw.RoundedBox(10, 0, 0, w, h, Color(20, 90, 200, 255))
                draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        if addZ ~= 0 then
            rh.DBut = vgui.Create("DButton", rh)
            rh.DBut:SetText("")
            rh.DBut:SetSize(rh:GetWide() - 40, 50)
            rh.DBut:SetPos(20, rh:GetTall() - 100)
            rh.DBut.Paint = function(ss, w, h) end
            rh.DBut.DoClick = function()
                surface.PlaySound("garrysmod/balloon_pop_cute.wav")
                SetClipboardText(hecode)
                if IsValid(rh.txh) then rh.txh:Remove() end
                rh.txh = vgui.Create("DLabel", rh.DBut)
                rh.txh:SetSize(rh.DBut:GetWide(), rh.DBut:GetTall())
                rh.txh:SetPos(0, 0)
                rh.txh:SetText("")
                rh.txh:SetAlpha(255)
                rh.txh:AlphaTo(0, 0.5, 0.5, function(s) if IsValid(rh.txh) then rh.txh:Remove() end end)
                rh.txh.Paint = function(s, w, h)
                    draw.RoundedBox(10, 0, 0, w, h, Color(20, 90, 200, 255))
                    draw.SimpleText(aR:T("LReplace_txt_CopyCode"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end

        timer.Simple(30.5, function()
            if IsValid(rh) then
                rh.SBut:SetDisabled(true)
                rh.SBut:SetCursor("arrow")
                rh:AlphaTo(0, 0.5, 0.2, function(s) if IsValid(rh) then rh:Remove() end end)
            end
        end)

        surface.PlaySound("actmod/s/getcart.mp3")
        return rh0
    end

    local PANEL = {}
    function PANEL:Init()
        local ply = LocalPlayer()
        local bF = A_AM.ActMod.Settings["IconsActs"]
        if not file.Exists(AG_BED(2, "bm5sai5qc29u"), "DATA") then AG_CDet() end
        local aa_self = vgui.Create("DButton")
        aa_self:SetSize(ScrW(), ScrH())
        aa_self:SetText("")
        aa_self:MakePopup()
        aa_self:SetCursor("arrow")
        aa_self:Center()
        aa_self:SetAlpha(0)
        aa_self.OnMouseReleased = function() if IsValid(self) then self:Remove() end end
        self:SetSize(800, math.max(355, math.min(ScrH() / 1.3, 680)))
        self:Center()
        self:SetTitle("")
        self:SetAlpha(0)
        self:AlphaTo(255, 0.2, 0.1)
        self:MakePopup()
        self:ShowCloseButton(false)
        self.alltask = 0
        self.tt = CurTime() + 0.7
        self.tta = AG_DatA(5)
        self.tye = AG_DatA(11) or 0
        self.Think = function(s)
            if (s.tt or 0) < CurTime() then
                s.tt = CurTime() + 0.7
                s.tta = AG_DatA(5)
                s.tye = AG_DatA(11)
            end
        end

        self.OnRemove = function() if IsValid(aa_self) then aa_self:Remove() end end
        self.Paint = function(ss, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(70, 120, 160, 255))
            draw.RoundedBox(5, 10, 10, w - 20, h - 20, Color(40, 50, 60, 255))
            draw.SimpleText(aR:T("LAchievements_yor") .. " ActMod ( " .. ss.tta .. " / " .. ss.alltask .. " )", "ActMod_a6", 90, 30, Color(255, 255, 215, 255))
            if ss.tye > 0 then
                local acw = math.max(0, math.min(100, 50 + (100 * math.sin(CurTime() * 7))))
                draw.SimpleText("* (" .. ss.tye .. ")", "ActMod_a6", w - 80, 30, Color(100 + acw, 200 + acw * 0.5, 255, 255), 2)
            end

            draw.SimpleText(aR:T("LAchievements_t_ihlp"), "ActMod_e1", ss:GetWide() / 2, ss:GetTall() - 80, Color(255, 255, 215, 255), 1)
            draw.SimpleText("code ActMod:", "ActMod_a1", 15, ss:GetTall() - 50, Color(255, 255, 215, 255))
        end

        self.Pmdl = vgui.Create("DLabel", self)
        self.Pmdl:SetText("")
        self.Pmdl:SetPos(15, 10)
        self.Pmdl:SetSize(60, 60)
        self.Pmdl:SetAlpha(0)
        self.Pmdl:AlphaTo(255, 0.2, 0.2)
        self.Tmdl = vgui.Create("DModelPanel", self.Pmdl)
        self.Tmdl:Dock(FILL)
        self.Tmdl:SetAlpha(0)
        self.Tmdl:AlphaTo(255, 0.4)
        self.Tmdl:SetModel("models/maxofs2d/logo_gmod_b.mdl")
        self.Tmdl:SetCamPos(Vector(240, 0, 0))
        self.Tmdl:SetLookAt(Vector(0, 0, 0))
        self.Tmdl:SetFOV(40)
        function self.Tmdl:LayoutEntity(ent)
            ent:SetAngles(Angle(0, 40 * math.sin(CurTime() * 0.5), 0))
        end

        self.SBut = vgui.Create("DButton", self)
        self.SBut:SetText("X")
        self.SBut:SetFont("ActMod_a1")
        self.SBut:SetAlpha(0)
        self.SBut:SetTextColor(Color(20, 5, 5))
        self.SBut:SetPos(self:GetWide() - 50, -50)
        self.SBut:SetSize(30, 30)
        self.SBut:AlphaTo(255, 0.3, 0.5)
        self.SBut:MoveTo(self:GetWide() - 50, 20, 0.4, 0.3)
        self.SBut.Paint = function(ss, w, h)
            if ss:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
            end
        end

        self.SBut.DoClick = function()
            surface.PlaySound("garrysmod/balloon_pop_cute.wav")
            if IsValid(self) then self:Remove() end
        end

        local frame = vgui.Create('DPanel', self)
        frame:SetPos(20, 70)
        frame:SetSize(self:GetWide() - 40, self:GetTall() - 160)
        frame.Paint = function(p, w, h)
            draw.RoundedBox(5, 0, 0, w, h, Color(10, 50, 150, 150))
            surface.SetDrawColor(Color(255, 255, 255, 100))
            surface.SetMaterial(Material("gui/gradient_down"))
            surface.DrawTexturedRect(0, 0, w, h)
        end

        local plist = frame:Add('AM4_DScrollPanel')
        plist:Dock(FILL)
        local OnServ = ply.ActMod_TabTSrvr and ply.ActMod_TabTSrvr == 1
        if OnServ then
            title(plist, aR:T("LAchievements_a1_b"))
            ic_dit(plist, {
                icon = "hud/killicons/default",
                ok = "Avs_a1_1",
                oning = 50,
                conntSv = "209.222.97.134:27017",
                nemu = string.format(aR:T("LAchievements_a1_m1"), "50"),
                missin = string.format(aR:T("LAchievements_a1_i1"), "50")
            }, self)

            ic_dit(plist, {
                icon = "hud/killicons/default",
                ok = "Avs_a3_7",
                oning = 250,
                conntSv = "209.222.97.134:27017",
                nemu = string.format(aR:T("LAchievements_a1_m1"), "250"),
                missin = string.format(aR:T("LAchievements_a1_i1"), "250")
            }, self)

            ic_dit(plist, {
                icon = "icon16/time.png",
                ok = "Avs_a1_2",
                oning = 35,
                conntSv = "209.222.97.134:27017",
                nemu = aR:T("LAchievements_a1_m2"),
                missin = aR:T("LAchievements_a1_i2")
            }, self)

            ic_dit(plist, {
                icon = "icon64/tool.png",
                ok = "Avs_a1_3",
                oning = 3,
                conntSv = "209.222.97.134:27017",
                nemu = aR:T("LAchievements_a1_m3"),
                missin = aR:T("LAchievements_a1_i3")
            }, self)
        else
            title(plist, aR:T("LAchievements_a1_b_n1"))
            ic_dit(plist, {
                icon = "entities/npc_zombie.png",
                ok = "Avs_a1_1",
                oning = 50,
                nemu = string.format(aR:T("LAchievements_a1_m1"), "50"),
                missin = string.format(aR:T("LAchievements_a1_i1_n1"), "50", "Fists (Gmod)")
            }, self)

            ic_dit(plist, {
                icon = "entities/npc_zombie.png",
                ok = "Avs_a3_7",
                oning = 250,
                nemu = string.format(aR:T("LAchievements_a1_m1"), "250"),
                missin = string.format(aR:T("LAchievements_a1_i1_n1"), "250", "SMG")
            }, self)

            ic_dit(plist, {
                icon = "icon16/time.png",
                ok = "Avs_a1_2",
                oning = 35,
                nemu = aR:T("LAchievements_a1_m2_n1"),
                missin = aR:T("LAchievements_a1_i2_n1")
            }, self)

            ic_dit(plist, {
                icon = "icon64/tool.png",
                ok = "Avs_a1_3",
                oning = 3,
                ongame = true,
                nemu = aR:T("LAchievements_a1_m3"),
                missin = aR:T("LAchievements_a1_i3_n1")
            }, self)
        end

        title(plist, "A")
        title(plist)
        title(plist, aR:T("LAchievements_a3_b"))
        ic_dit(plist, {
            icon = "actmod/imenu/amap_gamerenl1.png",
            ok = "Avs_a3_1",
            idW = "2580513967",
            nemu = aR:T("LAchievements_a3_m1"),
            missin = aR:T("LAchievements_a3_i1")
        }, self)

        ic_dit(plist, {
            icon = "actmod/imenu/a3_2.png",
            ok = "Avs_a3_2",
            copy = "amod_dance_california_girls",
            nemu = aR:T("LAchievements_a3_m2"),
            missin = aR:T("LAchievements_a3_i2")
        }, self)

        title(plist, "A")
        title(plist)
        title(plist, aR:T("LAchievements_a2_b"))
        ic_dit(plist, {
            icon = bF .. "/amod_am4_levepalestina._so_..png",
            copy = "amod_am4_levepalestina",
            ok = "Avs_a3_6",
            nemu = aR:T("LAchievements_a3_m6"),
            missin = aR:T("LAchievements_a3_i6")
        }, self)

        ic_dit(plist, {
            icon = bF .. "/amod_mmd_dance_specialist._so_..png",
            copy = "amod_mmd_dance_specialist",
            ok = "Avs_a2_1",
            nemu = aR:T("LAchievements_a2_m1"),
            missin = aR:T("LAchievements_a2_i1")
        }, self)

        ic_dit(plist, {
            icon = "entities/npc_antlionguard.png",
            ok = "Avs_a2_2",
            nemu = aR:T("LAchievements_a2_m2"),
            missin = aR:T("LAchievements_a2_i2")
        }, self)

        ic_dit(plist, {
            icon = "entities/combineelite.png",
            ok = "Avs_a2_3",
            nemu = aR:T("LAchievements_a2_m3"),
            missin = aR:T("LAchievements_a2_i3")
        }, self)

        ic_dit(plist, {
            icon = "actmod/imenu/TheatricalMMD_1.png",
            ok = "Avs_a2_6",
            idW = "2567449282",
            nemu = aR:T("LAchievements_a2_m6"),
            missin = string.format(aR:T("LAchievements_a2_i6"), "Theatrical Chaos")
        }, self)

        ic_dit(plist, {
            icon = "actmod/imenu/GDiva_image.png",
            ok = "Avs_a2_5",
            idW = "2896053995",
            nemu = aR:T("LAchievements_a2_m4") .. "  [ 90,000 ]",
            missin = string.format(aR:T("LAchievements_a2_i4"), "90,000")
        }, self)

        ic_dit(plist, {
            icon = "actmod/imenu/GDiva_image.png",
            ok = "Avs_a2_4",
            oning = 3,
            idW = "2896053995",
            nemu = aR:T("LAchievements_a2_m4") .. "  [ 130,000 ]",
            missin = string.format(aR:T("LAchievements_a2_i4"), "130,000") .. "   " .. string.format(aR:T("LAchievements_a2_i4t"), "3")
        }, self)

        ic_dit(plist, {
            icon = bF .. "/f_thumbsup.png",
            ok = "Avs_a2_7",
            copy = "f_thumbsup",
            nemu = aR:T("LAchievements_a2_m7"),
            missin = aR:T("LAchievements_a2_i7")
        }, self)

        ic_dit(plist, {
            icon = "entities/npc_headcrab.png",
            ok = "Avs_a2_8",
            oning = 15,
            nemu = aR:T("LAchievements_a2_m8"),
            missin = aR:T("LAchievements_a2_i8")
        }, self)

        ic_dit(plist, {
            icon = "entities/npc_manhack.png",
            ok = "Avs_a2_9",
            oning = 25,
            nemu = aR:T("LAchievements_a2_m9"),
            missin = aR:T("LAchievements_a2_i9")
        }, self)

        ic_dit(plist, {
            icon = "actmod/imenu/TheatricalMMD_2.png",
            ok = "Avs_a3_3",
            idW = "2567449282",
            nemu = aR:T("LAchievements_a2_m6"),
            missin = string.format(aR:T("LAchievements_a2_i6"), "PV120 - Shake it")
        }, self)

        if OnServ then
            ic_dit(plist, {
                icon = "actmod/imenu/v_1.png",
                ok = "Avs_a3_4",
                ongame = true,
                nemu = aR:T("LAchievements_a3_m4"),
                missin = aR:T("LAchievements_a3_i4")
            }, self)
        else
            ic_dit(plist, {
                icon = "actmod/imenu/v_1.png",
                ok = "Avs_a3_4",
                nemu = aR:T("LAchievements_a3_m4"),
                missin = aR:T("LAchievements_a3_i4_n1")
            }, self)
        end

        ic_dit(plist, {
            icon = "actmod/imenu/v_fl.png",
            ok = "Avs_a3_8",
            nemu = aR:T("LAchievements_a3_m8"),
            missin = aR:T("LAchievements_a3_i8")
        }, self)

        ic_dit(plist, {
            icon = "entities/npc_poisonzombie.png",
            ok = "Avs_a3_5",
            oning = 13,
            nemu = aR:T("LAchievements_a3_m5"),
            missin = aR:T("LAchievements_a3_i5")
        }, self)

        title(plist, "A")
        self.searchBox = self:Add("DTextEntry")
        self.searchBox:SetSize(500, 25)
        self.searchBox:SetFont("ActMod_a3")
        self.searchBox:SetPos(150, self:GetTall() - 48)
        self.searchBox:SetPlaceholderText(" " .. aR:T("LAchievements_Ecode"))
        self.SBut = vgui.Create("DButton", self)
        self.SBut:SetText("Enter")
        self.SBut:SetFont("ActMod_a1")
        self.SBut:SetTextColor(Color(20, 5, 5))
        self.SBut:SetPos(670, self:GetTall() - 50)
        self.SBut:SetSize(100, 30)
        self.SBut.Paint = function(ss, w, h)
            if self.searchBox:GetValue() == "" then
                draw.RoundedBox(10, 0, 0, w, h, Color(120, 120, 120, 255))
            elseif ss:IsHovered() then
                draw.RoundedBox(10, 0, 0, w, h, ss:IsDown() and Color(100, 190, 145, 255) or Color(100, 130, 145, 255))
            else
                draw.RoundedBox(10, 0, 0, w, h, Color(150, 140, 80, 255))
            end
        end

        self.SBut.DoClick = function()
            if self.searchBox:GetValue() == "" then return end
            local Gt, Gn = "", ""
            if ply.GetTable_Avs then
                for k, v in pairs(A_AM.ActMod.ActLck) do
                    if v["T2"] ~= "" and AG_BED(2, self.searchBox:GetValue()) == v["T2"] .. v["T1"] then
                        Gt = k
                        Gn = v["T1"]
                    end
                end

                if A_AM.ActMod.ActuLck and istable(A_AM.ActMod.ActuLck) and A_AM.ActMod.ActuLck[AG_BED(2, "QU00X0F2cw==")] then
                    for k, v in pairs(A_AM.ActMod.ActuLck) do
                        if v ~= "" and k ~= AG_BED(2, "QU00X0F2cw==") and AG_BED(2, self.searchBox:GetValue()) == AG_BED(2, v) then
                            Gt = k
                            Gn = AG_BED(2, AG_BED(2, v))
                        end
                    end
                end

                if A_AM.ActMod.ActuAck and istable(A_AM.ActMod.ActuAck) and A_AM.ActMod.ActuAck[AG_BED(2, "QU00X0F2cw==")] then
                    for k, v in pairs(A_AM.ActMod.ActuAck) do
                        if v ~= "" and k ~= AG_BED(2, "QU00X0F2cw==") and self.searchBox:GetValue() == v["Pa"] then
                            Gt = k
                            Gn = v["Em"]
                        end
                    end
                end

                if ply.ActMod_TabTSrvr and ply.ActMod_TabTSrvr == 1 then
                else
                    if AG_BED(1, self.searchBox:GetValue()) == "QWhtZWRNYWtlNDAw" then
                        Gt = AG_BED(2, "QXZzX2EzXzQ=")
                        Gn = AG_BED(2, "YW1vZF9tbWRfaGlhc29iaQ==")
                    end
                end

                if AG_BED(1, self.searchBox:GetValue()) == "TG9uZyBsaXZlIFBhbGVzdGluZQ==" then
                    Gt = AG_BED(2, "QXZzX2EzXzg=")
                    Gn = AG_BED(2, "YW1vZF9kcmlwXzAx")
                end

                if Gt and Gt ~= "" and ply.GetTable_Avs[Gt] then
                    AG_DatA(6)
                    if ply.GetTable_Avs[Gt]["ok"] == "Done" then
                        surface.PlaySound("actmod/s/warning.wav")
                        Derma_Query(aR:T("LAchievements_coderau") .. "  " .. A_AM.ActMod:ReNameAct(RvString(ReString(Gn))) .. "\n" .. aR:T("LAchievements_Name") .. "  " .. ReString(Gn), "code ActMod", aR:T("LReplace_txt_ok"), function() end, aR:T("LReplace_txt_CopyName"), function() SetClipboardText(ReString(Gn)) end)
                    else
                        A_AM.ActMod:vShowunLock(1, Gt)
                    end
                else
                    surface.PlaySound("actmod/s/button19.wav")
                    Derma_Message(aR:T("LAchievements_codeEr"), "code ActMod", aR:T("LReplace_txt_ok"))
                end
            end
        end
    end

    vgui.Register("ActMod_Avs", PANEL, "DFrame")
    local PANEL = {}
    function PANEL:Init()
        local bF = A_AM.ActMod.Settings["IconsActs"]
        local ttat = {1.5, 1.75, 2, 2.25, 2.5}
        local aw, ah = ScrW() / table.Random(ttat), ScrH() / table.Random(ttat)
        local zw, zh = 200, 50
        local Alpa = 355
        local Alpha_on = false
        local Zitxt = 100
        local Apag = "vgui/notices/hint"
        local Anna = "nil_"
        local Apng = false
        LocalPlayer():SetNWInt("AShowTimeInt", Alpha)
        self:MakePopup()
        self:SetMouseInputEnabled(false)
        self:SetKeyboardInputEnabled(false)
        self:SetSize(50, 50)
        self:SetText("")
        self:SetPos(aw - self:GetWide() / 2, -(self:GetTall() + 5))
        self:SetAlpha(0)
        self:AlphaTo(255, 0.2, 0.2)
        timer.Simple(0.1, function()
            if IsValid(self) then
                if self.pag then Apag = self.pag end
                if self.nna then Anna = self.nna end
                if self.Typ == 2 then
                    self:SetPos(-(self:GetWide() + 5), ah - self:GetTall() / 2)
                    self:MoveTo(self:GetWide() / 2, ah - self:GetTall() / 2, 0.4)
                else
                    self:MoveTo(aw - self:GetWide() / 2, 100 - self:GetTall() / 2, 0.4)
                end
            end
        end)

        timer.Simple(0.5, function()
            if IsValid(self) then
                Alpha_on = true
                if string.find(Apag, ".png") then Apng = true end
                if self.Typ == 2 then
                    Zitxt = math.max(160, A_AM.ActMod:AZtxt(Anna, "ActMod_e1") + 55)
                    self:MoveTo(25, ah - self:GetTall() / 2, 0.5)
                else
                    Zitxt = math.max(160, A_AM.ActMod:AZtxt(Anna, "ActMod_e1") + 93)
                    self:MoveTo(aw - Zitxt / 2, 100 - self:GetTall() / 2, 0.5)
                end

                self:SizeTo(Zitxt, zh, 0.5)
                timer.Simple(3, function()
                    if IsValid(self) then
                        if self.Typ == 2 then
                            self:MoveTo(-(self:GetWide() + 5), ah - self:GetTall() / 2, 2.5)
                        else
                            self:MoveTo(aw - Zitxt / 2, -(self:GetTall() + 5), 2.5)
                        end

                        self:AlphaTo(0, 1.0, 1.5, function(s) if IsValid(self) then self:Remove() end end)
                    end
                end)
            end
        end)

        self.Think = function(p) if Alpha_on == true and Alpa > 0 then Alpa = math.max(0, Alpa - 500 * FrameTime()) end end
        self.Paint = function(s, w, h)
            draw.RoundedBox(5 + (40 * Alpa / 255), 0, 0, w, h, Color(80, 80, 100, 255))
            draw.RoundedBox(50 * Alpa / 255, 5, 5, w - 10, h - 10, Color(50, 100, 150, 255))
            if Alpa < 200 then
                surface.SetDrawColor(Color(255, 255, 255, 255))
                if Apng == true then
                    surface.SetMaterial(Material(Apag, "noclamp smooth"))
                else
                    surface.SetMaterial(Material(Apag))
                end

                surface.DrawTexturedRect(5 + (5 * Alpa / 50), 5, h - 10, h - 10)
                if self.Typ ~= 2 then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                    surface.DrawTexturedRect(s:GetWide() - (40 + (5 * Alpa / 50)), 10, h - 20, h - 20)
                end

                draw.SimpleText("ActMod :", "ActMod_a4", s:GetWide() / 2, 8, Color(255, 255, 255, 255), 1)
                draw.SimpleText(Anna, "ActMod_e1", 48, 25, Color(255, 255, 255, 255))
            end

            if Alpa > 0 then
                draw.RoundedBox(50 * Alpa / 255, 0, 0, w, h, Color(255, 255, 255, 255 * Alpa / 255))
                surface.SetDrawColor(Color(255, 255, 255, 255 * Alpa / 255))
                surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                surface.DrawTexturedRect(s.Typ == 2 and 0 or s:GetWide() / 2 - 25, 0, 50, 50)
            end
        end
    end

    vgui.Register("ActMod_Avs_Done", PANEL, "DLabel")
    local Actoji = A_AM.ActMod.Actoji
    local function aMeBu(a, aa, aba, az, aN)
        local bF = A_AM.ActMod.Settings["IconsActs"]
        local ply = LocalPlayer()
        local vCs, BZz
        local aO = 0.2
        local aS = 0.2
        local aSi = 30
        local aSi2 = 25
        local aSi3 = -2
        local self = Actoji
        local function getIntercept(x, y, radius, angle, w, h)
            return x + (radius * math.sin(angle)) - (w or 0), y + (radius * -math.cos(angle)) - (h or 0)
        end

        if aba then
            vCs = aba
        else
            vCs = self.Frame
        end

        if az then
            BZz = az
        else
            BZz = self.ButtonSize
        end

        local es = vgui.Create("DPanel", vCs)
        es:SetSize(BZz, BZz)
        local tx, ty
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            tx, ty = a, aa
        else
            tx, ty = getIntercept(aba:GetWide() / 2, aba:GetTall() / 2, aba:GetWide() / 3, a, es:GetWide() / 2, es:GetTall() / 2)
        end

        es:SetPos(tx, ty)
        es:SetSize(BZz, BZz)
        es:SetText("")
        es:SetAlpha(0)
        es.Paint = function(ste, w, h)
            if (ply.ActMod_TimMenRe or 0) < CurTime() then
                surface.SetDrawColor(Color(255, 255, 255, 255))
            else
                surface.SetDrawColor(Color(255, 100, 100, 255))
            end

            surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        end

        local e = vgui.Create("DButton", vCs)
        e:SetText("")
        e:SetAlpha(0)
        e:AlphaTo(200, aO)
        e.Slot = aN
        local ActojiData, ActojiData_1, ActojiData_2
        ActojiData = LocalPlayer():GetPData("ActojiDial", false) or false
        if ActojiData and ActojiData ~= "false" then self.table = util.JSONToTable(ActojiData) end
        if self.table[aN] then
            if Material(bF .. "/" .. self.table[aN], "noclamp smooth"):IsError() then
                ActojiData_1 = Material(bF .. "/" .. A_AM.ActMod.AGetDitN[aN], "noclamp smooth")
                ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
                self.table[aN] = A_AM.ActMod.AGetDitN[aN]
                LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
            else
                ActojiData_1 = Material(bF .. "/" .. self.table[aN], "noclamp smooth")
                ActojiData_2 = self.table[aN]
            end
        else
            ActojiData_1 = Material(bF .. "/" .. A_AM.ActMod.AGetDitN[aN], "noclamp smooth")
            ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
            self.table[aN] = A_AM.ActMod.AGetDitN[aN]
            LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
        end

        e.Material = ActojiData_1
        e.Actoji = ActojiData_2
        e.TActoji = ActojiData_2
        e.N__i = 0
        ActojiData = nil
        ActojiData_1 = nil
        ActojiData_2 = nil
        if GetConVar("actmod_sv_avs"):GetInt() > 0 then
            timer.Simple(0.1, function()
                if IsValid(ply) and IsValid(e) then
                    if A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(e.Actoji)) == true then
                        e.GLok = true
                    else
                        e.GLok = false
                    end
                end
            end)
        end

        e.DoClick = function(s)
            if not s.Actoji then return end
            surface.PlaySound("garrysmod/ui_click.wav")
            if aba.GTTebl_n > 1 and e.N__i < aba.GTTebl_n then
                e.N__i = e.N__i + 1
            elseif e.N__i >= aba.GTTebl_n or e.N__i == 0 then
                e.N__i = 1
            end

            self.table[aN] = aba.GTTebl_i[e.N__i]
            LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
            e.Material = Material(bF .. "/" .. self.table[aN], "noclamp smooth")
            e.Actoji = self.table[aN]
        end

        e.DoRightClick = function(s)
            surface.PlaySound("garrysmod/ui_return.wav")
            self.table[aN] = e.TActoji
            LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
            e.Material = Material(bF .. "/" .. self.table[aN], "noclamp smooth")
            e.Actoji = self.table[aN]
        end

        e.b = false
        e.a = true
        e:SetSize(BZz, BZz)
        local x, y
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            x, y = a, aa
        else
            x, y = getIntercept(vCs:GetWide() / 2, vCs:GetTall() / 2, vCs:GetWide() / 3, a, e:GetWide() / 2, e:GetTall() / 2)
        end

        e:SetSize(BZz, BZz)
        e:SizeTo(BZz, BZz, aO, 0, -1, function(t, s) s.a = false end)
        e:SetPos(x + 5, y + 5)
        e:MoveTo(x, y, aO)
        e.posX = x
        e.posY = y
        e.Think = function(s)
            if s:IsHovered() then
                if s.a or e.b then return end
                s.a = true
                s:AlphaTo(255, aS)
                es:AlphaTo(255, aS)
                s:MoveTo(s.posX - (aSi / 2), s.posY - (aSi / 2), aS)
                es:MoveTo(s.posX - (aSi2 / 2), s.posY - (aSi2 / 2), aS)
                s:SizeTo(BZz + aSi, BZz + aSi, aS, 0, -1, function(t, s)
                    s.a = false
                    s.b = true
                end)

                es:SizeTo(BZz + aSi2, BZz + aSi2, aS, 0, -1, function(t, s)
                    s.a = false
                    s.b = true
                end)
            else
                if s.a or not s.b then return end
                s.a = true
                s:AlphaTo(180, aS)
                es:AlphaTo(0, aS)
                s:MoveTo(s.posX, s.posY, aS)
                es:MoveTo(s.posX, s.posY, aS)
                s:SizeTo(BZz, BZz, aS, 0, -1, function(t, s)
                    s.a = false
                    s.b = false
                end)

                es:SizeTo(BZz, BZz, aS, 0, -1, function(t, s)
                    s.a = false
                    s.b = false
                end)
            end
        end

        e.Paint = function(s, w, h)
            if not s.Material then return end
            surface.SetDrawColor(color_white)
            surface.SetMaterial(s.Material)
            if s:IsHovered() then
                if IsValid(aba) then
                    aba.Afh_atrue = CurTime() + 0.11
                    if aba.Afh_StPos then
                        aba.Afh_StPos[1] = Lerp(0.2, aba.Afh_StPos[1], s:GetX() + s:GetWide() / 2)
                        aba.Afh_StPos[2] = Lerp(0.2, aba.Afh_StPos[2], s:GetY() + s:GetTall() / 2)
                    else
                        aba.Afh_StPos = {s:GetX() + s:GetWide() / 2, s:GetY() + s:GetTall() / 2}
                    end
                end

                local asc = 5 + (5 * math.sin(CurTime() * 4))
                surface.DrawTexturedRect(asc / 2, asc / 2, w - asc, h - asc)
            else
                surface.DrawTexturedRect(0, 0, w, h)
            end
        end
        return e
    end

    local function Siqit(plst, data, NIi)
        local GBse, Gzz = plst, 50
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            local GTup = 20
            local Ms = 20
            local GTdo = plst:GetTall() - 70
            aMeBu(20, GTup, GBse, Gzz, 9)
            aMeBu(55 + Ms, GTup, GBse, Gzz, 10)
            aMeBu(85 + Ms * 2, GTup, GBse, Gzz, 11)
            aMeBu(120 + Ms * 3, GTup, GBse, Gzz, 12)
            aMeBu(20, GTdo, GBse, Gzz, 13)
            aMeBu(55 + Ms, GTdo, GBse, Gzz, 14)
            aMeBu(85 + Ms * 2, GTdo, GBse, Gzz, 15)
            aMeBu(120 + Ms * 3, GTdo, GBse, Gzz, 16)
            GTup = nil
            Ms = nil
            GTdo = nil
        else
            local pi = 3.14159265
            local pr = 8.13
            aMeBu(0, nil, GBse, Gzz, 1)
            aMeBu(pi / 4, nil, GBse, Gzz, 2)
            aMeBu(pi / 2, nil, GBse, Gzz, 3)
            aMeBu(pi - pi / 4, nil, GBse, Gzz, 4)
            aMeBu(pi, nil, GBse, Gzz, 5)
            aMeBu(pi + pi / 4, nil, GBse, Gzz, 6)
            aMeBu(pi * 1.5, nil, GBse, Gzz, 7)
            aMeBu(pi * 1.5 + pi / 4, nil, GBse, Gzz, 8)
            pi = nil
        end

        GTdo = nil
        GBse = nil
    end

    function A_AM.ActMod:Chicon(plist, NIi, fid)
        if IsValid(plist.aMh) then plist.aMh:Remove() end
        local bF = A_AM.ActMod.Settings["IconsActs"]
        plist.aMh = vgui.Create("DPanel")
        plist.aMh:SetSize(ScrW(), ScrH())
        plist.aMh:MakePopup()
        plist.aMh:SetText("")
        plist.aMh.taa = false
        plist.aMh.Paint = function(p, w, h)
            if p.taa == true and p:IsHovered() then
                if IsValid(p.AAW) then
                    p.AAW:Remove()
                    p:Remove()
                end
            end
        end

        plist.aMh.AAW = vgui.Create("DPanel", plist.aMh)
        plist.aMh.AAW:MakePopup()
        plist.aMh.AAW.OnRemove = function(pan) if IsValid(plist.aMh) then plist.aMh:Remove() end end
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            plist.aMh.AAW:SetSize(250, 230)
            plist.aMh.AAW.AT = 2
        else
            plist.aMh.AAW:SetSize(250, 250)
            plist.aMh.AAW.AT = 1
        end

        plist.aMh.AAW:SetText("")
        plist.aMh.AAW:SetAlpha(0)
        plist.aMh.AAW:AlphaTo(255, 0.1, 0, function(s) if IsValid(plist.aMh) then plist.aMh.taa = true end end)
        plist.aMh.AAW:SetPos(gui.MouseX() - plist.aMh.AAW:GetWide() / 2, gui.MouseY() - plist.aMh.AAW:GetTall() / 2)
        if file.Exists("materials/actmod/imenu/arrow.png", "GAME") then
            plist.aMh.AAW.m_arrow = "actmod/imenu/arrow.png"
        else
            plist.aMh.AAW.m_arrow = "gui/arrow"
        end

        local GTTebl_i = {}
        local GTTebl_n = 0
        for k, v in pairs(file.Find("materials/" .. bF .. "/" .. ReString(NIi) .. "*", "GAME")) do
            if string.find(string.sub(v, -4, -1), ".png") then
                table.insert(GTTebl_i, v)
                GTTebl_n = GTTebl_n + 1
            end
        end

        plist.aMh.AAW.GTTebl_i = GTTebl_i
        plist.aMh.AAW.GTTebl_n = GTTebl_n
        plist.aMh.AAW.Afh_a = 0
        plist.aMh.AAW.Afh_atrue = CurTime()
        plist.aMh.AAW.aNIi = NIi
        plist.aMh.AAW.Paint = function(s, w, h)
            if s.Afh_atrue > CurTime() then
                if s.Afh_a < 255 then s.Afh_a = math.min(255, s.Afh_a + 800 * FrameTime()) end
            else
                if s.Afh_a > 0 then s.Afh_a = math.max(0, s.Afh_a - 1000 * FrameTime()) end
            end

            if s.AT == 1 then
                draw.RoundedBox(h / 2, 0, 0, w, h, Color(150, 150, 50, 100))
                draw.RoundedBox(h / 2 - 10, 10, 10, w - 20, h - 20, Color(50, 255, 255, 100))
            else
                draw.RoundedBox(30, 0, 0, w, h, Color(150, 150, 50, 100))
                draw.RoundedBox(30 - 10, 10, 10, w - 20, h - 20, Color(50, 255, 255, 100))
            end

            surface.SetDrawColor(Color(255, 255, 255, 255))
            if fid then
                surface.SetMaterial(Material(bF .. "/" .. plist.aMh.AAW.GTTebl_i[1], "noclamp smooth"))
            else
                surface.SetMaterial(Material(bF .. "/" .. NIi .. ".png", "noclamp smooth"))
            end

            surface.DrawTexturedRect(w / 2 - 30, h / 2 - 30, 60, 60)
            local centerX, centerY = w / 2, h / 2
            local angle
            if s.Afh_StPos then
                angle = math.pi - math.atan2(centerY - s.Afh_StPos[2], centerX - s.Afh_StPos[1])
            else
                local mouseX, mouseY = s:LocalCursorPos()
                angle = math.pi - math.atan2(centerY - mouseY, centerX - mouseX)
            end

            local deg = math.deg(angle) - 90
            surface.SetDrawColor(Color(255, 255, 255, math.max(0, math.min(255, s.Afh_a + (s.Afh_a * math.sin(CurTime() * 7))))))
            surface.SetMaterial(Material(s.m_arrow, "noclamp smooth"))
            surface.DrawTexturedRectRotated(centerX, centerY, 50, 50, deg)
        end

        GTTebl_i = nil
        GTTebl_n = nil
        Siqit(plist.aMh.AAW)
        return plist.aMh
    end
end