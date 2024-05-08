A_AM.ActMod.LuaHok = true
hook.Add("InitLoadAnimations", "ActMod_ReSt", function() if SERVER then timer.Simple(0.5, function() if ASvTag then A_AM.ActMod:ReTast_Seq_restuo() end end) end end)
hook.Add("PlayerCanPickupWeapon", "0ActMod", function(ply, weap)
    if ply and IsValid(ply) and weap:GetClass() == "aact_weapact" then
        weap.GiveTo = ply
        return true
    end
end)

hook.Add("ShutDown", "AN_ShutDown", function() A_AM.ActMod.svOn = false end)
hook.Add("PlayerDisconnect", "AN_Disconnect", function(ply) ply.OffActMod = true end)
hook.Add("PlayerDisconnected", "AN_Disconnected", function(ply) ply.OffActMod = true end)
hook.Add("PlayerSpawn", "A_AM_ActMod.P_Spawn", function(ply) A_AM.ActMod:A_ActMod_OffActing(ply) end)
hook.Add("PlayerDeath", "A_AM_ActMod.P_Death", function(ply) A_AM.ActMod:A_ActMod_OffActing(ply) end)
local function RmoveHook(k, v)
    hook.Remove(k, v)
end

function A_AM.ActMod:RemoveAllhook(Jst, nR)
    local function fUt(k, v)
        if istable(v) then
            for n, f in pairs(v) do
                if isstring(n) and string.find(n, "ActMod") then
                    if nR then
                        print(k, n)
                    else
                        RmoveHook(k, n)
                    end
                end
            end
        end
    end

    for k, v in pairs(hook.GetTable()) do
        if Jst and isstring(Jst) then
            if k == Jst then fUt(k, v) end
        else
            if SERVER then if k == "OnNPCKilled" then fUt(k, v) end end
            if CLIENT then if k == "HUDWeaponPickedUp" then fUt(k, v) end end
            if k == "PlayerSpawn" then fUt(k, v) end
            if k == "PlayerDeath" then fUt(k, v) end
            if k == "Think" then fUt(k, v) end
            if k == "DoAnimationEvent" then fUt(k, v) end
            if k == "UpdateAnimation" then fUt(k, v) end
            if k == "CalcMainActivity" then fUt(k, v) end
            if k == "Move" then fUt(k, v) end
        end
    end
end

function A_AM.ActMod:A_BED(ty, txt)
    local Atxt = txt
    if Atxt ~= "" then
        if not isstring(Atxt) then Atxt = tostring(Atxt) end
        if ty == 1 then
            Atxt = util.Base64Encode(txt)
        elseif ty == 2 then
            Atxt = util.Base64Decode(txt)
        end
        return Atxt
    end
    return ""
end

function A_AM.ActMod:Setuphook()
    local aR = A_AM.ActMod.Sutep_DoneR
    local yR = tostring(aR)
    local aallow = false
    if A_AM.ActMod.GSetuphook then
        if SERVER then
            RmoveHook("Think", yR .. "ActMod_ThinkSv")
            RmoveHook("OnNPCKilled", yR .. "ActMod_Avs_KillNPC")
        elseif CLIENT then
            RmoveHook("Think", yR .. "ActMod_ThinkCl")
            RmoveHook("HUDWeaponPickedUp", yR .. "ActMod_NSw")
        end

        RmoveHook("PlayerSpawn", yR .. "A_AM_ActMod_Spawn")
        RmoveHook("PlayerDeath", yR .. "A_AM_ActMod_Death")
        RmoveHook("DoAnimationEvent", yR .. "A_AM_ActMod_DAE")
        RmoveHook("UpdateAnimation", yR .. "A_AM_ActMod_SlowDownAnim")
        RmoveHook("CalcMainActivity", yR .. "A_AM_ActMod_Animations")
        RmoveHook("Move", yR .. "A_AM_ActMod_MoveDir")
        aallow = true
    else
        RmoveHook("PlayerSpawn", "A_AM_ActMod.P_Spawn")
        RmoveHook("PlayerDeath", "A_AM_ActMod.P_Death")
    end

    A_AM.ActMod.GSetuphook = true
    A_AM.ActMod.Sutep_Done1 = true
    if aallow == true then
        A_AM.ActMod.Sutep_DoneR = A_AM.ActMod.Sutep_DoneR + 1
        aR = A_AM.ActMod.Sutep_DoneR
        yR = tostring(aR)
    end

    if SERVER then
        hook.Add("Think", yR .. "ActMod_ThinkSv", function()
            A_AM.ActMod.Think()
            A_AM.ActMod.ActMod_Sv_Avs()
        end)

        hook.Add("OnNPCKilled", yR .. "ActMod_Avs_KillNPC", function(a1, a2, a3) A_AM.ActMod.ActMod_Avs_KNPC(a1, a2, a3) end)
    end

    if CLIENT then
        hook.Add("HUDWeaponPickedUp", yR .. "ActMod_NSw", function(we) if we:GetClass() == "aact_weapact" then return false end end)
        hook.Add("Think", yR .. "ActMod_ThinkCl", function()
            A_AM.ActMod.Think(LocalPlayer())
            A_AM.ActMod.ActMod_Cl_Avs(LocalPlayer())
        end)
    end

    hook.Add("PlayerSpawn", yR .. "A_AM_ActMod_Spawn", function(ply) A_AM.ActMod:A_ActMod_OffActing(ply) end)
    hook.Add("PlayerDeath", yR .. "A_AM_ActMod_Death", function(ply) A_AM.ActMod:A_ActMod_OffActing(ply) end)
    hook.Add("DoAnimationEvent", yR .. "A_AM_ActMod_DAE", function(ply, event, data)
        local Wep
        pcall(function() Wep = aIsPlayerHoldingSwep(ply) end)
        if A_AM.ActMod.LuaSAnim and Wep ~= nil and isfunction(Wep.GetNetworkVars) and (Wep:GetState() > 0) then
            local validWep = IsPlayerValidForAnimation(p)
            if validWep ~= nil then return ACT_INVALID end
        else
            if A_AM.ActMod.Mounted["Theatrical MMD"] and event == PLAYERANIMEVENT_CUSTOM then
                local Strg = ply:AActEnt_GetActDir() or ""
                local scya = ply:AActEnt_CycleAct() or ""
                local seq, setcyc
                if data == 100110 then
                    ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_GRENADE, ply:LookupSequence("range_smg1"), 5, true)
                    return ACT_INVALID
                elseif data == 102020 then
                    seq = ply:LookupSequence(Strg)
                    setcyc = scya
                    if not seq or seq < 0 then return end
                    ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_GRENADE, seq, setcyc, true)
                    return ACT_INVALID
                end
            end

            if A_AM.ActMod.svOn == false or ply.OffActMod then return end
            if event == PLAYERANIMEVENT_CUSTOM then
                if data == 100010 then
                    ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_GRENADE, ply:LookupSequence("range_smg1"), 5, true)
                    return ACT_INVALID
                elseif data == 101020 then
                    if GetConVar("actmod_sy_tovs_mmdfast"):GetInt() == 0 and not ply:IsBot() and ply.A_ActMod_GetDir and ply.A_ActMod_GetDir == ply:A_ActMod_GetActDir() then
                        if GetConVar("actmod_sy_tovs"):GetInt() == 1 then
                            net.Start("A_AM.ActMod.ClToSv_OkAct")
                            net.WriteEntity(ply)
                            net.SendToServer()
                        else
                            ply:ConCommand("actmod_wts CToS_SvAOK\n")
                        end
                    end

                    local seq, setcyc
                    local Strg = ply:A_ActMod_GetActDir() or ""
                    local scya = ply:A_ActMod_CycleAct() or ""
                    seq = ply:LookupSequence(Strg)
                    setcyc = scya
                    if not seq or seq < 0 then return end
                    ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_GRENADE, seq, setcyc, true)
                    return ACT_INVALID
                end
            end
        end
    end)

    hook.Add("UpdateAnimation", yR .. "A_AM_ActMod_SlowDownAnim", function(ply, velocity, maxSeqGroundSpeed)
        if ply:A_ActMod_IsActing() then
            local Wep
            pcall(function() Wep = aIsPlayerHoldingSwep(ply) end)
            if A_AM.ActMod.LuaSAnim and Wep ~= nil and isfunction(Wep.GetNetworkVars) and (Wep:GetState() > 0) then
                hook.Call("AM_UATheFirst", nil, ply)
            else
                if ply:A_ActMod_RateAct() ~= 1 then
                    ply:SetPlaybackRate(ply:A_ActMod_RateAct())
                else
                    ply:SetPlaybackRate(1)
                end
                return true
            end
        end
    end)

    hook.Add("CalcMainActivity", yR .. "A_AM_ActMod_Animations", function(ply, velocity)
        if not IsValid(ply) or not ply:A_ActMod_IsActing() or ply:A_ActMod_GetSqAct() or A_IsL4DA(ply) then return end
        local Wep
        pcall(function() Wep = aIsPlayerHoldingSwep(ply) end)
        if A_AM.ActMod.LuaSAnim and Wep ~= nil and isfunction(Wep.GetNetworkVars) and (Wep:GetState() > 0) then
            local act = ply:LookupSequence("walk_suitcase")
            return act, act
        else
            local seq = ply:A_ActMod_GetActDir()
            local seqid = ply:LookupSequence(seq or "")
            if seqid == nil or seqid < 0 then return end
            if ply:A_ActMod_RateAct() ~= 1 then
                ply:SetPlaybackRate(ply:A_ActMod_RateAct())
            else
                ply:SetPlaybackRate(1)
            end
            return -1, seqid or nil
        end
    end)

    hook.Add("Move", yR .. "A_AM_ActMod_MoveDir", function(ply, mv)
        if not ply:A_ActMod_IsActing() then return end
        local vel, atr = mv:GetVelocity(), false
        if ply:A_ActMod_GetMoveDir() == 1 or ply:A_ActMod_GetMoveDir() == 9 then
            atr = true
            vel = ply:GetForward() * ply:GetNWInt("A_AM.MoveSpeed")
        elseif ply:A_ActMod_GetMoveDir() == 2 then
            atr = true
            vel = ply:GetForward() * -ply:GetNWInt("A_AM.MoveSpeed")
        elseif ply:A_ActMod_GetMoveDir() == 3 then
            atr = true
            vel = ply:GetRight() * ply:GetNWInt("A_AM.MoveSpeed")
        elseif ply:A_ActMod_GetMoveDir() == 4 then
            atr = true
            vel = ply:GetRight() * -ply:GetNWInt("A_AM.MoveSpeed")
        elseif ply:A_ActMod_GetMoveDir() == 5 or ply:A_ActMod_GetMoveDir() == 6 then
            atr = true
            if (ply.TimeGo_FORWARD or 0) > CurTime() and (ply:A_ActMod_GetMoveDir() == 6 and (ply.TimeGo_Attk or 0) < CurTime() or ply:A_ActMod_GetMoveDir() ~= 6) then
                ply.AGSped_f = math.min(ply:GetNWInt("A_AM.MoveSpeed"), ply.AGSped_f + ply:GetNWInt("A_AM.MoveSpeed") * 5 * FrameTime())
                vel = ply:GetForward() * ply.AGSped_f
                ply:SetNWInt("ply.AGSped_f", ply.AGSped_f)
                ply.AalowAnim_MForward = true
            else
                if ply.AGSped_f > 0 then
                    ply.AGSped_f = math.max(0, ply.AGSped_f - ply:GetNWInt("A_AM.MoveSpeed") * 6 * FrameTime())
                    vel = ply:GetForward() * ply.AGSped_f
                    ply:SetNWInt("ply.AGSped_f", ply.AGSped_f)
                end

                ply.AalowAnim_MForward = nil
            end
        elseif ply:A_ActMod_GetMoveDir() == 8 then
            ply:SetNWInt("ply.AGSped_f", vel:Length())
        elseif ply:A_ActMod_GetMoveDir() == 18 then
            atr = true
            if (ply.TimeGo_FORWARD or 0) > CurTime() then
                ply.AGSped_b = 0
                ply.AGSped_f = Lerp(0.04, ply.AGSped_f, ply:GetNWInt("A_AM.MoveSpeed"))
                vel = ply:GetForward() * ply.AGSped_f
            elseif (ply.TimeGo_BACK or 0) > CurTime() then
                ply.AGSped_f = 0
                if ply:GetNWString("A_ActMod.Dir", "") == "zombie_run_fast" then
                    ply.AGSped_b = Lerp(0.04, ply.AGSped_b, ply:GetNWInt("A_AM.MoveSpeed") / 5)
                else
                    ply.AGSped_b = Lerp(0.04, ply.AGSped_b, ply:GetNWInt("A_AM.MoveSpeed"))
                end

                vel = ply:GetForward() * -ply.AGSped_b
            else
                if ply.AGSped_f > 0 then
                    ply.AGSped_f = math.max(0, ply.AGSped_f - ply:GetNWInt("A_AM.MoveSpeed") * 3 * FrameTime())
                    vel = ply:GetForward() * ply.AGSped_f
                end

                if ply.AGSped_b > 0 then
                    ply.AGSped_b = math.max(0, ply.AGSped_b - ply:GetNWInt("A_AM.MoveSpeed") * 2.5 * FrameTime())
                    vel = ply:GetForward() * -ply.AGSped_b
                end
            end
        end

        if vel and (vel[1] ~= 0 or vel[2] ~= 0) and atr == true then mv:SetVelocity(vel + Angle(0, ply:EyeAngles().y, ply:EyeAngles().r):Forward()) end
    end)
end

A_AM.ActMod:Setuphook()