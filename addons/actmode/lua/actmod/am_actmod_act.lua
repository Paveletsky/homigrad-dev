A_AM.ActMod.LuaAct = true
local function AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
    if SERVER then
        net.Start("A_AM.ActMod.AddMdl")
        net.WriteEntity(ply)
        net.WriteString(Strg)
        net.WriteTable(Tmd1)
        net.WriteTable(Tmd2)
        net.WriteTable(Tmd3)
        net.WriteTable(Tmd4)
        net.Broadcast()
    else
        A_AM.ActMod:AddCrMdl(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
    end
end

local function AA_AdModelRemov(ply, txt)
    if SERVER then
        net.Start("A_AM.ActMod.AddRemove")
        net.WriteEntity(ply)
        net.WriteString(txt)
        net.Broadcast()
    else
        A_AM.ActMod:RemoveCrMdl(ply, txt)
    end
end

function A_AM.ActMod:AA_AddModel(ply, strg, agin)
    local Strg = strg or ply:GetNWString("A_ActMod.Dir", "") or ""
    if string.find(string.sub(Strg, 0, 2), "f_") and not string.find(Strg, "amod") then Strg = string.Replace(Strg, "f_", "") end
    if timer.Exists("A_AM.Mdl_1" .. ply:EntIndex()) then timer.Remove("A_AM.Mdl_1" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Mdl_2" .. ply:EntIndex()) then timer.Remove("A_AM.Mdl_2" .. ply:EntIndex()) end
    local Tmd1 = {}
    local Tmd2 = {}
    local Tmd3 = {}
    local Tmd4 = {}
    local function CrMdl(ply, mdl_, mat_, UseAtta_, attm_, pos_, pfo_, prl_, pup_, ang_, anp_, any_, anr_, size_)
        local Tmdl = {}
        Tmdl["mdl"] = mdl_ or "models/props_junk/TrafficCone001a.mdl"
        Tmdl["Mat"] = mat_ or nil
        Tmdl["TypAtta"] = UseAtta_ or 1
        Tmdl["attm"] = attm_ or "ValveBiped.Bip01_R_Hand"
        Tmdl["pos"] = pos_ or Vector(0, 0, 0)
        Tmdl["pos_fo"], Tmdl["pos_ri"], Tmdl["pos_up"] = pfo_ or 0, prl_ or 0, pup_ or 0
        Tmdl["ang"] = ang_ or Angle(0, 0, 0)
        Tmdl["ang_p"], Tmdl["ang_y"], Tmdl["ang_r"] = anp_ or 0, any_ or 0, anr_ or 0
        Tmdl["size"] = size_ or 1
        return Tmdl
    end

    if Strg == "epic_sax_guy" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply, "models/actmod/mdl_sax.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, -1, -2, -18, nil, 0, -160, -190, 0.65) end
    elseif Strg == "rock_guitar" then
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply, "models/actmod/guitar_metal.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 2.5, 5, -2.5, nil, 70, 60, -16, 0.7) end
    elseif Strg == "glowstickdance" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply, "models/actmod/mdl_stick.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, 0, 1.4, 2, nil, 4, -75, 15, 0.8) end
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply, "models/actmod/mdl_stick.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 1, 1.4, -3.5, nil, 4, 75, 15, 0.8) end
    elseif Strg == "cheerleader" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply, "models/actmod/mdl_shrub.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, 0, 2, 3, nil, 0, 90, 0, 0.4) end
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply, "models/actmod/mdl_shrub.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 0, 2, 3, nil, 0, 90, 0, 0.4) end
    elseif Strg == "touchdown_dance" then
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then
            Tmd1 = CrMdl(ply, "models/actmod/mdl_afootball.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 5, 3, -5, nil, 0, 0, 0, 1)
            timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.935, 1, function()
                if IsValid(ply) then
                    local ef_ = EffectData()
                    ef_:SetOrigin(ply:GetPos() + ply:GetForward() * 15 + ply:GetRight() * 5 + ply:GetUp() * 5)
                    util.Effect("am_f_toudo_dance", ef_, true, true)
                    AA_AdModelRemov(ply, "mdl1")
                end
            end)
        end
    elseif Strg == "cowbell" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply, "models/props_phx/misc/potato_launcher.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, 3, 1, -15, nil, 0, 20, 0, 0.15) end
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply, "models/props_phx/wheelaxis.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 3.5, 2, -0.5, nil, 0, -10, -0, 0.35) end
    elseif Strg == "make_it_rain_v2" then
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then
            if agin then
                Tmd1 = CrMdl(ply, "models/actmod/Money_v2.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 4.5, 0, 1.5, nil, 80, 15, 5, 1)
            else
                timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.25, 1, function()
                    if IsValid(ply) then
                        Tmd1 = CrMdl(ply, "models/actmod/Money_v2.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 4.5, 0, 1.5, nil, 80, 15, 5, 1)
                        AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
                    end
                end)
            end
        end
    elseif Strg == "guitar_walk" then
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply, "models/actmod/guitar_metal.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 1.8, 5, -2.5, nil, 50, 60, -46, 0.7) end
    elseif Strg == "amod_fortnite_marionette1" then
        if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply, "models/gh3pack/guitar1.mdl", nil, 3, "ValveBiped.Bip01_L_Hand", nil, 10.5, 20, 1.5, nil, 45, 15, -46, 1.0) end
    elseif Strg == "amod_fortnite_cerealbox" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then
            if agin then
                Tmd1 = CrMdl(ply, "models/actmod/chocorings.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, 1.6, 5, -7.5, nil, 0, 0, 20, 0.5)
            else
                timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.4, 1, function()
                    if IsValid(ply) then
                        Tmd1 = CrMdl(ply, "models/actmod/chocorings.mdl", nil, 0, "", nil, 22, -16, -22.5, nil, 90, 0, 90, 0.5)
                        AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
                        timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 1.08, 1, function()
                            if IsValid(ply) then
                                Tmd1 = CrMdl(ply, "models/actmod/chocorings.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, 1.6, 5, -7.5, nil, 0, 0, 20, 0.5)
                                AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
                            end
                        end)
                    end
                end)
            end
        end
    elseif Strg == "amod_fortnite_cyclone" then
        if ply:LookupBone("ValveBiped.Bip01_R_Hand") then
            Tmd1 = CrMdl(ply, "models/actmod/mic.mdl", nil, 3, "ValveBiped.Bip01_R_Hand", nil, -3.5, -1.5, -10, nil, -10, 201, 0, 0.9)
            timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.5, 0, function() if IsValid(ply) then AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4) end end)
        end
    elseif Strg == "amod_fortnite_indigoapple" then
        if ply:LookupBone("ValveBiped.Bip01_Head1") then
            timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 8.1, 1, function()
                if IsValid(ply) then
                    local pos_, px, py, pz = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1")), 20, 10, 10
                    local ef_ = EffectData()
                    ef_:SetOrigin(pos_ + ply:GetForward() * px + ply:GetRight() * py + ply:GetUp() * pz)
                    util.Effect("am_f_poki_e1", ef_, true, true)
                    timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.2, 1, function()
                        if IsValid(ply) then
                            local pos_, px, py, pz = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1")), 20, 10, 10
                            local ef_ = EffectData()
                            ef_:SetOrigin(pos_ + ply:GetForward() * px + ply:GetRight() * py + ply:GetUp() * pz)
                            util.Effect("am_f_poki_e3", ef_, true, true)
                            Tmd1 = CrMdl(ply, "models/actmod/iphone_v1.mdl", nil, 3, "ValveBiped.Bip01_Head1", nil, pz - py * 2, px, py, nil, 0, -90, 0, 1)
                            AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4)
                            timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.65, 1, function()
                                if IsValid(ply) then
                                    local pos_, px, py, pz = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1")), 21, 10, 8.5
                                    local ef_ = EffectData()
                                    ef_:SetOrigin(pos_ + ply:GetForward() * px + ply:GetRight() * py + ply:GetUp() * pz)
                                    util.Effect("am_f_poki_e2", ef_, true, true)
                                    timer.Create("A_AM.Mdl_1" .. ply:EntIndex(), 0.5, 1, function() if IsValid(ply) then AA_AdModelRemov(ply, "mdl1") end end)
                                end
                            end)
                        end
                    end)
                end
            end)
        end
    end

    if Tmd1 or Tmd2 or Tmd3 or Tmd4 then AA_AdModelSet(ply, Strg, Tmd1, Tmd2, Tmd3, Tmd4) end
end

local function AA_AddEff(Gy, ply, txtP, txtB, s1, s2)
    local AdEff = ents.Create("info_particle_system")
    AdEff:SetKeyValue("effect_name", txtP)
    AdEff:SetPos(ply:GetBonePosition(txtB))
    AdEff:Spawn()
    AdEff:Activate()
    AdEff:Fire("Start", "", s1)
    AdEff:Fire("kill", 0, s2)
    ply:DeleteOnRemove(AdEff)
    ply.AAct_Eff[Gy]["ents"] = AdEff
    ply.AAct_Eff[Gy]["B_"] = txtB
    AdEff = nil
end

function A_AM.ActMod:AA_AddEffects(ply, agin, Strg)
    if timer.Exists("A_AM.Ef_1" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_1" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_2" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_2" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_3" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_3" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_4" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_4" .. ply:EntIndex()) end
    if Strg == "break_dance_v2" then
        if SERVER then
            local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Foot")
            local bone2 = ply:LookupBone("ValveBiped.Bip01_L_Foot")
            ply.AAct_Eff = {
                ["E1"] = {
                    ["ents"] = NULL,
                    ["B_"] = ""
                },
                ["E2"] = {
                    ["ents"] = NULL,
                    ["B_"] = ""
                },
                ["E3"] = {
                    ["ents"] = NULL,
                    ["B_"] = ""
                },
                ["E4"] = {
                    ["ents"] = NULL,
                    ["B_"] = ""
                }
            }

            if bone1 then
                AA_AddEff("E1", ply, "portal_1_projectile_3rdperson", bone1, 4, 5.2)
                AA_AddEff("E3", ply, "portal_1_projectile_ball", bone1, 2.4, 6)
            end

            if bone2 then
                AA_AddEff("E2", ply, "portal_2_projectile_3rdperson", bone2, 4, 5.2)
                AA_AddEff("E4", ply, "portal_2_projectile_ball", bone2, 1.7, 6)
            end
        end
    elseif Strg == "amod_pubg_tocatoca" then
        local function CrEff1(pos_)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_04_e4", ef_, true, true)
        end

        local function CrEff2(pos_)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_2cerealbox", ef_, true, true)
        end

        if agin then
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.3, 1, function()
                if IsValid(ply) then
                    local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_R_Hand"), ply:LookupBone("ValveBiped.Bip01_L_Hand")
                    if bone1 or bone2 then
                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0, 1, function()
                            if IsValid(ply) then
                                if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.4, 1, function() if IsValid(ply) then if bone2 then CrEff1(ply:GetBonePosition(bone2)) end end end)
                            end
                        end)

                        timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.8, 1, function()
                            if IsValid(ply) then
                                if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.4, 1, function() if IsValid(ply) then if bone2 then CrEff1(ply:GetBonePosition(bone2)) end end end)
                            end
                        end)
                    end
                end
            end)
        else
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.37, 1, function()
                if IsValid(ply) then
                    local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_R_Hand"), ply:LookupBone("ValveBiped.Bip01_L_Hand")
                    if bone1 or bone2 then
                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.8, 2, function()
                            if IsValid(ply) then
                                if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.4, 1, function() if IsValid(ply) then if bone2 then CrEff1(ply:GetBonePosition(bone2)) end end end)
                            end
                        end)
                    end

                    timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 15.25, 1, function()
                        if IsValid(ply) then
                            local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_R_Hand"), ply:LookupBone("ValveBiped.Bip01_L_Hand")
                            if bone1 or bone2 then
                                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.8, 2, function()
                                    if IsValid(ply) then
                                        if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                        timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.4, 1, function() if IsValid(ply) then if bone2 then CrEff1(ply:GetBonePosition(bone2)) end end end)
                                    end
                                end)
                            end
                        end
                    end)
                end
            end)
        end
    elseif Strg == "amod_fortnite_cerealbox" then
        local function CrEff1(pos_)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_1cerealbox", ef_, true, true)
        end

        local function CrEff2(pos_)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_2cerealbox", ef_, true, true)
        end

        if agin then
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.0, 1, function()
                if IsValid(ply) then
                    local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                    if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.1, 9, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 6 + ply:GetRight() * -9) end end end) end
                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 1.0, 1, function()
                        if IsValid(ply) then
                            local bone1 = ply:LookupBone("ValveBiped.Bip01_Head1")
                            if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.4, 3, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 5 + ply:GetUp() * -3) end end end) end
                            timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 2.5, 1, function()
                                if IsValid(ply) then
                                    local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                    if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.1, 13, function() if IsValid(ply) then if bone1 then CrEff2(ply:GetBonePosition(bone1) + ply:GetForward() * 4 + ply:GetRight() * -5 + ply:GetUp() * 8) end end end) end
                                end
                            end)
                        end
                    end)
                end
            end)
        else
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.32, 1, function()
                if IsValid(ply) then
                    local ef_ = EffectData()
                    ef_:SetOrigin(ply:GetBonePosition(0) + ply:GetForward() * 16 + ply:GetRight() * 22 + Vector(0, 0, 16))
                    util.Effect("am_f_cerealbox", ef_, true, true)
                    timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.23, 1, function()
                        if IsValid(ply) then
                            local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                            if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.1, 9, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 6 + ply:GetRight() * -9) end end end) end
                            timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 1.0, 1, function()
                                if IsValid(ply) then
                                    local bone1 = ply:LookupBone("ValveBiped.Bip01_Head1")
                                    if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.4, 3, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 5 + ply:GetUp() * -3) end end end) end
                                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 2.5, 1, function()
                                        if IsValid(ply) then
                                            local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                            if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.1, 13, function() if IsValid(ply) then if bone1 then CrEff2(ply:GetBonePosition(bone1) + ply:GetForward() * 4 + ply:GetRight() * -5 + ply:GetUp() * 8) end end end) end
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                end
            end)
        end
    elseif Strg == "electroshuffle2" then
        local function CrEff1(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_elecfle2_01", ef_, true, true)
        end

        local function CrEff2(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_elecfle2_03", ef_, true, true)
        end

        local function CrEff3(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_elecfle2_02", ef_, true, true)
        end

        local re_1 = false
        local function CrSav1(pos_, neff)
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0, 1, function()
                if IsValid(ply) then
                    local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Foot"), ply:LookupBone("ValveBiped.Bip01_R_Foot")
                    if bone1 or bone2 then
                        timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.12, 1, function()
                            if IsValid(ply) then
                                if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                            end
                        end)
                    end

                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.12, 1, function()
                        if IsValid(ply) then
                            local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Foot")
                            if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.5, 3, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1)) end end end) end
                            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.96, 1, function()
                                if IsValid(ply) then
                                    local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Foot")
                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.45, 1, function()
                                        if IsValid(ply) then
                                            local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Foot")
                                            if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                            timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.05, 1, function()
                                                if IsValid(ply) then
                                                    local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Foot")
                                                    if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.45, 2, function() if IsValid(ply) then if bone1 then CrEff1(ply:GetBonePosition(bone1)) end end end) end
                                                    timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.8, 1, function()
                                                        if IsValid(ply) then
                                                            local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                            if bone1 or bone2 then
                                                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.03, 50, function()
                                                                    if IsValid(ply) then
                                                                        if bone1 then CrEff3(ply:GetBonePosition(bone1)) end
                                                                        if bone2 then CrEff3(ply:GetBonePosition(bone2)) end
                                                                    end
                                                                end)
                                                            end
                                                        end
                                                    end)

                                                    timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 1.5, 1, function()
                                                        if IsValid(ply) then
                                                            local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                            if bone1 or bone2 then
                                                                timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.03, 15, function()
                                                                    if IsValid(ply) then
                                                                        if bone1 then CrEff2(ply:GetBonePosition(bone1)) end
                                                                        if bone2 then CrEff2(ply:GetBonePosition(bone2)) end
                                                                    end
                                                                end)
                                                            end
                                                        end
                                                    end)

                                                    timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.48, 1, function()
                                                        if IsValid(ply) then
                                                            local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Foot"), ply:LookupBone("ValveBiped.Bip01_R_Foot")
                                                            if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                            if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                                            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.8, 1, function()
                                                                if IsValid(ply) then
                                                                    local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Foot"), ply:LookupBone("ValveBiped.Bip01_R_Foot")
                                                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                                    if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                                                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.46, 1, function()
                                                                        if IsValid(ply) then
                                                                            local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Foot")
                                                                            if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                                            timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.07, 1, function()
                                                                                if IsValid(ply) then
                                                                                    local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Foot")
                                                                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                                                    timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.53, 1, function()
                                                                                        if IsValid(ply) then
                                                                                            local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Foot"), ply:LookupBone("ValveBiped.Bip01_R_Foot")
                                                                                            if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                                                            if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                                                                            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 2.0, 1, function()
                                                                                                if IsValid(ply) and re_1 == false then
                                                                                                    re_1 = true
                                                                                                    CrSav1()
                                                                                                end
                                                                                            end)
                                                                                        end
                                                                                    end)
                                                                                end
                                                                            end)
                                                                        end
                                                                    end)
                                                                end
                                                            end)
                                                        end
                                                    end)
                                                end
                                            end)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                end
            end)
        end

        CrSav1()
    elseif Strg == "kpop_02" then
        local function CrEff1(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_02_e1", ef_, true, true)
        end

        local function CrEff2(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_02_e2", ef_, true, true)
        end

        local function CrEff3(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_02_e3", ef_, true, true)
        end

        timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.7, 1, function()
            if IsValid(ply) then
                local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                if bone1 or bone2 then
                    timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.03, 8, function()
                        if IsValid(ply) then
                            if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                            if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                        end
                    end)
                end

                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 3.6, 1, function()
                    if IsValid(ply) then
                        local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                        if bone1 or bone2 then
                            timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.03, 40, function()
                                if IsValid(ply) then
                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                    if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                end
                            end)
                        end

                        timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 1.2, 1, function()
                            if IsValid(ply) then
                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                if bone1 then timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.03, 20, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.5, 1, function()
                                    if IsValid(ply) then
                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                        if bone1 then CrEff2(ply:GetBonePosition(bone1) + ply:GetUp() * -3) end
                                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 1.17, 1, function()
                                            if IsValid(ply) then
                                                local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                if bone1 or bone2 then
                                                    timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 35, function()
                                                        if IsValid(ply) then
                                                            if bone1 then CrEff3(ply:GetBonePosition(bone1)) end
                                                            if bone2 then CrEff3(ply:GetBonePosition(bone2)) end
                                                        end
                                                    end)
                                                end
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end
        end)
    elseif Strg == "kpop_04" then
        local function CrEff1(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_04_e1", ef_, true, true)
        end

        local function CrEff2(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_04_e2", ef_, true, true)
        end

        local function CrEff3(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_04_e3", ef_, true, true)
        end

        local function CrEff4(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_kpop_04_e4", ef_, true, true)
        end

        timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.2, 1, function()
            if IsValid(ply) then
                local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.03, 14, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.7, 1, function()
                    if IsValid(ply) then
                        local bone2 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                        if bone2 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.03, 20, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone2)) end end) end
                        timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.2, 1, function()
                            if IsValid(ply) then
                                local bone1 = ply:LookupBone("ValveBiped.Bip01_Head1")
                                if bone1 then CrEff2(ply:GetBonePosition(bone1) + Vector(0, 0, 25)) end
                                timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.4, 1, function()
                                    if IsValid(ply) then
                                        local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                        if bone1 or bone2 then
                                            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.03, 15, function()
                                                if IsValid(ply) then
                                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                    if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                                end
                                            end)
                                        end

                                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 2.03, 1, function()
                                            if IsValid(ply) then
                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                if bone2 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.02, 15, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 1.1, 1, function()
                                                    if IsValid(ply) then
                                                        local bone1, bone2 = ply:LookupBone("ValveBiped.Bip01_L_Hand"), ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                        if bone1 or bone2 then
                                                            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.03, 10, function()
                                                                if IsValid(ply) then
                                                                    if bone1 then CrEff1(ply:GetBonePosition(bone1)) end
                                                                    if bone2 then CrEff1(ply:GetBonePosition(bone2)) end
                                                                end
                                                            end)
                                                        end

                                                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 1.7, 1, function()
                                                            if IsValid(ply) then
                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 85, function() if IsValid(ply) then CrEff3(ply:GetBonePosition(bone1)) end end) end
                                                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 1.3, 1, function()
                                                                    if timer.Exists("A_AM.Ef_2" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_2" .. ply:EntIndex()) end
                                                                    if IsValid(ply) then
                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                        if bone1 then CrEff4(ply:GetBonePosition(bone1) + ply:GetUp() * 5) end
                                                                    end
                                                                end)
                                                            end
                                                        end)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end
        end)
    elseif Strg == "make_it_rain_v2" then
        local function CrEff1(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_make_rain_v2", ef_, true, true)
        end

        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
        if agin then
            if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.15, 17, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 1 + ply:GetRight() * 4 + ply:GetUp() * 8) end end) end
        else
            timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.6, 1, function() if IsValid(ply) then if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.15, 20, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1) + ply:GetForward() * 3 + ply:GetRight() * 5 + ply:GetUp() * 10) end end) end end end)
        end
    elseif Strg == "cheerleader" then
        local function CrEff1(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_chelead_e1", ef_, true, true)
        end

        local function CrEff2(pos_, neff)
            local ef_ = EffectData()
            ef_:SetOrigin(pos_)
            util.Effect("am_f_chelead_e2", ef_, true, true)
        end

        timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.5, 1, function()
            if IsValid(ply) then
                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                if bone1 then timer.Create("A_AM.Ef_1" .. ply:EntIndex(), 0.01, 10, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.5, 1, function()
                    if IsValid(ply) then
                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                        if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 15, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                        timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.4, 1, function()
                            if IsValid(ply) then
                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                if bone1 then timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.01, 7, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.3, 1, function()
                                    if IsValid(ply) then
                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                        if bone1 then timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.01, 10, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.5, 1, function()
                                            if IsValid(ply) then
                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 10, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.3, 1, function()
                                                    if IsValid(ply) then
                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                        if bone1 then timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.01, 10, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                        timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.3, 1, function()
                                                            if IsValid(ply) then
                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                if bone1 then timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.01, 15, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.1, 1, function()
                                                                    if IsValid(ply) then
                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                                        if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 15, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                        timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.6, 1, function()
                                                                            if IsValid(ply) then
                                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                                if bone1 then timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.01, 20, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.1, 1, function()
                                                                                    if IsValid(ply) then
                                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                                                        if bone1 then timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.01, 20, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                        timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 1.8, 1, function()
                                                                                            if IsValid(ply) then
                                                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                                                if bone1 then timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.04, 60, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.1, 1, function()
                                                                                                    if IsValid(ply) then
                                                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                                                                        if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.04, 60, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                                        timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 1.5, 1, function()
                                                                                                            if IsValid(ply) then
                                                                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                                                                if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.04, 40, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                                                timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.1, 1, function()
                                                                                                                    if IsValid(ply) then
                                                                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                                                                                        if bone1 then timer.Create("A_AM.Ef_3" .. ply:EntIndex(), 0.04, 40, function() if IsValid(ply) then CrEff1(ply:GetBonePosition(bone1)) end end) end
                                                                                                                        timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 2.9, 1, function()
                                                                                                                            if IsValid(ply) then
                                                                                                                                local bone1 = ply:LookupBone("ValveBiped.Bip01_R_Hand")
                                                                                                                                if bone1 then timer.Create("A_AM.Ef_4" .. ply:EntIndex(), 0.01, 20, function() if IsValid(ply) then CrEff2(ply:GetBonePosition(bone1)) end end) end
                                                                                                                                timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.1, 1, function()
                                                                                                                                    if IsValid(ply) then
                                                                                                                                        local bone1 = ply:LookupBone("ValveBiped.Bip01_L_Hand")
                                                                                                                                        if bone1 then timer.Create("A_AM.Ef_2" .. ply:EntIndex(), 0.01, 20, function() if IsValid(ply) then CrEff2(ply:GetBonePosition(bone1)) end end) end
                                                                                                                                    end
                                                                                                                                end)
                                                                                                                            end
                                                                                                                        end)
                                                                                                                    end
                                                                                                                end)
                                                                                                            end
                                                                                                        end)
                                                                                                    end
                                                                                                end)
                                                                                            end
                                                                                        end)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        end)
                                                                    end
                                                                end)
                                                            end
                                                        end)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

local ActMod_GNameSAlow = {"f_blow_kiss", "f_bring_it_on", "f_celebration", "f_chug", "f_confused", "f_dust_off_shoulders", "f_facepalm", "f_flex", "f_golfclap", "f_i_break_you", "f_tpose", "f_heelclick", "f_fistpump_celebration", "f_hotstuff", "f_salute", "f_snap", "f_timeout", "f_acrobatic_superhero", "f_idontknow", "f_kitty_cat", "f_mind_blown", "f_shaolin", "f_wackyinflatable", "f_yayexcited", "amod_fortnite_spectacleweb"}
A_AM.ActMod.GTabSd_WOS_F = {
    ["thumbsup"] = {{"actmod/crowd/crowd_kansei_l.wav"}, 2},
    ["thumbsdown"] = {{"actmod/crowd/crowd_doyomeki_m.wav"}, 2},
    ["bbd"] = {{"actmod/i_act/fortnite/f_bbd.mp3"}},
    ["chicken_moves"] = {{"actmod/i_act/fortnite/f_chicken_moves.mp3"}},
    ["crab_dance"] = {{"actmod/i_act/fortnite/f_crab_dance.mp3"}},
    ["dance_off"] = {{"actmod/i_act/fortnite/f_dance_off.mp3"}},
    ["electroswing"] = {{"actmod/i_act/fortnite/f_electroswing.mp3"}},
    ["flossdance"] = {{"actmod/i_act/fortnite/f_flossdance.mp3"}},
    ["fresh"] = {{"actmod/i_act/fortnite/f_fresh.mp3"}},
    ["glowstickdance"] = {{"actmod/i_act/fortnite/f_glowstickdance.mp3"}},
    ["jaywalk"] = {{"actmod/i_act/fortnite/f_jaywalk.mp3"}},
    ["make_it_rain_v2"] = {{"actmod/i_act/fortnite/f_make_it_rain_v2.mp3"}, 0.4, {"actmod/i_act/fortnite/f_make_it_rain_v2.mp3"}},
    ["mello"] = {{"actmod/i_act/fortnite/f_mello.mp3"}},
    ["mime"] = {{"actmod/i_act/fortnite/f_mime.mp3"}},
    ["og_runningman"] = {{"actmod/i_act/fortnite/f_og_runningman.mp3"}},
    ["security_guard"] = {{"actmod/i_act/fortnite/f_security_guard.mp3"}},
    ["twist"] = {{"actmod/i_act/fortnite/f_twist.mp3"}},
    ["windmillfloss"] = {{"actmod/i_act/fortnite/f_windmillfloss.mp3"}},
    ["bendi"] = {{"actmod/i_act/fortnite/f_bendi.mp3"}},
    ["crackshot"] = {{"actmod/i_act/fortnite/f_crackshot.mp3"}},
    ["dance_shoot"] = {{"actmod/i_act/fortnite/f_dance_shoot.mp3"}},
    ["dancing_girl"] = {{"actmod/i_act/fortnite/f_dancing_girl.mp3"}},
    ["kpop_02"] = {{"actmod/i_act/fortnite/f_kpop_02.mp3"}},
    ["kpop_03"] = {{"actmod/i_act/fortnite/f_kpop_03.mp3"}},
    ["kpop_04"] = {{"actmod/i_act/fortnite/f_kpop_04.mp3"}},
    ["technozombie"] = {{"actmod/i_act/fortnite/f_technozombie.mp3"}},
    ["conga"] = {{"actmod/i_act/fortnite/f_conga.mp3"}},
    ["rock_guitar"] = {{"actmod/i_act/fortnite/f_rock_guitar.mp3"}},
    ["robotdance"] = {{"actmod/i_act/fortnite/f_robotdance.mp3"}},
    ["bandofthefort"] = {{"actmod/i_act/fortnite/f_bandofthefort.mp3"}},
    ["treadmilldance"] = {{"actmod/i_act/fortnite/f_treadmilldance.mp3"}},
    ["break_dance"] = {{"actmod/i_act/fortnite/f_break_dance.mp3"}},
    ["break_dance_v2"] = {{"actmod/i_act/fortnite/f_break_dance_v2.mp3"}},
    ["dj_drop"] = {{"actmod/i_act/fortnite/f_dj_drop_p1.mp3"}, nil, {"actmod/i_act/fortnite/f_dj_drop_p2.mp3"}},
    ["boogie_down"] = {{"actmod/i_act/fortnite/f_boogie_down.mp3"}},
    ["cheerleader"] = {{"actmod/i_act/fortnite/f_cheerleader.mp3"}},
    ["cowbell"] = {{"actmod/i_act/fortnite/f_cowbell.mp3"}},
    ["dance_swipeit"] = {{"actmod/i_act/fortnite/f_dance_swipeit.mp3"}},
    ["groovejam"] = {{"actmod/i_act/fortnite/f_groovejam.mp3"}},
    ["hilowave"] = {{"actmod/i_act/fortnite/f_hilowave.mp3"}},
    ["hip_hop"] = {{"actmod/i_act/fortnite/f_hip_hop.mp3"}},
    ["hip_hop_s7"] = {{"actmod/i_act/fortnite/f_hip_hop_s7.mp3"}, nil, {"actmod/i_act/fortnite/f_hip_hop_s7_r.mp3"}},
    ["hiphop_01"] = {{"actmod/i_act/fortnite/f_hiphop_01.mp3"}},
    ["jammin"] = {{"actmod/i_act/fortnite/f_jammin.mp3"}},
    ["mask_off"] = {{"actmod/i_act/fortnite/f_mask_off.mp3"}},
    ["runningv3"] = {{"actmod/i_act/fortnite/f_runningv3.mp3"}},
    ["thighslapper"] = {{"actmod/i_act/fortnite/f_thighslapper_c1.mp3"}, nil, {"actmod/i_act/fortnite/f_thighslapper_c2.mp3"}},
    ["touchdown_dance"] = {{"actmod/i_act/fortnite/f_touchdown_dance.mp3"}},
    ["trex"] = {{"actmod/i_act/fortnite/f_trex.mp3"}},
    ["eastern_bloc"] = {{"actmod/i_act/fortnite/f_eastern_bloc.mp3"}},
    ["aerobicchamp"] = {{"actmod/i_act/fortnite/f_aerobicchamp.mp3"}},
    ["afrohouse"] = {{"actmod/i_act/fortnite/f_afrohouse.mp3"}},
    ["blow_kiss"] = {{"actmod/i_act/fortnite/f_blow_kiss.mp3"}},
    ["bring_it_on"] = {{"actmod/crowd/f_bring_it_on.mp3"}, 0.1},
    ["capoeira"] = {{"actmod/i_act/fortnite/f_capoeira_c1.mp3"}, nil, {"actmod/i_act/fortnite/f_capoeira_c2.mp3"}},
    ["celebration"] = {{"actmod/i_act/fortnite/f_celebration.mp3"}},
    ["charleston"] = {{"actmod/i_act/fortnite/f_charleston.mp3"}},
    ["chicken"] = {{"actmod/i_act/fortnite/f_chicken.mp3"}},
    ["chug"] = {{"actmod/i_act/fortnite/f_chug.mp3"}},
    ["confused"] = {{"actmod/i_act/fortnite/f_confused.mp3"}},
    ["crazyfeet"] = {{"actmod/i_act/fortnite/f_crazyfeet.mp3"}},
    ["cross_legs"] = {{"actmod/i_act/fortnite/f_cross_legs.mp3"}},
    ["dance_disco_t3"] = {{"actmod/i_act/fortnite/f_dance_disco_t3.mp3"}},
    ["disagree"] = {{"actmod/i_act/fortnite/f_disagree.mp3"}},
    ["dust_off_shoulders"] = {{"actmod/i_act/fortnite/f_dust_off_shoulders.mp3"}},
    ["facepalm"] = {{"actmod/i_act/fortnite/f_facepalm.mp3"}, 0.38},
    ["fancyfeet"] = {{"actmod/i_act/fortnite/f_fancyfeet.mp3"}},
    ["koreaneagle"] = {{"actmod/i_act/fortnite/f_koreaneagle.mp3"}},
    ["loser_dance"] = {{"actmod/i_act/fortnite/f_loser_dance.mp3"}},
    ["flex"] = {{"actmod/i_act/fortnite/f_flex_s1.mp3", "actmod/i_act/fortnite/f_flex_s2.mp3"}, 0.5},
    ["heelclick"] = {{"actmod/i_act/fortnite/f_heelclick_s1.mp3", "actmod/i_act/fortnite/f_heelclick_s1.mp3"}, 0.1},
    ["flamenco"] = {{"actmod/i_act/fortnite/f_flamenco_c1.mp3"}, nil, {"actmod/i_act/fortnite/f_flamenco_c2.mp3"}},
    ["hula"] = {{"actmod/i_act/fortnite/f_hula.mp3"}},
    ["flippnsexy"] = {{"actmod/i_act/fortnite/f_flippnsexy.mp3"}, 0.3},
    ["headbanger"] = {{"actmod/i_act/fortnite/f_headbanger.mp3"}},
    ["headbanger"] = {{"actmod/i_act/fortnite/f_headbanger.mp3"}},
    ["infinidab"] = {{"actmod/i_act/fortnite/f_infinidab.mp3"}},
    ["golfclap"] = {{"actmod/i_act/fortnite/f_golfclap.mp3"}},
    ["i_break_you"] = {{"actmod/i_act/fortnite/f_i_break_you.mp3"}},
    ["look_at_this"] = {{"actmod/i_act/fortnite/f_look_at_this.mp3"}},
    ["livinglarge"] = {{"actmod/i_act/fortnite/f_livinglarge.mp3"}},
    ["irishjig"] = {{"actmod/i_act/fortnite/f_irishjig.mp3"}},
    ["poplock"] = {{"actmod/i_act/fortnite/f_poplock.mp3"}},
    ["pump_dance"] = {{"actmod/i_act/fortnite/f_pump_dance.mp3"}},
    ["stagebow"] = {{"actmod/i_act/fortnite/f_stagebow.mp3"}},
    ["smooth_ride"] = {{"actmod/i_act/fortnite/f_smooth_ride.mp3"}},
    ["taichi"] = {{"actmod/i_act/fortnite/f_taichi.mp3"}},
    ["tpose"] = {{"actmod/i_act/fortnite/f_tpose.mp3"}},
    ["zippy_dance"] = {{"actmod/i_act/fortnite/f_zippy_dance.mp3"}},
    ["fistpump_celebration"] = {{"actmod/i_act/fortnite/f_fistpump_celebration.mp3"}},
    ["hillbilly_shuffle"] = {{"actmod/i_act/fortnite/f_hillbilly_shuffle.mp3"}},
    ["hooked"] = {{"actmod/i_act/fortnite/f_hooked.mp3"}},
    ["hotstuff"] = {{"actmod/i_act/fortnite/f_hotstuff.mp3"}},
    ["luchador"] = {{"actmod/i_act/fortnite/f_luchador.mp3"}, 0.4},
    ["marat"] = {{"actmod/i_act/fortnite/f_marat.mp3"}},
    ["needtopee"] = {{"actmod/i_act/fortnite/f_needtopee.mp3"}},
    ["ridethepony"] = {{"actmod/i_act/fortnite/f_ridethepony.mp3"}},
    ["rocket_rodeo"] = {{"actmod/i_act/fortnite/f_rocket_rodeo.mp3"}},
    ["salt"] = {{"actmod/i_act/fortnite/f_salt.mp3"}},
    ["salute"] = {{"actmod/i_act/fortnite/f_salute.mp3"}, 0.5},
    ["showstopper_dance"] = {{"actmod/i_act/fortnite/f_showstopper_dance.mp3"}},
    ["snap"] = {{"actmod/i_act/fortnite/f_snap_s1.mp3", "actmod/i_act/fortnite/f_snap_s2.mp3"}},
    ["somethingstinks"] = {{"actmod/i_act/fortnite/f_somethingstinks.mp3"}},
    ["sparkles"] = {{"actmod/i_act/fortnite/f_sparkles.mp3"}},
    ["timeout"] = {{"actmod/i_act/fortnite/f_timeout.mp3"}},
    ["youre_awesome"] = {{"actmod/i_act/fortnite/f_youre_awesome.mp3"}},
    ["acrobatic_superhero"] = {{"actmod/i_act/fortnite/f_acrobatic_superhero.mp3"}},
    ["idontknow"] = {{"actmod/i_act/fortnite/f_idontknow.mp3"}},
    ["kitty_cat"] = {{"actmod/i_act/fortnite/f_kitty_cat.mp3"}},
    ["mind_blown"] = {{"actmod/i_act/fortnite/f_mind_blown.mp3"}},
    ["shaolin"] = {{"actmod/i_act/fortnite/f_shaolin.mp3"}},
    ["armup"] = {{"actmod/i_act/fortnite/f_armup.mp3"}},
    ["cool_robot"] = {{"actmod/i_act/fortnite/f_cool_robot.mp3"}},
    ["cowboydance"] = {{"actmod/i_act/fortnite/f_cowboydance.mp3"}},
    ["funk_time"] = {{"actmod/i_act/fortnite/f_funk_time.mp3"}},
    ["head_bounce"] = {{"actmod/i_act/fortnite/f_head_bounce.mp3"}},
    ["jazz_dance"] = {{"actmod/i_act/fortnite/f_jazz_dance.mp3"}},
    ["octopus"] = {{"actmod/i_act/fortnite/f_octopus.mp3"}},
    ["running"] = {{"actmod/i_act/fortnite/f_running.mp3"}},
    ["sprinkler"] = {{"actmod/i_act/fortnite/f_sprinkler.mp3"}},
    ["wave_dance"] = {{"actmod/i_act/fortnite/f_wave_dance.mp3"}},
    ["thequicksweeper"] = {{"actmod/i_act/fortnite/f_thequicksweeper.mp3"}},
    ["electroshuffle2"] = {{"actmod/i_act/fortnite/f_electroshuffle2.mp3"}},
    ["indiadance"] = {{"actmod/i_act/fortnite/f_indiadance.mp3"}},
    ["kpop_dance03"] = {{"actmod/i_act/fortnite/f_kpop_dance03.mp3"}},
    ["swim_dance"] = {{"actmod/i_act/fortnite/f_swim_dance.mp3"}},
    ["wackyinflatable"] = {{"actmod/i_act/fortnite/f_wackyinflatable.mp3"}},
    ["yayexcited"] = {{"actmod/i_act/fortnite/f_yayexcited.mp3"}},
    ["floppy_dance"] = {{"actmod/i_act/fortnite/f_floppy_dance.mp3"}},
    ["doublesnap"] = {{"actmod/i_act/fortnite/f_doublesnap.mp3"}},
    ["dreamfeet"] = {{"actmod/i_act/fortnite/f_dreamfeet.mp3"}},
    ["gabby_hiphop"] = {{"actmod/i_act/fortnite/f_gabby_hiphop.mp3"}},
    ["sneaky"] = {{"actmod/i_act/fortnite/f_sneaky.mp3"}},
    ["hiptobesquare"] = {{"actmod/i_act/fortnite/f_hiptobesquare.mp3"}},
    ["guitar_walk"] = {{"actmod/i_act/fortnite/f_guitar_walk.mp3"}},
    ["take_the_w"] = {{"actmod/i_act/fortnite/f_take_the_w.mp3"}}
}

A_AM.ActMod.GTabSd_AM4_O = {
    ["amod_dance_gangnamstyle"] = {{"actmod/i_act/am4/amod_gangnamstyle_c1.mp3"}, nil, {"actmod/i_act/am4/amod_gangnamstyle_c2.mp3"}},
    ["amod_dance_macarena"] = {{"actmod/i_act/am4/amod_dance_macarena.mp3"}},
    ["amod_dance_california_girls"] = {{"actmod/i_act/am4/amod_dance_california_girls_s1.mp3"}, nil, {"actmod/i_act/am4/amod_dance_california_girls_s2.mp3"}},
    ["amod_am4_drliveseywalk_1"] = {{"actmod/i_act/am4/DrLiveseyWalk_loop3.mp3"}},
    ["amod_am4_drliveseywalk_2"] = {{"actmod/i_act/am4/DrLiveseyWalk_loop1.mp3"}},
    ["amod_am4_drliveseywalk_3"] = {{"actmod/i_act/am4/DrLiveseyWalk_loop2.mp3"}},
    ["amod_am4_levepalestina"] = {{"actmod/i_act/am4/amod_LF_1.mp3"}, nil, {"actmod/i_act/am4/amod_LF_2.mp3"}}
}

A_AM.ActMod.GTabSd_AM4_F = {
    ["amod_fortnite_nevergonna"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_nevergonna_s1.mp3"}, nil, {"actmod/i_act/am4/fortnite/amod_fortnite_nevergonna_s2.mp3"}},
    ["amod_fortnite_aloha"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_alohaa.mp3"}},
    ["amod_fortnite_dance_distraction"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_dance_distraction.mp3"}},
    ["amod_fortnite_behere"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_behere.mp3"}},
    ["amod_fortnite_littleegg"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_littleegg.mp3"}},
    ["amod_fortnite_lyrical"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_lyrical.mp3"}},
    ["amod_fortnite_ohana"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_ohana.mp3"}},
    ["amod_fortnite_prance"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_prance.mp3"}},
    ["amod_fortnite_realm"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_realm.mp3"}},
    ["amod_fortnite_sleek"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_sleek.mp3"}},
    ["amod_fortnite_spectacleweb"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_spectacleweb.mp3"}},
    ["amod_fortnite_tally"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_tally.mp3"}},
    ["amod_fortnite_tonal"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_tonal.mp3"}},
    ["amod_fortnite_zest"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_zest.mp3"}},
    ["amod_fortnite_sunlit"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_sunlit.mp3"}},
    ["amod_fortnite_marionette1"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_marionette.mp3"}},
    ["amod_fortnite_twistdaytona"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_twistdaytona.mp3"}},
    ["amod_fortnite_hotpink"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_hotpink.mp3"}},
    ["amod_fortnite_sunburstdance"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_sunburstdance.mp3"}},
    ["amod_fortnite_cyclone_headbang"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_cyclone_headbang.mp3"}},
    ["amod_fortnite_cyclone"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_cyclone.mp3"}},
    ["amod_fortnite_julybooks"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_julybooks.mp3"}},
    ["amod_fortnite_twistwasp"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_twistwasp.mp3"}},
    ["amod_fortnite_stringdance"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_stringdance.mp3"}},
    ["amod_fortnite_gasstation"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_gasstation.mp3"}},
    ["amod_fortnite_comrade"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_comrade.mp3"}},
    ["amod_fortnite_indigoapple"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_indigoapple.mp3"}},
    ["amod_fortnite_zebrascramble"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_zebrascramble.mp3"}},
    ["amod_fortnite_heavyroardance"] = {{"actmod/i_act/am4/fortnite/amod_fortnite_heavyroardance_L.mp3"}, 0.8, {"actmod/i_act/am4/fortnite/amod_fortnite_heavyroardance_L.mp3"}, nil, {"actmod/i_act/am4/fortnite/amod_fortnite_heavyroardance_i.mp3"}, 0.1}
}

A_AM.ActMod.GTabSd_AM4_P = {
    ["amod_pubg_samsara"] = {{"actmod/i_act/am4/pubg/amod_pubg_samsaraa.mp3"}, nil, {"actmod/i_act/am4/pubg/amod_pubg_samsara_loop.mp3"}},
    ["amod_pubg_victorydance102"] = {{"actmod/i_act/am4/pubg/amod_pubg_victorydance102.mp3"}, nil, {"actmod/i_act/am4/pubg/amod_pubg_victorydance102_loop.mp3"}},
    ["amod_pubg_victorydance99"] = {{"actmod/i_act/am4/pubg/amod_pubg_victorydance99.mp3"}, nil, {"actmod/i_act/am4/pubg/amod_pubg_victorydance99_loop.mp3"}},
    ["amod_pubg_seetinh"] = {{"actmod/i_act/am4/pubg/amod_pubg_seetinh.mp3"}},
    ["amod_pubg_bboombboom"] = {{"actmod/i_act/am4/pubg/amod_pubg_bboombboom.mp3"}},
    ["amod_pubg_victorydance60"] = {{"actmod/i_act/am4/pubg/amod_pubg_victorydance60.mp3"}},
    ["amod_pubg_2phuthon"] = {{"actmod/i_act/am4/pubg/amod_pubg_2phuthon.mp3"}},
    ["amod_pubg_tocatoca"] = {{"actmod/i_act/am4/pubg/amod_pubg_tocatoca_2.mp3"}, nil, {"actmod/i_act/am4/pubg/amod_pubg_tocatoca_b.mp3"}}
}

A_AM.ActMod.GTabSd_WOS_MMD = {
    ["original_dance1"] = {{"mmd/original_dance1.mp3"}},
    ["original_dance2"] = {{"mmd/original_dance2.mp3"}},
    ["original_dance3"] = {{"mmd/original_dance3.mp3"}},
    ["original_dance4"] = {{"mmd/original_dance4.mp3"}},
    ["original_dance5"] = {{"mmd/original_dance5.mp3"}},
    ["original_dance6"] = {{"mmd/original_dance6.mp3"}},
    ["original_dance7"] = {{"mmd/original_dance7.mp3"}},
    ["original_dance8"] = {{"mmd/original_dance8.mp3"}},
    ["original_dance9"] = {{"mmd/original_dance9.mp3"}},
    ["original_dance10"] = {{"mmd/original_dance10.mp3"}},
    ["original_dance11"] = {{"mmd/original_dance11.mp3"}},
    ["original_dance12"] = {{"mmd/original_dance12.mp3"}},
    ["original_dance13"] = {{"mmd/original_dance13.mp3"}},
    ["original_dance14"] = {{"mmd/original_dance14.mp3"}},
    ["original_dance15"] = {{"mmd/original_dance15.mp3"}},
    ["original_dance22"] = {{"mmd/original_dance18.mp3"}},
    ["original_dance23"] = {{"mmd/original_dance19.mp3"}},
    ["original_dance24"] = {{"mmd/original_dance20.mp3"}},
    ["original_dance25"] = {{"mmd/original_dance21.mp3"}},
    ["original_dance26"] = {{"mmd/original_dance22.mp3"}},
    ["original_dance27"] = {{"mmd/original_dance23.mp3"}},
    ["original_dance28"] = {{"mmd/original_dance24.mp3"}},
    ["original_dance29"] = {{"mmd/original_dance25.mp3"}},
    ["original_dance30"] = {{"mmd/original_dance26.mp3"}}
}

A_AM.ActMod.GTabSd_AM4_MMD = {
    ["amod_mmd_helltaker"] = {{"actmod/i_act/am4/mmd/amod_mmd_helltaker.mp3"}},
    ["amod_mmd_dance_nostalogic"] = {{"actmod/i_act/am4/mmd/amod_mmd_nostalogic.mp3"}},
    ["amod_mmd_dance_specialist"] = {{"actmod/i_act/am4/mmd/amod_mmd_specialist.mp3"}},
    ["amod_mmd_dance_daisukeevolution"] = {{"actmod/i_act/am4/mmd/amod_mmd_daisukeevolution.mp3"}},
    ["amod_mmd_dance_caramelldansen"] = {{"actmod/i_act/am4/mmd/amod_mmd_caramelldansen.mp3"}},
    ["amod_mmd_whistle"] = {{"actmod/i_act/am4/mmd/amod_mmd_whistle.mp3"}},
    ["amod_mmd_badbadwater"] = {{"actmod/i_act/am4/mmd/amod_mmd_badbadwater.mp3"}},
    ["amod_mmd_king_kanaria"] = {{"actmod/i_act/am4/mmd/amod_mmd_king_kanaria.mp3"}},
    ["amod_mmd_dance_tuni-kun"] = {{"actmod/i_act/am4/mmd/amod_mmd_dance_tuni-kun.mp3"}},
    ["amod_mmd_fiery_sarilang"] = {{"actmod/i_act/am4/mmd/amod_mmd_fiery_sarilang.mp3"}},
    ["amod_mmd_followtheleader"] = {{"actmod/i_act/am4/mmd/amod_mmd_followtheleader.mp3"}},
    ["amod_mmd_getdown"] = {{"actmod/i_act/am4/mmd/amod_mmd_getdown.mp3"}},
    ["amod_mmd_goodbyedeclaration"] = {{"actmod/i_act/am4/mmd/amod_mmd_goodbyedeclaration.mp3"}},
    ["amod_mmd_ponponpon"] = {{"actmod/i_act/am4/mmd/amod_mmd_ponponpon.mp3"}},
    ["amod_mmd_girls"] = {{"actmod/i_act/am4/mmd/amod_mmd_girls.mp3"}},
    ["amod_mmd_mrsaxobeat"] = {{"actmod/i_act/am4/mmd/amod_mmd_mrsaxobeat.mp3"}},
    ["amod_mmd_aoagoodluck"] = {{"actmod/i_act/am4/mmd/amod_mmd_aoagoodluck.mp3"}},
    ["amod_mmd_nyaarigato"] = {{"actmod/i_act/am4/mmd/amod_mmd_nyaarigato.mp3"}},
    ["amod_mmd_ghostdance"] = {{"actmod/i_act/am4/mmd/amod_mmd_ghostdance.mp3"}},
    ["amod_mmd_blablabla"] = {{"actmod/i_act/am4/mmd/amod_mmd_blablabla.mp3"}},
    ["amod_mmd_hiasobi"] = {{"actmod/i_act/am4/mmd/amod_mmd_hiasobi.mp3"}},
    ["amod_mmd_hiproll_loop"] = {{"actmod/i_act/am4/mmd/amod_mmd_hiproll_t2.mp3"}},
    ["amod_mmd_hiproll"] = {{"actmod/i_act/am4/mmd/amod_mmd_hiproll_t1.mp3"}},
    ["amod_mmd_chikichiki"] = {{"actmod/i_act/am4/mmd/amod_mmd_chikichiki.mp3"}},
    ["amod_mmd_caixukun"] = {{"actmod/i_act/am4/mmd/amod_mmd_caixukun.mp3"}},
    ["amod_mmd_calisthenics"] = {{"actmod/i_act/am4/mmd/amod_mmd_calisthenics.mp3"}},
    ["amod_mmd_s001"] = {{"actmod/i_act/am4/mmd/amod_mmd_s001.mp3"}},
    ["amod_mmd_s002"] = {{"actmod/i_act/am4/mmd/amod_mmd_s002.mp3"}},
    ["amod_mmd_s003"] = {{"actmod/i_act/am4/mmd/amod_mmd_s003.mp3"}},
    ["amod_mmd_s004"] = {{"actmod/i_act/am4/mmd/amod_mmd_s004.mp3"}},
    ["amod_mmd_s005"] = {{"actmod/i_act/am4/mmd/amod_mmd_s005.mp3"}},
    ["amod_mmd_s006"] = {{"actmod/i_act/am4/mmd/amod_mmd_s006.mp3"}},
    ["amod_mmd_s007"] = {{"actmod/i_act/am4/mmd/amod_mmd_s007.mp3"}},
    ["amod_mmd_s008"] = {{"actmod/i_act/am4/mmd/amod_mmd_s008.mp3"}},
    ["amod_mmd_s009"] = {{"actmod/i_act/am4/mmd/amod_mmd_s009.mp3"}},
    ["amod_mmd_s010"] = {{"actmod/i_act/am4/mmd/amod_mmd_s010.mp3"}},
    ["amod_mmd_s011"] = {{"actmod/i_act/am4/mmd/amod_mmd_s011.mp3"}},
    ["amod_mmd_s012"] = {{"actmod/i_act/am4/mmd/amod_mmd_s012.mp3"}},
    ["amod_mmd_s013"] = {{"actmod/i_act/am4/mmd/amod_mmd_s013.mp3"}},
    ["amod_mmd_s014"] = {{"actmod/i_act/am4/mmd/amod_mmd_s014.mp3"}},
    ["amod_mmd_s015"] = {{"actmod/i_act/am4/mmd/amod_mmd_s015.mp3"}},
    ["amod_mmd_s017"] = {{"actmod/i_act/am4/mmd/amod_mmd_s017.mp3"}},
    ["amod_mmd_bad_apple_l"] = {{"actmod/i_act/am4/mmd/amod_mmd_bad_apple.mp3"}},
    ["amod_mmd_bad_apple_r"] = {{"actmod/i_act/am4/mmd/amod_mmd_bad_apple.mp3"}},
    ["amod_mmd_gfriendrough"] = {{"actmod/i_act/am4/mmd/amod_mmd_gfriendrough.mp3"}},
    ["amod_mmd_massdestruction"] = {{"actmod/i_act/am4/mmd/amod_mmd_massdestruction.mp3"}},
    ["amod_mmd_mememe"] = {{"actmod/i_act/am4/mmd/amod_mmd_mememe.mp3"}},
    ["amod_mmd_roki_p1"] = {{"actmod/i_act/am4/mmd/amod_mmd_roki.mp3"}},
    ["amod_mmd_roki_p2"] = {{"actmod/i_act/am4/mmd/amod_mmd_roki.mp3"}},
    ["amod_mmd_senbonzakura"] = {{"actmod/i_act/am4/mmd/amod_mmd_senbonzakura.mp3"}},
    ["amod_mmd_supermjopping"] = {{"actmod/i_act/am4/mmd/amod_mmd_supermjopping.mp3"}},
    ["amod_mmd_nahoha"] = {{"actmod/i_act/am4/mmd/amod_mmd_nahoha.mp3"}},
    ["amod_mmd_ch4nge"] = {{"actmod/i_act/am4/mmd/amod_mmd_ch4nge.mp3"}},
    ["amod_mmd_conqueror"] = {{"actmod/i_act/am4/mmd/amod_mmd_conqueror.mp3"}},
    ["amod_mmd_yoidore"] = {{"actmod/i_act/am4/mmd/amod_mmd_yoidore.mp3"}},
    ["amod_mmd_dokuhebi"] = {{"actmod/i_act/am4/mmd/amod_mmd_dokuhebii.mp3"}},
    ["amod_mmd_darling"] = {{"actmod/i_act/am4/mmd/amod_mmd_darling.mp3"}},
    ["amod_mmd_dancin"] = {{"actmod/i_act/am4/mmd/amod_mmd_dancin.mp3"}},
    ["amod_mmd_adeepmentality"] = {{"actmod/i_act/am4/mmd/amod_mmd_adeepmentality.mp3"}},
    ["amod_mmd_gimmexgimme"] = {{"actmod/i_act/am4/mmd/amod_mmd_gimmexgimme.mp3"}},
    ["amod_mmd_yaosobi-idol"] = {{"actmod/i_act/am4/mmd/amod_mmd_yaosobi-idol.mp3"}},
    ["amod_mmd_kwlink"] = {{"actmod/i_act/am4/mmd/amod_mmd_kwlink.mp3"}},
    ["amod_mmd_adj_1"] = {{"actmod/i_act/am4/mmd/amod_mmd_adj_1.mp3"}},
    ["amod_mmd_adj_2"] = {{"actmod/i_act/am4/mmd/amod_mmd_adj_1.mp3"}},
    ["amod_mmd_kemuthree"] = {{"actmod/i_act/am4/mmd/amod_mmd_kemuthree.mp3"}}
}

A_AM.ActMod.GTabSd_OSv = {"flex", "heelclick", "amod_fortnite_cerealbox", "amod_fortnite_rememberme", "amod_fortnite_jiggle", "amod_fortnite_autumntea"}
local function AeTabData(tbl, str, hlp)
    if tbl then
        for k, v in pairs(tbl) do
            if hlp then print("Search_   " .. k .. "  ->", v, k == str) end
            if str and k == str then return true end
        end
    end
    return false
end

local function Saja(ply)
    ply.SVAct_Svsound = true
    if GetConVar("actmod_sy_tovs_strfast"):GetInt() == 1 then AAct_STOPSOUND(ply) end
end

local function Saagh(ply, Strg)
    if A_AM.ActMod.GTabSd_OSv and A_AM.ActMod:AA_TableBool(A_AM.ActMod.GTabSd_OSv, Strg) == true then Saja(ply) end
end

local function OnTaba(ply, aaData, Strg, agin)
    if aaData[Strg][3] then
        if agin then
            if aaData[Strg][4] then
                timer.Create("A_AM.So_1" .. ply:EntIndex(), aaData[Strg][4], 1, function() if IsValid(ply) then AAct_CreateSound(ply, aaData[Strg][3]) end end)
            else
                AAct_CreateSound(ply, aaData[Strg][3])
            end
        else
            if aaData[Strg][2] then
                Saja(ply)
                timer.Create("A_AM.So_1" .. ply:EntIndex(), aaData[Strg][2], 1, function() if IsValid(ply) then AAct_CreateSound(ply, aaData[Strg][1]) end end)
            else
                Saagh(ply, Strg)
                AAct_CreateSound(ply, aaData[Strg][1])
            end
        end
    else
        if aaData[Strg][2] then
            Saja(ply)
            timer.Create("A_AM.So_1" .. ply:EntIndex(), aaData[Strg][2], 1, function() if IsValid(ply) then AAct_CreateSound(ply, aaData[Strg][1]) end end)
        else
            Saagh(ply, Strg)
            AAct_CreateSound(ply, aaData[Strg][1])
        end
    end

    if not agin and aaData[Strg][5] then
        if aaData[Strg][6] then
            timer.Create("A_AM.So_2" .. ply:EntIndex(), aaData[Strg][6], 1, function() if IsValid(ply) then AAct_CreateSound(ply, aaData[Strg][5], 2) end end)
        else
            AAct_CreateSound(ply, aaData[Strg][5], 2)
        end
    end
end

function A_AM.ActMod:AA_AddSdTbl(ply, AAW, Strg, agin)
    if AAW == "AM4_F" then
        if A_AM.ActMod.GTabSd_AM4_F and AeTabData(A_AM.ActMod.GTabSd_AM4_F, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_AM4_F, Strg, agin) end
    elseif AAW == "AM4_P" then
        if A_AM.ActMod.GTabSd_AM4_P and AeTabData(A_AM.ActMod.GTabSd_AM4_P, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_AM4_P, Strg, agin) end
    elseif AAW == "AM4_MMD" then
        if A_AM.ActMod.GTabSd_AM4_MMD and AeTabData(A_AM.ActMod.GTabSd_AM4_MMD, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_AM4_MMD, Strg, agin) end
    elseif AAW == "AM4_O" then
        if A_AM.ActMod.GTabSd_AM4_O and AeTabData(A_AM.ActMod.GTabSd_AM4_O, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_AM4_O, Strg, agin) end
    elseif AAW == "WOS_F" then
        if A_AM.ActMod.GTabSd_WOS_F and AeTabData(A_AM.ActMod.GTabSd_WOS_F, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_WOS_F, Strg, agin) end
    elseif AAW == "WOS_MMD" then
        if A_AM.ActMod.GTabSd_WOS_MMD and AeTabData(A_AM.ActMod.GTabSd_WOS_MMD, Strg) == true then OnTaba(ply, A_AM.ActMod.GTabSd_WOS_MMD, Strg, agin) end
    end
end

local function AA_AddSound(ply, Str, agin)
    local Strg = Str or ply:GetNWString("A_ActMod.Dir", "") or ""
    if ply and Strg ~= (nil or "") then
        if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
        if timer.Exists("A_AM.So_2" .. ply:EntIndex()) then timer.Remove("A_AM.So_2" .. ply:EntIndex()) end
        if string.sub(Strg, 1, 14) == "amod_fortnite_" then
            if not agin then Saagh(ply, Strg) end
            if Strg == "amod_fortnite_eerie_walk" or Strg == "amod_fortnite_eerie" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_eerie.mp3"})
            elseif Strg == "amod_fortnite_autumntea" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_autumn_tea_loop.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_autumn_tea_intro.mp3"}, 2)
                    AAct_STOPSOUND(ply, 1)
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 2.829, 1, function()
                        if IsValid(ply) then
                            AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_autumn_tea_loop.mp3"})
                            AAct_STOPSOUND(ply, 2)
                        end
                    end)
                end
            elseif Strg == "amod_fortnite_twisteternity_ayo" or Strg == "amod_fortnite_twisteternity_teo" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_twisteternity.mp3"})
            elseif Strg == "amod_fortnite_bythefire_follower" or Strg == "amod_fortnite_bythefire_leader" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_bythefire.mp3"})
            elseif Strg == "amod_fortnite_jiggle" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_jiggle_s2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_jiggle_s1.mp3"}, 2)
                    AAct_STOPSOUND(ply, 1)
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 0.7, 1, function()
                        if IsValid(ply) then
                            AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_jiggle_s2.mp3"})
                            AAct_STOPSOUND(ply, 2)
                        end
                    end)
                end
            elseif Strg == "amod_fortnite_jumpingjoy_walk" or Strg == "amod_fortnite_jumpingjoy_static" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_jumpingjoy.mp3"})
            elseif Strg == "amod_fortnite_rememberme" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_rememberme_s2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_STOPSOUND(ply)
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 0.5, 1, function()
                        if IsValid(ply) then
                            AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_rememberme_s1.mp3"}, 2)
                            AAct_STOPSOUND(ply, 1)
                            timer.Create("A_AM.So_1" .. ply:EntIndex(), 0.92, 1, function() if IsValid(ply) then AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_rememberme_s2.mp3"}) end end)
                        end
                    end)
                end
            elseif Strg == "amod_fortnite_cerealbox" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_cerealbox_t2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_STOPSOUND(ply)
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_cerealbox_t1.mp3"})
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 1.2, 1, function() if IsValid(ply) then AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_cerealbox_t2.mp3"}, 2) end end)
                end
            elseif Strg == "amod_fortnite_chew" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_chew_2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_STOPSOUND(ply)
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_chew_1.mp3"})
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 3.6, 1, function() if IsValid(ply) then AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_chew_2.mp3"}, 2) end end)
                end
            elseif Strg == "amod_fortnite_devotion" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_devotion_2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_STOPSOUND(ply)
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_devotion_1.mp3"})
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 0.45, 1, function() if IsValid(ply) then AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_devotion_2.mp3"}, 2) end end)
                end
            elseif Strg == "amod_fortnite_grooving" then
                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_grooving2.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_grooving1.mp3"})
                end
            elseif Strg == "amod_fortnite_griddle" or Strg == "amod_fortnite_griddle_walk" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_griddle.mp3"})
            elseif Strg == "amod_fortnite_walkywalk" or Strg == "amod_fortnite_walkywalk_walk" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/fortnite/amod_fortnite_walkywalk.mp3"})
            else
                A_AM.ActMod:AA_AddSdTbl(ply, "AM4_F", Strg, agin)
            end
        elseif string.sub(Strg, 1, 10) == "amod_pubg_" then
            if Strg == "amod_pubg_xxxxxxxx" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_victorydance102_loop.mp3"})
            else
                A_AM.ActMod:AA_AddSdTbl(ply, "AM4_P", Strg, agin)
            end
        elseif string.sub(Strg, 1, 9) == "amod_mmd_" then
            if Strg == "amod_mmd_dance_gokurakujodo" then
                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_despacito.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_gokurakujodo.mp3"})
                end
            elseif Strg == "amod_mmd_theatrical_airline_luk" or Strg == "amod_mmd_theatrical_airline_mik" or Strg == "amod_mmd_theatrical_airline_rin" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/tricoloreairline2020remake.mp3"})
            elseif Strg == "amod_mmd_sadcatdance" or Strg == "amod_mmd_sadcatdance_loop" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_sadcatdance_loop.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_sadcatdance.mp3"})
                end
            elseif Strg == "amod_mmd_phao2phuthon_p1" or Strg == "amod_mmd_phao2phuthon_p2" or Strg == "amod_mmd_phao2phuthon_p3" or Strg == "amod_mmd_phao2phuthon_p4" or Strg == "amod_mmd_phao2phuthon_p5" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_phao2phuthon_p1.mp3"})
            elseif Strg == "amod_mmd_pv120_shi_p1" or Strg == "amod_mmd_pv120_shi_p2" or Strg == "amod_mmd_pv120_shi_p3" then
                AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_pv120_shake_it.mp3"})
            elseif Strg == "amod_mmd_lmfao" then
                if agin then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_lmfao_s2.mp3"})
                else
                    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
                    AAct_STOPSOUND(ply)
                    AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_lmfao_s1.mp3"})
                    timer.Create("A_AM.So_1" .. ply:EntIndex(), 2.1, 1, function() if IsValid(ply) then AAct_CreateSound(ply, {"actmod/i_act/am4/mmd/amod_mmd_lmfao_s2.mp3"}, 2) end end)
                end
            else
                if agin then if Strg == "amod_mmd_hiproll" then Strg = "amod_mmd_hiproll_loop" end end
                A_AM.ActMod:AA_AddSdTbl(ply, "AM4_MMD", Strg, agin)
            end
        elseif string.sub(Strg, 1, 5) == "amod_" then
            if Strg == "amod_taunt_quagmire" then
                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                    AAct_CreateSound(ply, {"actmod/i_act/am4/amod_taunt_quagmire_music.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/am4/amod_taunt_quagmire.mp3"})
                end
            else
                A_AM.ActMod:AA_AddSdTbl(ply, "AM4_O", Strg, agin)
            end
        elseif string.sub(Strg, 1, 8) == "wos_tf2_" then
            if Strg == "wos_tf2_demo_taunt_conga" or Strg == "wos_tf2_engi_taunt_conga" or Strg == "wos_tf2_heavy_taunt_conga" or Strg == "wos_tf2_medic_taunt_conga" or Strg == "wos_tf2_pyro_taunt_conga" or Strg == "wos_tf2_scout_taunt_conga" or Strg == "wos_tf2_sniper_taunt_conga" or Strg == "wos_tf2_soldier_taunt_conga" or Strg == "wos_tf2_spy_taunt_conga" then
                AAct_CreateSound(ply, {"actmod/i_act/tf2/taunts/conga.wav"})
            elseif Strg == "wos_tf2_demo_taunt_mannrobics_straight" or Strg == "wos_tf2_engi_taunt_mannrobics_straight" or Strg == "wos_tf2_heavy_taunt_mannrobics_straight" or Strg == "wos_tf2_medic_taunt_mannrobics_straight" or Strg == "wos_tf2_pyro_taunt_mannrobics_straight" or Strg == "wos_tf2_scout_taunt_mannrobics_straight" or Strg == "wos_tf2_sniper_taunt_mannrobics_straight" or Strg == "wos_tf2_soldier_taunt_mannrobics_straight" or Strg == "wos_tf2_spy_taunt_mannrobics_straight" then
                AAct_CreateSound(ply, {"actmod/i_act/tf2/taunts/mannrobics.wav"})
            elseif Strg == "wos_tf2_demo_taunt_russian" or Strg == "wos_tf2_engi_taunt_russian" or Strg == "wos_tf2_heavy_taunt_russian" or Strg == "wos_tf2_medic_taunt_russian" or Strg == "wos_tf2_pyro_taunt_russian" or Strg == "wos_tf2_scout_taunt_russian" or Strg == "wos_tf2_sniper_taunt_russian" or Strg == "wos_tf2_soldier_taunt_russian" or Strg == "wos_tf2_spy_taunt_russian" then
                AAct_CreateSound(ply, {"actmod/i_act/tf2/taunts/russian.wav"})
            end
        elseif string.sub(Strg, 1, 11) == "original_da" then
            if Strg == "original_dance16" or Strg == "original_dance17" or Strg == "original_dance18" then
                AAct_CreateSound(ply, {"mmd/original_dance16.mp3"})
            elseif Strg == "original_dance19" or Strg == "original_dance20" or Strg == "original_dance21" then
                AAct_CreateSound(ply, {"mmd/original_dance17.mp3"})
            elseif Strg == "original_dance22" then
                AAct_CreateSound(ply, {"mmd/original_dance18.mp3"})
            else
                A_AM.ActMod:AA_AddSdTbl(ply, "WOS_MMD", Strg, agin)
            end
        else
            if string.sub(Strg, 1, 2) == "f_" and not string.find(Strg, "amod") then Strg = string.Replace(Strg, "f_", "") end
            if not agin then Saagh(ply, Strg) end
            if Strg == "accolades" then
                timer.Create("A_AM.So_1" .. ply:EntIndex(), 0.3, 1, function()
                    if IsValid(ply) then
                        AAct_CreateSound(ply, {"actmod/crowd/Crowd_Kansei_m.wav"}, 1)
                        timer.Create("A_AM.So_1" .. ply:EntIndex(), 1.1, 1, function()
                            if IsValid(ply) then
                                AAct_CreateSound(ply, {"actmod/crowd/Crowd_Kansei_s.wav"}, 2)
                                timer.Create("A_AM.So_1" .. ply:EntIndex(), 1.3, 1, function()
                                    if IsValid(ply) then
                                        AAct_STOPSOUND(ply, 1)
                                        AAct_CreateSound(ply, {"actmod/crowd/crowd_kansei_l.wav"}, 1)
                                        timer.Create("A_AM.So_1" .. ply:EntIndex(), 1.2, 1, function()
                                            if IsValid(ply) then
                                                AAct_STOPSOUND(ply, 2)
                                                AAct_CreateSound(ply, {"actmod/crowd/crowd_hakusyu_l.wav"}, 2)
                                                timer.Create("A_AM.So_1" .. ply:EntIndex(), 1.1, 1, function()
                                                    if IsValid(ply) then
                                                        AAct_STOPSOUND(ply, 1)
                                                        AAct_CreateSound(ply, {"actmod/crowd/Crowd_Hakusyu_s.wav"}, 1)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)
            elseif Strg == "epic_sax_guy" then
                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                    AAct_CreateSound(ply, {"actmod/i_act/fortnite/epicsax_f.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/fortnite/epicsax.mp3"})
                end
            elseif Strg == "dancemoves" then
                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                    AAct_CreateSound(ply, {"actmod/i_act/fortnite/f_dancemoves_2.mp3"})
                else
                    AAct_CreateSound(ply, {"actmod/i_act/fortnite/f_dancemoves.mp3"})
                end
            else
                A_AM.ActMod:AA_AddSdTbl(ply, "WOS_F", Strg, agin)
            end
        end
    end
end

function A_AM.ActMod:AA_RemoveAdd(ply, nmdl, nma)
    if SERVER and not nma then
        net.Start("A_AM.ActMod.AddRemove")
        net.WriteEntity(ply)
        net.WriteString("*")
        net.Broadcast()
    end

    if ply.AAct_Eff then
        for k, v in pairs(ply.AAct_Eff) do
            if v["ents"] and v["ents"] ~= NULL and IsValid(v["ents"]) then v["ents"]:Fire("kill", 0, 0) end
        end

        ply.AAct_Eff = nil
    end

    if not nmdl then AAct_STOPSOUND(ply) end
    if timer.Exists("AA_TSond" .. ply:EntIndex()) then timer.Remove("AA_TSond" .. ply:EntIndex()) end
    if timer.Exists("A_AM.So_1" .. ply:EntIndex()) then timer.Remove("A_AM.So_1" .. ply:EntIndex()) end
    if timer.Exists("A_AM.So_2" .. ply:EntIndex()) then timer.Remove("A_AM.So_2" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_1" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_1" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_2" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_2" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_3" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_3" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Ef_4" .. ply:EntIndex()) then timer.Remove("A_AM.Ef_4" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Mdl_1" .. ply:EntIndex()) then timer.Remove("A_AM.Mdl_1" .. ply:EntIndex()) end
    if timer.Exists("A_AM.Mdl_2" .. ply:EntIndex()) then timer.Remove("A_AM.Mdl_2" .. ply:EntIndex()) end
    ply:StopParticles()
end

function A_AM.ActMod:AA_TableBool(tbl, str, ss, hlp)
    if not str or str == "" then return false end
    for k, v in pairs(tbl) do
        if hlp then print("Search_   " .. v .. "  ->  " .. str, v == str, string.find(v, str)) end
        if (ss and v == str) or string.find(v, str) then return true end
    end
    return false
end

A_AM.ActMod.Ac_Geff = {"break_dance_v2"}
function A_AM.ActMod:AA_GetActAddEnt(ply, strg, agin, sond, aTab)
    local OnSnd, OnEff
    if ply.ActMod_tAb and ply.ActMod_tAb[2] ~= nil then OnSnd = ply.ActMod_tAb[2] end
    if ply.ActMod_tAb and ply.ActMod_tAb[3] ~= nil then OnEff = ply.ActMod_tAb[3] end
    if aTab then
        if aTab[1] == true then ply:SetNWBool("A_AM.ActMod.AddC1", true) end
        if aTab[2] == true then ply:SetNWBool("A_AM.ActMod.AddC2", true) end
    end

    if GetConVar("actmod_sy_tovs_strfast"):GetInt() ~= 1 then A_AM.ActMod:AA_AddModel(ply, strg, agin) end
    if strg and GetConVarNumber("actmod_sv_enabled_addef") == 1 and ((OnEff and OnEff == 1) or not OnEff and ply:GetNWBool("A_AM.ActMod.AddEf", false) == true and ply:A_ActModEffects() == true) then
        if string.find(string.sub(strg, 0, 2), "f_") and not string.find(strg, "amod") then strg = string.Replace(strg, "f_", "") end
        if GetConVar("actmod_sy_tovs_eff"):GetInt() == 2 and A_AM.ActMod:AA_TableBool(A_AM.ActMod.Ac_Geff, strg, true) ~= true then
            local Awgin = "0"
            if agin then Awgin = "1" end
            for _, pl in pairs(player.GetAll()) do
                if IsValid(pl) and not pl:IsBot() then pl:ConCommand("actmod_wtc wts_StartEffe " .. ply:EntIndex() .. " " .. strg .. " " .. Awgin .. "\n") end
            end
        else
            A_AM.ActMod:AA_AddEffects(ply, agin, strg)
            if ply:GetNWBool("A_AM.ActMod.AddMo", false) == true then A_AM.ActMod:AA_AddModel(ply, strg, agin) end
        end
    end

    if GetConVarNumber("actmod_sv_enabled_addso") == 1 and ((OnSnd and OnSnd == 1) or not OnSnd and (ply:GetNWBool("A_AM.ActMod.AddSo", false) == true or A_AM.ActMod:AA_TableBool(ActMod_GNameSAlow, strg) == true or sond == 2) and ply:A_ActModSound() == true) then AA_AddSound(ply, strg, agin) end
    ply:SetNWBool("A_AM.ActMod.AddC1", false)
    ply:SetNWBool("A_AM.ActMod.AddC2", false)
    ply:SetNWBool("A_AM.ActMod.AddMo", false)
    ply:SetNWBool("A_AM.ActMod.AddEf", false)
    ply:SetNWBool("A_AM.ActMod.AddSo", false)
end

local ActMod_GNameNo2 = {"amod_mmd_helltaker", "amod_mmd_phao2phuthon_p1", "amod_mmd_hiproll", "amod_mmd_hiproll_loop"}
local ActMod_GNameNoDif = {"taunt_cheer", "taunt_dance", "taunt_laugh", "taunt_muscle", "taunt_persistence", "taunt_robot", "f_dust_off_hands", "f_dust_off_shoulders", "f_wolf_howl", "f_cheerleader", "f_fresh", "f_dance_swipeit", "f_groovejam", "f_dance_disco_t3", "f_koreaneagle", "f_infinidab", "f_pump_dance", "f_hillbilly_shuffle"}
local ActMod_GNameNoDif_Re = {"taunt_cheer", "taunt_laugh", "taunt_persistence", "taunt_robot", "f_trex", "f_airhorn", "f_assassin_salute", "f_blow_kiss", "f_bring_it_on", "f_calculated", "f_disagree", "f_dust_off_hands", "f_dust_off_shoulders", "f_facepalm", "f_flex", "f_flex_02", "f_fonzie_pistol", "f_i_break_you", "f_idontknow", "f_touchdown_dance", "f_respectthepeace", "f_stagebow", "f_heelclick", "f_thumbsup", "f_thumbsdown", "f_salute", "f_acrobatic_superhero", "amod_mixamo_gesture_1", "amod_mixamo_gesture_2", "amod_mixamo_gesture_3", "amod_mixamo_gesture_4", "amod_mixamo_gesture_5", "amod_mixamo_gesture_6", "amod_mixamo_gesture_7", "amod_mixamo_gesture_8", "amod_mixamo_gesture_9", "amod_mixamo_gesture_10", "amod_mixamo_gesture_11", "amod_mixamo_gesture_12", "amod_mixamo_gesture_13", "amod_mixamo_gesture_14", "amod_mixamo_gesture_15", "amod_mixamo_jump", "amod_mixamo_kick_1", "amod_mixamo_kick_2", "amod_mixamo_kick_3", "amod_mixamo_kick_4", "amod_mixamo_kick_5", "amod_fortnite_ohana", "amod_fortnite_spectacleweb", "amod_mixamo_taunt_10", "amod_mixamo_taunt_11"}
local function _RLoopAnim(ply, time2, time2R, aTab, agin)
    local Effe = false
    if aTab and istable(aTab) then
        local Strg = ply:GetNWString("A_ActMod.Dir", "")
        if GetConVar("actmod_sy_tovs_strfast"):GetInt() == 1 then
            local OnEff
            if ply.ActMod_tAb and istable(ply.ActMod_tAb) and ply.ActMod_tAb[3] ~= nil then OnEff = ply.ActMod_tAb[3] end
            if aTab["Eff"] and Strg and GetConVarNumber("actmod_sv_enabled_addef") == 1 and ((OnEff and OnEff == 1) or not OnEff and ply:A_ActModEffects() == true) then
                if string.find(string.sub(Strg, 0, 2), "f_") and not string.find(Strg, "amod") then Strg = string.Replace(Strg, "f_", "") end
                Effe = true
            end
        end
    end

    if agin then
        if timer.Exists("AA_RLoopAnim" .. ply:EntIndex()) then timer.Remove("AA_RLoopAnim" .. ply:EntIndex()) end
        if aTab["RAnim2_T"] then time2 = aTab["RAnim2_T"] end
        if aTab["RAnim2_C"] then time2R = aTab["RAnim2_C"] end
        timer.Create("AA_RLoopAnim" .. ply:EntIndex(), time2, 1, function()
            if IsValid(ply) then
                A_AM.ActMod:CycleAni(ply, time2R, nil, Effe, aTab["Rmdl"])
                _RLoopAnim(ply, time2, time2R, aTab, true)
            end
        end)
    else
        A_AM.ActMod:CycleAni(ply, time2R, nil, Effe, aTab["Rmdl"])
        _RLoopAnim(ply, time2, time2R, aTab, true)
    end
end

local function _RLoopSond(ply, GetStrg, agin, time, timeT, aTab)
    if timer.Exists("AA_RLoopSond" .. ply:EntIndex()) then timer.Remove("AA_RLoopSond" .. ply:EntIndex()) end
    if timeT then agin = true end
    if agin then if aTab and istable(aTab) then if aTab["RSond_T"] then time = aTab["RSond_T"] end end end
    timer.Create("AA_RLoopSond" .. ply:EntIndex(), time, 1, function()
        if IsValid(ply) then
            A_AM.ActMod:AA_GetActAddEnt(ply, GetStrg, true, 2, aTab)
            _RLoopSond(ply, GetStrg, true, time, timeT, aTab)
        end
    end)
end

local function _RLoop(ply, time2, time2R)
    if timer.Exists("AA_RLoop" .. ply:EntIndex()) then timer.Remove("AA_RLoop" .. ply:EntIndex()) end
    timer.Create("AA_RLoop" .. ply:EntIndex(), time2, 1, function()
        if IsValid(ply) then
            A_AM.ActMod:CycleAni(ply, 0)
            _RLoop(ply, time2, time2R)
        end
    end)
end

function A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, sond, Rs, aTab)
    if time2 then
        if not Rs then
            A_AM.ActMod:CycleAni(ply, 0)
            _RLoop(ply, time2, time2R)
        end
    else
        A_AM.ActMod:CycleAni(ply, 0)
    end

    if time2 and Rs then
        timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function() if IsValid(ply) then A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, sond, true, aTab) end end)
        if sond == 2 then A_AM.ActMod:AA_GetActAddEnt(ply, GetStrg, nil, sond, aTab) end
    elseif time2 then
        timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function()
            if IsValid(ply) then
                if ply:A_ActModLoop() == 1 or ply:A_ActModLoop() == 2 and A_AM.ActMod:AA_TableBool(ActMod_GNameNoDif_Re, GetStrg) == false then
                    timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function() if IsValid(ply) then A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, sond, true, aTab) end end)
                    if sond == 2 then A_AM.ActMod:AA_GetActAddEnt(ply, GetStrg, nil, sond, aTab) end
                else
                    A_AM.ActMod:A_ActMod_OffActing(ply)
                end
            end
        end)
    else
        timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function() if IsValid(ply) then A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, sond, true, aTab) end end)
        if sond == 2 then A_AM.ActMod:AA_GetActAddEnt(ply, GetStrg, nil, sond, aTab) end
    end
end

function A_AM.ActMod:ThinkChingAni(ply)
    local GDir = ply:GetNWString("A_ActMod.Dir", "")
    if not ply.AalowAnim_MForward then
        if GDir == "amod_fortnite_griddle_walk" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_griddle") end
        if GDir == "amod_fortnite_eerie_walk" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_eerie") end
        if GDir == "amod_fortnite_jumpingjoy_walk" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_jumpingjoy_static") end
        if GDir == "amod_fortnite_walkywalk_walk" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_walkywalk") end
    elseif ply.AalowAnim_MForward then
        if GDir == "amod_fortnite_griddle" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_griddle_walk") end
        if GDir == "amod_fortnite_eerie" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_eerie_walk") end
        if GDir == "amod_fortnite_jumpingjoy_static" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_jumpingjoy_walk") end
        if GDir == "amod_fortnite_walkywalk" then ply:SetNWString("A_ActMod.Dir", "amod_fortnite_walkywalk_walk") end
    end
end

function A_AM.ActMod:ChingAni(ply, OnBUt)
    local EIx = ply:EntIndex()
    if (OnBUt == 1 or OnBUt == 0) or not timer.Exists("AA_TReA" .. EIx) and (ply.TimeGo_Attk or 0) < CurTime() then
        local GDir = ply:GetNWString("A_ActMod.Dir", "")
        if string.find(string.sub(GDir, 1, 7), "_tf2") and string.find(string.sub(GDir, -9, -1), "_straight") then
            local ChDir = GDir
            local time = 0
            if string.find(string.sub(GDir, -9, -1), "_straight") then
                ChDir = string.Replace(ChDir, "_straight", "_start" .. math.random(1, 2))
                time = ply:SequenceDuration(ply:LookupSequence(ChDir))
            end

            A_AM.ActMod:CycleAni(ply, 0)
            ply:SetNWString("A_ActMod.Dir", ChDir)
            ply.TimeGo_Attk = CurTime() + time
            timer.Create("AA_TReA" .. EIx, time - 0.5, 1, function() if IsValid(ply) then ply:SetNWString("A_ActMod.Dir", GDir) end end)
        elseif string.find(string.sub(GDir, 1, 22), "amod_mmd_phao2phuthon_") then
            local ChDir = GDir
            local NuDir = tonumber(string.sub(GDir, -1, -1))
            if NuDir == 1 then
                ChDir = string.Replace(ChDir, "_p1", "_p2")
            elseif NuDir == 2 then
                ChDir = string.Replace(ChDir, "_p2", "_p3")
            elseif NuDir == 3 then
                ChDir = string.Replace(ChDir, "_p3", "_p4")
            elseif NuDir == 4 then
                ChDir = string.Replace(ChDir, "_p4", "_p5")
            elseif NuDir == 5 then
                ChDir = string.Replace(ChDir, "_p5", "_p1")
            end

            ply:SetNWString("A_ActMod.Dir", ChDir)
            ply.TimeGo_Attk = CurTime() + 0.3
        elseif string.find(string.sub(GDir, 1, 12), "zombie_walk_") then
            local ChDir = GDir
            local NuDir = tonumber(string.sub(GDir, -1, -1))
            if NuDir == 1 then
                ChDir = string.Replace(ChDir, "01", "02")
            elseif NuDir == 2 then
                ChDir = string.Replace(ChDir, "02", "03")
            elseif NuDir == 3 then
                ChDir = string.Replace(ChDir, "03", "04")
            elseif NuDir == 4 then
                ChDir = string.Replace(ChDir, "04", "05")
            elseif NuDir == 5 then
                ChDir = string.Replace(ChDir, "05", "06")
            elseif NuDir == 6 then
                ChDir = string.Replace(ChDir, "06", "01")
            end

            ply:SetNWString("A_ActMod.Dir", ChDir)
            ply.TimeGo_Attk = CurTime() + 0.2
        elseif string.find(string.sub(GDir, 1, 15), "zombie_run_fast") then
            ply:SetNWString("A_ActMod.Dir", "zombie_run")
            ply.TimeGo_Attk = CurTime() + 0.2
        elseif string.find(string.sub(GDir, 1, 10), "zombie_run") then
            ply:SetNWString("A_ActMod.Dir", "zombie_run_fast")
            ply.TimeGo_Attk = CurTime() + 0.2
        elseif GDir == "zombie_idle_01" then
            local ChDir = "zombie_slump_rise_01"
            if OnBUt then ChDir = "zombie_slump_rise_02_fast" end
            ply:SetNWString("A_ActMod.Dir", ChDir)
            ply.TimeGo_Attk = CurTime() + 3.2
            A_AM.ActMod:CycleAni(ply, 0.9)
            ply:SetNWInt("A_AM.ActRate", -1)
            timer.Create("AA_TReA" .. EIx, ply:SequenceDuration(ply:LookupSequence(ChDir)), 1, function()
                if IsValid(ply) then
                    A_AM.ActMod:CycleAni(ply, 0)
                    ply:SetNWInt("A_AM.ActRate", 0)
                end
            end)
        elseif GDir == "zombie_slump_rise_01" or GDir == "zombie_slump_rise_02_fast" then
            ply.TimeGo_Attk = CurTime() + 3.2
            A_AM.ActMod:CycleAni(ply, 0)
            ply:SetNWInt("A_AM.ActRate", 1)
            timer.Create("AA_TReA" .. EIx, ply:SequenceDuration(ply:LookupSequence(GDir)), 1, function() if IsValid(ply) then ply:SetNWString("A_ActMod.Dir", "zombie_idle_01") end end)
        elseif GDir == "amod_fortnite_griddle" then
            ply.TimeGo_Attk = CurTime() + 0.1
            ply:SetNWString("A_ActMod.Dir", "amod_fortnite_griddle_walk")
        elseif GDir == "amod_fortnite_eerie" then
            ply.TimeGo_Attk = CurTime() + 0.1
            ply:SetNWString("A_ActMod.Dir", "amod_fortnite_eerie_walk")
        elseif GDir == "amod_fortnite_jumpingjoy_static" then
            ply.TimeGo_Attk = CurTime() + 0.1
            ply:SetNWString("A_ActMod.Dir", "amod_fortnite_jumpingjoy_walk")
        elseif GDir == "amod_fortnite_walkywalk" then
            ply.TimeGo_Attk = CurTime() + 0.1
            ply:SetNWString("A_ActMod.Dir", "amod_fortnite_walkywalk_walk")
        elseif GDir == "amod_mixamo_sit" then
            ply.TimeGo_Attk = CurTime() + 3
            A_AM.ActMod:CycleAni(ply, 0)
            ply:SetNWString("A_ActMod.Dir", "amod_mixamo_sit_to_stand")
            timer.Create("AA_TReA" .. EIx, ply:SequenceDuration(ply:LookupSequence("amod_mixamo_sit_to_stand")), 1, function() if IsValid(ply) then ply:SetNWString("A_ActMod.Dir", "amod_mixamo_idle_3") end end)
        elseif GDir == "amod_mixamo_idle_3" then
            ply.TimeGo_Attk = CurTime() + 3
            A_AM.ActMod:CycleAni(ply, 0)
            ply:SetNWString("A_ActMod.Dir", "amod_mixamo_sit_to_stand_reversed")
            timer.Create("AA_TReA" .. EIx, ply:SequenceDuration(ply:LookupSequence("amod_mixamo_sit_to_stand_reversed")), 1, function() if IsValid(ply) then ply:SetNWString("A_ActMod.Dir", "amod_mixamo_sit") end end)
        elseif GDir == "amod_am4_drliveseywalk_1" then
            ply.TimeGo_Attk = CurTime() + 0.25
            ply:SetNWString("A_ActMod.Dir", "amod_am4_drliveseywalk_2")
        elseif GDir == "amod_am4_drliveseywalk_2" then
            ply.TimeGo_Attk = CurTime() + 0.25
            ply:SetNWString("A_ActMod.Dir", "amod_am4_drliveseywalk_3")
        elseif GDir == "amod_am4_drliveseywalk_3" then
            ply.TimeGo_Attk = CurTime() + 0.25
            ply:SetNWString("A_ActMod.Dir", "amod_am4_drliveseywalk_1")
        end
    end
end

function A_AM.ActMod:StartAniAct(ply, GetStr, rres, Tab2)
    if ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "aact_weapact" then
        local GetStrg = GetStr
        if ply and GetStrg ~= nil and GetStrg ~= "" then
            if timer.Exists("AA_TStratA" .. ply:EntIndex()) then timer.Remove("AA_TStratA" .. ply:EntIndex()) end
            if timer.Exists("AA_TReA" .. ply:EntIndex()) then timer.Remove("AA_TReA" .. ply:EntIndex()) end
            if timer.Exists("AA_TMov" .. ply:EntIndex()) then timer.Remove("AA_TMov" .. ply:EntIndex()) end
            if timer.Exists("AA_TSTr" .. ply:EntIndex()) then timer.Remove("AA_TSTr" .. ply:EntIndex()) end
            if timer.Exists("AA_TEnd" .. ply:EntIndex()) then timer.Remove("AA_TEnd" .. ply:EntIndex()) end
            if timer.Exists("AA_RLoop" .. ply:EntIndex()) then timer.Remove("AA_RLoop" .. ply:EntIndex()) end
            if timer.Exists("AA_RLoopAnim" .. ply:EntIndex()) then timer.Remove("AA_RLoopAnim" .. ply:EntIndex()) end
            if timer.Exists("AA_RLoopSond" .. ply:EntIndex()) then timer.Remove("AA_RLoopSond" .. ply:EntIndex()) end
            ply.TimeGo_Attk = nil
            ply.AalowAnim = nil
            local Rate = 1
            local Cycle = 0
            local Cyclesv
            local function SRate(ply, Rat)
                ply:SetNWInt("A_AM.ActRate", Rat)
                Rate = Rat
            end

            local Strg = GetStrg
            local CamParent = false
            local CamInLerp = 5
            local IsMMD = true
            local aTab = {
                [1] = false,
                [2] = false,
                ["Eff"] = false
            }

            local aTab2 = Tab2 or {}
            local time, aOneCyc, time1, timeT, time2, time2R, NoStop
            time = ply:SequenceDuration(ply:LookupSequence(GetStrg)) + 0.22
            hook.Call("A_AM.ActMod.OnAct", nil, ply)
            ply:SetNWBool("A_AM.ActMod.OnButtons", false)
            ply:SetNWInt("A_AM.ActRate", 1)
            ply:SetNWInt("A_ActMod.MoveDir", 0)
            ply:SetNWInt("A_AM.MoveSpeed", 200)
            ply:SetNWBool("A_AM.ActMod.Cam_Parent", false)
            ply:SetNWInt("A_AM.ActMod.CamInLerp", 5)
            ply.A_ActModOKAct = nil
            ply:SetNWBool("A_AM.ActMod.IsAct", true)
            local EIx = ply:EntIndex()
            if ply.ActMod_Cum then
                NoStop = 0
            elseif string.sub(Strg, 1, 2) == "f_" then
                if Strg == "f_break_dance_v2" then
                    time = time - 0.2
                    if rres then
                        Cyclesv = 0
                    else
                        Cyclesv = 0.02
                    end
                elseif Strg == "f_capoeira" then
                    if rres then
                        Cycle = 0.339
                        time = time - 1.66
                    end
                elseif Strg == "f_dj_drop" then
                    if rres then
                        Cycle = 0.3308
                        time = time - 7.5
                    else
                        Cycle = 0.0
                        time = time - 0.0
                    end
                elseif Strg == "f_cry" then
                    if rres then
                        Cycle = 0.125
                        time = time - 1.15
                    end
                elseif Strg == "f_laugh" then
                    if rres then
                        Cycle = 0.18
                        time = time - 1.7
                    end
                elseif Strg == "f_look_at_this" then
                    if rres then
                        Cycle = 0.21
                        time = time - 0.8
                    end
                elseif Strg == "f_golfer_clap" then
                    if rres then
                        Cycle = 0.11
                        time = time - 3.5
                    else
                        time = time - 2.9
                    end
                elseif Strg == "f_bandofthefort" then
                    time = time + 4.5
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)

                    timer.Create("AA_TReA" .. EIx, 4.5, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_chicken_moves" then
                    time = time + 9.6
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)

                    timer.Create("AA_TReA" .. EIx, 3.2, 4, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_conga" then
                    time = time - 0.05
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 52)
                        end
                    end)
                elseif Strg == "f_hiptobesquare" then
                    NoStop = 2
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 100)
                        end
                    end)

                    time2 = time - 0.2
                    time = 21
                elseif Strg == "f_happyskipping" then
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 100)
                        end
                    end)
                elseif Strg == "f_cartwheel" then
                    Cycle = 0.31
                    if rres then
                        time = time - 0.85
                    else
                        time = time - 0.78
                    end

                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 100)
                        end
                    end)
                elseif Strg == "f_llamamarch" then
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)
                elseif Strg == "f_treadmilldance" then
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 53)
                        end
                    end)
                elseif Strg == "f_sneaky" then
                    NoStop = 2
                    time = time * 4 - 1.36
                    time2 = 5.7
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)
                elseif Strg == "f_robotdance" then
                    if math.random(1, 2) == 1 then
                        time = time + 10.03
                        timer.Create("AA_TReA" .. EIx, 9.95, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    end
                elseif Strg == "f_crackshot" then
                    time = time + 6.65
                    timer.Create("AA_TReA" .. EIx, 6.65, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_dance_shoot" then
                    time = time + 6.3
                    timer.Create("AA_TReA" .. EIx, 7.12, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.569)
                        end
                    end)
                elseif Strg == "f_kpop_03" then
                    time = time + 9.55
                    timer.Create("AA_TReA" .. EIx, 9.6, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.503)
                        end
                    end)
                elseif Strg == "f_crab_dance" then
                    time = time + 15.15
                    timer.Create("AA_TReA" .. EIx, 7.67, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            timer.Create("AA_TReA" .. EIx, 7.67, 1, function()
                                if IsValid(ply) then
                                    A_AM.ActMod:CycleAni(ply, 0)
                                    SRate(ply, 0.515)
                                end
                            end)
                        end
                    end)
                elseif Strg == "f_electroswing" then
                    time = time + 8.0
                    timer.Create("AA_TReA" .. EIx, 8.0, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_flossdance" then
                    time = time + 3.25
                    timer.Create("AA_TReA" .. EIx, 4.87, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_glowstickdance" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 2 - 0.22
                elseif Strg == "f_windmillfloss" then
                    time = time + 2.7
                    timer.Create("AA_TReA" .. EIx, 5.36, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_jaywalk" then
                    NoStop = 3
                    time1 = 10.7
                    time2 = 3.36
                    time2R = 0.196
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 34)
                        end
                    end)
                elseif Strg == "f_make_it_rain_v2" then
                    NoStop = 3
                    time1 = 3.2
                    time2 = 2.7
                    time2R = 0.26
                elseif Strg == "f_statuepose" then
                    if rres then
                        if math.random(1, 2) == 1 then
                            time = time - 2.5
                            Cycle = 0.26
                        else
                            time = 2.5
                            Cycle = 0.26
                        end
                    end
                elseif Strg == "f_og_runningman" then
                    time = 31.4
                    local aginum = 0
                    timer.Create("AA_TReA" .. EIx, 3.86, 7, function()
                        if IsValid(ply) then
                            aginum = aginum + 1
                            A_AM.ActMod:CycleAni(ply, 0)
                            if aginum == 7 then SRate(ply, 0.467) end
                        end
                    end)
                elseif Strg == "f_boogie_down" then
                    time = time + 13.2
                    timer.Create("AA_TReA" .. EIx, 4.4, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_cheerleader" then
                    time = time - 0.1
                elseif Strg == "f_dance_swipeit" then
                    time = time + 6.26
                    timer.Create("AA_TReA" .. EIx, 6.56, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_groovejam" then
                    time = 15.3
                    timer.Create("AA_TReA" .. EIx, 7.58, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_hilowave" then
                    time = time + 9.6
                    timer.Create("AA_TReA" .. EIx, 9.6, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_hip_hop" then
                    time = time + 7.25
                    timer.Create("AA_TReA" .. EIx, 7.25, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_hip_hop_s7" then
                    if rres then
                        time = time + 5.88
                        Cycle = 0.20
                        timer.Create("AA_TReA" .. EIx, 7.88, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:CycleAni(ply, 0.199)
                                SRate(ply, 0.502)
                            end
                        end)
                    else
                        time = time + 7.9
                        timer.Create("AA_TReA" .. EIx, 9.85, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.20) end end)
                    end
                elseif Strg == "f_hiphop_01" then
                    time = time + 6.25
                    timer.Create("AA_TReA" .. EIx, 6.25, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_jammin" then
                    time = time + 6.98
                    timer.Create("AA_TReA" .. EIx, 6.98, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_mask_off" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = time + 12.34
                elseif Strg == "f_runningv3" then
                    time = time + 6.2
                    timer.Create("AA_TReA" .. EIx, 6.21, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_thighslapper" then
                    if rres then
                        time = 61.5
                        Cycle = 0.20
                        timer.Create("AA_TReA" .. EIx, 10.2, 5, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.20) end end)
                    else
                        time = 64
                        timer.Create("AA_TReA" .. EIx, 12.74, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:CycleAni(ply, 0.20)
                                timer.Create("AA_TReA" .. EIx, 10.2, 5, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.20) end end)
                            end
                        end)
                    end
                elseif Strg == "f_touchdown_dance" then
                    time = 20
                    local aginum = 0
                    timer.Create("AA_TReA" .. EIx, 9.08, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0.805)
                            timer.Create("AA_TReA" .. EIx, 1.7, 6, function()
                                if IsValid(ply) then
                                    aginum = aginum + 1
                                    if aginum == 6 then
                                        ply:SetNWString("A_ActMod.Dir", "idle_all_angry")
                                    else
                                        A_AM.ActMod:CycleAni(ply, 0.805)
                                    end
                                end
                            end)
                        end
                    end)
                elseif Strg == "f_aerobicchamp" then
                    time = time + 6.3
                    timer.Create("AA_TReA" .. EIx, 6.3, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_afrohouse" then
                    time = time + 11.1
                    timer.Create("AA_TReA" .. EIx, 3.7, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_charleston" then
                    time = time + 11.1
                    timer.Create("AA_TReA" .. EIx, 3.7, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_crazyfeet" then
                    time = time + 15.12
                    timer.Create("AA_TReA" .. EIx, 5.03, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_cross_legs" then
                    time = 19.2
                    timer.Create("AA_TReA" .. EIx, 4.75, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_dance_disco_t3" then
                    time = time - 0.40
                elseif Strg == "f_fancyfeet" then
                    time = time + 4.2
                    timer.Create("AA_TReA" .. EIx, 4.2, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_koreaneagle" then
                    time = 9.6
                    timer.Create("AA_TReA" .. EIx, 4.57, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.425)
                        end
                    end)
                elseif Strg == "f_loser_dance" then
                    time = 25.05
                    timer.Create("AA_TReA" .. EIx, 4.13, 5, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_technozombie" then
                    time = 9.75
                    timer.Create("AA_TReA" .. EIx, 4.83, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.51)
                        end
                    end)
                elseif Strg == "f_hula" then
                    time = time + 6.9
                    timer.Create("AA_TReA" .. EIx, 7.2, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.52)
                        end
                    end)
                elseif Strg == "f_smooth_ride" then
                    time = 16.1
                    timer.Create("AA_TReA" .. EIx, 7.8, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.483)
                        end
                    end)
                elseif Strg == "f_taichi" then
                    time = 16.25
                    timer.Create("AA_TReA" .. EIx, 8.43, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.55)
                        end
                    end)
                elseif Strg == "f_infinidab" then
                    time = 7.95
                    timer.Create("AA_TReA" .. EIx, 4.0, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.589)
                        end
                    end)
                elseif Strg == "f_cowbell" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            SRate(ply, 0.5)
                        end
                    end)

                    time = time * 2 - 0.2
                elseif Strg == "f_pump_dance" then
                    time = 13.64
                    timer.Create("AA_TReA" .. EIx, 3.35, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_headbanger" then
                    if rres then
                        time = time + 5.84
                        A_AM.ActMod:CycleAni(ply, 0.0745)
                        timer.Create("AA_TReA" .. EIx, 6.38, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.0744) end end)
                    else
                        time = time + 6.34
                        timer.Create("AA_TReA" .. EIx, 6.93, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.0744) end end)
                    end
                elseif Strg == "f_epic_sax_guy" then
                    if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                        timer.Create("AA_TReA" .. EIx, time - 0.3, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                        time = time * 4 - 1
                    else
                        time = time - 0.1
                        SRate(ply, 0.90)
                    end
                elseif Strg == "f_marat" then
                    time = 15.6
                    timer.Create("AA_TReA" .. EIx, 4.47, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0.161)
                            timer.Create("AA_TReA" .. EIx, 3.72, 1, function()
                                if IsValid(ply) then
                                    A_AM.ActMod:CycleAni(ply, 0.161)
                                    timer.Create("AA_TReA" .. EIx, 3.72, 1, function()
                                        if IsValid(ply) then
                                            A_AM.ActMod:CycleAni(ply, 0.161)
                                            SRate(ply, 0.47)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                elseif Strg == "f_ridethepony" then
                    time = 12.5
                    timer.Create("AA_TReA" .. EIx, 4.12, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            timer.Create("AA_TReA" .. EIx, 4.12, 1, function()
                                if IsValid(ply) then
                                    A_AM.ActMod:CycleAni(ply, 0)
                                    timer.Create("AA_TReA" .. EIx, 4.12, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                                end
                            end)
                        end
                    end)
                elseif Strg == "f_armup" then
                    time = 20.4
                    timer.Create("AA_TReA" .. EIx, 10.1, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_funk_time" then
                    time = 17.4
                    timer.Create("AA_TReA" .. EIx, 8.6, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_cool_robot" then
                    time = 30.2
                    timer.Create("AA_TReA" .. EIx, 15.0, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_head_bounce" then
                    time = 15.2
                    timer.Create("AA_TReA" .. EIx, 5.55, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            timer.Create("AA_TMov" .. EIx, 0.5, 1, function()
                                if IsValid(ply) then
                                    ply:SetNWInt("A_AM.ActRate", 0.4)
                                    timer.Create("AA_TMov" .. EIx, 1.0, 1, function()
                                        if IsValid(ply) then
                                            ply:SetNWInt("A_AM.ActRate", 0.35)
                                            timer.Create("AA_TMov" .. EIx, 1.0, 1, function()
                                                if IsValid(ply) then
                                                    ply:SetNWInt("A_AM.ActRate", 0.3)
                                                    timer.Create("AA_TMov" .. EIx, 1.0, 1, function() if IsValid(ply) then ply:SetNWInt("A_AM.ActRate", 0.25) end end)
                                                end
                                            end)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                elseif Strg == "f_jazz_dance" then
                    time = 28.4
                    timer.Create("AA_TReA" .. EIx, 14.1, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_octopus" then
                    time = 21.0
                    timer.Create("AA_TReA" .. EIx, 5.4, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_running" then
                    time = 15.1
                    timer.Create("AA_TReA" .. EIx, 5.6, 2, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_sprinkler" then
                    time = 22.6
                    timer.Create("AA_TReA" .. EIx, 3.73, 5, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_wave_dance" then
                    time = 15.7
                    timer.Create("AA_TReA" .. EIx, 7.73, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_thequicksweeper" then
                    time = 14.5
                    timer.Create("AA_TReA" .. EIx, 7.13, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_electroshuffle2" then
                    time = 16.2
                    timer.Create("AA_TReA" .. EIx, 8.0, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_indiadance" then
                    time = 19.0
                    timer.Create("AA_TReA" .. EIx, 4.7, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_kpop_dance03" then
                    time = 32.73
                    timer.Create("AA_TReA" .. EIx, 8.11, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_swim_dance" then
                    time = 12.5
                    timer.Create("AA_TReA" .. EIx, 6.11, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_floppy_dance" then
                    time = 16.8
                    timer.Create("AA_TReA" .. EIx, 8.33, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            ply:SetNWInt("A_AM.ActRate", 0.505)
                        end
                    end)
                elseif Strg == "f_doublesnap" then
                    time = 28.8
                    timer.Create("AA_TReA" .. EIx, 7.15, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_dreamfeet" then
                    time = time * 2 - 0.3
                    timer.Create("AA_TReA" .. EIx, 12.3, 1, function()
                        if IsValid(ply) then
                            A_AM.ActMod:CycleAni(ply, 0)
                            ply:SetNWInt("A_AM.ActRate", 0.505)
                        end
                    end)
                elseif Strg == "f_gabby_hiphop" then
                    time = time * 2 - 0.2
                    timer.Create("AA_TReA" .. EIx, 8.0, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_poplock" then
                    if rres then
                        time = 8.40
                        Cycle = 0.024
                        SRate(ply, 4.87)
                    end
                elseif Strg == "f_kpop_04" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0, nil, true) end end)
                    time = time * 2 - 0.22
                elseif Strg == "f_bbd" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 2 - 0.22
                elseif Strg == "f_take_the_w" then
                    time = time * 4 - 0.5
                    timer.Create("AA_TMov" .. EIx, 3.94, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "f_guitar_walk" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = 61.8
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 30)
                        end
                    end)
                end
            elseif string.sub(Strg, 1, 14) == "amod_fortnite_" then
                if Strg == "amod_fortnite_eerie" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = 33.55
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 32)
                        end
                    end)

                    ply.AalowAnim = true
                elseif Strg == "amod_fortnite_eerie_walk" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = 33.55
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 32)
                        end
                    end)
                elseif Strg == "amod_fortnite_eerie" then
                    time = 33.55
                    timer.Create("AA_TReA" .. EIx, 8.33, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "amod_fortnite_autumntea" then
                    if rres then
                        time = 11.43
                        Cycle = 0.2035
                        SRate(ply, 1)
                    end
                elseif Strg == "amod_fortnite_nevergonna" then
                    time = 33.82
                    Cycle = 0.16
                    if rres then
                        timer.Create("AA_TReA" .. EIx, 8.4, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.16) end end)
                    else
                        timer.Create("AA_TReA" .. EIx, 8.4, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.16) end end)
                    end
                elseif Strg == "amod_fortnite_aloha" then
                    time = time * 8 - 1.6
                    timer.Create("AA_TReA" .. EIx, 5.29, 7, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "amod_fortnite_jiggle" then
                    if rres then
                        time = 9.78
                        Cycle = 0.077
                    end
                elseif Strg == "amod_fortnite_rememberme" then
                    if rres then
                        time = 8.6
                        Cycle = 0.15
                    end
                elseif Strg == "amod_fortnite_jumpingjoy_static" then
                    NoStop = 2
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 54)
                        end
                    end)

                    ply.AalowAnim = true
                elseif Strg == "amod_fortnite_jumpingjoy_walk" then
                    NoStop = 2
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 54)
                        end
                    end)
                elseif Strg == "amod_fortnite_littleegg" then
                    time = time * 2 - 0.2
                    timer.Create("AA_TReA" .. EIx, 9.93, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "amod_fortnite_lyrical" then
                    time = time * 2 - 0.2
                    timer.Create("AA_TReA" .. EIx, 5.29, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "amod_fortnite_tonal" then
                    timer.Create("AA_TReA" .. EIx, time - 0.2, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 2 - 0.2
                elseif Strg == "amod_fortnite_sunlit" then
                    timer.Create("AA_TReA" .. EIx, time - 0.2, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 4 - 0.6
                elseif Strg == "amod_fortnite_realm" then
                    NoStop = 3
                    time1 = 37.8
                    time2 = 3.36
                    time2R = 0.196
                    if not rres then
                        timer.Create("AA_TMov" .. EIx, 0.6, 1, function()
                            if IsValid(ply) then
                                ply:SetNWInt("A_ActMod.MoveDir", 1)
                                ply:SetNWInt("A_AM.MoveSpeed", 5)
                                timer.Create("AA_TMov" .. EIx, 0.05, 7, function() if IsValid(ply) then ply:SetNWInt("A_AM.MoveSpeed", ply:GetNWInt("A_AM.MoveSpeed", 0) + 10) end end)
                            end
                        end)
                    end
                elseif Strg == "amod_fortnite_marionette1" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 4 - 0.6
                elseif Strg == "amod_fortnite_cerealbox" then
                    if rres then
                        time = 57.6
                        Cycle = 0.194
                        timer.Create("AA_TReA" .. EIx, 6.364, 8, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.194, nil, true) end end)
                    else
                        time = 59.05
                        timer.Create("AA_TReA" .. EIx, 7.91, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:CycleAni(ply, 0.194, nil, true)
                                timer.Create("AA_TReA" .. EIx, 6.364, 7, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.194, nil, true) end end)
                            end
                        end)
                    end
                elseif Strg == "amod_fortnite_chew" then
                    if rres then
                        time = 14.65
                        Cycle = 0.19963032007217
                    end
                elseif Strg == "amod_fortnite_devotion" then
                    if rres then
                        time = 11.3
                        Cycle = 0.043103449046612
                    end
                elseif Strg == "amod_fortnite_grooving" then
                    if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                        time1 = 32.0
                    else
                        time1 = 24.0
                    end

                    NoStop = 4
                elseif Strg == "amod_fortnite_hotpink" then
                    timer.Create("AA_TMov" .. EIx, time - 0.22, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 2 - 0.22
                elseif Strg == "amod_fortnite_griddle" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = time * 4 - 0.58
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 100)
                        end
                    end)

                    ply.AalowAnim = true
                elseif Strg == "amod_fortnite_griddle_walk" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = time * 4 - 0.58
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 100)
                        end
                    end)
                elseif Strg == "amod_fortnite_walkywalk" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = 28.9
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 67)
                        end
                    end)

                    ply.AalowAnim = true
                elseif Strg == "amod_fortnite_walkywalk_walk" then
                    NoStop = 2
                    time2 = time - 0.2
                    time = 28.9
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 67)
                        end
                    end)
                elseif Strg == "amod_fortnite_cyclone" then
                    NoStop = 2
                    time2 = time - 0.22
                    time = 6
                elseif Strg == "amod_fortnite_julybooks" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 4 - 0.66
                elseif Strg == "amod_fortnite_comrade" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                    time = time * 4 - 0.66
                elseif Strg == "amod_fortnite_indigoapple" then
                    timer.Create("AA_TReA" .. EIx, time - 0.22, 3, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0, nil, true, true) end end)
                    time = time * 4 - 0.66
                    if rres then
                        A_AM.ActMod:CycleAni(ply, 0, nil, true, true)
                        aOneCyc = 0
                    else
                        aOneCyc = 1
                    end
                elseif Strg == "amod_fortnite_heavyroardance" then
                    if rres then
                        time = 9.38
                        Cycle = 0.077181205153465
                    end
                elseif Strg == "amod_fortnite_zebrascramble" then
                    NoStop = 4
                    time1 = time - 0.22
                end
            elseif string.sub(Strg, 1, 10) == "amod_pubg_" then
                if Strg == "amod_pubg_samsara" then
                    if rres then
                        time = 39.9
                        Cycle = 0.1
                    end
                elseif Strg == "amod_pubg_victorydance102" then
                    if rres then
                        time = 30.1
                        Cycle = 0.0147
                    end
                elseif Strg == "amod_pubg_victorydance99" then
                    if rres then
                        time = 15.086
                        Cycle = 0.117
                    end
                elseif Strg == "amod_pubg_tocatoca" then
                    if rres then
                        time = 15.44
                        Cycle = 0.530
                    end
                end
            elseif string.sub(Strg, 1, 12) == "amod_mixamo_" then
                if Strg == "amod_mixamo_sit" then
                    NoStop = 0
                    Strg = "amod_mixamo_sit_to_stand_reversed"
                    timer.Create("AA_TReA" .. EIx, 2.6, 1, function()
                        if IsValid(ply) then
                            ply:SetNWString("A_ActMod.Dir", "amod_mixamo_sit")
                            ply:SetNWInt("A_ActMod.MoveDir", 7)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_0_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_1_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 45)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_2_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 43)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_3_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_4_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_5_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 12)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_6_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 55)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_7_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 65)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_8_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 38)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_9_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 63)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_9_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 63)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_10_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 75)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_11_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 35.5)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_12_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_13_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 17)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_14_back" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 2)
                            ply:SetNWInt("A_AM.MoveSpeed", 22)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_15_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 20)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_16_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 57)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_17_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 50)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_18_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 40)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_19_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 25)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_20_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 55)
                        end
                    end)
                elseif Strg == "amod_mixamo_walk_21_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 25)
                        end
                    end)
                elseif Strg == "amod_mixamo_run_1_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 250)
                        end
                    end)
                elseif Strg == "amod_mixamo_run_2_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 180)
                        end
                    end)
                elseif Strg == "amod_mixamo_run_3_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 210)
                        end
                    end)
                elseif Strg == "amod_mixamo_run_4_forward" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 94)
                        end
                    end)
                elseif Strg == "amod_mixamo_kick_1" then
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 240)
                            timer.Create("AA_TMov" .. EIx, 0.6, 1, function() if IsValid(ply) then ply:SetNWInt("A_ActMod.MoveDir", 0) end end)
                        end
                    end)
                elseif Strg == "amod_mixamo_dead_1" then
                    NoStop = 1
                    timer.Create("AA_TReA" .. EIx, time - 0.5, 1, function()
                        if IsValid(ply) then
                            Strg = "amod_mixamo_dead_1_idle"
                            ply:SetNWString("A_ActMod.Dir", Strg)
                        end
                    end)
                elseif Strg == "amod_mixamo_dead_2" then
                    NoStop = 1
                    timer.Create("AA_TReA" .. EIx, time - 0.5, 1, function()
                        if IsValid(ply) then
                            Strg = "amod_mixamo_dead_2_idle"
                            ply:SetNWString("A_ActMod.Dir", Strg)
                        end
                    end)
                elseif Strg == "amod_mixamo_dead_3" then
                    NoStop = 1
                    timer.Create("AA_TReA" .. EIx, time - 0.5, 1, function()
                        if IsValid(ply) then
                            Strg = "amod_mixamo_dead_3_idle"
                            ply:SetNWString("A_ActMod.Dir", Strg)
                        end
                    end)
                elseif Strg == "amod_mixamo_dead_4" then
                    NoStop = 1
                    timer.Create("AA_TReA" .. EIx, time - 0.5, 1, function()
                        if IsValid(ply) then
                            Strg = "amod_mixamo_dead_4_idle"
                            ply:SetNWString("A_ActMod.Dir", Strg)
                        end
                    end)
                elseif Strg == "amod_mixamo_taunt_7" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 2)
                            ply:SetNWInt("A_AM.MoveSpeed", 28)
                        end
                    end)
                elseif Strg ~= "amod_mixamo_taunt_10" and Strg ~= "amod_mixamo_taunt_11" and string.sub(Strg, 1, 18) == "amod_mixamo_taunt_" then
                    NoStop = 0
                end
            elseif string.sub(Strg, 1, 8) == "wos_tf2_" then
                if Strg == "wos_tf2_demo_taunt_conga" or Strg == "wos_tf2_engi_taunt_conga" or Strg == "wos_tf2_heavy_taunt_conga" or Strg == "wos_tf2_medic_taunt_conga" or Strg == "wos_tf2_pyro_taunt_conga" or Strg == "wos_tf2_scout_taunt_conga" or Strg == "wos_tf2_sniper_taunt_conga" or Strg == "wos_tf2_soldier_taunt_conga" or Strg == "wos_tf2_spy_taunt_conga" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 1)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)
                elseif Strg == "wos_tf2_demo_taunt_mannrobics_straight" or Strg == "wos_tf2_engi_taunt_mannrobics_straight" or Strg == "wos_tf2_heavy_taunt_mannrobics_straight" or Strg == "wos_tf2_medic_taunt_mannrobics_straight" or Strg == "wos_tf2_pyro_taunt_mannrobics_straight" or Strg == "wos_tf2_scout_taunt_mannrobics_straight" or Strg == "wos_tf2_sniper_taunt_mannrobics_straight" or Strg == "wos_tf2_soldier_taunt_mannrobics_straight" or Strg == "wos_tf2_spy_taunt_mannrobics_straight" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 6)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)
                elseif Strg == "wos_tf2_demo_taunt_russian" or Strg == "wos_tf2_engi_taunt_russian" or Strg == "wos_tf2_heavy_taunt_russian" or Strg == "wos_tf2_medic_taunt_russian" or Strg == "wos_tf2_pyro_taunt_russian" or Strg == "wos_tf2_scout_taunt_russian" or Strg == "wos_tf2_sniper_taunt_russian" or Strg == "wos_tf2_soldier_taunt_russian" or Strg == "wos_tf2_spy_taunt_russian" then
                    NoStop = 0
                    timer.Create("AA_TMov" .. EIx, 0.1, 1, function()
                        if IsValid(ply) then
                            ply:SetNWInt("A_ActMod.MoveDir", 5)
                            ply:SetNWInt("A_AM.MoveSpeed", 60)
                        end
                    end)
                end
            elseif string.sub(Strg, 1, 9) == "amod_mmd_" then
                if Strg == "amod_mmd_pv120_shi_p1" or Strg == "amod_mmd_pv120_shi_p2" or Strg == "amod_mmd_pv120_shi_p3" then
                    CamParent = true
                    CamInLerp = 0.42
                elseif Strg == "amod_mmd_aoagoodluck" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_blablabla" then
                    CamInLerp = 0.3
                elseif Strg == "amod_mmd_chikichiki" then
                    CamParent = true
                    CamInLerp = 0.4
                elseif Strg == "amod_mmd_ghostdance" then
                    CamInLerp = 0.7
                elseif Strg == "amod_mmd_girls" then
                    CamParent = true
                    CamInLerp = 0.15
                elseif Strg == "amod_mmd_hiasobi" then
                    CamParent = true
                    CamInLerp = 0.47
                elseif Strg == "amod_mmd_hiproll" or Strg == "amod_mmd_hiproll_loop" then
                    if rres then
                        Strg = "amod_mmd_hiproll_loop"
                        GetStrg = Strg
                        time2 = 5.6
                        time = 6.7
                        NoStop = 2
                    else
                        CamInLerp = 0.4
                        time = time - 0.55
                        timer.Create("AA_TReA" .. EIx, time - 0.55, 1, function() if IsValid(ply) then ply:SetNWString("A_ActMod.Dir", "amod_mmd_hiproll_loop") end end)
                    end
                elseif Strg == "amod_mmd_mrsaxobeat" then
                    CamParent = true
                    CamInLerp = 0.45
                elseif Strg == "amod_mmd_nyaarigato" then
                    IsMMD = false
                    CamInLerp = 0.7
                elseif Strg == "amod_mmd_dance_tuni-kun" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_fiery_sarilang" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_followtheleader" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_ponponpon" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_goodbyedeclaration" then
                    CamParent = true
                    CamInLerp = 0.5
                elseif Strg == "amod_mmd_phao2phuthon_p1" then
                    NoStop = 4
                    time1 = 93.72
                    ply:SetNWInt("A_ActMod.MoveDir", 7)
                elseif Strg == "amod_mmd_s001" then
                    CamParent = true
                    CamInLerp = 0.52
                elseif Strg == "amod_mmd_s002" then
                    CamParent = true
                    CamInLerp = 0.52
                elseif Strg == "amod_mmd_s003" then
                    CamParent = true
                    CamInLerp = 0.52
                elseif Strg == "amod_mmd_s004" then
                    CamParent = true
                    CamInLerp = 0.52
                elseif Strg == "amod_mmd_s005" then
                    CamParent = true
                    CamInLerp = 0.15
                elseif Strg == "amod_mmd_s006" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_s007" then
                    CamParent = true
                    CamInLerp = 0.34
                elseif Strg == "amod_mmd_s008" then
                    CamParent = true
                    CamInLerp = 0.1
                elseif Strg == "amod_mmd_s009" then
                    CamParent = true
                    CamInLerp = 0.5
                elseif Strg == "amod_mmd_s010" then
                    CamParent = true
                    CamInLerp = 0.9
                elseif Strg == "amod_mmd_s017" then
                    CamParent = true
                    CamInLerp = 0.4
                elseif Strg == "amod_mmd_helltaker" then
                    NoStop = 4
                    time1 = 226.3
                    CamInLerp = 0.28
                elseif Strg == "amod_mmd_dance_gokurakujodo" then
                    CamParent = true
                    CamInLerp = 0.6
                    if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then time = 165 end
                elseif Strg == "amod_mmd_dance_nostalogic" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_dance_specialist" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_dance_caramelldansen" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_dance_daisukeevolution" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_whistle" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "amod_mmd_theatrical_airline_luk" or Strg == "amod_mmd_theatrical_airline_mik" or Strg == "amod_mmd_theatrical_airline_rin" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_badbadwater" then
                    CamParent = true
                    CamInLerp = 0.35
                elseif Strg == "amod_mmd_king_kanaria" then
                    CamParent = true
                    CamInLerp = 0.4
                elseif Strg == "amod_mmd_caixukun" then
                    CamInLerp = 0.5
                elseif Strg == "amod_mmd_sadcatdance" then
                    IsMMD = false
                    if rres then
                        time = 13.2
                        SRate(ply, 0.935)
                        Strg = "amod_mmd_sadcatdance_loop"
                        ply:SetNWString("A_ActMod.Dir", Strg)
                        Cycle = 0
                        ply:SetNWInt("A_AM.ActRate", 0.935)
                    else
                        timer.Create("AA_TReA" .. EIx, time - 0.4, 1, function()
                            if IsValid(ply) then
                                Strg = "amod_mmd_sadcatdance_loop"
                                ply:SetNWString("A_ActMod.Dir", Strg)
                            end
                        end)
                    end
                elseif Strg == "amod_mmd_bad_apple_l" or Strg == "amod_mmd_bad_apple_r" then
                    CamParent = true
                    CamInLerp = 0.158
                elseif Strg == "amod_mmd_gfriendrough" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "amod_mmd_massdestruction" then
                    CamParent = true
                    CamInLerp = 0.2
                elseif Strg == "amod_mmd_mememe" then
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_roki_p1" then
                    CamParent = true
                    CamInLerp = 0.07
                elseif Strg == "amod_mmd_roki_p2" then
                    CamParent = true
                    CamInLerp = 0.1
                elseif Strg == "amod_mmd_senbonzakura" then
                    CamParent = true
                    CamInLerp = 0.1
                elseif Strg == "amod_mmd_supermjopping" then
                    CamParent = true
                    CamInLerp = 0.17
                elseif Strg == "amod_mmd_nahoha" then
                    CamParent = true
                    CamInLerp = 0.02
                elseif Strg == "amod_mmd_ch4nge" then
                    CamParent = true
                    CamInLerp = 0.45
                elseif Strg == "amod_mmd_conqueror" then
                    CamParent = true
                    CamInLerp = 0.25
                elseif Strg == "amod_mmd_yoidore" then
                    CamParent = true
                    CamInLerp = 0.8
                elseif Strg == "amod_mmd_dokuhebi" then
                    CamParent = true
                    CamInLerp = 0.57
                elseif Strg == "amod_mmd_darling" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "amod_mmd_dancin" then
                    CamParent = true
                    CamInLerp = 0.05
                elseif Strg == "amod_mmd_adeepmentality" then
                    CamParent = true
                    CamInLerp = 0.7
                elseif Strg == "amod_mmd_s011" then
                    CamParent = true
                    CamInLerp = 0.8
                elseif Strg == "amod_mmd_s012" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_s013" then
                    CamParent = true
                    CamInLerp = 0.55
                elseif Strg == "amod_mmd_s014" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "amod_mmd_s015" then
                    CamParent = true
                    CamInLerp = 0.12
                elseif Strg == "amod_mmd_gimmexgimme" then
                    CamParent = true
                    CamInLerp = 1.1
                elseif Strg == "amod_mmd_yaosobi-idol" then
                    CamParent = true
                    CamInLerp = 0.5
                elseif Strg == "amod_mmd_kwlink" then
                    CamParent = true
                    CamInLerp = 0.12
                elseif Strg == "amod_mmd_lmfao" then
                    IsMMD = false
                    if rres then
                        time = 29.85
                        Cycle = 0.060732983052731
                    end
                elseif Strg == "amod_mmd_adj_1" or Strg == "amod_mmd_adj_2" then
                    IsMMD = false
                    CamInLerp = 0.7
                    NoStop = 4
                    time1 = time - 0.25
                elseif Strg == "amod_mmd_kemuthree" then
                    CamParent = true
                    CamInLerp = 0.7
                end
            elseif string.sub(Strg, 1, 5) == "amod_" then
                if Strg == "amod_dance_gangnamstyle" then
                    if rres then
                        time = 29.4
                        SRate(ply, 1.0)
                        timer.Create("AA_TReA" .. EIx, 0.2, 1, function()
                            if IsValid(ply) then
                                ply:SetNWInt("A_AM.ActRate", 1.2)
                                timer.Create("AA_TReA" .. EIx, 3.7, 1, function()
                                    if IsValid(ply) then
                                        ply:SetNWInt("A_AM.ActRate", 1.16)
                                        timer.Create("AA_TReA" .. EIx, 4.1, 1, function()
                                            if IsValid(ply) then
                                                ply:SetNWInt("A_AM.ActRate", 0.9)
                                                timer.Create("AA_TReA" .. EIx, 5, 1, function() if IsValid(ply) then ply:SetNWInt("A_AM.ActRate", 1.23) end end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)

                        timer.Create("AA_TMov" .. EIx, 14.2, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:CycleAni(ply, 0)
                                timer.Create("AA_TReA" .. EIx, 0.2, 1, function()
                                    if IsValid(ply) then
                                        ply:SetNWInt("A_AM.ActRate", 1.2)
                                        timer.Create("AA_TReA" .. EIx, 3.7, 1, function()
                                            if IsValid(ply) then
                                                ply:SetNWInt("A_AM.ActRate", 1.16)
                                                timer.Create("AA_TReA" .. EIx, 4.1, 1, function()
                                                    if IsValid(ply) then
                                                        ply:SetNWInt("A_AM.ActRate", 0.85)
                                                        timer.Create("AA_TReA" .. EIx, 5, 1, function() if IsValid(ply) then ply:SetNWInt("A_AM.ActRate", 0.85) end end)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    else
                        time = 30.7
                        SRate(ply, 0.2)
                        CamInLerp = 0.28
                        timer.Create("AA_TReA" .. EIx, 1.1, 1, function()
                            if IsValid(ply) then
                                ply:SetNWInt("A_AM.ActRate", 1.2)
                                timer.Create("AA_TReA" .. EIx, 3.7, 1, function()
                                    if IsValid(ply) then
                                        ply:SetNWInt("A_AM.ActRate", 1.16)
                                        timer.Create("AA_TReA" .. EIx, 4.1, 1, function()
                                            if IsValid(ply) then
                                                ply:SetNWInt("A_AM.ActRate", 0.9)
                                                timer.Create("AA_TReA" .. EIx, 5, 1, function() if IsValid(ply) then ply:SetNWInt("A_AM.ActRate", 0.82) end end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)

                        timer.Create("AA_TMov" .. EIx, 15.8, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:CycleAni(ply, 0)
                                ply:SetNWInt("A_AM.ActRate", 0.2)
                                timer.Create("AA_TReA" .. EIx, 0.2, 1, function()
                                    if IsValid(ply) then
                                        ply:SetNWInt("A_AM.ActRate", 1.2)
                                        timer.Create("AA_TReA" .. EIx, 3.7, 1, function()
                                            if IsValid(ply) then
                                                ply:SetNWInt("A_AM.ActRate", 1.16)
                                                timer.Create("AA_TReA" .. EIx, 4.1, 1, function()
                                                    if IsValid(ply) then
                                                        ply:SetNWInt("A_AM.ActRate", 0.9)
                                                        timer.Create("AA_TReA" .. EIx, 5, 1, function() if IsValid(ply) then ply:SetNWInt("A_AM.ActRate", 1.0) end end)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                elseif Strg == "amod_dance_macarena" then
                    time = 157.2
                    SRate(ply, 0.94)
                    CamInLerp = 0.28
                    timer.Create("AA_TReA" .. EIx, 8.85, 17, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0) end end)
                elseif Strg == "amod_dance_california_girls" then
                    if rres then
                        time = 30.88
                        Cycle = 0.133
                    else
                        time = time - 0.1
                    end
                elseif Strg == "amod_taunt_quagmire" then
                    if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then
                        time = 9.24
                        SRate(ply, 0.65)
                        timer.Create("AA_TReA" .. EIx, 4.6, 1, function() if IsValid(ply) then A_AM.ActMod:CycleAni(ply, 0.11) end end)
                    else
                        time = 5.5
                    end
                elseif Strg == "amod_am4_drliveseywalk_1" then
                    time1 = 15.67
                    NoStop = 4
                    ply:SetNWInt("A_ActMod.MoveDir", 9)
                    ply:SetNWInt("A_AM.MoveSpeed", 85)
                elseif Strg == "amod_am4_drliveseywalk_2" then
                    time1 = 31.99
                    NoStop = 4
                    ply:SetNWInt("A_ActMod.MoveDir", 9)
                    ply:SetNWInt("A_AM.MoveSpeed", 85)
                elseif Strg == "amod_am4_drliveseywalk_3" then
                    time1 = 63.9
                    NoStop = 4
                    ply:SetNWInt("A_ActMod.MoveDir", 9)
                    ply:SetNWInt("A_AM.MoveSpeed", 85)
                elseif Strg == "amod_am4_levepalestina" then
                    NoStop = 3
                    time1 = 104.1
                    time2 = time - 0.22
                    time2R = 0.31964483857155
                    aTab["RAnim2_T"] = 20.4
                    aTab["RSond_T"] = 42.6
                    CamParent = true
                    CamInLerp = 0.5
                end
            elseif string.sub(Strg, 1, 11) == "original_da" then
                if Strg == "original_dance1" then
                    CamParent = true
                    CamInLerp = 1
                elseif Strg == "original_dance2" then
                    CamParent = true
                    CamInLerp = 1
                elseif Strg == "original_dance3" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "original_dance4" then
                    CamParent = true
                    CamInLerp = 0.27
                elseif Strg == "original_dance5" then
                    CamParent = true
                    CamInLerp = 0.18
                elseif Strg == "original_dance6" then
                    CamParent = true
                    CamInLerp = 0.6
                elseif Strg == "original_dance7" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "original_dance8" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "original_dance9" then
                    CamParent = true
                    CamInLerp = 0.4
                elseif Strg == "original_dance10" then
                    CamParent = true
                    CamInLerp = 1
                elseif Strg == "original_dance11" then
                    CamParent = true
                    CamInLerp = 1
                elseif Strg == "original_dance12" then
                    CamParent = true
                    CamInLerp = 0.5
                elseif Strg == "original_dance13" then
                    CamParent = true
                    CamInLerp = 0.7
                elseif Strg == "original_dance14" then
                    CamParent = true
                    CamInLerp = 0.7
                elseif Strg == "original_dance15" then
                    CamParent = true
                    CamInLerp = 0.25
                elseif Strg == "original_dance16" then
                    CamParent = true
                    CamInLerp = 0.11
                elseif Strg == "original_dance17" then
                    CamParent = true
                    CamInLerp = 0.11
                elseif Strg == "original_dance18" then
                    CamParent = true
                    CamInLerp = 0.11
                elseif Strg == "original_dance19" then
                    CamParent = true
                    CamInLerp = 0.006
                elseif Strg == "original_dance20" then
                    CamParent = true
                    CamInLerp = 0.1
                elseif Strg == "original_dance21" then
                    CamParent = true
                    CamInLerp = 0.025
                elseif Strg == "original_dance22" then
                    CamParent = true
                    CamInLerp = 0.15
                elseif Strg == "original_dance23" then
                    CamParent = true
                    CamInLerp = 0.5
                elseif Strg == "original_dance24" then
                    CamParent = true
                    CamInLerp = 0.48
                elseif Strg == "original_dance25" then
                    CamParent = true
                    CamInLerp = 0.13
                elseif Strg == "original_dance26" then
                    CamParent = true
                    CamInLerp = 0.27
                elseif Strg == "original_dance27" then
                    CamParent = true
                    CamInLerp = 0.3
                elseif Strg == "original_dance28" then
                    CamParent = true
                    CamInLerp = 0.46
                elseif Strg == "original_dance29" then
                    CamParent = true
                    CamInLerp = 0.25
                elseif Strg == "original_dance30" then
                    CamParent = true
                    CamInLerp = 0.48
                end
            else
                if Strg == "zombie_walk_01" then
                    NoStop = 0
                    ply:SetNWInt("A_ActMod.MoveDir", 8)
                    ply:SetNWInt("A_AM.MoveSpeed", 45)
                elseif Strg == "zombie_run" then
                    NoStop = 0
                    ply:SetNWInt("A_ActMod.MoveDir", 8)
                    ply:SetNWInt("A_AM.MoveSpeed", 220)
                elseif Strg == "zombie_idle_01" then
                    NoStop = 0
                    ply:SetNWInt("A_ActMod.MoveDir", 7)
                elseif Strg == "taunt_dance" then
                    if rres then
                        Cycle = 0.335
                        time = 6.1
                    else
                        Cycle = 0.02
                        time = time - 0.5
                    end
                elseif Strg == "idle_all_02" or Strg == "idle_all_angry" or Strg == "idle_all_cower" or Strg == "idle_all_scared" or Strg == "idle_suitcase" or Strg == "menu_combine" or Strg == "menu_gman" or Strg == "menu_zombie_01" or Strg == "ragdoll" then
                    NoStop = 0
                end
            end

            if A_AM.ActMod:AA_TableBool(ActMod_GNameNoDif, Strg) == true then
                if Strg == "f_dust_off_hands" then
                    Strg = "dust_off_hands"
                    SRate(ply, 0.5)
                elseif Strg == "f_dust_off_shoulders" then
                    Strg = "dust_off_shoulders"
                    SRate(ply, 0.5)
                elseif Strg == "f_fresh" then
                    Strg = "fresh"
                    SRate(ply, 1)
                elseif Strg == "f_wolf_howl" then
                    Strg = "wolf_howl"
                    SRate(ply, 0.5)
                elseif Strg == "f_cheerleader" then
                    Strg = "cheerleader"
                    SRate(ply, 0.504)
                elseif Strg == "f_dance_swipeit" then
                    Strg = "dance_swipeit"
                    SRate(ply, 0.528)
                elseif Strg == "f_groovejam" then
                    Strg = "groovejam"
                    SRate(ply, 0.620)
                elseif Strg == "f_dance_disco_t3" then
                    Strg = "dance_disco_t3"
                    SRate(ply, 0.5135)
                elseif Strg == "f_koreaneagle" then
                    Strg = "koreaneagle"
                    SRate(ply, 0.45)
                elseif Strg == "f_infinidab" then
                    Strg = "infinidab"
                    SRate(ply, 0.555)
                elseif Strg == "f_pump_dance" then
                    Strg = "pump_dance"
                    SRate(ply, 0.53)
                elseif Strg == "f_hillbilly_shuffle" then
                    Strg = "hillbilly_shuffle"
                    SRate(ply, 0.42)
                    time = 6.2
                elseif Strg == "taunt_cheer" then
                    Strg = "taunt_cheer_base"
                    SRate(ply, 0.6)
                elseif Strg == "taunt_dance" then
                    Strg = "taunt_dance_base"
                    SRate(ply, 1.05)
                elseif Strg == "taunt_laugh" then
                    Strg = "taunt_laugh_base"
                    SRate(ply, 1.15)
                elseif Strg == "taunt_muscle" then
                    Strg = "taunt_muscle_base"
                    SRate(ply, 1.15)
                elseif Strg == "taunt_persistence" then
                    Strg = "taunt_persistence_base"
                elseif Strg == "taunt_robot" then
                    Strg = "taunt_robot_base"
                    SRate(ply, 1.15)
                end
            else
                if string.sub(Strg, 1, 2) == "f_" and not string.find(Strg, "amod_") then
                    Strg = string.Replace(Strg, "f_", "")
                    SRate(ply, 0.5)
                end
            end

            ply:SetNWBool("A_AM.ActMod.Cam_Parent", CamParent)
            ply:SetNWInt("A_AM.ActMod.CamInLerp", CamInLerp)
            ply:SetNWString("A_ActMod.Dir", Strg)
            ply:SetNWInt("A_AM.ActRate", Rate)
            if ply:GetNWBool("A_AM.ActMod.AddMo", false) == true then aTab2["mdl"] = true end
            if aOneCyc then
                if aOneCyc == 1 then
                    A_AM.ActMod:CycleAni(ply, Cycle, Cyclesv, true, true)
                elseif aOneCyc == 2 then
                    A_AM.ActMod:CycleAni(ply, Cycle, Cyclesv, true, nil)
                end
            else
                A_AM.ActMod:CycleAni(ply, Cycle, Cyclesv, nil, true)
            end

            if GetConVar("actmod_sy_tovs_strfast"):GetInt() == 1 and ply.ActMod_SFast == true then
                local So_1, So_2, So_3, So_4, Sond, Effe, Mdl, MMDOn, MMDFst = "NonE", "1", "75", "3", "0", "0", "0", "0", "0"
                ply.SVAct_Tsound = nil
                local OnSnd, OnEff
                if ply.ActMod_tAb and ply.ActMod_tAb[2] ~= nil then OnSnd = ply.ActMod_tAb[2] end
                if ply.ActMod_tAb and ply.ActMod_tAb[3] ~= nil then OnEff = ply.ActMod_tAb[3] end
                if Strg and GetConVarNumber("actmod_sv_enabled_addef") == 1 and ((OnEff and OnEff == 1) or not OnEff) then
                    aTab["Eff"] = true
                    if ply:GetNWBool("A_AM.ActMod.AddEf", false) == true and ply:A_ActModEffects() == true then
                        if string.find(string.sub(Strg, 0, 2), "f_") and not string.find(Strg, "amod_") then Strg = string.Replace(Strg, "f_", "") end
                        if GetConVar("actmod_sy_tovs_eff"):GetInt() == 2 and A_AM.ActMod:AA_TableBool(A_AM.ActMod.Ac_Geff, Strg, true) ~= true then
                            Effe = "1"
                        else
                            A_AM.ActMod:AA_AddEffects(ply, agin, Strg)
                            if ply:GetNWBool("A_AM.ActMod.AddMo", false) == true then A_AM.ActMod:AA_AddModel(ply, Strg, agin) end
                        end
                    end
                end

                if GetConVarNumber("actmod_sv_enabled_addso") == 1 and ((OnSnd and OnSnd == 1) or not OnSnd and (ply:GetNWBool("A_AM.ActMod.AddSo", false) == true or A_AM.ActMod:AA_TableBool(ActMod_GNameSAlow, Strg) == true) and ply:A_ActModSound() == true) then
                    AA_AddSound(ply, Strg, agin)
                    if ply.SVAct_Svsound then
                        Sond = "5"
                    else
                        Sond = "1"
                    end
                end

                if ply:GetNWBool("A_AM.ActMod.AddMo", false) == true then
                    aTab["mdl"] = true
                    Mdl = "1"
                end

                if ply:GetNWBool("A_AM.ActMod.AddC1", false) == true then aTab[1] = true end
                if ply:GetNWBool("A_AM.ActMod.AddC2", false) == true then aTab[2] = true end
                ply:SetNWBool("A_AM.ActMod.AddC1", false)
                ply:SetNWBool("A_AM.ActMod.AddC2", false)
                ply:SetNWBool("A_AM.ActMod.AddMo", false)
                ply:SetNWBool("A_AM.ActMod.AddEf", false)
                ply:SetNWBool("A_AM.ActMod.AddSo", false)
                if ply.SVAct_Tsound then
                    So_1 = ply.SVAct_Tsound["sound"]
                    So_2 = ply.SVAct_Tsound["SettoG"]
                    So_3 = ply.SVAct_Tsound["soundlevel"]
                    So_4 = ply.SVAct_Tsound["onSnd"]
                    ply.SVAct_Tsound = nil
                end

                if IsMMD == true and (string.find(Strg, "original_dance") or string.find(Strg, "amod_mmd")) and A_AM.ActMod:AA_TableBool(ActMod_GNameNo2, Strg) == false then
                    MMDOn = "1"
                    ply.A_ActMod_GetDir = Strg
                end

                if GetConVar("actmod_sy_tovs"):GetInt() == 1 or GetConVar("actmod_sy_tovs"):GetInt() == 3 then
                    net.Start("A_AM.ActMod.SToC_ST")
                    net.WriteEntity(NULL)
                    net.WriteString("SToC_")
                    net.WriteTable({"SToC_SFast", ply:EntIndex(), Strg, tostring(Rate), tostring(Cycle), tostring(Cyclesv), So_1, So_2, So_3, So_4, Sond, Effe, Mdl, MMDOn})
                    net.Broadcast()
                else
                    for _, pl in pairs(player.GetAll()) do
                        if IsValid(pl) and not pl:IsBot() then pl:ConCommand("actmod_wtc SToC_SFast " .. ply:EntIndex() .. " " .. Strg .. " " .. tostring(Rate) .. " " .. tostring(Cycle) .. " " .. tostring(Cyclesv) .. " " .. So_1 .. " " .. So_2 .. " " .. So_3 .. " " .. So_4 .. " " .. Sond .. " " .. Effe .. " " .. Mdl .. " " .. MMDOn .. "\n") end
                    end
                end
            else
                if GetConVar("actmod_sy_tovs_mmdfast"):GetInt() == 1 then
                    if ply:A_ActMod_GetIsAct() == false then
                        if GetConVar("actmod_sy_tovs"):GetInt() == 1 then
                            net.Start("A_AM.ActMod.StartCamera")
                            net.Send(ply)
                        else
                            ply:ConCommand("actmod_wtc SToC_SrCamr\n")
                        end
                    end
                else
                    if GetConVar("actmod_sy_tovs"):GetInt() == 1 then
                        net.Start("A_AM.ActMod.act_Tocl")
                        net.WriteString(Strg)
                        net.WriteFloat(Rate)
                        net.Broadcast()
                    else
                        for _, pl in pairs(player.GetAll()) do
                            if IsValid(pl) and not pl:IsBot() then pl:ConCommand("actmod_wtc SToC_actT " .. ply:EntIndex() .. " " .. Strg .. " " .. tostring(Rate) .. "\n") end
                        end
                    end
                end
            end

            if IsMMD == true and (string.find(Strg, "original_dance") or string.find(Strg, "amod_mmd")) and A_AM.ActMod:AA_TableBool(ActMod_GNameNo2, Strg) == false then
                if CLIENT then ply:SetNWString("A_ActMod.Dir", Strg) end
                ply:SetNWBool("A_AM.ActMod.SqAct", true)
                if GetConVar("actmod_sy_tovs_mmdfast"):GetInt() == 1 or ply.ActMod_Oall or ply:IsBot() or game.SinglePlayer() then
                    if GetConVar("actmod_sy_tovs_mmdfast"):GetInt() == 1 and not game.SinglePlayer() then
                        ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, 101020)
                    else
                        timer.Create("AA_TSTr" .. EIx, 0.15, 1, function()
                            if IsValid(ply) then
                                A_AM.ActMod:AA_GetActAddEnt(ply, Strg, rres, nil)
                                ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, 101020)
                            end
                        end)
                    end
                else
                    ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, 101020)
                    timer.Create("AA_TSTr" .. EIx, 0.01, 120, function()
                        if IsValid(ply) then
                            if ply.A_ActModOKAct_r then
                                if ply.A_ActModOKAct_r < 100 then
                                    ply.A_ActModOKAct_r = ply.A_ActModOKAct_r + 1
                                else
                                    if timer.Exists("AA_TSTr" .. ply:EntIndex()) then timer.Remove("AA_TSTr" .. ply:EntIndex()) end
                                    ply.A_ActModOKAct = nil
                                    ply.A_ActModOKAct_r = nil
                                    A_AM.ActMod:A_ActMod_OffActing(ply)
                                end
                            else
                                ply.A_ActModOKAct_r = 1
                            end

                            ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, 101020)
                            if ply.A_ActModOKAct then
                                if timer.Exists("AA_TSTr" .. ply:EntIndex()) then timer.Remove("AA_TSTr" .. ply:EntIndex()) end
                                ply.A_ActModOKAct = nil
                                ply.A_ActModOKAct_r = nil
                                A_AM.ActMod:AA_GetActAddEnt(ply, Strg, rres, nil)
                            end
                        end
                    end)
                end
            elseif ply:A_ActMod_GetSqAct() then
                ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, 100010)
                ply:SetNWBool("A_AM.ActMod.SqAct", false)
                ply.A_ActModOKAct = nil
                ply.A_ActModOKAct_r = nil
            end

            if ply:GetNWInt("A_ActMod.MoveDir", 0) > 0 then ply.ActMod_ROne = 0.8 end
            if NoStop == 1 then ply.ActMod_ROne = 0.06 end
            if NoStop then
                ply:SetNWInt("A_AM.ActTime", -2)
            else
                ply:SetNWInt("A_AM.ActTime", CurTime() + time)
            end

            if SERVER then
                if AnimationSWEP then AnimationSWEP:Toggle(ply, false) end
                if NoStop and NoStop == 0 then
                else
                    if NoStop == 3 then
                        _RLoopSond(ply, GetStrg, rres, time1, timeT, aTab)
                        timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function() if IsValid(ply) then _RLoopAnim(ply, time2, time2R, aTab) end end)
                    elseif NoStop == 4 then
                        _RLoopSond(ply, GetStrg, rres, time1, timeT, aTab)
                        ply.ActMod_ROne = 0.1
                    else
                        if NoStop and time2 then
                            A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, NoStop, rres, aTab)
                        else
                            timer.Create("AA_TEnd" .. ply:EntIndex(), math.max(0, time - 0.22), 1, function()
                                if IsValid(ply) then
                                    local OnLoop
                                    if ply.ActMod_tAb and ply.ActMod_tAb[5] ~= nil then OnLoop = ply.ActMod_tAb[5] end
                                    if aTab2 and aTab2["mdl"] then A_AM.ActMod:AA_AddModel(ply, nil, agin) end
                                    if (OnLoop and OnLoop == 1) or not OnLoop and (ply:A_ActModLoop() == 1 or ply:A_ActModLoop() == 2 and A_AM.ActMod:AA_TableBool(ActMod_GNameNoDif_Re, GetStrg) == false) then
                                        if NoStop then
                                            A_AM.ActMod:ActMod_RLoop(ply, GetStrg, time, time2, time2R, NoStop, rres, aTab)
                                        else
                                            ply:SetNWInt("A_AM.ActTime", ply:GetNWInt("A_AM.ActTime", 1) + 0.5)
                                            A_AM.ActMod:ActMod_SSTr(ply, ply:A_ActModString(), true, aTab2)
                                        end
                                    else
                                        A_AM.ActMod:A_ActMod_OffActing(ply)
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end

        ply.ActMod_JOne = true
        local TAng = ply:EyeAngles()
        ply:SetEyeAngles(Angle(0, TAng.y, TAng.r))
    else
        A_AM.ActMod:A_ActMod_OffActing(ply)
    end
end