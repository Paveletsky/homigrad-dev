A_AM.ActMod.LuaVgi = true
if SERVER then return end
local Actoji = A_AM.ActMod.Actoji
A_AM.ActMod.FindIt = {}
local TLang = {"en", "ru", "zh-CN", "de"}
local a_actmod_enabled = GetConVar("actmod_sv_enabled")
local a_actmod_key_iconmenu = GetConVar("actmod_key_iconmenu")
local GetIDNames = {}
local function Mar_TabDat(tbl, str, hlp)
    if tbl and tbl ~= "false" then
        for k, v in pairs(tbl) do
            if hlp then print("Get_", str, "-> ", v, "==", str, v == str) end
            if str and v == str then return true end
        end
    end
    return false
end

local function AddToFvite(AName)
    local ATData = {}
    local ATDataNew = LocalPlayer():GetPData("Actojifavo", false) or false
    if ATDataNew and ATDataNew ~= "false" then ATData = util.JSONToTable(ATDataNew) end
    if ATData and A_AM.ActMod:ATabData(ATData, AName) == true then
        table.RemoveByValue(ATData, AName)
        LocalPlayer():SetPData("Actojifavo", util.TableToJSON(ATData))
    else
        surface.PlaySound("actmod/s/button9.wav")
        table.insert(ATData, AName)
        LocalPlayer():SetPData("Actojifavo", util.TableToJSON(ATData))
    end

    ATData = nil
    ATDataNew = nil
end

local function RemveFvite(AName)
    local ATData = {}
    local ATDataNew = LocalPlayer():GetPData("Actojifavo", false) or false
    if ATDataNew and ATDataNew ~= "false" then ATData = util.JSONToTable(ATDataNew) end
    if ATData and A_AM.ActMod:ATabData(ATData, AName) == true then
        surface.PlaySound("actmod/s/s2.wav")
        table.RemoveByValue(ATData, AName)
        LocalPlayer():SetPData("Actojifavo", util.TableToJSON(ATData))
    end

    ATData = nil
    ATDataNew = nil
end

local function aShowCopy(s)
    surface.PlaySound("actmod/s/lock.wav")
    if IsValid(s.trh) then s.trh:Remove() end
    s.trh = vgui.Create("DLabel", s)
    s.trh:SetSize(s:GetWide(), s:GetTall())
    s.trh:SetPos(0, 0)
    s.trh:SetText("")
    s.trh:SetAlpha(255)
    s.trh:AlphaTo(0, 0.5, 0.3, function(sa) if IsValid(s.trh) then s.trh:Remove() end end)
    s.trh.Paint = function(s, w, h)
        draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(20, 90, 200, 255))
        draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function sStNewDat(pl, Sstr)
    local TmpData = {}
    local ActDataNew = pl:GetPData("ActojiDNew1", false) or nil
    if ActDataNew and ActDataNew ~= "false" then
        local TActDataNew = util.JSONToTable(ActDataNew)
        if TActDataNew[1] and TActDataNew[1] == A_AM.ActMod.Mounted["Version ActMod"] then
            TmpData = TActDataNew
        else
            TActDataNew = {}
            table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
            TmpData = TActDataNew
            pl:SetPData("ActojiDNew1", util.TableToJSON(TmpData))
        end

        TActDataNew = nil
    else
        local TActDataNew = {}
        table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
        TmpData = TActDataNew
        LocalPlayer():SetPData("ActojiDNew1", util.TableToJSON(TmpData))
        TActDataNew = nil
    end

    if A_AM.ActMod:ATabData(TmpData, Sstr) == false and A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, Sstr) == true then
        table.insert(TmpData, Sstr)
        pl:SetPData("ActojiDNew1", util.TableToJSON(TmpData))
    end

    TmpData = nil
    ActDataNew = nil
end

local ASettings = A_AM.ActMod.Settings
local function ActLoadIcons()
    Actoji.Valid = {}
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[1])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[2])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[3])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[4])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[5])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[6])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[7])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[8])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[9])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[10])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[11])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[12])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[13])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[14])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[15])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[16])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[17])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[18])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[19])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[20])
    table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[21])
end

ActLoadIcons()
local function ActojiDefault()
    Actoji.draw = {}
    Actoji.table = {}
    Actoji.table2 = {}
    Actoji.tableh = {}
    for k, v in pairs(Actoji.Valid or {}) do
        if k > 21 then break end
        table.insert(Actoji.table, v)
    end
end

ActojiDefault()
local function ActojiClear()
    LocalPlayer():SetPData("ActojiDial", false)
    LocalPlayer():SetPData("ActojiDial2", false)
    LocalPlayer():SetPData("ActojiDialh", false)
    LocalPlayer():SetPData("ActojiDNew1", false)
    ActLoadIcons()
    ActojiDefault()
end

concommand.Add("actmod_resetactoj", function(ply, cmd, args) if ply and IsValid(ply) and ply:IsPlayer() then ActojiClear() end end)
Actoji.ButtonSize = 135
Actoji.Close = function(self, reset)
    local ply = LocalPlayer()
    ply.ActMod_MousePos = {gui.MouseX(), gui.MouseY()}
    if reset and reset == "nOw" then
        timer.Simple(0.1, function() if IsValid(ply) and input.IsKeyDown(a_actmod_key_iconmenu:GetInt()) then self:Open() end end)
    else
        if not IsValid(self.Frame) then return end
        self.Frame:AlphaTo(0, 0.1, 0, function(t, s)
            if IsValid(s) then s:Remove() end
            if reset then self:Open() end
        end)
    end
end

local function ReString(st, tam4)
    return A_AM.ActMod:ReString(st, tam4)
end

local function RvString(ara)
    return A_AM.ActMod:RvString(ara)
end

hook.Add("HUDPaint", "ActMod_Hud", function()
    local ply = LocalPlayer()
    if not (IsValid(LocalPlayer()) and LocalPlayer() == ply) then return end
    if GetConVarNumber("actmod_cl_enloading") ~= 0 and ply:GetNWInt("A_ActMod.IMeun_Num", 0) > 0 and ply:GetNWBool("A_ActMod_RedyUse", false) ~= true and not ply.ActMod_UseMenu then
        local ZW, ZH = 380, 80
        local SW, SH = ScrW() / 2 - ZW / 2, 50
        draw.RoundedBox(15, SW + 0, SH - 20, ZW, ZH + 20, Color(50, 70, 90, 150))
        draw.RoundedBox(15, SW + 0, SH - 20, ZW, 30, Color(20, 30, 50, 100))
        draw.SimpleText("ActMod  " .. aR:T("wndSetup") .. "AhmedMake400 )  V" .. A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a3", SW + ZW / 2, SH - 5, Color(180, 235, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(aR:T("wndSetup_Checks"), "ActMod_a6", SW + 2, SH + 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
        draw.SimpleText(ply:GetNWInt("A_ActMod_RedyUse_Num", 0) .. "%", "ActMod_a6", SW + ZW - 57, SH + 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
        draw.RoundedBox(10, SW + 10, SH + 40, ZW - 20, 30, Color(20, 20, 20, 150))
        draw.RoundedBox(10, SW + 10, SH + 40, ZW - 20 - (300 - ply:GetNWInt("A_ActMod_RedyUse_Num", 0) * 3), 30, Color(20, 150, 100, 150))
        local WiDl
        local PSho = ply:GetNWInt("A_ActMod_RedyUse_Num", 0)
        if PSho >= 100 then
            WiDl = aR:T("wndSetupL_HBComp")
        elseif PSho >= 97 then
            WiDl = aR:T("wndSetupL_Effects")
        elseif PSho >= 93 then
            WiDl = aR:T("wndSetupL_Background")
        elseif PSho >= 64 then
            WiDl = aR:T("wndSetupL_Emotes")
        elseif PSho >= 60 then
            WiDl = aR:T("wndSetupL_Sounds")
        elseif PSho >= 49 then
            WiDl = aR:T("wndSetupL_AaCing") .. "..."
        elseif PSho >= 36 then
            WiDl = aR:T("wndSetupL_AaCing") .. ".."
        elseif PSho >= 10 then
            WiDl = aR:T("wndSetupL_AaCing") .. "."
        else
            WiDl = aR:T("wndSetupL_Please")
        end

        draw.SimpleText(WiDl, "ActMod_a5", SW + ZW / 2, SH + 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

local function GetReadyFUse(ply)
    if ply ~= LocalPlayer() or not ply:Alive() or ply:InVehicle() or ply:Crouching() or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 0 then return false end
    if ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then return false end
    if prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3) then return false end
    if ply:GetNWBool("wOS.LS.IsGetIncapped", false) then return false end
    if (wOS and wOS.RollMod and ply:wOSIsRolling()) or ply:GetNWBool("wOS.LS.IsRolling", false) then return false end
    if ply:GetNWBool("L4DA.IsChargerAttPly", false) or ply:GetNWBool("L4DA.IsSmokerAttPly", false) or ply:GetNWBool("L4DA.IsHntrAttPly", false) or ply:GetNWBool("L4DA.IsJockeyAttPly", false) then return false end
    if not a_actmod_enabled:GetBool() or not ply:OnGround() then return false end
    return true
end

function A_AM.ActMod:GetReadyFUse(ply)
    return GetReadyFUse(ply)
end

function A_AM.ActMod:LokTabData(pl, tbl, str, hlp)
    if pl.GetTable_Avs and tbl then
        for k, v in pairs(tbl) do
            if (ReString(v["T1"]) == str or v["C1"] and ReString(v["C1"]) == str) and pl.GetTable_Avs[k] and pl.GetTable_Avs[k]["ok"] ~= "Done" then
                if hlp then print("Search_" .. k .. "->", v, pl.GetTable_Avs[k]["ok"]) end
                return true
            end
        end
    end
    return false
end

local function CTxtMos(Ow, IsH, Ty, txt, txf, aup)
    if IsH or Ow:IsHovered() then
        if IsValid(Ow.CTxg) then
            if aup then
                Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 3), gui.MouseY() - (Ow.CTxg:GetTall() + 15))
            else
                Ow.CTxg:SetPos(gui.MouseX() + 2, gui.MouseY() + (Ow.CTxg:GetTall() + 10))
            end
        else
            Ow.CTxg = vgui.Create("DLabel")
            Ow.OnRemove = function(pan) if IsValid(Ow.CTxg) then Ow.CTxg:Remove() end end
            Ow.CTxg:SetText(" " .. txt .. " ")
            Ow.CTxg:SetFont(txf)
            Ow.CTxg:SizeToContents()
            Ow.CTxg:SetDrawOnTop(true)
            Ow.CTxg:SetAlpha(0)
            Ow.CTxg:AlphaTo(255, 0.3, 0.3)
            Ow.CTxg:SetPos(gui.MouseX(), gui.MouseY() - (Ow.CTxg:GetTall() + 5))
            Ow.CTxg.Paint = function(s, w, h)
                local amov = math.max(60 + (70 * math.sin(CurTime() * 3)), 0)
                if Ty then
                    draw.RoundedBox(5, 0, 0, w, h, Color(Ty[1], Ty[2], Ty[3], math.max(0, math.min(255, Ty[4] + amov))))
                else
                    draw.RoundedBox(5, 0, 0, w, h, Color(70, 60, 155, math.max(0, math.min(255, 180 + amov))))
                end

                draw.SimpleTextOutlined(" " .. txt .. " ", txf, 0, 0, Color(0, 0, 0, 0), 0, 0, 1, Color(0, 0, 255, 255))
            end
        end
    else
        if IsValid(Ow.CTxg) then Ow.CTxg:Remove() end
    end
end

local function BTt1(bs, px, ph, zx, zh, txt)
    local SButX = vgui.Create("DButton", bs)
    SButX:SetText(txt)
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetPos(px, ph)
    SButX:SetSize(zx, zh)
    SButX:AlphaTo(255, 0.9)
    SButX.Paint = function(ss, w, h)
        if IsValid(bs) and txt == "R" and bs.tt == false then
            draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50, 255))
        else
            if ss:IsHovered() then
                if txt == "R" then
                    draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 85, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
                end
            else
                if txt == "R" then
                    draw.RoundedBox(4, 0, 0, w, h, Color(200, 200, 200, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
                end
            end
        end

        if txt == "R" then CTxtMos(ss, nil, {100, 100, 50, 140}, aR:T("LButt_LB_txt3"), "CreditsText", 1) end
    end

    SButX.DoClick = function()
        if IsValid(bs) and txt == "R" and bs.tt == false then return end
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if txt == "X" then
            if IsValid(bs) then bs:Remove() end
        elseif txt == "R" and bs.tt == true then
            local t = "actmod_keyo_"
            bs.tt = false
            LocalPlayer():ConCommand(t .. "h " .. tostring(KEY_LALT) .. "\n")
            LocalPlayer():ConCommand(t .. "1 " .. tostring(KEY_1) .. "\n")
            LocalPlayer():ConCommand(t .. "2 " .. tostring(KEY_2) .. "\n")
            LocalPlayer():ConCommand(t .. "3 " .. tostring(KEY_3) .. "\n")
            LocalPlayer():ConCommand(t .. "4 " .. tostring(KEY_4) .. "\n")
            LocalPlayer():ConCommand(t .. "5 " .. tostring(KEY_5) .. "\n")
            timer.Simple(0.3, function()
                if IsValid(bs) then
                    bs.tt = true
                    bs.ASpow()
                end
            end)
        end
    end
    return SButX
end

local function AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp)
    local buton = vgui.Create("DBinder", es)
    buton:SetPos(Gw, Gh)
    buton:SetSize(Zw, Zh)
    if alp then
        buton:SetAlpha(0)
        if alp[2] ~= 0 then
            buton:AlphaTo(255, alp[1], alp[2])
        else
            buton:AlphaTo(255, alp[1])
        end
    end

    buton:SetValue(GetConVar(txt[1]):GetInt())
    buton:SetFont(txt[2])
    buton.kyT = false
    buton.Paint = function(self, w, h)
        if buton.kyT == true then
            draw.RoundedBox(10, 0, 0, w, h, Color(math.max(200 + (55 * math.sin(CurTime() * 7)), 200), 150, 80, 255))
        else
            draw.RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 255))
        end
    end

    function buton:OnChange(num)
        if num == 66 or num == 83 or num == 107 or num == 108 or num == 109 or num == 112 or num == 113 or num == GetConVar("actmod_key_iconmenu"):GetInt() then
            buton:SetText(aR:T("AL_COS_CKy"))
            buton.kyT = true
        else
            buton.kyT = false
            RunConsoleCommand(txt[1], num)
        end
    end
    return buton
end

local function DBtO(Gw, Gh, es, NBt)
    local pgh = vgui.Create("DPanel", es)
    pgh:SetSize(110, 170)
    pgh:SetPos(Gw, Gh)
    pgh.Paint = function(ste, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(10, 20, 70, 255))
        draw.SimpleText("V", "ActMod_a6", w / 2, 45, Color(255, 255, 255, 255), 1, 1)
    end

    AC_butCh(5, 5, 100, 30, pgh, {"actmod_keyo_" .. NBt, "ChatFont"}, {0.5})
    return pgh
end

local ActMod_Iok1 = false
Actoji.Open = function(self)
    if IsValid(self.Frame) then self.Frame:Remove() end
    local w = ScrW() / 1.08
    local h = ScrH() / 1.08
    local ply = LocalPlayer()
    ply.ActMod_UseMenu = true
    if w > h then
        w = h
    else
        h = w
    end

    if ply.ActMod_MousePos then gui.SetMousePos(ply.ActMod_MousePos[1], ply.ActMod_MousePos[2]) end
    local EndFrameA = vgui.Create("DButton")
    EndFrameA:SetSize(ScrW(), ScrH())
    EndFrameA:SetText("")
    EndFrameA:SetCursor("arrow")
    EndFrameA:Center()
    EndFrameA:SetAlpha(0)
    EndFrameA.DoClick = function(s) if IsValid(self.Frame) then self.Frame:Remove() end end
    EndFrameA.Paint = function(ste, aw, ah) end
    self.Frame = vgui.Create("DPanel")
    self.Frame.OnRemove = function(pan)
        ply.ActMod_UseMenu = nil
        if IsValid(self.Loding) then self.Loding:Remove() end
        if IsValid(self.LitHelp) then self.LitHelp:Remove() end
        if IsValid(EndFrameA) then EndFrameA:Remove() end
        if IsValid(self.LitLang) then self.LitLang:Remove() end
    end

    self.Frame:SetText("")
    if (ply:GetNWBool("A_ActMod_RedyUse", false) ~= false and GetConVarNumber("actmod_cl_enloading") ~= 0) or GetConVarNumber("actmod_cl_enloading") == 0 then
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            self.Frame:SetSize(751, 488)
        else
            self.Frame:SetSize(w, h)
        end
    else
        self.Frame:SetSize(0, 0)
        self.Frame.SSz = true
        if GetConVarNumber("actmod_cl_enloading") ~= 0 then
            self.Loding = vgui.Create("DPanel")
            self.Loding:SetPos(ScrW() / 2 - 380 / 2, ScrH() / 2 - 100)
            self.Loding:SetSize(380, 80)
            self.Loding:SetText("")
            self.Loding.Paint = function(ste, aw, ah)
                draw.RoundedBox(15, 0, 0, aw, ah, Color(50, 70, 90, 150))
                draw.SimpleText(aR:T("wndSetup_Checks"), "ActMod_a6", 2, 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
                draw.SimpleText(ply:GetNWInt("A_ActMod_RedyUse_Num", 0) .. "%", "ActMod_a6", aw - 57, 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
                draw.RoundedBox(10, 10, 40, aw - 20, 30, Color(20, 20, 20, 150))
                draw.RoundedBox(10, 10, 40, aw - 20 - (300 - ply:GetNWInt("A_ActMod_RedyUse_Num", 0) * 3), 30, Color(20, 150, 100, 150))
                local WiDl
                local PSho = ply:GetNWInt("A_ActMod_RedyUse_Num", 0)
                if PSho >= 100 then
                    WiDl = aR:T("wndSetupL_HBComp")
                elseif PSho >= 98 then
                    WiDl = aR:T("wndSetupL_Effects")
                elseif PSho >= 96 then
                    WiDl = aR:T("wndSetupL_Background")
                elseif PSho >= 90 then
                    WiDl = aR:T("wndSetupL_Emotes")
                elseif PSho >= 75 then
                    WiDl = aR:T("wndSetupL_Sounds")
                elseif PSho >= 70 then
                    WiDl = aR:T("wndSetupL_AaCing") .. "..."
                elseif PSho >= 52 then
                    WiDl = aR:T("wndSetupL_AaCing") .. ".."
                elseif PSho == 10 then
                    WiDl = aR:T("wndSetupL_AaCing") .. "."
                else
                    WiDl = aR:T("wndSetupL_Please")
                end

                draw.SimpleText(WiDl, "ActMod_a5", aw / 2, 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                WiDl = nil
            end
        end
    end

    self.Frame:MakePopup()
    self.Frame:SetKeyboardInputEnabled(false)
    self.Frame:Center()
    self.Frame:SetAlpha(0)
    if GetReadyFUse(ply) == true then
        self.Frame:AlphaTo(255, 0.1)
    else
        self.Frame:AlphaTo(85, 0.1)
    end

    local function getIntercept(x, y, radius, angle, w, h)
        return x + (radius * math.sin(angle)) - (w or 0), y + (radius * -math.cos(angle)) - (h or 0)
    end

    local function DrawLine(w, h, a)
        local x, y = getIntercept(w / 2, h / 2, h / 2, a)
        surface.DrawLine(w / 2, h / 2, x, y)
    end

    local function DrOuR(w, h, WH, sA, Co)
        surface.SetDrawColor(Co)
        surface.DrawOutlinedRect(9.2 - WH, 20 - WH, w - 18.5 + WH + WH, h - 95 + WH + WH, sA)
    end

    local pi = 3.14159265
    local pr = 8.13
    self.Frame.Paint = function(s, w, h)
        if GetConVarNumber("actmod_cl_sortemote") == 2 then
            if GetConVarNumber("actmod_cl_menuformat2") == 1 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(70, 150, 255, 140))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(2, 2, 5, 180))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 2 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(120, 20, 50, 100))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(30, 70, 80, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 3 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(120, 100, 255, 70))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(2, 2, 5, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 4 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(60, 70, 70, 100))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(0, 0, 0, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 5 then
                DrOuR(w - 1, h, 10, 5, Color(90, 90, 90, 255))
                DrOuR(w, h, 5, 5, Color(90, 95, 120, 240))
                DrOuR(w, h, 1, 4, Color(90, 110, 150, 200))
                DrOuR(w, h, -3, 3, Color(110, 150, 180, 150))
            end
        else
            if GetConVarNumber("actmod_cl_menuformat") == 1 then
                surface.SetDrawColor(50, 50, 255, 150)
                DrawLine(w, h, pi / 8)
                DrawLine(w, h, pi / 2 - pi / 8)
                DrawLine(w, h, pi / 2 + pi / 8)
                DrawLine(w, h, pi - pi / 8)
                DrawLine(w, h, pi + pi / 8)
                DrawLine(w, h, pi * 1.5 - pi / 8)
                DrawLine(w, h, pi * 1.5 + pi / 8)
                DrawLine(w, h, pi * 2 - pi / 8)
                surface.SetDrawColor(50, 255, 50, 150)
                DrawLine(w, h, pi / pr)
                DrawLine(w, h, pi / 2 - pi / pr)
                DrawLine(w, h, pi / 2 + pi / pr)
                DrawLine(w, h, pi - pi / pr)
                DrawLine(w, h, pi + pi / pr)
                DrawLine(w, h, pi * 1.5 - pi / pr)
                DrawLine(w, h, pi * 1.5 + pi / pr)
                DrawLine(w, h, pi * 2 - pi / pr)
                surface.SetDrawColor(255, 50, 50, 150)
                local pr = 7.93
                DrawLine(w, h, pi / pr)
                DrawLine(w, h, pi / 2 - pi / pr)
                DrawLine(w, h, pi / 2 + pi / pr)
                DrawLine(w, h, pi - pi / pr)
                DrawLine(w, h, pi + pi / pr)
                DrawLine(w, h, pi * 1.5 - pi / pr)
                DrawLine(w, h, pi * 1.5 + pi / pr)
                DrawLine(w, h, pi * 2 - pi / pr)
            elseif GetConVarNumber("actmod_cl_menuformat") == 2 then
                local sr = 155 - (100 * math.sin(CurTime() * 0.7))
                local sg = 155 - (100 * math.sin(CurTime() * 0.4))
                local sb = 155 - (100 * math.sin(CurTime() * 0.1))
                local radius = math.min(w, h)
                local innerradius = radius / 2
                surface.DrawCircle(w / 2, h / 2, radius / 14, Color(sr, sg, sb, 30))
                surface.DrawCircle(w / 2, h / 2, radius / 13, Color(sr * 1.1, sg * 1.1, sb * 1.1, 50))
                surface.DrawCircle(w / 2, h / 2, radius / 12, Color(sr * 1.2, sg * 1.2, sb * 1.2, 70))
                surface.DrawCircle(w / 2, h / 2, radius / 11, Color(sr * 1.3, sg * 1.3, sb * 1.3, 90))
                surface.DrawCircle(w / 2, h / 2, radius / 10, Color(sr * 1.4, sg * 1.4, sb * 1.4, 100))
                surface.DrawCircle(w / 2, h / 2, radius / 9, Color(sr * 1.5, sg * 1.5, sb * 1.5, 110))
                surface.DrawCircle(w / 2, h / 2, radius / 8, Color(sr * 1.6, sg * 1.6, sb * 1.6, 120))
                surface.DrawCircle(w / 2, h / 2, radius / 7, Color(sr * 1.7, sg * 1.7, sb * 1.7, 130))
                surface.DrawCircle(w / 2, h / 2, radius / 6.2, Color(sr * 1.8, sg * 1.8, sb * 1.8, 140))
                surface.DrawCircle(w / 2, h / 2, radius / 2.04, Color(220, 240, 255, 140))
                surface.DrawCircle(w / 2, h / 2, radius / 2, Color(100, 155, 255, 140))
            end
        end

        if GetReadyFUse(ply) ~= true then
            local zw, zh = 450, 70
            local zw2, zh2 = math.max(zw - 10 + (8 * math.sin(CurTime() * 6)), 0), math.max(zh - 10 + (5 * math.sin(CurTime() * 6)), 0)
            draw.RoundedBox(10, w / 2 - (zw + 15) / 2, h / 2 - (zh + 15) / 2, zw + 15, zh + 15, Color(0, 0, 0, 255))
            draw.RoundedBox(10, w / 2 - (zw + 10) / 2, h / 2 - (zh + 10) / 2, zw + 10, zh + 10, Color(0, 0, 0, 255))
            draw.RoundedBox(10, w / 2 - zw / 2, h / 2 - zh / 2, zw, zh, Color(0, 0, 0, 255))
            draw.RoundedBox(10, w / 2 - zw2 / 2, h / 2 - zh2 / 2, zw2, zh2, Color(200, 100, 0, 255))
            local WiDl
            if ply:InVehicle() then
                WiDl = aR:T("iCantUse_inVehicle")
            elseif not ply:OnGround() then
                WiDl = aR:T("iCantUse_notFloor")
            elseif ply:Crouching() then
                WiDl = aR:T("iCantUse_Crouching")
            elseif prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3) then
                WiDl = aR:T("iCantUse_prone")
            elseif ply:GetNWBool("wOS.LS.IsGetIncapped", false) then
                WiDl = aR:T("iCantUse_helpless")
            elseif (wOS and wOS.RollMod and ply:wOSIsRolling()) or ply:GetNWBool("wOS.LS.IsRolling", false) then
                WiDl = aR:T("iCantUse_rolling")
            elseif ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then
                WiDl = aR:T("iCantUse_moving")
            end

            if WiDl then
                draw.SimpleText(WiDl, "ActMod_a1", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
                draw.SimpleText(WiDl, "ActMod_a1", w / 2 + 1, h / 2 + 1, Color(255, 255, 255, 255), 1, 1)
            end
        end
    end

    self.Frame.tr = false
    self.Frame.Think = function(s)
        local ply = LocalPlayer()
        if self.Frame.SSz == true then
            if ply:GetNWBool("A_ActMod_RedyUse", false) ~= false then
                self.Frame.SSz = nil
                self:Close(true)
            end
        else
            if GetReadyFUse(ply) == true then
                if self.Frame.tr == false then
                    self.Frame.tr = true
                    self.Frame:AlphaTo(255, 0.1)
                    return
                end
            else
                if self.Frame.tr == true then
                    self.Frame.tr = false
                    self.Frame:AlphaTo(85, 0.1)
                    return
                end
            end
        end
    end

    local function ASa(gg)
        surface.PlaySound("actmod/s/lock.wav")
        if IsValid(gg.trh) then gg.trh:Remove() end
        gg.trh = vgui.Create("DLabel", gg)
        gg.trh:SetSize(gg:GetWide(), gg:GetTall())
        gg.trh:SetPos(0, 0)
        gg.trh:SetText("")
        gg.trh:SetAlpha(255)
        gg.trh:AlphaTo(0, 0.5, 0.6, function(s) if IsValid(gg.trh) then gg.trh:Remove() end end)
        gg.trh.Think = function(s) s:SetSize(gg:GetWide(), gg:GetTall()) end
        gg.trh.Paint = function(s, w, h)
            draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
            draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    local aO = 0.2
    local aS = 0.16
    local aSi = 20
    local aSi2 = 10
    local aSi3 = -2
    local ButSize = h * 0.18
    local function MakeButton(a, aa, aba, az, aN)
        local ply = LocalPlayer()
        local vCs, BZz
        local GMat = "actmod/sm_hover.png"
        if file.Exists("materials/actmod/sm_hover2.png", "GAME") then GMat = "actmod/sm_hover2.png" end
        if aba then
            vCs = aba
        else
            vCs = self.Frame
        end

        if az then
            BZz = az
        else
            BZz = ButSize
        end

        local es = vgui.Create("DPanel", vCs)
        es:SetSize(BZz, BZz)
        local tx, ty
        if GetConVarNumber("actmod_cl_sortemote") == 2 or aba then
            tx, ty = a, aa
        else
            tx, ty = getIntercept(self.Frame:GetWide() / 2, self.Frame:GetTall() / 2, self.Frame:GetWide() / 3, a, es:GetWide() / 2, es:GetTall() / 2)
        end

        es:SetPos(tx + 5, ty + 5)
        es:SetSize(BZz - 10, BZz - 10)
        es:SetText("")
        es:SetAlpha(0)
        es.AA = false
        es.Paint = function(ste, w, h)
            if ste.AA == false then return end
            if (ply.ActMod_TimMenRe or 0) < CurTime() then
                surface.SetDrawColor(Color(255, 255, 255, 255))
            else
                surface.SetDrawColor(Color(255, 100, 100, 255))
            end

            surface.SetMaterial(Material(GMat, "noclamp smooth"))
            if GetConVarNumber("actmod_cl_stibox") > 1 then
                surface.SetMaterial(Material("materials/actmod/sm_hover" .. tostring(GetConVarNumber("actmod_cl_stibox")) .. ".png", "noclamp smooth"))
            else
                surface.SetMaterial(Material("materials/actmod/sm_hover.png", "noclamp smooth"))
            end

            surface.DrawTexturedRect(0, 0, w, h)
        end

        local e = vgui.Create("DButton", vCs)
        e:SetText("")
        e.OnRemove = function() if IsValid(e.Cmenu) then e.Cmenu:Remove() end end
        e:SetAlpha(0)
        e:AlphaTo(180, aO)
        e.Slot = aN
        local ActojiData, ActojiData_1, ActojiData_2
        ActojiData = LocalPlayer():GetPData("ActojiDial", false) or false
        if ActojiData and ActojiData ~= "false" then self.table = util.JSONToTable(ActojiData) end
        if self.table[aN] then
            if Material(ASettings["IconsActs"] .. "/" .. self.table[aN], "noclamp smooth"):IsError() then
                ActojiData_1 = Material(ASettings["IconsActs"] .. "/" .. A_AM.ActMod.AGetDitN[aN], "noclamp smooth")
                ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
                self.table[aN] = A_AM.ActMod.AGetDitN[aN]
                LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
            else
                ActojiData_1 = Material(ASettings["IconsActs"] .. "/" .. self.table[aN], "noclamp smooth")
                ActojiData_2 = self.table[aN]
            end
        else
            ActojiData_1 = Material(ASettings["IconsActs"] .. "/" .. A_AM.ActMod.AGetDitN[aN], "noclamp smooth")
            ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
            self.table[aN] = A_AM.ActMod.AGetDitN[aN]
            LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
        end

        e.Material = ActojiData_1
        e.Actoji = ActojiData_2
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

        e.DoRightClick = function(s)
            if input.IsMouseDown(MOUSE_LEFT) then
                if IsValid(e.Cmenu) then e.Cmenu:Remove() end
                local ATData = {}
                local ATDataNew = LocalPlayer():GetPData("Actojifavo", false) or false
                if ATDataNew and ATDataNew ~= "false" then ATData = util.JSONToTable(ATDataNew) end
                e.Cmenu = DermaMenu()
                e.Cmenu:AddOption(aR:T("LReplace_txt_CopyName"), function()
                    SetClipboardText(A_AM.ActMod:ReNameAct(RvString(ReString(s.Actoji))))
                    aShowCopy(s)
                end):SetIcon("icon16/page_copy.png")

                e.Cmenu:AddOption("name_act", function()
                    SetClipboardText(ReString(s.Actoji))
                    aShowCopy(s)
                end):SetIcon("icon16/page_copy.png")

                e.Cmenu:AddSpacer()
                if ATData and A_AM.ActMod:ATabData(ATData, s.Actoji) == true then
                    e.Cmenu:AddOption("Remove from F", function() RemveFvite(s.Actoji) end):SetIcon("icon16/drive_delete.png")
                else
                    e.Cmenu:AddOption(aR:T("LReplace_txt_AddF"), function() AddToFvite(s.Actoji) end):SetIcon("icon16/drive_disk.png")
                end

                e.Cmenu:Open()
            else
                self:Replace(s.Slot, aba)
                A_AM.ActMod.ClServro(ply)
            end
        end

        e.DoClick = function(s)
            if not s.Actoji then return end
            if GetReadyFUse(ply) ~= true or (ply.ActMod_TimMenRe or 0) > CurTime() then return end
            if s.GLok == true then
                ASa(s)
                return
            end

            if IsValid(self.MenuFrind) and self.MenuFrind.Enable == true then
                ply.ActMod_FrindActoji = s.Actoji
            else
                ply.ActMod_TimMenRe = CurTime() + 0.5
                ply:SetNWString("A_ActMod_cl_actLoop", s.Actoji)
                ply.AGSped_f = 0
                ply.AGSped_b = 0
                if GetConVar("actmod_sy_tovs"):GetInt() == 1 then
                    net.Start("A_AM.ActMod.Start")
                    net.WriteString(s.Actoji)
                    net.SendToServer()
                else
                    local cl_s, cl_e, cl_l = "0", "0", "0"
                    if GetConVarNumber("actmod_cl_sound") == 1 then
                        ply:SetNWBool("A_ActMod_cl_Sound", true)
                        cl_s = "1"
                    else
                        ply:SetNWBool("A_ActMod_cl_Sound", false)
                    end

                    if GetConVarNumber("actmod_cl_effects") == 1 then
                        ply:SetNWBool("A_ActMod_cl_Effects", true)
                        cl_e = "1"
                    else
                        ply:SetNWBool("A_ActMod_cl_Effects", false)
                    end

                    if GetConVarNumber("actmod_cl_loop") == 1 then
                        ply:SetNWInt("A_ActMod_cl_Loop", 1)
                        cl_l = "1"
                    elseif GetConVarNumber("actmod_cl_loop") == 2 then
                        ply:SetNWInt("A_ActMod_cl_Loop", 2)
                        cl_l = "2"
                    else
                        ply:SetNWInt("A_ActMod_cl_Loop", 0)
                    end

                    ply:ConCommand("actmod_wts wts " .. s.Actoji .. " " .. cl_s .. " " .. cl_e .. " " .. cl_l .. "\n")
                end

                self:Close()
                sStNewDat(ply, ReString(e.Actoji))
            end
        end

        e.b = true
        e.ba = false
        e:SetSize(BZz, BZz + 20)
        local x, y
        if GetConVarNumber("actmod_cl_sortemote") == 2 or aba then
            x, y = a, aa
        else
            x, y = getIntercept(vCs:GetWide() / 2, vCs:GetTall() / 2, vCs:GetWide() / 3, a, e:GetWide() / 2, e:GetTall() / 2)
        end

        e:SetSize(BZz - 10, BZz + 10)
        e:SizeTo(BZz, BZz + 20, aO, 0, -1, function(t, s) s.b = false end)
        e:SetPos(x + 5, y + 5)
        e:MoveTo(x, y, aO)
        e.posX = x
        e.posY = y
        e.Think = function(s)
            if s:IsHovered() and GetReadyFUse(ply) == true then
                if s.b == false and s.ba == false then
                    s.ba = true
                    es.AA = true
                    s:AlphaTo(255, aS)
                    es:AlphaTo(255, aS)
                    s:MoveTo(s.posX - (aSi / 2), s.posY - (aSi / 2), aS)
                    es:MoveTo(s.posX - (aSi2 / 2), s.posY - (aSi2 / 2), aS)
                    s:SizeTo(BZz + aSi, BZz + aSi + 20, aS, 0, -1, function()
                        s.ba = false
                        s.b = true
                        s.rh:AlphaTo(255, 0.2)
                    end)

                    es:SizeTo(BZz + aSi2, BZz + aSi2, aS, 0, -1)
                end
            else
                if s.b == true and s.ba == false then
                    s.ba = true
                    s:AlphaTo(160, aS)
                    es:AlphaTo(0, aS)
                    s:MoveTo(s.posX, s.posY, aS)
                    es:MoveTo(s.posX, s.posY, aS)
                    s:SizeTo(BZz, BZz + 20, aS, 0, -1, function()
                        s.ba = false
                        s.b = false
                        es.AA = false
                        s.rh:AlphaTo(0, 0.2)
                    end)

                    es:SizeTo(BZz, BZz, aS, 0, -1)
                end
            end
        end

        local NIcon
        local shv = ReString(e.Actoji)
        local si_Gmod_Taunt = A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, shv) == true and not string.find(shv, "amod_") and not string.find(shv, "wos_tf2_")
        local si_AM4_Amod = (string.find(shv, "amod_") or string.find(shv, "amod_am4_") or string.find(shv, "amod_m_")) and not string.find(shv, "amod_pubg_") and not string.find(shv, "amod_mixamo_") and not string.find(shv, "amod_mmd_") and not string.find(shv, "amod_fortnite_")
        local si_AM4_PUBG = string.find(shv, "amod_pubg_")
        local si_AM4_Mixamo = string.find(shv, "amod_mixamo_")
        local si_AM4_MMD = string.find(shv, "amod_mmd_")
        local si_AM4_Fortnite = string.find(shv, "amod_fortnite_")
        local si_CTA_MMD = string.find(shv, "original_dance")
        local si_CTA_Fortnite = string.find(string.sub(shv, 1, 2), "f_") and not string.find(shv, "original_dance") and not string.find(shv, "amod_")
        local si_CTA_TF2 = string.find(shv, "wos_tf2_")
        e.Paint = function(s, w, h)
            if not s.Material then return end
            surface.SetDrawColor(color_white)
            surface.SetMaterial(s.Material)
            surface.DrawTexturedRect(0, 0, w, h - 20)
            if s:IsHovered() then
                local amov = 10 + (10 * math.sin(CurTime() * 3))
                surface.SetDrawColor(Color(255, 255, 255, math.max(155 + (100 * math.sin(CurTime() * 3)) * 1.5, 0)))
                if si_Gmod_Taunt then
                    surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
                    NIcon = "( G )"
                elseif si_AM4_Amod then
                    surface.SetMaterial(Material("actmod/imenu/is_am4.png", "noclamp smooth"))
                    NIcon = "AM4"
                elseif si_AM4_PUBG then
                    surface.SetMaterial(Material("actmod/imenu/is_pubg.png", "noclamp smooth"))
                    NIcon = "AM4"
                elseif si_AM4_Mixamo then
                    surface.SetMaterial(Material("actmod/imenu/is_mixamo.png", "noclamp smooth"))
                    NIcon = "AM4"
                elseif si_AM4_MMD then
                    surface.SetMaterial(Material("actmod/imenu/is_mmd2.png", "noclamp smooth"))
                    NIcon = "AM4"
                elseif si_AM4_Fortnite then
                    surface.SetMaterial(Material("actmod/imenu/Is_fortnite.png", "noclamp smooth"))
                    NIcon = "AM4"
                elseif si_CTA_MMD then
                    surface.SetMaterial(Material("actmod/imenu/is_mmd.png", "noclamp smooth"))
                    NIcon = "CTA"
                elseif si_CTA_Fortnite then
                    surface.SetMaterial(Material("actmod/imenu/Is_fortnite.png", "noclamp smooth"))
                    NIcon = "CTA"
                elseif si_CTA_TF2 then
                    surface.SetMaterial(Material("actmod/imenu/is_team_fortress2.png", "noclamp smooth"))
                    NIcon = "TF2"
                else
                    surface.SetMaterial(Material("icon64/tool.png", "noclamp smooth"))
                    NIcon = "None"
                end

                surface.DrawTexturedRect(10 - amov / 2, 10 - amov / 2, 20 + amov, 20 + amov)
                draw.RoundedBox(10, 0, 40, 40, 21, Color(20, 20, 30, math.max(-150 + amov * 25, 0)))
                draw.SimpleText(NIcon, "ActMod_a3", 20, 50, Color(180, 255, 255, math.max(-130 + amov * 15, 0)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        e.rh = vgui.Create("DLabel", e)
        e.rh:SetText(" " .. A_AM.ActMod:ReNameAct(RvString(ReString(e.Actoji))) .. " ")
        e.rh:SetFont("ActMod_a4")
        e.rh:SizeToContents()
        e.rh:SetAlpha(0)
        e.rh:SetPos((BZz + aSi) / 2 - e.rh:GetWide() / 2, e:GetTall() + 8)
        e.rh.Paint = function(s, w, h) if e:IsHovered() then draw.RoundedBox(2, 0, 0, w, h, Color(20, 20, 20, 200)) end end
        return e
    end

    if GetConVarNumber("actmod_cl_sortemote") == 2 then
        local GTup = 30
        local Ms = (self.Frame:GetWide() / 135) * 9
        local GTdo = self.Frame:GetTall() - 240
        MakeButton(20, GTup, nil, nil, 9)
        MakeButton(155 + Ms, GTup, nil, nil, 10)
        MakeButton(300 + Ms * 2, GTup, nil, nil, 11)
        MakeButton(445 + Ms * 3, GTup, nil, nil, 12)
        MakeButton(20, GTdo, nil, nil, 13)
        MakeButton(155 + Ms, GTdo, nil, nil, 14)
        MakeButton(300 + Ms * 2, GTdo, nil, nil, 15)
        MakeButton(445 + Ms * 3, GTdo, nil, nil, 16)
        GTup = nil
        Ms = nil
        GTdo = nil
    else
        MakeButton(0, nil, nil, nil, 1)
        MakeButton(pi / 4, nil, nil, nil, 2)
        MakeButton(pi / 2, nil, nil, nil, 3)
        MakeButton(pi - pi / 4, nil, nil, nil, 4)
        MakeButton(pi, nil, nil, nil, 5)
        MakeButton(pi + pi / 4, nil, nil, nil, 6)
        MakeButton(pi * 1.5, nil, nil, nil, 7)
        MakeButton(pi * 1.5 + pi / 4, nil, nil, nil, 8)
    end

    local ess = vgui.Create("DPanel", self.Frame)
    ess.t = false
    if GetConVarNumber("actmod_cl_sortemote") == 2 then
        ess:SetSize(200, 47)
        ess:SetPos(self.Frame:GetWide() / 2 - ess:GetWide() / 2, self.Frame:GetTall() - 50.5)
    else
        ess:SetSize(100, 90)
        ess:SetPos(self.Frame:GetWide() / 2 - ess:GetWide() / 2, self.Frame:GetTall() / 2 - ess:GetWide() / 2 + 6)
    end

    ess:SetText("")
    ess.Paint = function(ste, w, h) draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 100)) end
    local function DBtt(Gw, Gh, GCN, GSN)
        local DBu = vgui.Create("DButton", ess)
        DBu:SetPos(Gw, Gh)
        DBu:SetSize(38, 38)
        DBu:SetText("")
        DBu.Cmo = GCN
        DBu.Paint = function(ste, w, h)
            if GSN == "actmod_sv_enabled_addso" or GSN == "actmod_sv_enabled_addef" then
                if ste:IsHovered() then
                    surface.SetDrawColor(Color(80, 255, 255, 255))
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end
            elseif GCN == "A_BETT_2" then
                if A_AM.ActMod.ActGrpP then
                    if ste:IsHovered() then
                        surface.SetDrawColor(Color(80, 255, 255, 255))
                        surface.DrawOutlinedRect(0, 0, w, h, 2)
                    end
                elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 then
                    if ste:IsHovered() then
                        surface.SetDrawColor(Color(200, 220, 200, 255))
                        surface.DrawOutlinedRect(0, 0, w, h, 2)
                    else
                        surface.SetDrawColor(Color(math.max(200 + (255 * math.sin(CurTime() * 6)) * 1.5, 100), math.max(210 + (255 * math.sin(CurTime() * 6)) * 1.5, 110), 200, 255))
                        surface.DrawOutlinedRect(0, 0, w, h, 2)
                    end
                elseif not A_AM.ActMod.ActGrpP then
                    if ste:IsHovered() then
                        surface.SetDrawColor(Color(180, 170, 150, 255))
                        surface.DrawOutlinedRect(0, 0, w, h, 2)
                    end
                end
            else
                if ste:IsHovered() then
                    surface.SetDrawColor(Color(80, 255, 255, 255))
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end
            end

            surface.SetDrawColor(color_white)
            if GSN == "actmod_sv_enabled_addso" then
                if GetConVarNumber(GSN) == 1 then
                    if GetConVarNumber(GCN) == 1 then
                        surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
                    else
                        surface.SetMaterial(Material("icon16/sound_mute.png", "noclamp smooth"))
                    end
                else
                    surface.SetMaterial(Material("icon32/muted.png", "noclamp smooth"))
                end
            elseif GSN == "actmod_sv_enabled_addef" then
                if GetConVarNumber(GSN) == 1 then
                    if GetConVarNumber(GCN) == 1 then
                        surface.SetMaterial(Material("actmod/imenu/ic_star_01.png", "noclamp smooth"))
                    else
                        surface.SetMaterial(Material("actmod/imenu/ic_star_02.png", "noclamp smooth"))
                    end
                else
                    surface.SetMaterial(Material("icon16/delete.png", "noclamp smooth"))
                end
            elseif GCN == "A_BETT_1" then
                surface.SetMaterial(Material("icon16/keyboard_add.png", "noclamp smooth"))
                CTxtMos(ste, nil, {100, 150, 200, 130}, aR:T("LButt_LB_txt0"), "CreditsText")
            elseif GCN == "A_BETT_2" then
                surface.SetMaterial(Material("icon16/group_link.png", "noclamp smooth"))
                if A_AM.ActMod.ActGrpP then
                    CTxtMos(ste, nil, {100, 150, 200, 130}, aR:T("LButt_LC_txt1"), "CreditsText")
                elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 then
                    CTxtMos(ste, nil, {110, 150, 100, 110}, string.format(aR:T("LButt_LC_txt0t"), "90,000"), "CreditsText")
                elseif not A_AM.ActMod.ActGrpP then
                    CTxtMos(ste, nil, {200, 150, 100, 110}, aR:T("LButt_LC_txt0"), "CreditsText")
                end
            end

            surface.DrawTexturedRect(3, 3, w - 6, h - 6)
        end

        DBu.DoClick = function(s)
            if GCN == "A_BETT_1" then
                surface.PlaySound("garrysmod/ui_click.wav")
                if IsValid(DBu.pgh) then
                    DBu.pgh:Remove()
                    DBu.pgh = nil
                else
                    local txt1 = aR:T("LButt_LB_txt1")
                    local aZtxt1 = A_AM.ActMod:AZtxt(txt1, "ChatFont")
                    local aa_self = vgui.Create("DButton")
                    aa_self:SetSize(ScrW(), ScrH())
                    aa_self:SetText("")
                    aa_self:MakePopup()
                    aa_self:SetCursor("arrow")
                    aa_self:Center()
                    aa_self:SetAlpha(0)
                    aa_self.DoClick = function() if IsValid(DBu.pgh) then DBu.pgh:Remove() end end
                    DBu.pgh = vgui.Create("DFrame", self.Frame)
                    local pgh = DBu.pgh
                    pgh:MakePopup()
                    pgh:SetSize(638, 220)
                    pgh:SetPos(ScrW() / 2 - pgh:GetWide() / 2, ScrH() / 2 - pgh:GetTall() / 2)
                    pgh:SetTitle("")
                    pgh:SetDraggable(false)
                    pgh:ShowCloseButton(false)
                    pgh.tt = true
                    pgh.OnRemove = function() if IsValid(aa_self) then aa_self:Remove() end end
                    pgh.Paint = function(ste, w, h)
                        draw.RoundedBox(10, 0, 0, w, h, Color(90, 100, 200, 255))
                        draw.RoundedBox(10, 5, 30, w - 10, h - 40, Color(50, 50, 100, 255))
                        draw.SimpleText(txt1, "ChatFont", 30, 15, Color(255, 255, 155, 255), 0, 1)
                        draw.SimpleText(aR:T("LButt_LB_txt2"), "ChatFont", 140 + aZtxt1, 15, Color(255, 255, 155, 255), 0, 1)
                    end

                    local DBuBox = vgui.Create("DCheckBoxLabel", pgh)
                    DBuBox:SetPos(10, 8)
                    DBuBox:SetText("")
                    DBuBox:SetConVar("actmod_cl_allowkey")
                    DBuBox:SetSize(15, 15)
                    if GetConVarNumber("actmod_cl_allowkey") ~= 0 then pgh.xt = BTt1(pgh, pgh:GetWide() - 35, 5, 25, 20, "X") end
                    pgh.rt = BTt1(pgh, pgh:GetWide() - 65, 5, 25, 20, "R")
                    local aa, ga_w, ga_h, ea, z, va = 15, 127, 100, pgh, 100, 65
                    pgh.ASpow = function(s)
                        if pgh.tt == false then return end
                        if IsValid(pgh.bH) then
                            pgh.bH:Remove()
                            pgh.bH = nil
                        end

                        pgh.bH = AC_butCh(aZtxt1 + 35, 8, 100, 15, pgh, {"actmod_keyo_h", "ChatFont"})
                        if IsValid(pgh.ASp1) then
                            pgh.ASp1:Remove()
                            pgh.ASp1 = nil
                        end

                        pgh.ASp1 = DBtO(aa - 5, ga_h - va, pgh, 1)
                        if IsValid(pgh.ASp2) then
                            pgh.ASp2:Remove()
                            pgh.ASp2 = nil
                        end

                        pgh.ASp2 = DBtO(aa - 5 + ga_w, ga_h - va, pgh, 2)
                        if IsValid(pgh.ASp3) then
                            pgh.ASp3:Remove()
                            pgh.ASp3 = nil
                        end

                        pgh.ASp3 = DBtO(aa - 5 + ga_w * 2, ga_h - va, pgh, 3)
                        if IsValid(pgh.ASp4) then
                            pgh.ASp4:Remove()
                            pgh.ASp4 = nil
                        end

                        pgh.ASp4 = DBtO(aa - 5 + ga_w * 3, ga_h - va, pgh, 4)
                        if IsValid(pgh.ASp5) then
                            pgh.ASp5:Remove()
                            pgh.ASp5 = nil
                        end

                        pgh.ASp5 = DBtO(aa - 5 + ga_w * 4, ga_h - va, pgh, 5)
                        MakeButton(aa, ga_h, ea, z, 17)
                        MakeButton(aa + ga_w, ga_h, ea, z, 18)
                        MakeButton(aa + ga_w * 2, ga_h, ea, z, 19)
                        MakeButton(aa + ga_w * 3, ga_h, ea, z, 20)
                        MakeButton(aa + ga_w * 4, ga_h, ea, z, 21)
                        pgh.tt = true
                    end

                    pgh.ASpow()
                    pgh.ALoked = function(s)
                        local txt1 = aR:T("LButt_LB_txt4")
                        local aZtxt1 = A_AM.ActMod:AZtxt(txt1, "CloseCaption_Bold")
                        pgh.loked = vgui.Create("DPanel", pgh)
                        pgh.loked:SetSize(pgh:GetWide(), pgh:GetTall())
                        if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
                        pgh.loked.Paint = function(ste, w, h)
                            draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 70, 200))
                            draw.SimpleText(">", "CloseCaption_Bold", w / 2 - (aZtxt1 / 2 + 15 + 20 + (20 * math.sin(CurTime() * 7))), h / 2 + 20, Color(200, 255, 255, 255), 1, 1)
                            draw.SimpleText("<", "CloseCaption_Bold", w / 2 + (aZtxt1 / 2 + 15 + 20 + (20 * math.sin(CurTime() * 7))), h / 2 + 20, Color(200, 255, 255, 255), 1, 1)
                        end

                        local DBa = vgui.Create("DButton", pgh.loked)
                        DBa:SetSize(10 + aZtxt1, 40)
                        DBa:SetPos(pgh:GetWide() / 2 - DBa:GetWide() / 2, pgh:GetTall() / 2)
                        DBa:SetText("")
                        DBa.Paint = function(ste, w, h)
                            draw.RoundedBox(15, 0, 0, w, h, Color(100, 150, 100, 200))
                            draw.RoundedBox(10, 0, 0, w, h, ste:IsDown() and Color(100, 130, 100, 255) or ste:IsHovered() and Color(100, 150, 200, 200) or Color(100, 100, 100, 200))
                            draw.SimpleText(txt1, "CloseCaption_Bold", w / 2, h / 2, Color(200, 255, 255, 255), 1, 1)
                        end

                        DBa.DoClick = function(s)
                            LocalPlayer():ConCommand("actmod_cl_allowkey 1\n")
                            if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
                        end

                        if IsValid(pgh.xt) then
                            pgh.xt:Remove()
                            pgh.xt = nil
                        end

                        pgh.xt = BTt1(pgh, pgh:GetWide() - 35, 5, 25, 20, "X")
                    end

                    if GetConVarNumber("actmod_cl_allowkey") == 0 then pgh.ALoked() end
                    if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
                end
            elseif GCN == "A_BETT_2" then
                if A_AM.ActMod.ActGrpP then
                    surface.PlaySound("garrysmod/ui_click.wav")
                    A_AM.ActMod.ActGrpP:OMenu(LocalPlayer())
                elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 and A_AM.ActMod.autDon_URL and A_AM.ActMod.autDon_URL ~= "" then
                    gui.OpenURL(A_AM.ActMod.autDon_URL)
                else
                    surface.PlaySound("garrysmod/ui_return.wav")
                end
            else
                if GetConVarNumber(s.Cmo) == 1 then
                    RunConsoleCommand(s.Cmo, "0")
                else
                    RunConsoleCommand(s.Cmo, "1")
                end

                surface.PlaySound("garrysmod/ui_click.wav")
            end
        end
    end

    if GetConVarNumber("actmod_cl_sortemote") == 1 then
        DBtt(5, 4, "actmod_cl_sound", "actmod_sv_enabled_addso")
        DBtt(ess:GetWide() - 42, 4, "actmod_cl_effects", "actmod_sv_enabled_addef")
        DBtt(5, 48, "A_BETT_1")
        DBtt(ess:GetWide() - 42, 48, "A_BETT_2")
    else
        DBtt(5, 5, "actmod_cl_sound", "actmod_sv_enabled_addso")
        DBtt(55, 5, "actmod_cl_effects", "actmod_sv_enabled_addef")
        DBtt(106, 5, "A_BETT_1")
        DBtt(158, 5, "A_BETT_2")
    end

    local function RGR_Table_Ply(Ply, Ret)
        Ply.GetR_Table_Ply = Ret and Ply.GetR_Table_Ply or {
            ["GetRequirements"] = {
                ["IMeun_Num"] = 0,
                ["IMeun_Tiyp"] = 0,
                ["Base_wOS_xdR"] = 0,
                ["Base_AM4"] = 0,
                ["Anim_CTE"] = 0,
                ["Anim_AM4"] = 0,
                ["Sound_CTM"] = 0,
                ["Sound_AM4"] = 0
            },
            ["GetConCl"] = {
                ["GetConN_actmod_cl_menuformat"] = 0,
                ["GetConN_actmod_cl_menuformat2"] = 0,
                ["GetConN_actmod_cl_loop"] = 0,
                ["GetConN_actmod_cl_effects"] = 0,
                ["GetConN_actmod_cl_sound"] = 0,
                ["GetConN_actmod_cl_thememenu"] = 0,
                ["GetConN_actmod_cl_stext"] = "nil",
                ["GetConN_actmod_cl_showmodl"] = 0,
                ["GetConN_actmod_cl_sortemote"] = 0,
                ["GetConN_actmod_cl_setcamera"] = 0,
                ["GetConN_actmod_cl_showbhelp"] = 0
            },
            ["GetIcoUseCl"] = {
                ["GetIco_1"] = "",
                ["GetIco_2"] = "",
                ["GetIco_3"] = "",
                ["GetIco_4"] = "",
                ["GetIco_5"] = "",
                ["GetIco_6"] = "",
                ["GetIco_7"] = "",
                ["GetIco_8"] = "",
                ["GetIco2_1"] = "",
                ["GetIco2_2"] = "",
                ["GetIco2_3"] = "",
                ["GetIco2_4"] = "",
                ["GetIco2_5"] = "",
                ["GetIco2_6"] = "",
                ["GetIco2_7"] = "",
                ["GetIco2_8"] = ""
            }
        }
    end

    local function MakeScroll(selfG)
        local zia1 = 25
        local Scroll = vgui.Create("AM4_DScrollPanel", selfG)
        Scroll:SetPos(5, 62)
        Scroll:SetSize(selfG:GetWide() - 5, 310)
        Scroll.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w - 5, h, Color(20, 20, 20, 220)) end
        local b = Scroll:GetVBar()
        function b.btnUp:Paint(w, h)
        end

        function b.btnDown:Paint(w, h)
        end

        function b:Paint(w, h)
            draw.RoundedBox(0, w / 2 - 2, 0, 5, h, Color(50, 90, 70, 255))
        end

        function b.btnGrip:Paint(w, h)
            draw.RoundedBox(4, w / 2 - 3, 0, 6, h, Color(40, 120, 150, 255))
        end

        local List
        local Buttons = {}
        local zzx, zzy = Scroll:GetWide(), 64
        List = vgui.Create("DIconLayout", Scroll)
        List:SetPos(0, 0)
        List:SetSize(Scroll:GetWide(), Scroll:GetTall())
        List:SetSpaceY(zzx / 20)
        List:SetSpaceX(zzy)
        local function GZeroTeb(vply)
            local tab = vply.GetR_Table_Ply
            if tab["GetRequirements"]["Base_wOS_xdR"] == 0 and tab["GetRequirements"]["Base_AM4"] == 0 and tab["GetRequirements"]["Anim_CTE"] == 0 and tab["GetRequirements"]["Anim_AM4"] == 0 and tab["GetRequirements"]["Sound_CTM"] == 0 and tab["GetIcoUseCl"]["GetIco_1"] == "" and tab["GetIcoUseCl"]["GetIco2_1"] == "" and tab["GetConCl"]["GetConN_actmod_cl_effects"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_sound"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_menuformat"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_menuformat2"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_stext"] == "nil" then
                return true
            else
                return false
            end
        end

        local function MakeButton(vply, demoe)
            if demoe then
                local Gtry = 0
                local TxtL = "Loading....."
                local Txts = (game.SinglePlayer() and aR:T("LORTR_S_TV")) or (game.MaxPlayers() > 1 and aR:T("LORTR_S_SV")) or aR:T("LORTR_S_NV")
                local ListItem = List:Add("DButton")
                table.insert(Buttons, ListItem)
                ListItem:SetSize(zzx, zzy)
                ListItem:SetText("")
                ListItem.Geting = false
                local function GThttp()
                    Gtry = Gtry + 1
                    if Gtry == 1 or Gtry == 3 or Gtry == 5 then A_AM.ActMod.ClServro(LocalPlayer()) end
                end

                ListItem.DoClick = function(s)
                    A_AM.ActMod.ReHFG = 0
                    A_AM.ActMod.TVersion = nil
                    A_AM.ActMod.HFGtrue = nil
                    Gtry = 0
                    GThttp()
                    surface.PlaySound("garrysmod/ui_click.wav")
                    if timer.Exists("ATmp_https") then timer.Remove("ATmp_https") end
                    timer.Create("ATmp_https", 1.5, 5, function() if IsValid(ListItem) then GThttp() end end)
                end

                ListItem.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end
                    if s:IsHovered() then
                        if A_AM.ActMod.HFGtrue then
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 180, 180, 255)) or Color(70, 80, 160, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 150, 110, 255)) or Color(180, 170, 30, 105))
                        end
                    else
                        if A_AM.ActMod.HFGtrue then
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(90, 100, 120, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(130, 60, 30, 150))
                        end
                    end
                end

                local iin = vgui.Create("DLabel", ListItem)
                iin:SetText("")
                iin:SetSize(230, 64)
                iin:SetFont("ActMod_a1")
                iin:SetAlpha(255)
                iin.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end
                    if A_AM.ActMod.HFGtrue and A_AM.ActMod.TVersion then
                        draw.SimpleText(aR:T("LORTR_S_Sh"), "ActMod_a3", 2, 1, Color(155, 255, 255, 155 + (100 * math.sin(CurTime() * 7))))
                        draw.SimpleText(aR:T("LORTR_S_LV"), "ActMod_a6", 2, 19, Color(155, 255, 255, 155 + (100 * math.sin(CurTime() * 7))))
                        draw.SimpleText(A_AM.ActMod.TVersion, "ActMod_a6", w - 33, 19, Color(155, 255, 255, 155 + (100 * math.sin(CurTime() * 7))))
                        if A_AM.ActMod.TVersion < tonumber(A_AM.ActMod.Mounted["Version ActMod"]) then
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(155, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w - 33, 40, Color(255, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                        elseif A_AM.ActMod.TVersion == tonumber(A_AM.ActMod.Mounted["Version ActMod"]) then
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(155, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w - 33, 40, Color(155, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                        else
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(255, 155, 55, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w - 33, 40, Color(255, 155, 55, 155 + (100 * math.sin(CurTime() * 7))))
                        end
                    elseif Gtry == 6 then
                        draw.SimpleText(aR:T("LORTR_S_FTC"), "ActMod_a1", w / 2, h / 2 - 15, Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 7))), 1, 1)
                        draw.SimpleText(aR:T("LORTR_S_FTC2"), "ActMod_a1", w / 2, h / 2 + 15, Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 7))), 1, 1)
                    elseif Gtry ~= 0 then
                        draw.SimpleText(string.sub(TxtL, 1, 7 + Gtry), "ActMod_a1", w / 2, h / 2, Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 7))), 1, 1)
                    else
                        draw.SimpleText(aR:T("LORTR_S_CH"), "ActMod_a1", w / 2, h / 2 - 15, Color(255, 255, 255, 200 + (55 * math.sin(CurTime() * 5))), 1, 1)
                        draw.SimpleText(aR:T("LORTR_S_CH2"), "ActMod_a1", w / 2, h / 2 + 15, Color(255, 255, 255, 200 + (55 * math.sin(CurTime() * 5))), 1, 1)
                    end
                end
            else
                RGR_Table_Ply(vply, true)
                local ListItem = List:Add("DButton")
                table.insert(Buttons, ListItem)
                ListItem:SetSize(zzx, zzy)
                ListItem:SetText("")
                ListItem.filePly = vply
                ListItem.NPly = vply:Nick()
                ListItem.Geting = false
                if IsValid(self.MenuEror) then self.MenuEror.litI = ListItem end
                local function CMListP(selfG)
                    if timer.Exists("ATmp_CMLit") then timer.Remove("ATmp_CMLit") end
                    if IsValid(self.Frame.es) then self.Frame.es:Remove() end
                    local tabA = selfG.GetR_Table_Ply
                    local function Bdt(ps1, ps2, tcon)
                        local rh = vgui.Create("DPanel", self.Frame.es)
                        rh:SetPos(ps1, ps2)
                        rh:SetSize(270, 40)
                        rh:SetText("")
                        rh:SetAlpha(255)
                        rh.ttaa = false
                        rh.Paint = function(s, w, h)
                            if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                            if s:IsHovered() then
                                draw.RoundedBox(10, 0, 0, w, h, Color(60, 60, 80, 255))
                            else
                                draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
                            end

                            surface.SetDrawColor(color_white)
                            if tcon == "GetConN_actmod_cl_loop" then
                                draw.SimpleText(aR:T("LReplace_TLoop"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/control_repeat_blue.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/control_equalizer_blue.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/control_stop_blue.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_sound" then
                                draw.SimpleText(aR:T("LReplace_txt_Sound"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/sound_mute.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_effects" then
                                draw.SimpleText(aR:T("LReplace_txt_Effects"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/ic_star_01.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/ic_star_02.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_setcamera" then
                                draw.SimpleText(aR:T("LReplace_BxSCView"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/camera.png", "noclamp smooth"))
                            elseif tcon == "GetConN_actmod_cl_sortemote" then
                                draw.SimpleText(aR:T("LReplace_BxSEm"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/application_view_tile.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/imll1_1.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_thememenu" then
                                draw.SimpleText(aR:T("LReplace_BxCTh"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/application_xp_terminal.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/application_xp.png", "noclamp smooth"))
                                end
                            elseif tcon == "IMeun_Num" then
                                draw.SimpleText(aR:T("LReplace_BxNum"), "ActMod_a2", 95, 2, color_white)
                                if tabA["GetRequirements"][tcon] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 2 or tabA["GetRequirements"][tcon] == 3 or tabA["GetRequirements"][tcon] == 7 or tabA["GetRequirements"][tcon] == 9 then
                                    surface.SetMaterial(Material("actmod/imenu/Is_fortnite.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 4 then
                                    surface.SetMaterial(Material("actmod/imenu/is_mmd.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 5 then
                                    surface.SetMaterial(Material("actmod/imenu/is_am4.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 6 then
                                    surface.SetMaterial(Material("actmod/imenu/is_mmd2.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 10 then
                                    surface.SetMaterial(Material("actmod/imenu/is_mixamo.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                                end

                                surface.DrawTexturedRect(50, 0, 40, 40)
                                if tabA["GetRequirements"]["IMeun_Tiyp"] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/ifrom_cte.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"]["IMeun_Tiyp"] == 2 then
                                    surface.SetMaterial(Material("actmod/imenu/ifrom_am4.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_showmodl" then
                                draw.SimpleText(aR:T("LReplace_BxSModel"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/user_gray.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/image.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_stext" then
                                draw.SimpleText(aR:T("LReplace_txt_Search"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/magnifier.png", "noclamp smooth"))
                            elseif tcon == "GetConN_actmod_cl_menuformat" then
                                draw.SimpleText(aR:T("LReplace_txt_MFormat"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/pencil.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("actmod/imenu/isk1_1.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_menuformat2" then
                                draw.SimpleText(aR:T("LReplace_txt_MFormat"), "ActMod_a2", 50, 2, color_white)
                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/bullet_blue.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/bullet_red.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 3 then
                                    surface.SetMaterial(Material("icon16/bullet_purple.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 4 then
                                    surface.SetMaterial(Material("icon16/bullet_black.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 5 then
                                    surface.SetMaterial(Material("icon16/collision_on.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_showbhelp" then
                                draw.SimpleText(aR:T("AL_COS_EH"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/application_view_columns.png", "noclamp smooth"))
                            else
                                surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                            end

                            surface.DrawTexturedRect(5, 0, 40, 40)
                            if tcon == "IMeun_Num" then
                                draw.SimpleText("A_ActMod.IMeun_Num", "ActMod_a2", 95, 20, color_white)
                            else
                                draw.SimpleText(string.sub(tcon, 9), "ActMod_a3", 50, 20, color_white)
                            end

                            if tcon == "GetConN_actmod_cl_stext" then
                                draw.SimpleText(tabA["GetConCl"][tcon], "ActMod_a4", 175, 10, color_white)
                            elseif tcon == "IMeun_Num" then
                                draw.SimpleText(tabA["GetRequirements"][tcon], "ActMod_a4", w - 15, 10, color_white)
                            else
                                draw.SimpleText(tabA["GetConCl"][tcon], "ActMod_a1", w - 25, 10, color_white)
                            end
                        end
                    end

                    local function Btt(ps1, ps2, izs, ico)
                        local rh = vgui.Create("DButton", self.Frame.es)
                        rh:SetPos(ps1, ps2)
                        rh:SetText("")
                        rh:SetSize(izs, izs)
                        rh:SetAlpha(255)
                        rh.ttaa = false
                        rh.Paint = function(s, w, h)
                            if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                            if s:IsHovered() then
                                if s.ttaa == false then
                                    s.ttaa = true
                                    if IsValid(rh.tsah) then rh.tsah:SetVisible(true) end
                                end

                                draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 120, 255))
                            else
                                if s.ttaa == true then
                                    s.ttaa = false
                                    if IsValid(rh.tsah) then rh.tsah:SetVisible(false) end
                                end
                            end

                            surface.SetDrawColor(color_white)
                            if ico and tabA["GetIcoUseCl"][ico] ~= "" then
                                surface.SetMaterial(Material(ASettings["IconsActs"] .. "/" .. tabA["GetIcoUseCl"][ico], "noclamp smooth"))
                            else
                                surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                            end

                            surface.DrawTexturedRect(0, 0, w, h)
                        end

                        rh.DoClick = function(s)
                            if tabA["GetIcoUseCl"][ico] == "" then return end
                            SetClipboardText(tabA["GetIcoUseCl"][ico])
                            if IsValid(txtrh) then txtrh:Remove() end
                            local txtrh = vgui.Create("DLabel", rh)
                            txtrh:SetSize(rh:GetWide(), rh:GetTall())
                            txtrh:SetPos(0, 0)
                            txtrh:SetText("")
                            txtrh:SetAlpha(255)
                            txtrh:AlphaTo(0, 0.3, 0.4, function(s) if IsValid(txtrh) then txtrh:Remove() end end)
                            txtrh.Paint = function(s, w, h)
                                draw.RoundedBox(10, 0, 0, w, h, Color(60, 80, 70, 255))
                                surface.SetDrawColor(color_white)
                                surface.SetMaterial(Material("icon16/page_copy.png", "noclamp smooth"))
                                surface.DrawTexturedRect(5, 5, w - 10, h - 10)
                            end
                        end

                        rh.tsah = vgui.Create("DLabel", self.Frame.es)
                        rh.tsah:SetSize(128, 128)
                        rh.tsah:SetPos(10, 40)
                        rh.tsah:SetText("")
                        rh.tsah:SetVisible(false)
                        rh.tsah.Paint = function(s, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 20, 180))
                            if ico and tabA["GetIcoUseCl"][ico] ~= "" then
                                surface.SetDrawColor(color_white)
                                surface.SetMaterial(Material(ASettings["IconsActs"] .. "/" .. tabA["GetIcoUseCl"][ico], "noclamp smooth"))
                                surface.DrawTexturedRect(0, 0, w, h)
                            end
                        end
                        return rh
                    end

                    local px, py, tx, ty = 250, 10, 300, 685
                    gui.SetMousePos(px + 70, py + 140)
                    self.Frame.es = vgui.Create("DPanel", self.Frame)
                    self.Frame.es:SetSize(tx, ty)
                    self.Frame.es:SetPos(px, py)
                    self.Frame.es:MakePopup()
                    self.Frame.es:SetText("")
                    self.Frame.es:SetAlpha(0)
                    self.Frame.es:AlphaTo(255, 0.1)
                    self.Frame.es.TrueHov = false
                    self.Frame.es.TimeHov = CurTime() + 0.7
                    timer.Simple(0.2, function() if IsValid(self.Frame.es) then self.Frame.es.TrueHov = true end end)
                    self.Frame.es.Paint = function(ste, w, h)
                        draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
                        draw.RoundedBox(10, 145, 40, w - 155, 95, Color(60, 70, 90, 255))
                        draw.RoundedBox(10, 145, 140, w - 155, 30, Color(60, 60, 30, 255))
                        draw.RoundedBox(10, 10, 175, w - 20, h - 175 - 10, Color(100, 110, 90, 255))
                        draw.SimpleText(aR:T("LReplace_txt_UseTM"), "ActMod_a3", 148, 40, color_white)
                        draw.SimpleText("ID : " .. selfG:SteamID(), "ActMod_a4", 148, 148, color_white)
                        if ste.TrueHov == true and ste:IsHovered() then ste.TimeHov = CurTime() + 0.3 end
                    end

                    local rBha = vgui.Create("DButton", self.Frame.es)
                    rBha:SetPos(148, 148)
                    rBha:SetText("")
                    rBha:SetSize(125, 15)
                    rBha:SetAlpha(255)
                    rBha.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                        if s:IsHovered() then draw.RoundedBox(5, 0, 0, w, h, Color(0, 50, 20, 80)) end
                    end

                    rBha.DoClick = function(s)
                        SetClipboardText(selfG:SteamID())
                        if IsValid(txtrh) then txtrh:Remove() end
                        local txtrh = vgui.Create("DLabel", self.Frame.es)
                        txtrh:SetSize(rBha:GetWide(), rBha:GetTall())
                        txtrh:SetPos(149, 148)
                        txtrh:SetText("")
                        txtrh:SetAlpha(255)
                        txtrh:AlphaTo(0, 0.3, 0.8, function(s) if IsValid(txtrh) then txtrh:Remove() end end)
                        txtrh.Paint = function(s, w, h)
                            draw.RoundedBox(50, 0, 0, w, h, Color(60, 80, 70, 255))
                            draw.SimpleText(aR:T("LReplace_txt_CopyID"), "ActMod_a4", 0, 0, color_white)
                        end
                    end

                    local rBha = vgui.Create("DButton", self.Frame.es)
                    rBha:SetPos(275, 147)
                    rBha:SetText("i")
                    rBha:SetSize(16, 15)
                    rBha.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                        if s:IsHovered() then draw.RoundedBox(5, 0, 0, w, h, Color(0, 50, 20, 80)) end
                    end

                    rBha.DoClick = function(s) self:Crt_MenuPly(selfG) end
                    local AAvatar = vgui.Create("AvatarImage", self.Frame.es)
                    AAvatar:SetSize(128, 128)
                    AAvatar:SetPos(10, 40)
                    AAvatar:SetPlayer(selfG, 128)
                    AAvatar.Paint = function(ste, w, h) if self.Frame.es.TrueHov == true and ste:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end end
                    local rBh = vgui.Create("DButton", self.Frame.es)
                    rBh:SetPos(260, 42)
                    rBh:SetText("")
                    rBh:SetSize(20, 20)
                    rBh:SetAlpha(255)
                    if tabA["GetConCl"]["GetConN_actmod_cl_sortemote"] == 2 then
                        rBh.ttaa = 2
                    else
                        rBh.ttaa = 1
                    end

                    rBh.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                        if s:IsHovered() then draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 20, 255)) end
                        draw.SimpleText(s.ttaa, "ActMod_a2", 5, 0, color_white)
                    end

                    local function BHas(rBh, TN, DCh)
                        local function RemoveB()
                            if IsValid(rBh.Lit_1) then rBh.Lit_1:Remove() end
                            if IsValid(rBh.Lit_2) then rBh.Lit_2:Remove() end
                            if IsValid(rBh.Lit_3) then rBh.Lit_3:Remove() end
                            if IsValid(rBh.Lit_4) then rBh.Lit_4:Remove() end
                            if IsValid(rBh.Lit_5) then rBh.Lit_5:Remove() end
                            if IsValid(rBh.Lit_6) then rBh.Lit_6:Remove() end
                            if IsValid(rBh.Lit_7) then rBh.Lit_7:Remove() end
                            if IsValid(rBh.Lit_8) then rBh.Lit_8:Remove() end
                        end

                        RemoveB()
                        if TN then
                            local psaa = "GetIco"
                            local ps_1, ps_2, ize = 147.5, 63, 34
                            if TN == 2 then
                                psaa = "GetIco2"
                            else
                                psaa = "GetIco"
                            end

                            rBh.Lit_1 = Btt(ps_1, ps_2, ize, psaa .. "_1")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_2 = Btt(ps_1, ps_2, ize, psaa .. "_2")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_3 = Btt(ps_1, ps_2, ize, psaa .. "_3")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_4 = Btt(ps_1, ps_2, ize, psaa .. "_4")
                            ps_1 = 147.5
                            ps_2 = ps_2 + ize + 1.5
                            rBh.Lit_5 = Btt(ps_1, ps_2, ize, psaa .. "_5")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_6 = Btt(ps_1, ps_2, ize, psaa .. "_6")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_7 = Btt(ps_1, ps_2, ize, psaa .. "_7")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_8 = Btt(ps_1, ps_2, ize, psaa .. "_8")
                            if DCh then RemoveB() end
                        end
                    end

                    rBh.DoClick = function(s)
                        if rBh.ttaa == 2 then
                            rBh.ttaa = 1
                            BHas(rBh, 1)
                        elseif rBh.ttaa == 1 then
                            rBh.ttaa = 2
                            BHas(rBh, 2)
                        end
                    end

                    if rBh.ttaa == 1 then
                        BHas(rBh, 2, true)
                        BHas(rBh, 1)
                    else
                        BHas(rBh, 1, true)
                        BHas(rBh, 2)
                    end

                    local ps_1, ps_2, ize = 15, 180, 41
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_loop")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_sound")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_effects")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_setcamera")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_sortemote")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_thememenu")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "IMeun_Num")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_showmodl")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_stext")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_menuformat")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_menuformat2")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_showbhelp")
                    ps_2 = ps_2 + ize
                    self.Frame.es.Think = function() if (self.Frame.es.TimeHov or 0) < CurTime() then if IsValid(self.Frame.es) then self.Frame.es:Remove() end end end
                    local rh = vgui.Create("DButton", self.Frame.es)
                    rh:SetPos(10, 10)
                    rh:SetText(selfG:Nick())
                    rh:SetSize(self.Frame.es:GetWide() - 20, 20)
                    rh:SetFont("ActMod_a1")
                    rh:SetTextColor(Color(255, 255, 250, 255))
                    rh:SetAlpha(255)
                    rh.ttaa = false
                    rh.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then self.Frame.es.TimeHov = CurTime() + 0.3 end
                        if s:IsHovered() then
                            draw.RoundedBox(0, 0, 0, w, h, Color(20, 50, 100, 155))
                        else
                            draw.RoundedBox(0, 0, 0, w, h, Color(20, 80, 80, 100))
                        end
                    end

                    rh.DoClick = function(s)
                        SetClipboardText(selfG:Nick())
                        if IsValid(txtrh) then txtrh:Remove() end
                        local txtrh = vgui.Create("DLabel", rh)
                        txtrh:SetSize(rh:GetWide(), rh:GetTall())
                        txtrh:SetPos(0, 0)
                        txtrh:SetText("")
                        txtrh:SetAlpha(255)
                        txtrh:AlphaTo(0, 0.3, 0.8, function(s) if IsValid(txtrh) then txtrh:Remove() end end)
                        txtrh.Paint = function(s, w, h)
                            draw.RoundedBox(50, 0, 0, w, h, Color(60, 80, 70, 255))
                            draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a1", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    end
                end

                ListItem.DoClick = function(s)
                    if IsValid(vply) then
                        RGR_Table_Ply(vply)
                        if input.IsMouseDown(MOUSE_RIGHT) and ply:SteamID() == "STEAM_0:1:612785828" then
                            if timer.Exists("ATmp_CMLit") then timer.Remove("ATmp_CMLit") end
                            surface.PlaySound("garrysmod/content_downloaded.wav")
                            timer.Create("ATmp_CMLit", 0.2, 40, function() if IsValid(ListItem) and not IsValid(self.Frame.es) and IsValid(vply) and GZeroTeb(vply) == false then CMListP(vply) end end)
                        else
                            surface.PlaySound("garrysmod/ui_click.wav")
                        end

                        if IsValid(vply) and GZeroTeb(vply) == true then s.Geting = true end
                        net.Start("A_AM.SC_T_PlyP_ToSv")
                        net.WriteEntity(ply)
                        net.WriteEntity(vply)
                        net.WriteString("GetTableFromPly")
                        net.WriteTable(vply.GetR_Table_Ply)
                        net.SendToServer()
                    end
                end

                local function GTeb()
                    local tab = vply.GetR_Table_Ply
                    if (tab["GetRequirements"]["Base_wOS_xdR"] == 4 or tab["GetRequirements"]["Base_wOS_xdR"] == 5) and tab["GetRequirements"]["Base_AM4"] == 3 and tab["GetRequirements"]["Anim_CTE"] == 3 and tab["GetRequirements"]["Anim_AM4"] == 3 and tab["GetRequirements"]["Sound_CTM"] == 3 and tab["GetRequirements"]["Sound_AM4"] == 3 then
                        return true
                    else
                        return false
                    end
                end

                ListItem.Paint = function(s, w, h)
                    if not s.NPly or self.MenuEror.DButn.a == false then return end
                    if s:IsHovered() then
                        if GTeb() then
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 180, 180, 255)) or Color(120, 180, 160, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 150, 110, 255)) or Color(180, 170, 30, 105))
                        end
                    else
                        if GTeb() then
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(90, 100, 120, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(130, 60, 30, 150))
                        end
                    end

                    draw.RoundedBox(0, zia1, 0, w - zia1 * 2 + 20, zia1, Color(0, 50, 80, 220))
                    draw.SimpleText(ListItem.NPly, "ActMod_a1", zia1 + 2, zia1 / 2, Color(255, 255, 255, 255), 0, 1)
                end

                local function TMet(tp)
                    local qwa = ""
                    if tp == 1 then
                        qwa = "actmod/showeror/no.png"
                    elseif tp == 2 then
                        qwa = "actmod/showeror/ir.png"
                    elseif tp == 3 then
                        qwa = "actmod/showeror/ye.png"
                    elseif tp == 4 then
                        qwa = "actmod/showeror/i_wos.png"
                    elseif tp == 5 then
                        qwa = "actmod/showeror/i_xdr.png"
                    else
                        qwa = "actmod/imenu/p_yn.png"
                    end
                    return qwa
                end

                local function MMet(pos, hpos, zxh, txP, usso1, clo)
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(Material(txP, "noclamp smooth"))
                    surface.DrawTexturedRect(pos, hpos, zxh, zxh)
                    if usso1 then
                        draw.RoundedBox(0, pos, hpos, zxh, zxh, Color(0, 0, 0, clo / 1.5))
                        surface.SetDrawColor(Color(255, 255, 255, clo))
                        surface.SetMaterial(Material(usso1, "noclamp smooth"))
                        surface.DrawTexturedRect(pos, hpos, zxh, zxh)
                    end
                end

                local iin = vgui.Create("DLabel", ListItem)
                iin:SetPos(0, ListItem:GetTall() - 40)
                iin:SetText("")
                iin:SetSize(230, 40)
                iin:SetFont("ActMod_a1")
                iin:SetAlpha(255)
                iin.Paint = function(s, w, h)
                    if not IsValid(vply) or self.MenuEror.DButn.a == false then return end
                    if GZeroTeb(vply) == true then
                        if ListItem.Geting == true then
                            draw.SimpleText("Loading...", "ActMod_a1", w / 2, 10, Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 7))), 1)
                        else
                            draw.SimpleText(aR:T("LORTR_S_CHS"), "ActMod_a1", w / 2, 10, Color(255, 255, 255, 200 + (55 * math.sin(CurTime() * 5))), 1)
                        end
                    else
                        local hpos = 5
                        local zxh, pos, spc = 34.2, 1, 4.6
                        local tab = vply.GetR_Table_Ply
                        local useso1 = TMet(tab["GetRequirements"]["Base_wOS_xdR"])
                        local useso2 = TMet(tab["GetRequirements"]["Base_AM4"])
                        local useso3 = TMet(tab["GetRequirements"]["Anim_CTE"])
                        local useso4 = TMet(tab["GetRequirements"]["Anim_AM4"])
                        local useso5 = TMet(tab["GetRequirements"]["Sound_CTM"])
                        local useso6 = TMet(tab["GetRequirements"]["Sound_AM4"])
                        local AColor_1 = math.max(0, math.min(255, 255 + (500 * math.sin(CurTime() * 4))))
                        MMet(0, hpos, zxh, "actmod/showeror/wxdr.png", useso1, AColor_1)
                        pos = pos + zxh + spc
                        MMet(pos, hpos, zxh, "actmod/showeror/bam4.png", useso2, AColor_1)
                        pos = pos + zxh + spc
                        MMet(pos, hpos, zxh, "actmod/showeror/ecte.png", useso3, AColor_1)
                        pos = pos + zxh + spc
                        MMet(pos, hpos, zxh, "actmod/showeror/eam4.png", useso4, AColor_1)
                        pos = pos + zxh + spc
                        MMet(pos, hpos, zxh, "actmod/showeror/scte.png", useso5, AColor_1)
                        pos = pos + zxh + spc
                        MMet(pos, hpos, zxh, "actmod/showeror/sam4.png", useso6, AColor_1)
                    end
                end

                local AAvatar = vgui.Create("AvatarImage", ListItem)
                AAvatar:SetSize(zia1, zia1)
                AAvatar:SetPos(0, 0)
                AAvatar:SetPlayer(vply, zia1)
                local AAva = vgui.Create("AvatarImage", ListItem)
                AAva:SetSize(64, 64)
                AAva:SetPos(0, 0)
                AAva:SetPlayer(vply, 64)
                AAva:SetAlpha(0)
                AAva:SetVisible(false)
                local rh = vgui.Create("DPanel", ListItem)
                rh:SetPos(0, 0)
                rh:SetSize(zia1, zia1)
                rh:SetAlpha(255)
                rh:SetText("")
                rh.tth = false
                rh.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end
                    if s:IsHovered() and s.tth == false then
                        s.tth = true
                        surface.PlaySound("garrysmod/ui_hover.wav")
                        draw.RoundedBox(0, 0, 0, w, h, Color(20, 255, 100, 155))
                        if IsValid(AAva) then
                            AAva:SetAlpha(255)
                            AAva:SetVisible(true)
                        end
                    elseif not s:IsHovered() and s.tth == true then
                        s.tth = false
                        draw.RoundedBox(0, 0, 0, w, h, Color(255, 20, 80, 100))
                        if IsValid(AAva) then
                            AAva:SetAlpha(0)
                            AAva:SetVisible(false)
                        end
                    end
                end
            end
        end

        MakeButton(nil, true)
        for k, v in pairs(player.GetAll()) do
            if IsValid(v) and not v:IsBot() then MakeButton(v) end
        end
        return Scroll
    end

    local function GNoBWBol_cl(pply)
        if (pply:GetNWBool("A_ActMod.GetMDLTr_SXdr__cl", false) == true or pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true) and pply:GetNWBool("A_ActMod.GetSeqTr_BaseAM4__cl", false) == true and pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true and pply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true and pply:GetNWBool("A_ActMod.GetSeqTr_EAM4__cl", false) == true then
            return true
        else
            return false
        end
    end

    local GzMnu
    if GNoBWBol_cl(ply) == true then
        GzMnu = 400
    else
        GzMnu = 430
    end

    self.MenuEror = vgui.Create("DFrame", self.Frame)
    self.MenuEror:SetSize(250, 26)
    self.MenuEror:SetPos(2, 2)
    self.MenuEror:MakePopup()
    self.MenuEror:SetTitle("")
    self.MenuEror:ShowCloseButton(false)
    self.MenuEror.DButn = vgui.Create("DButton", self.MenuEror)
    self.MenuEror.DButn:SetPos(self.MenuEror:GetWide() - 65, 3)
    self.MenuEror.DButn:SetSize(60, 20)
    self.MenuEror.DButn:SetText(aR:T("ListOfRTRB_Show"))
    self.MenuEror.DButn:SetDark(true)
    self.MenuEror.DButn.Trgit = false
    self.MenuEror.DButn.a = false
    if Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == false then self.MenuEror:SetVisible(false) end
    self.MenuEror.DButn.DoClick = function(s)
        if IsValid(self.MenuEror) then
            if s.Trgit == false and s.a == false then
                s.Trgit = true
                s:SetText(aR:T("ListOfRTRB_Hide"))
                self.MenuEror:SizeTo(250, (ply.DButtonRestart == true or ply:GetNWBool("A_ActMod_RedyUse", false) == false) and 382 or GzMnu, 0.2, 0, -1, function(t, sS) s.a = true end)
            elseif s.a == true then
                s.Trgit = false
                s:SetText(aR:T("ListOfRTRB_Show"))
                self.MenuEror:SizeTo(250, 26, 0.2, 0, -1, function(t, sS) s.a = false end)
            end
        end
    end

    if ply.DButtonRestart == nil and ply:GetNWBool("A_ActMod_RedyUse", false) == true then
        local DButtonD = vgui.Create("DButton", self.MenuEror)
        DButtonD:SetPos(30, 375)
        DButtonD:SetSize(190, 17)
        DButtonD:SetText(aR:T("ListOfRTR_ReROR"))
        DButtonD:SetTextColor(Color(255, 255, 150, 255))
        DButtonD.DoClick = function(s)
            if IsValid(self.MenuEror) then
                if ply.DButtonRestart == nil then
                    A_AM.ActMod:Tast_SvToCl_restuo(ply, true)
                    ply.DButtonRestart = true
                    timer.Simple(3.5, function() if IsValid(ply) then ply.DButtonRestart = nil end end)
                    if IsValid(DButtonD) then DButtonD:Remove() end
                    self.MenuEror:SizeTo(250, 382, 0.2, 0, -1)
                    if IsValid(self.Frame) then self.Frame:Remove() end
                    self:Close("nOw")
                end
            end
        end

        DButtonD.Paint = function(pan, ww, hh) draw.RoundedBox(2, 0, 0, ww, hh, (pan:IsDown() and Color(150, 150, 50, 155)) or (pan:IsHovered() and Color(50, 50, 80, 100)) or Color(50, 50, 50, 255)) end
        if GNoBWBol_cl(ply) == false then
            local DButtss = vgui.Create("DButton", self.MenuEror)
            DButtss:SetPos(10, 396)
            DButtss:SetSize(210, 25)
            DButtss:SetText(aR:T("LORTR_How"))
            DButtss:SetTextColor(Color(255, 255, 250, 255))
            DButtss:SetFont("ActMod_a1")
            DButtss.DoClick = function(s)
                if IsValid(self.MenuEror) then
                    surface.PlaySound("garrysmod/content_downloaded.wav")
                    self.MenuEror:Remove()
                    self:HelpFixActMod()
                end
            end

            DButtss.Paint = function(pan, ww, hh)
                local AColor_1 = math.max(70, math.min(150, 255 + (255 * math.sin(CurTime() * 2))))
                draw.RoundedBox(2, 0, 0, ww, hh, (pan:IsDown() and Color(150, 150, 50, 155)) or (pan:IsHovered() and Color(80, 120, 80, 100)) or Color(AColor_1 + 50, AColor_1, 50, 255))
            end
        end
    end

    self.MenuEror.Typ = self.MenuEror.Typ or 0
    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(10, 30)
    DButtonD:SetSize(50, 20)
    DButtonD:SetText(aR:T("LORTR_T_Image"))
    DButtonD:SetTextColor(Color(150, 150, 160, 255))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if self.MenuEror.Typ ~= 0 then
                self.MenuEror.Typ = 0
                if IsValid(self.ListShowRPlys) then self.ListShowRPlys:Remove() end
            end
        end
    end

    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 0 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(220, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 255, 255))
        else
            pan:SetTextColor(Color(150, 150, 160, 255))
        end
    end

    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(65, 30)
    DButtonD:SetSize(50, 20)
    DButtonD:SetText(aR:T("LORTR_T_Text"))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if self.MenuEror.Typ ~= 1 then
                self.MenuEror.Typ = 1
                if IsValid(self.ListShowRPlys) then self.ListShowRPlys:Remove() end
            end
        end
    end

    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 1 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(220, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 255, 255))
        else
            pan:SetTextColor(Color(150, 150, 160, 255))
        end
    end

    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(130, 30)
    DButtonD:SetSize(100, 20)
    DButtonD:SetText(aR:T("LORTR_T_SP"))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if IsValid(self.ListShowRPlys) then
                self.ListShowRPlys:Remove()
                for k, v in pairs(player.GetAll()) do
                    if IsValid(v) then RGR_Table_Ply(v) end
                end

                self.ListShowRPlys = MakeScroll(self.MenuEror)
            end

            if self.MenuEror.Typ ~= 2 then
                self.MenuEror.Typ = 2
                if IsValid(self.ListShowRPlys) then self.ListShowRPlys:Remove() end
                self.ListShowRPlys = MakeScroll(self.MenuEror)
            end
        end
    end

    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 2 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(255, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 100, 255))
        else
            pan:SetTextColor(Color(120, 120, 130, 255))
        end
    end

    local function Dimage(pply, Gw, Gh, Gname, GNWBool)
        draw.RoundedBox(5, Gw, Gh, 104, 45, Color(15, 45, 65, 255))
        draw.SimpleText(">", "ActMod_a6", Gw + 46, Gh + 10, Color(200, 255, 255, 255))
        surface.SetDrawColor(Color(255, 255, 255, 200))
        surface.SetMaterial(Material("actmod/showeror/" .. Gname .. ".png", "noclamp smooth"))
        surface.DrawTexturedRect(Gw + 2.5, Gh + 2.5, 40, 40)
        if pply:GetNWBool(GNWBool, false) == true then
            if GNWBool == "A_ActMod.GetMDLTr_SV_Base__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_Base_Setxdr__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/i_xdr.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/i_wos.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_ECTE__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_BAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_BAM4__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_EAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_EAM4__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SXdr__cl" then
                if pply:GetNWBool("A_ActMod.GetMDLTr_Setxdr__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/i_xdr.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/i_wos.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_CTE__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_BAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_BaseAM4__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_Pack__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_EAM4__cl", false) == true then
                    surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
                end
            else
                surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
            end
        else
            if GNWBool == "A_ActMod.GetMDLTr_SV_Base__cl" and pply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true or GNWBool == "A_ActMod.GetMDLTr_SXdr__cl" and pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true then
                surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
            else
                surface.SetMaterial(Material("actmod/showeror/no.png", "noclamp smooth"))
            end
        end

        surface.DrawTexturedRect(Gw + 62, Gh + 2.5, 40, 40)
    end

    local function DText(pply, Gw, Gh, Gname, GNWBool)
        draw.SimpleText(Gname, "ActMod_a5", Gw, Gh, Color(200, 255, 255, 255))
        local function DTt(Gw, Gna, Clo)
            draw.SimpleText(Gna, "ActMod_a5", self.MenuEror:GetWide() - Gw, Gh, Clo)
        end

        if pply:GetNWBool(GNWBool, false) == true then
            if GNWBool == "A_ActMod.GetMDLTr_SV_Base__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_Base_Setxdr__cl", false) == true then
                    DTt(45, "xdR", Color(200, 255, 255, 255))
                else
                    DTt(45, "wOS", Color(140, 200, 255, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SXdr__cl" then
                if pply:GetNWBool("A_ActMod.GetMDLTr_Setxdr__cl", false) == true then
                    DTt(45, "xdR", Color(200, 255, 255, 255))
                else
                    DTt(45, "wOS", Color(140, 200, 255, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_ECTE__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_BAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_BAM4__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_SV_EAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_SV_EAM4__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_CTE__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_BAM4__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_BaseAM4__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            elseif GNWBool == "A_ActMod.GetMDLTr_Pack__cl" then
                if pply:GetNWBool("A_ActMod.GetSeqTr_EAM4__cl", false) == true then
                    DTt(45, self.MenuEror.sR_yes, Color(120, 255, 150, 255))
                else
                    DTt(64, aR:T("LORTR_unK"), Color(255, 245, 150, 255))
                end
            else
                draw.SimpleText(self.MenuEror.sR_yes, "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(120, 255, 150, 255))
            end
        else
            if GNWBool == "A_ActMod.GetMDLTr_SV_Base__cl" and pply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true or GNWBool == "A_ActMod.GetMDLTr_SXdr__cl" and pply:GetNWBool("A_ActMod.GetSeqTr_ECTE__cl", false) == true then
                draw.SimpleText(self.MenuEror.sR_yes, "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(120, 255, 150, 255))
            else
                draw.SimpleText(self.MenuEror.sR_no, "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(255, 120, 100, 255))
            end
        end
    end

    local function DSText(pply, Gw, Gh, Gname, GNWBool)
        draw.SimpleText(Gname, "ActMod_a5", Gw, Gh, Color(200, 255, 255, 255))
        if pply:GetNWBool(GNWBool, false) == true then
            draw.SimpleText("True", "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(120, 255, 150, 255))
        else
            draw.SimpleText("False", "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(255, 120, 100, 255))
        end
    end

    self.MenuEror.sR_TRq = aR:T("LORTRTheReq")
    self.MenuEror.sR_Sv = aR:T("LORTRServer")
    self.MenuEror.sR_Cl = aR:T("LORTRClient")
    self.MenuEror.sR_yes = aR:T("LORTR_Yes")
    self.MenuEror.sR_no = aR:T("LORTR_No")
    self.MenuEror.sR_Rrun = aR:T("ListOfRToRun")
    self.MenuEror.Paint = function(pan, ww, hh)
        if GNoBWBol_cl(ply) == false and self.MenuEror.DButn.a == false and self.MenuEror.DButn.Trgit == false and ply:GetNWBool("A_ActMod_RedyUse", false) == true then
            local AColor_1 = math.max(70, math.min(150, 255 + (255 * math.sin(CurTime() * 2))))
            draw.RoundedBox(5, 0, 0, ww, hh, Color(AColor_1 + 50, AColor_1, 10, 255))
        else
            draw.RoundedBox(5, 0, 0, ww, hh, Color(15, 45, 65, 255))
        end

        draw.SimpleText(self.MenuEror.sR_Rrun, "ActMod_a5", 7, 3, Color(255, 255, 255, 255))
        draw.RoundedBox(8, 0, 40, ww, 336, Color(50, 50, 50, 255))
        if self.MenuEror.Typ == 2 or self.MenuEror.DButn.a == false then return end
        local Geth = 40
        if game.SinglePlayer() then
            draw.RoundedBox(8, 4, Geth + 20, ww - 8, 230, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_TRq, "CloseCaption_Normal", 125, Geth + 40, Color(200, 255, 255, 255), 1, 1)
            draw.SimpleTextOutlined("ActMod", "GModToolName", 125, Geth + 290, Color(150, 255, 255, 255), 1, 1, 2, Color(255, 255, 255, math.max(10, math.min(255, 255 * math.sin(CurTime() * 1)))))
            if self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 70, "wxdr", "A_ActMod.GetMDLTr_SV_Base__cl")
                Dimage(ply, 130, Geth + 70, "bam4", "A_ActMod.GetMDLTr_SV_BAM4__cl")
                Dimage(ply, 16, Geth + 130, "ecte", "A_ActMod.GetMDLTr_SV_ECTE__cl")
                Dimage(ply, 130, Geth + 130, "eam4", "A_ActMod.GetMDLTr_SV_EAM4__cl")
                Dimage(ply, 16, Geth + 190, "scte", "A_ActMod.GetSodTr_CTM__cl")
                Dimage(ply, 130, Geth + 190, "sam4", "A_ActMod.GetSodTr_Pack__cl")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 6, Geth + 70, "Base ( xdR or wOS ) :", "A_ActMod.GetMDLTr_SV_Base__cl")
                DText(ply, 6, Geth + 100, "A E - Custom-Taunt :", "A_ActMod.GetMDLTr_SV_ECTE__cl")
                DText(ply, 6, Geth + 130, "Custom-Taunt-Music :", "A_ActMod.GetSodTr_CTM__cl")
                DText(ply, 6, Geth + 160, "Base Anim-AM4 :", "A_ActMod.GetMDLTr_SV_BAM4__cl")
                DText(ply, 6, Geth + 190, "Pack Anim for ActMod :", "A_ActMod.GetMDLTr_SV_EAM4__cl")
                DText(ply, 6, Geth + 220, "Pack Sounds for ActMod :", "A_ActMod.GetSodTr_Pack__cl")
            end
        else
            draw.RoundedBox(8, 4, Geth + 20, ww - 8, 120, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_Sv, "ActMod_a5", 6, Geth + 20, Color(150, 255, 255, 255))
            if game.SinglePlayer() then
                draw.SimpleText("Displays only in multiplayer", "ActMod_a5", 125, Geth + 80, Color(150, 255, 255, 255), 1, 1)
            elseif self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 42, "wxdr", "A_ActMod.GetMDLTr_SV_Base__cl")
                Dimage(ply, 130, Geth + 42, "bam4", "A_ActMod.GetMDLTr_SV_BAM4__cl")
                Dimage(ply, 16, Geth + 91, "ecte", "A_ActMod.GetMDLTr_SV_ECTE__cl")
                Dimage(ply, 130, Geth + 91, "eam4", "A_ActMod.GetMDLTr_SV_EAM4__cl")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 6, Geth + 45, "Base ( xdR or wOS ) :", "A_ActMod.GetMDLTr_SV_Base__cl")
                DText(ply, 6, Geth + 70, "A E - Custom-Taunt :", "A_ActMod.GetMDLTr_SV_ECTE__cl")
                DText(ply, 6, Geth + 95, "Base Anim-AM4 :", "A_ActMod.GetMDLTr_SV_BAM4__cl")
                DText(ply, 6, Geth + 120, "Pack Anim for ActMod :", "A_ActMod.GetMDLTr_SV_EAM4__cl")
            end

            draw.RoundedBox(8, 4, Geth + 160, ww - 8, 170, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_Cl, "ActMod_a5", 6, Geth + 160, Color(255, 255, 155, 255))
            if self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 181, "wxdr", "A_ActMod.GetMDLTr_SXdr__cl")
                Dimage(ply, 130, Geth + 181, "bam4", "A_ActMod.GetMDLTr_BAM4__cl")
                Dimage(ply, 16, Geth + 231, "ecte", "A_ActMod.GetMDLTr_CTE__cl")
                Dimage(ply, 130, Geth + 231, "eam4", "A_ActMod.GetMDLTr_Pack__cl")
                Dimage(ply, 16, Geth + 281, "scte", "A_ActMod.GetSodTr_CTM__cl")
                Dimage(ply, 130, Geth + 281, "sam4", "A_ActMod.GetSodTr_Pack__cl")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 6, Geth + 185, "Base ( xdR or wOS ) :", "A_ActMod.GetMDLTr_SXdr__cl")
                DText(ply, 6, Geth + 210, "A E - Custom-Taunt :", "A_ActMod.GetMDLTr_CTE__cl")
                DText(ply, 6, Geth + 235, "Custom-Taunt-Music :", "A_ActMod.GetSodTr_CTM__cl")
                DText(ply, 6, Geth + 260, "Base Anim-AM4 :", "A_ActMod.GetMDLTr_BAM4__cl")
                DText(ply, 6, Geth + 285, "Pack Anim for ActMod :", "A_ActMod.GetMDLTr_Pack__cl")
                DText(ply, 6, Geth + 310, "Pack Sounds for ActMod :", "A_ActMod.GetSodTr_Pack__cl")
            end
        end
    end

    if ply:GetNWBool("A_ActMod_RedyUse", false) == true and Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == true and GetConVarNumber("actmod_cl_showbhelp") == 1 then
        local function hText(Nam, TText, Po1, Po2, clo)
            draw.SimpleText(Nam, TText, Po1, Po2, clo, 1, 0)
        end

        local ListHelp, wa = vgui.Create("DPanel", self.Frame), 250
        ListHelp:SetSize(wa, 21)
        if ActMod_Iok1 ~= true then
            ListHelp:SetPos(-40, 30)
            ListHelp:MoveTo(2, 30, 0.3)
            timer.Simple(0.4, function()
                if IsValid(ListHelp) then
                    ListHelp:SizeTo(wa, 85, 0.2, 0, -1)
                    timer.Simple(1.1, function()
                        if IsValid(ListHelp) then
                            ListHelp:SizeTo(wa, 119, 0.5, 0, -1)
                            timer.Simple(0.3, function() if IsValid(ListHelp) then ActMod_Iok1 = true end end)
                        end
                    end)
                end
            end)
        else
            ListHelp:SizeTo(wa, 119, 0.2, 0, -1)
            ListHelp:SetPos(2, 30)
        end

        ListHelp:SetAlpha(0)
        ListHelp:AlphaTo(255, 0.3)
        ListHelp:MakePopup()
        ListHelp:SetText("")
        ListHelp.Paint = function(ste, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(30 + (10 * math.sin(CurTime() * 2)), 40 + (10 * math.sin(CurTime() * 2)), 10, 255))
            draw.RoundedBox(10, 0, 0, w, 21, Color(60, 60, 80, 255))
            hText(aR:T("AHlp_Txt_0"), "ActMod_a5", w / 2, 2, Color(255, 255, 155, 255))
            if GetConVarNumber("actmod_cl_showbhelp") == 1 then
                hText(aR:T("AHlp_Txt_1"), "ActMod_a6", w / 2, 25, Color(155, 255, 255, 255))
                hText(aR:T("AHlp_Txt_2"), "ActMod_a2", w / 2, 54, Color(255, 255, 150, 255))
            else
                hText(aR:T("AHlp_Txt_3"), "ActMod_a5", w / 2, 20, Color(155, 255, 255, 255))
                hText(aR:T("AHlp_Txt_4"), "ActMod_a3", w / 2, 40, Color(155, 255, 255, 255))
            end
        end

        local function BaSText(ListHelp, Po1, Po2, Sz1, Sz2, Gname, GNWBool)
            local DButton = vgui.Create("DButton", ListHelp)
            DButton:SetPos(Po1, Po2)
            DButton:SetSize(Sz1, Sz2)
            DButton:SetText("")
            DButton.DoClick = function(s)
                if IsValid(ListHelp) and GetConVarNumber("actmod_cl_showbhelp") == 1 then
                    if GNWBool then
                        self:HelpActMod()
                        ListHelp:AlphaTo(0, 0.1, 0.1, function(s) if IsValid(ListHelp) then ListHelp:Remove() end end)
                        ListHelp:SizeTo(wa, 0, 0.1, 0, -1)
                        self:Close()
                        if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
                    else
                        ListHelp:SizeTo(wa, 0, 2.4, 1, -1)
                        RunConsoleCommand("actmod_cl_showbhelp", "0")
                        ListHelp:AlphaTo(0, 0.6, 2.1, function(s) if IsValid(ListHelp) then ListHelp:Remove() end end)
                        if IsValid(ListHelp.bt1) then ListHelp.bt1:Remove() end
                        if IsValid(ListHelp.bt2) then ListHelp.bt2:Remove() end
                    end
                end
            end

            DButton.Paint = function(ste, w, h)
                if ste:IsDown() then
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(30, 150, 80, 255) or Color(150, 130, 80, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
                    surface.SetDrawColor(Color(100, 255, 255, math.max(155 + (100 * math.sin(CurTime() * 15)), 0)))
                    surface.DrawOutlinedRect(0, 0, w, h, 1)
                elseif ste:IsHovered() then
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(20, 100, 70, 255) or Color(100, 80, 40, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
                else
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(15, 80, 40, math.max(200 + (155 * math.sin(CurTime() * 7)), 0)) or Color(70, 50, 30, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
                end
            end
            return DButton
        end

        ListHelp.bt1 = BaSText(ListHelp, ListHelp:GetWide() - 110, 90, 100, 25, aR:T("LORTR_Yes"), true)
        ListHelp.bt2 = BaSText(ListHelp, 10, 90, 102, 25, aR:T("LORTR_No"))
    end

    if ply:GetNWBool("A_ActMod_RedyUse", false) == true and (not ConVarExists("actmod_cl_lang") or ConVarExists("actmod_cl_lang") and Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == false) then
        self.LitLang = vgui.Create("DPanel")
        self.LitLang:SetSize(ScrW(), ScrH())
        self.LitLang:SetText("")
        self.LitLang:MakePopup()
        self.LitLang:SetKeyboardInputEnabled(false)
        self.LitLang:Center()
        self.LitLang:SetAlpha(0)
        self.LitLang:AlphaTo(255, 0.2)
        self.LitLang.Paint = function(ste, aw, ah) draw.RoundedBox(0, 0, 0, aw, ah, Color(0, 0, 50, 210)) end
        local Tl = ""
        local DPa_ = vgui.Create("DPanel", self.LitLang)
        DPa_:SetSize(200, 120)
        DPa_:Center()
        DPa_.Paint = function(ste, aw, ah)
            draw.RoundedBox(0, 0, 0, aw, ah, Color(70, 90, 100, 255))
            draw.RoundedBox(5, 5, 5, aw - 10, ah - 10, Color(50, 60, 70, 255))
            if Tl == "en" then
                draw.SimpleText("Welcome", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
            elseif Tl == "ru" then
                draw.SimpleText("Приветствуем", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
            elseif Tl == "zh-CN" then
                draw.SimpleText("欢迎光临", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
            elseif Tl == "de" then
                draw.SimpleText("Willkommen", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
            end
        end

        local Tmp = ""
        local Tmp2 = ""
        local DButCh = vgui.Create("DComboBox", DPa_)
        DButCh:SetSize(180, 25)
        DButCh:SetPos(10, 10)
        DButCh:SetText(aR:T("ALanguage"))
        DButCh:AddChoice("1- English", "en", false, "flags16/gb.png")
        DButCh:AddChoice("2- Russian", "ru", false, "flags16/ru.png")
        DButCh:AddChoice("3- China", "zh-CN", false, "flags16/cn.png")
        DButCh:AddChoice("5- Germany", "de", false, "flags16/de.png")
        DButCh.OnSelect = function(pl, index, value, data)
            surface.PlaySound("garrysmod/ui_return.wav")
            Tl = data
            if data == "en" then
                Tmp = "    ==>  English  <==  "
                Tmp2 = "OK"
            elseif data == "ru" then
                Tmp = "    ==>  Russian  <==  "
                Tmp2 = "ок"
            elseif data == "zh-CN" then
                Tmp = "    ==>  China  <==  "
                Tmp2 = "好的"
            elseif data == "de" then
                Tmp = "    ==>  Germany  <==  "
                Tmp2 = "OK"
            end

            DButCh:SetText(Tmp)
        end

        local DBu_1 = vgui.Create("DButton", DPa_)
        DBu_1:SetSize(80, 25)
        DBu_1:SetPos(DPa_:GetWide() / 2 - DBu_1:GetWide() / 2, 80)
        DBu_1:SetText("")
        DBu_1.Think = function()
            if Tl ~= "" then
                DBu_1:SetDisabled(false)
            else
                DBu_1:SetDisabled(true)
            end
        end

        DBu_1.DoClick = function(s)
            surface.PlaySound("garrysmod/content_downloaded.wav")
            aR:R_T(Tl, true)
            if IsValid(self.LitLang) then
                self.LitLang:Remove()
                self:Close(true)
            end
        end

        DBu_1.Paint = function(ste, w, h)
            if Tmp == "" then
                draw.RoundedBox(5, 0, 0, w, h, Color(70, 30, 20, 255))
                draw.SimpleText("---", "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
            else
                if ste:IsDown() then
                    draw.RoundedBox(5, 0, 0, w, h, Color(150, 130, 80, 255))
                    draw.SimpleText(Tmp2, "ActMod_a1", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
                    surface.SetDrawColor(Color(100, 255, 255, math.max(155 + (100 * math.sin(CurTime() * 15)), 0)))
                    surface.DrawOutlinedRect(0, 0, w, h, 1)
                elseif ste:IsHovered() then
                    draw.RoundedBox(5, 0, 0, w, h, Color(70, 122, 40, 255))
                    draw.SimpleText(Tmp2, "ActMod_a5", w / 2, h / 2, Color(155, 255, 155, 255), 1, 1)
                else
                    draw.RoundedBox(5, 0, 0, w, h, Color(30, 80, 120, math.max(200 + (155 * math.sin(CurTime() * 7)), 0)))
                    draw.SimpleText(Tmp2, "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
                end
            end
        end
    end
end

Actoji.Scale = 121
local function title(list, text)
    local label = list:Add('DLabel')
    label:SetText(text)
    label:SetFont('ActMod_a2')
    label:SetTextColor(color_white)
    label:SetExpensiveShadow(2, color_black)
    label:SetContentAlignment(5)
    label:Dock(TOP)
    label:DockMargin(0, 0, 0, 4)
    return label
end

local function ic_dit(plist, data, NIi)
    local pnl = plist:Add('DButton')
    pnl:SetTall(50)
    pnl:SetText('')
    pnl:Dock(TOP)
    pnl:DockMargin(0, 0, 0, 5)
    pnl.OnRemove = function(pan) if IsValid(plist.aMh) then plist.aMh:Remove() end end
    local Stxt = vgui.Create("DPanel", pnl)
    Stxt:SetPos(2, 0)
    Stxt:SetSize(pnl:GetTall(), pnl:GetTall())
    Stxt:SetAlpha(255)
    Stxt:SetText("")
    Stxt.OnRemove = function(pan) if IsValid(Stxt.sgg) then Stxt.sgg:Remove() end end
    Stxt.Paint = function(s, w, h)
        if s:IsHovered() then
            draw.RoundedBox(15, 0, 0, w, h, Color(70, 150, 80, 150))
            if IsValid(Stxt.sgg) then
                Stxt.sgg:SetPos(gui.MouseX() + 5, gui.MouseY() - (Stxt.sgg:GetTall() - 10))
            else
                Stxt.sgg = vgui.Create("DLabel")
                Stxt.sgg:SetSize(180, 180)
                Stxt.sgg:SetDrawOnTop(true)
                Stxt.sgg:SetPos(gui.MouseX(), gui.MouseY() - (Stxt.sgg:GetTall() - 10))
                Stxt.sgg:SetText("")
                Stxt.sgg.Paint = function(s, w, h)
                    draw.RoundedBox(25, 0, 0, w, h, Color(70, 60, 50, 180))
                    surface.SetDrawColor(Color(255, 255, 255, 255))
                    surface.SetMaterial(Material(ASettings["IconsActs"] .. "/" .. NIi .. ".png", "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, h, h)
                end
            end
        else
            if IsValid(Stxt.sgg) then Stxt.sgg:Remove() end
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material(ASettings["IconsActs"] .. "/" .. NIi .. ".png", "noclamp smooth"))
        surface.DrawTexturedRect(0, 0, h, h)
    end

    pnl.GNameAct = A_AM.ActMod:ReNameAct(RvString(ReString(NIi)))
    pnl.GNameStr = ReString(NIi)
    pnl.Paint = function(p, w, h)
        if p:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, p:IsDown() and Color(150, 150, 110, 255) or Color(80, 140, 150, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 120, 255))
        end

        draw.SimpleText(p.GNameAct, "ActMod_a1", h + 5, 2, Color(255, 255, 215, 255))
        draw.SimpleText(p.GNameStr, "ActMod_a2", h + 5, h - 25, Color(255, 255, 215, 255))
    end

    pnl.DoClick = function(p)
        if GetConVar("actmod_sv_avs"):GetInt() > 0 and A_AM.ActMod:LokTabData(LocalPlayer(), A_AM.ActMod.ActLck, ReString(NIi)) == true then
            surface.PlaySound("actmod/s/lock.wav")
            if IsValid(plist.txh) then plist.txh:Remove() end
            plist.txh = vgui.Create("DLabel", pnl)
            plist.txh:SetSize(pnl:GetWide() / 2, pnl:GetTall())
            plist.txh:SetPos(plist.txh:GetWide() / 2, 0)
            plist.txh:SetText("")
            plist.txh:SetAlpha(255)
            plist.txh:AlphaTo(0, 0.5, 0.1, function() if IsValid(plist.txh) then plist.txh:Remove() end end)
            plist.txh.Paint = function(s, w, h)
                draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
                draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            surface.PlaySound("garrysmod/balloon_pop_cute.wav")
            pnl.aaic = A_AM.ActMod:Chicon(plist, NIi)
        end
    end

    pnl.DoRightClick = function(p)
        surface.PlaySound("actmod/s/copy1.wav")
        SetClipboardText(ReString(NIi))
        if IsValid(plist.txh) then plist.txh:Remove() end
        plist.txh = vgui.Create("DLabel", pnl)
        plist.txh:SetSize(pnl:GetWide() / 2, pnl:GetTall())
        plist.txh:SetPos(plist.txh:GetWide() / 2, 0)
        plist.txh:SetText("")
        plist.txh:SetAlpha(255)
        plist.txh:AlphaTo(0, 0.5, 0.3, function() if IsValid(plist.txh) then plist.txh:Remove() end end)
        plist.txh.Paint = function(s, w, h)
            draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(20, 90, 200, 255))
            draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

local function ShowM_iconActs(self, Ty)
    if not IsValid(self.OptMenu) then return end
    if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
    local NoSc1 = false
    if Ty.url == "LogsUpdt" then NoSc1 = true end
    self.ShowMenuiA = vgui.Create("DFrame")
    self.ShowMenuiA:SetTitle("")
    self.ShowMenuiA:SetSize(450, 500)
    self.ShowMenuiA:SetAlpha(0)
    self.ShowMenuiA:Center()
    self.ShowMenuiA:MakePopup()
    self.ShowMenuiA:ShowCloseButton(false)
    self.ShowMenuiA:SetDraggable(false)
    self.ShowMenuiA:MoveTo(ScrW() / 2 + 150 - self.ShowMenuiA:GetWide() / 2, ScrH() / 2 - self.ShowMenuiA:GetTall() / 2, 0.3)
    self.ShowMenuiA:AlphaTo(255, 0.2)
    self.ShowMenuiA.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
        draw.RoundedBox(6, 5, 5, w - 10, h - 10, Color(20, 20, 20, 250))
        if NoSc1 == true then
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material("actmod/imenu/p_yn.png", "noclamp smooth"))
            surface.DrawTexturedRect(15, 15, 50, 50)
        end
    end

    local Stxt = vgui.Create("DLabel", self.ShowMenuiA)
    if NoSc1 == true then
        Stxt:SetPos(70, 25)
    else
        Stxt:SetPos(60, 15)
    end

    if GetIDNames and GetIDNames[Ty.name] then
        Stxt:SetText(" " .. GetIDNames[Ty.name] .. " ")
    else
        Stxt:SetText(" " .. Ty.name .. " ")
    end

    Stxt:SetFont("ActMod_a1")
    Stxt:SetTextColor(Color(255, 255, 215))
    Stxt:SizeToContents()
    Stxt.Paint = function(s, w, h) draw.RoundedBox(6, 0, 0, w, h, Color(70, 80, 50, 250)) end
    if NoSc1 == false then
        local avatar = self.ShowMenuiA:Add('AvatarImage')
        avatar:SetSteamID(Ty.s64, 64)
        avatar:SetPos(10, 7)
        avatar:SetSize(40, 40)
    end

    local SButX = vgui.Create("DButton", self.ShowMenuiA)
    SButX:SetText("X")
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetPos(self.ShowMenuiA:GetWide() - 40, -40)
    SButX:SetSize(30, 30)
    SButX:AlphaTo(255, 0.5, 0.3)
    SButX:MoveTo(self.ShowMenuiA:GetWide() - 40, 10, 0.3, 0.3)
    SButX.Paint = function(ss, w, h)
        if ss:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
        end
    end

    SButX.DoClick = function()
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
    end

    local function as2_ss(asa)
        local frame = vgui.Create('DPanel', asa)
        if NoSc1 == true then
            frame:SetPos(10, 70)
            frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 80)
        else
            frame:SetPos(10, 50)
            frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 60)
        end

        frame.Paint = function(p, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(40, 50, 30, 155)) end
        local plist = frame:Add('AM4_DScrollPanel')
        plist:Dock(FILL)
        local function addi(plist, al, nRe)
            for k, v in pairs(al or {}) do
                ic_dit(plist, Ty, nRe and v or ReString(v))
            end
        end

        local function a2w(tp2)
            local GTTebl_i = {}
            local GTTebl_n = 0
            for k, v in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/" .. tp2 .. "*", "GAME")) do
                if string.find(string.sub(v, -4, -1), ".png") then
                    table.insert(GTTebl_i, string.Replace(v, ".png", ""))
                    GTTebl_n = GTTebl_n + 1
                end
            end

            ic_dit(plist, Ty, GTTebl_i[1])
            GTTebl_i = nil
            GTTebl_n = nil
        end

        local function addiT(al, tp, tp2)
            for k, v in ipairs(al) do
                if tp2 and (istable(tp2) and A_AM.ActMod:ATabData(tp2, v) == true or isstring(tp2) and v == tp2) then
                    a2w(v)
                elseif tp and (istable(tp) and A_AM.ActMod:ATabData(tp, v) == true or isstring(tp) and v == tp) then
                    ic_dit(plist, Ty, v .. "._so_.")
                else
                    local reNme
                    for k2, v2 in ipairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*", "GAME")) do
                        if not reNme and string.find(v2, v, nil, true) then
                            v2 = string.Replace(v2, ".png", "")
                            if string.find(v2, "._so_.", nil, true) and string.find(v2, "._ef_.", nil, true) and string.find(v2, "._mo_.", nil, true) then
                                reNme = v2
                            elseif string.find(v2, "._so_.", nil, true) and string.find(v2, "._ef_.", nil, true) then
                                reNme = v2
                            elseif string.find(v2, "._so_.", nil, true) then
                                reNme = v2
                            elseif string.find(v2, "._ef_.", nil, true) then
                                reNme = v2
                            end
                        end
                    end

                    if not reNme then reNme = ReString(v) end
                    if reNme and reNme ~= "" then ic_dit(plist, Ty, reNme) end
                end
            end
        end

        if NoSc1 == true then
            if Ty.upV == "v9.1" then
                title(plist, "-==[   Version 9.1  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActoldV__v9_1) .. "}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_1)
            elseif Ty.upV == "v9.2" then
                title(plist, "-==[   Version 9.2  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActoldV__v9_2) .. "}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_2)
            elseif Ty.upV == "v9.3" then
                title(plist, "-==[   Version 9.3  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActoldV__v9_3) .. "}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_3, "amod_dance_california_girls")
            elseif Ty.upV == "v9.4" then
                title(plist, "-==[   Version 9.4  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActoldV__v9_4) .. "}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_4)
            elseif Ty.upV == "v9.5" then
                title(plist, "-==[   Version 9.5  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActoldV__v9_5) .. "}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_5, nil, {"amod_fortnite_cerealbox", "amod_fortnite_cyclone"})
            elseif Ty.upV == "v9.6" then
                title(plist, "-==[   Version 9.6  {" .. A_AM.ActMod:ATabDataGNum(A_AM.ActMod.ActNewV) .. "}   ]==-")
                addiT(A_AM.ActMod.ActNewV)
            end
        else
            if Ty.url == "MMD_Reimu" then
                title(plist, '-==[ Version 8.6 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "helltaker._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.2 ]==-')
                addi(plist, {n .. "dance_gokurakujodo._so_.", n .. "dance_caramelldansen._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.4 ]==-')
                addi(plist, {n .. "fiery_sarilang._so_.", n .. "getdown._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.5 ]==-')
                addi(plist, {n .. "calisthenics._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.6 ]==-')
                addi(plist, {n .. "bad_apple_r._so_.", n .. "bad_apple_l._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_Lamb" then
                title(plist, '-==[ Version 8.9 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "dance_nostalogic._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.1 ]==-')
                addi(plist, {n .. "dance_specialist._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.5 ]==-')
                addi(plist, {n .. "girls._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.6 ]==-')
                addi(plist, {n .. "roki_p1._so_.", n .. "roki_p2._so_.",}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_RuneGalin" then
                title(plist, '-==[ Version 9.1 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "theatrical_airline_luk._so_.", n .. "theatrical_airline_mik._so_.", n .. "theatrical_airline_rin._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "Fortnite_Mosit" then
                title(plist, '-==[ Version 9.2 ]==-')
                local n = "amod_fortnite_"
                addiT({n .. "autumntea", n .. "eerie", n .. "eerie_walk", n .. "nevergonna", n .. "twistdaytona", n .. "twisteternity_ayo", n .. "twisteternity_teo"})
                title(plist, '')
                title(plist, '-==[ Version 9.4 ]==-')
                addiT({n .. "aloha", n .. "behere", n .. "bythefire_follower", n .. "bythefire_leader", n .. "dance_distraction", n .. "jiggle", n .. "jumpingjoy_static", n .. "jumpingjoy_walk", n .. "littleegg", n .. "ohana", n .. "spectacleweb", n .. "prance", n .. "realm", n .. "rememberme", n .. "sleek", n .. "sunlit", n .. "tally", n .. "tonal", n .. "zest"})
                title(plist, '')
                title(plist, '-==[ Version 9.5 ]==-')
                addiT({n .. "cerealbox", n .. "griddle", n .. "griddle_walk", n .. "hotpink", n .. "sunburstdance", n .. "cyclone", n .. "cyclone_headbang"})
                title(plist, '')
                title(plist, '-==[ Version 9.6 ]==-')
                addiT({n .. "twistwasp", n .. "stringdance", n .. "gasstation", n .. "grooving", n .. "devotion", n .. "chew"})
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_gmodsans" then
                title(plist, '-==[ Version 9.2 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "dance_daisukeevolution._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_Stan_Jacobs" then
                title(plist, '-==[ Version 9.4 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "sadcatdance._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.5 ]==-')
                addi(plist, {n .. "hiproll._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_BoNoYaSi" then
                title(plist, '-==[ Version 9.4 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "dance_tuni-kun._so_."}, true)
                title(plist, '')
                title(plist, '-==[ Version 9.6 ]==-')
                addi(plist, {n .. "massdestruction._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_TheTwilightDancer" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "blablabla._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_Notcoke" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "ghostdance._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_asukalangley" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "nyaarigato._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_Soukutty" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "hiasobi._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_WackoD" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "caixukun._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_juwii" then
                title(plist, '-==[ Version 9.5 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "yaosobi-idol._so_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_Skyrekpl" then
                title(plist, '-==[ Version 9.6 ]==-')
                local n = "amod_pubg_"
                addi(plist, {n .. "tocatoca._so_.._ef_."}, true)
                title(plist, '')
                tn = nil
            elseif Ty.url == "MMD_olds" then
                title(plist, '-==[ Version 9.6 ]==-')
                local n = "amod_mmd_"
                addi(plist, {n .. "kemuthree._so_."}, true)
                title(plist, '')
                tn = nil
            end
        end

        local Stxt2 = vgui.Create("DPanel", frame)
        Stxt2:SetPos(0, 0)
        Stxt2:SetSize(60, 28)
        Stxt2:SetAlpha(0)
        Stxt2:SetText("")
        Stxt2.Paint = function(s, w, h) end
    end

    as2_ss(self.ShowMenuiA)
end

local function button(list, text, fn)
    local btn = list:Add('DButton')
    btn:SetText(text)
    btn:Dock(TOP)
    btn:DockMargin(0, 0, 0, ScreenScale(2))
    btn.DoClick = function() fn() end
    return btn
end

local function ShowM_LgsUpd(self, Ty)
    if not IsValid(self.OptMenu) then return end
    if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
    self.ShowMenuiA = vgui.Create("DFrame")
    self.ShowMenuiA:SetTitle("")
    self.ShowMenuiA:SetSize(380, 300)
    self.ShowMenuiA:SetAlpha(0)
    self.ShowMenuiA:Center()
    self.ShowMenuiA:MakePopup()
    self.ShowMenuiA:ShowCloseButton(false)
    self.ShowMenuiA:SetDraggable(false)
    self.ShowMenuiA:MoveTo(ScrW() / 2 + 150 - self.ShowMenuiA:GetWide() / 2, ScrH() / 2 - self.ShowMenuiA:GetTall() / 2, 0.3)
    self.ShowMenuiA:AlphaTo(255, 0.2)
    self.ShowMenuiA.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
        draw.RoundedBox(6, 5, 5, w - 10, h - 10, Color(20, 20, 20, 250))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material("actmod/imenu/p_yn.png", "noclamp smooth"))
        surface.DrawTexturedRect(15, 15, 40, 40)
    end

    local Stxt = vgui.Create("DLabel", self.ShowMenuiA)
    Stxt:SetPos(60, 15)
    if GetIDNames and GetIDNames[Ty.name] then
        Stxt:SetText(" " .. GetIDNames[Ty.name] .. " ")
    else
        Stxt:SetText(" " .. Ty.name .. " ")
    end

    Stxt:SetFont("ActMod_a1")
    Stxt:SetTextColor(Color(255, 255, 215))
    Stxt:SizeToContents()
    Stxt.Paint = function(s, w, h) draw.RoundedBox(6, 0, 0, w, h, Color(70, 80, 50, 250)) end
    local SButX = vgui.Create("DButton", self.ShowMenuiA)
    SButX:SetText("X")
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetPos(self.ShowMenuiA:GetWide() - 40, -40)
    SButX:SetSize(30, 30)
    SButX:AlphaTo(255, 0.5, 0.3)
    SButX:MoveTo(self.ShowMenuiA:GetWide() - 40, 10, 0.3, 0.3)
    SButX.Paint = function(ss, w, h)
        if ss:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
        end
    end

    SButX.DoClick = function()
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
    end
end

local function credit(plist, data, aself)
    local pnl = plist:Add('DPanel')
    pnl:SetTall(data.Az or 50)
    pnl:SetText('')
    pnl:Dock(TOP)
    pnl:DockMargin(0, 0, 0, 5)
    if data.url then
        pnl.Bava0 = pnl:Add('DButton')
        pnl.Bava0:SetPos(pnl:GetTall() + 2, 0)
        pnl.Bava0:SetSize(320, pnl:GetTall())
        pnl.Bava0:SetAlpha(0)
        pnl.Bava0:SetText("")
        pnl.Bava0.DoClick = function(p)
            if string.find(data.url, "https:") then
                gui.OpenURL(data.url)
            else
                ShowM_iconActs(aself, data)
            end
        end
    end

    if data.rainbow and data.s64 == "76561199185837385" then
        pnl.Bava1 = pnl:Add('DButton')
        pnl.Bava1:SetPos(220, 0)
        pnl.Bava1:SetSize(150, 25)
        pnl.Bava1:SetAlpha(150)
        pnl.Bava1:SetText("")
        pnl.Bava1.THo = 0
        pnl.Bava1.Think = function(p)
            if p:IsHovered() then
                if p.THo == 0 then
                    p.THo = 1
                    p:AlphaTo(255, 0.3, nil, function(s) if IsValid(pnl.Bava1) then pnl.Bava1.THo = 2 end end)
                end
            else
                if p.THo == 2 then
                    p.THo = 1
                    p:AlphaTo(100, 0.2, nil, function(s) if IsValid(pnl.Bava1) then pnl.Bava1.THo = 0 end end)
                end
            end
        end

        pnl.Bava1.DoClick = function(p) A_AM.ActMod:MSupMe() end
        pnl.Bava1.Paint = function(p, w, h)
            if p:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, p:IsDown() and Color(70, 255, 190, 255) or Color(50, 155, 100, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(160, 160, 180, 255))
            end

            draw.RoundedBox(4, 0, 0, w, h / 1.5, Color(10, 20, 200, 200))
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material("icon16/heart.png", "noclamp smooth"))
            surface.DrawTexturedRect(w - h / 1.2, h / 2 - 10, 20, 20)
            draw.SimpleTextOutlined(aR:T("LReplace_txt_supl"), "ActMod_a3", w / 2 - 12, h / 2, Color(255, 255, 255, 255), 1, 1, 1, Color(5, 5, 255, 255))
        end
    end

    pnl.Paint = function(p, w, h)
        if pnl.Bava0 then
            if data.rainbow then
                if p.Bava0:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(100, 180, 150, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(20, 60, 60, 255))
                end
            else
                if p.Bava0:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(80, 70, 150, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 40, 255))
                end
            end
        else
            if p:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(80, 70, 150, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 40, 255))
            end
        end
    end

    if data.name and data.icon then
        local Bicon = pnl:Add('DLabel')
        Bicon:SetSize(335, pnl:GetTall())
        Bicon:SetAlpha(255)
        Bicon:SetText("")
        Bicon.Paint = function(p, w, h)
            if data.icon then
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.SetMaterial(Material(data.icon, "noclamp smooth"))
                surface.DrawTexturedRect(5, 2, h - 4, h - 4)
            end

            if data.name then draw.SimpleText(data.name, "ActMod_a6", w / 2 + 10, h / 2, Color(255, 255, 255, 255), 1, 1) end
        end
    end

    if data.s64 then
        local avatar = pnl:Add('AvatarImage')
        avatar:SetSteamID(data.s64, 64)
        avatar:DockMargin(2, 2, 5, 2)
        avatar:SetWide(pnl:GetTall() - 4)
        avatar:Dock(LEFT)
        local Bava = avatar:Add('DButton')
        Bava:Dock(FILL)
        Bava:SetSize(avatar:GetTall(), avatar:GetTall())
        Bava:SetAlpha(255)
        Bava:SetText("")
        Bava.DoClick = function(p) gui.OpenURL("https://steamcommunity.com/profiles/" .. data.s64) end
        Bava.Paint = function(p, w, h)
            if p:IsHovered() then
                surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
                surface.DrawOutlinedRect(0, 0, w, h, 3 + (2 * math.sin(CurTime() * 4)))
            end
        end

        local lblName = pnl:Add('DLabel')
        if GetIDNames and GetIDNames[data.name] then
            lblName:SetText(GetIDNames[data.name])
        else
            lblName:SetText(data.name)
        end

        lblName:SetFont('ActMod_a1')
        lblName:SetExpensiveShadow(1, color_black)
        lblName:Dock(FILL)
        if data.rainbow then
            lblName.Think = function(p) p:SetTextColor(HSVToColor((CurTime() * 16) % 360, 1, 1)) end
        else
            lblName:SetTextColor(data.color or color_white)
        end

        A_AM.ActMod:GetNameA(data.s64, function(Gname, Gonln)
            if IsValid(lblName) and Gname ~= "nonE" then
                GetIDNames[data.name] = Gname
                lblName:SetText(GetIDNames[data.name])
            end

            if IsValid(avatar) and Gonln ~= "nonE" then
                local lbOnli = vgui.Create('DPanel', pnl)
                lbOnli:SetText("")
                lbOnli:SetSize(20, 20)
                lbOnli:SetPos(-10, avatar:GetTall() - 30)
                if string.find(Gonln, "Online") or string.find(Gonln, "In-") then
                    lbOnli.Gnow = 2
                elseif string.find(string.sub(Gonln, 1, 7), "Offline") then
                    lbOnli.Gnow = 1
                else
                    lbOnli.Gnow = 0
                end

                lbOnli.Paint = function(p, w, h)
                    if p.Gnow == 2 then
                        draw.RoundedBox(10, 0, 0, w, h, Color(10, 10, 10, 100 + (100 * math.sin(CurTime() * 5))))
                        draw.RoundedBox(8, 2, 2, w - 4, h - 4, p:IsHovered() and Color(50, 255, 200, 255) or Color(50, 220, 150, 200 + (55 * math.sin(CurTime() * 5))))
                        CTxtMos(p, nil, {20, 150, 50, 140}, "Online", "CreditsText", 1)
                    elseif p.Gnow == 1 then
                        draw.RoundedBox(10, 0, 0, w, h, Color(10, 10, 10, 100 + (100 * math.sin(CurTime() * 5))))
                        draw.RoundedBox(8, 2, 2, w - 4, h - 4, p:IsHovered() and Color(200, 100, 0, 255) or Color(120, 0, 0, 200 + (55 * math.sin(CurTime() * 5))))
                        CTxtMos(p, nil, {100, 100, 50, 140}, "Offline", "CreditsText", 1)
                    else
                        draw.RoundedBox(10, 0, 0, w, h, Color(255, 40, 0, 255))
                    end
                end
            end
        end)
    end

    if data.desc then
        local lblDesc = pnl:Add('DLabel')
        lblDesc:SetText(data.desc)
        lblDesc:SetFont('ActMod_a5')
        lblDesc:SetExpensiveShadow(1, color_black)
        lblDesc:Dock(BOTTOM)
    end
end

Actoji.AMenuOption = function(self, ply)
    if IsValid(ply) then
        local function Button_DLabel(dkj, aPos, bPos, aSize, bSize, aText, comm, srvr)
            local SButton = vgui.Create("DPanel", dkj)
            SButton:SetText("")
            SButton:SetPos(aPos, bPos)
            SButton:SetSize(dkj:GetWide() - aPos * 2, bSize)
            SButton.Paint = function(self, w, h) end
            local es = vgui.Create("DPanel", SButton)
            es:SetPos(2, 5)
            es:SetSize(30, 30)
            es:SetText("")
            es:SetAlpha(0)
            timer.Simple(0.2, function() if IsValid(dkj) then es:AlphaTo(255, 0.5) end end)
            es.Paint = function(ste, w, h)
                surface.SetDrawColor(Color(255, 255, 255, 255))
                if GetConVarNumber(comm) == 1 then
                    surface.SetMaterial(Material("icon16/tick.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
                end

                surface.DrawTexturedRect(0, 0, w, h)
            end

            local pButton = vgui.Create("DButton", SButton)
            pButton:SetText("")
            pButton:SetPos(0, 0)
            pButton:SetSize(40, 40)
            local FpsText = vgui.Create("DPanel", SButton)
            FpsText:SetPos(35, 4.5)
            FpsText:SetText("")
            FpsText:SetAlpha(0)
            if comm == "actmod_sv_enabled_addso" or comm == "actmod_cl_sound" then
                FpsText:SetSize(A_AM.ActMod:AZtxt(aText .. " 888%", "DermaLarge"), 30)
            else
                FpsText:SetSize(A_AM.ActMod:AZtxt(aText, "DermaLarge"), 30)
            end

            FpsText:AlphaTo(255, 0.5)
            FpsText.gga = false
            FpsText.Paint = function(p, w, h)
                if p:IsHovered() then draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100)) end
                if comm == "actmod_sv_avs" then CTxtMos(p, nil, {100, 100, 100, 200}, aR:T("LAchievements_H"), "CreditsText") end
                if p.gga == true then draw.RoundedBox(0, 0, 0, w, h, Color(80, 100, 255, 100)) end
                if comm == "actmod_sv_enabled_addso" and GetConVarNumber("actmod_sv_enabled_addso") > 0 then
                    draw.SimpleText(aText .. " " .. GetConVarNumber("actmod_sv_soundlevel") .. "%", "DermaLarge", 0, h / 2, Color(255, 255, 255, 255), 0, 1)
                elseif comm == "actmod_cl_sound" and GetConVarNumber("actmod_cl_sound") > 0 then
                    draw.SimpleText(aText .. " " .. GetConVarNumber("actmod_cl_soundlevel") .. "%", "DermaLarge", 0, h / 2, Color(255, 255, 255, 255), 0, 1)
                else
                    draw.SimpleText(aText, "DermaLarge", 0, h / 2, Color(255, 255, 255, 255), 0, 1)
                end
            end

            pButton.Paint = function(self, w, h)
                if ply:IsSuperAdmin() and pButton:IsHovered() then
                    surface.SetDrawColor(Color(255, 255, 255, 255))
                    surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, w - 5, h)
                    FpsText.gga = true
                elseif srvr and pButton:IsHovered() then
                    surface.SetDrawColor(Color(255, 255, 255, 255))
                    surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, w - 5, h)
                    FpsText.gga = true
                elseif FpsText.gga == true then
                    FpsText.gga = false
                end
            end

            pButton.DoClick = function()
                if ply:IsSuperAdmin() then
                    surface.PlaySound("garrysmod/ui_click.wav")
                    if GetConVarNumber(comm) == 1 then
                        RunConsoleCommand(comm, "0")
                    else
                        RunConsoleCommand(comm, "1")
                    end
                elseif srvr then
                    surface.PlaySound("garrysmod/ui_click.wav")
                    if GetConVarNumber(comm) == 1 then
                        RunConsoleCommand(comm, "0")
                    else
                        RunConsoleCommand(comm, "1")
                    end
                else
                    surface.PlaySound("garrysmod/ui_return.wav")
                end
            end
        end

        local function as2_ss(asa)
            local frame = vgui.Create('DPanel', asa)
            frame:SetPos(10, 60)
            frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 100)
            frame.Paint = function(p, w, h) draw.RoundedBox(5, 0, 0, w, h, Color(10, 50, 150, 150)) end
            local plist = frame:Add('AM4_DScrollPanel')
            plist:Dock(FILL)
            title(plist, aR:T("LGPly_Credits"))
            credit(plist, {
                name = 'AhmedMake400',
                s64 = '76561199185837385',
                desc = aR:T("LGPly_Aif"),
                url = 'https://steamcommunity.com/sharedfiles/filedetails/?id=2538387266',
                rainbow = true
            }, self)

            title(plist, '')
            title(plist, aR:T("LGPly_PHme"))
            credit(plist, {
                name = 'lambups',
                s64 = '76561198448486497',
                desc = aR:T("cr_txtProg_")
            }, self)

            credit(plist, {
                name = 'Don Juan',
                s64 = '76561198264353568',
                desc = aR:T("cr_txtHAni_")
            }, self)

            credit(plist, {
                name = 'TiberiumFusion',
                s64 = '76561198029133445',
                desc = aR:T("cr_txtHAni_")
            }, self)

            credit(plist, {
                name = 'WackoD',
                s64 = '76561198046405253',
                desc = aR:T("cr_txtProg2_")
            }, self)

            title(plist, '')
            title(plist, aR:T("LGPly_PwsfA"))
            credit(plist, {
                name = '牛栏山辉夜',
                s64 = '76561198859969600',
                url = 'MMD_Reimu',
                desc = "[6]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'lambups',
                s64 = '76561198448486497',
                url = 'MMD_Lamb',
                desc = "[3]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'RuneGalin',
                s64 = '76561198054147531',
                url = 'MMD_RuneGalin',
                desc = "[3]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'MoistCr1tikal',
                s64 = '76561198071567487',
                url = 'Fortnite_Mosit',
                desc = "[28]- " .. aR:T("cr_txtFortnite") .. "  ( .psa )"
            }, self)

            credit(plist, {
                name = 'gmodsans',
                s64 = '76561199030803470',
                url = 'MMD_gmodsans',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'Sir Jallaston',
                s64 = '76561199074954623',
                url = 'MMD_BoNoYaSi',
                desc = "[2]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'Stan_Jacobs',
                s64 = '76561198247233572',
                url = 'MMD_Stan_Jacobs',
                desc = "[2]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'TheTwilightDancer',
                s64 = '76561198158807873',
                url = 'MMD_TheTwilightDancer',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'Notcoke',
                s64 = '76561198013910586',
                url = 'MMD_Notcoke',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'asukalangley',
                s64 = '76561199243768419',
                url = 'MMD_asukalangley',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'Soukutty',
                s64 = '76561198272832543',
                url = 'MMD_Soukutty',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'WackoD',
                s64 = '76561198046405253',
                url = 'MMD_WackoD',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'juwii',
                s64 = '76561198804828085',
                url = 'MMD_juwii',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'Skyrekpl',
                s64 = '76561198099751619',
                url = 'MMD_Skyrekpl',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            credit(plist, {
                name = 'old.老六',
                s64 = '76561199155861316',
                url = 'MMD_olds',
                desc = "[1]- " .. aR:T("cr_txtMND") .. "  ( .vmd )"
            }, self)

            title(plist, '')
            title(plist, aR:T("LGPly_AdLa"))
            credit(plist, {
                name = 'AhmedMake400',
                s64 = '76561199185837385',
                desc = aR:T("cr_txtAL_") .. "   China"
            }, self)

            credit(plist, {
                name = 'MoistCr1tikal',
                s64 = '76561198071567487',
                desc = aR:T("cr_txtAL_") .. "   Russian"
            }, self)

            credit(plist, {
                name = 'NextKuromeThe76Soldier',
                s64 = '76561197960487064',
                desc = aR:T("cr_txtAL_") .. "   Germany"
            }, self)

            title(plist, '')
            title(plist, aR:T("LGPly_InfoActMod"))
            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.6",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.6"
            }, self)

            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.5",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.5"
            }, self)

            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.4",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.4"
            }, self)

            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.3",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.3"
            }, self)

            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.2",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.2"
            }, self)

            credit(plist, {
                Az = 30,
                name = aR:T("LGPly_Info_upV") .. "  v9.1",
                icon = "icon32/folder.png",
                url = "LogsUpdt",
                upV = "v9.1"
            }, self)

            title(plist, '')
            return frame
        end

        if IsValid(self.OptMenu) then self.OptMenu:Remove() end
        local aa_self = vgui.Create("DButton")
        aa_self:SetSize(ScrW(), ScrH())
        aa_self:SetText("")
        aa_self:MakePopup()
        aa_self:SetCursor("arrow")
        aa_self:Center()
        aa_self:SetAlpha(0)
        aa_self.DoClick = function()
            if IsValid(self.OptMenu) and IsValid(self.ShowMenuiA) then
                self.ShowMenuiA:Remove()
                if IsValid(self.OptMenu) then self.OptMenu:MakePopup() end
            elseif IsValid(self.OptMenu) then
                self.OptMenu:Remove()
            end
        end

        self.OptMenu = vgui.Create("DFrame")
        self.OptMenu:SetTitle("")
        self.OptMenu:SetSize(410, 555)
        self.OptMenu:SetAlpha(0)
        self.OptMenu:Center()
        self.OptMenu:MakePopup()
        self.OptMenu:ShowCloseButton(false)
        self.OptMenu:SetDraggable(false)
        self.OptMenu:MoveTo(ScrW() / 10, ScrH() / 2 - self.OptMenu:GetTall() / 2, 0.3)
        self.OptMenu:AlphaTo(255, 0.3)
        self.OptMenu.OnRemove = function(pan)
            if IsValid(aa_self) then aa_self:Remove() end
            if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
        end

        self.OptMenu.Paint = function(s, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
            draw.RoundedBox(6, 5, 5, w - 10, h - 10, Color(20, 20, 20, 250))
        end

        self.OptMenu.TimeR = CurTime() + 0.8
        self.OptMenu.mTy = 1
        timer.Simple(0.4, function()
            if IsValid(self.OptMenu) then
                self.OptMenu.SBut = vgui.Create("DButton", self.OptMenu)
                self.OptMenu.SBut:SetText("X")
                self.OptMenu.SBut:SetFont("ActMod_a1")
                self.OptMenu.SBut:SetAlpha(0)
                self.OptMenu.SBut:SetTextColor(Color(20, 5, 5))
                self.OptMenu.SBut:SetPos(self.OptMenu:GetWide() - 40, -40)
                self.OptMenu.SBut:SetSize(30, 30)
                timer.Simple(0.5, function() if IsValid(self.OptMenu) then self.OptMenu.SBut:AlphaTo(255, 0.3) end end)
                self.OptMenu.SBut:MoveTo(self.OptMenu:GetWide() - 40, 10, 0.4)
                self.OptMenu.SBut.Paint = function(ss, w, h)
                    if ss:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
                    end
                end

                self.OptMenu.SBut.DoClick = function()
                    surface.PlaySound("garrysmod/balloon_pop_cute.wav")
                    if IsValid(self.OptMenu) then self.OptMenu:Remove() end
                end

                self.OptMenu.TxtV = vgui.Create("DLabel", self.OptMenu)
                self.OptMenu.TxtV:SetPos(7, self.OptMenu:GetTall() - 25)
                self.OptMenu.TxtV:SetSize(243, 20)
                self.OptMenu.TxtV:SetAlpha(0)
                self.OptMenu.TxtV:SetFont("ActMod_a2")
                self.OptMenu.TxtV:SetText(" " .. aR:T("AL_i_iefoV") .. "  AhmedMake400")
                timer.Simple(1.1, function() if IsValid(self.OptMenu) then self.OptMenu.TxtV:AlphaTo(255, 0.5) end end)
                self.OptMenu.Txt2V = vgui.Create("DLabel", self.OptMenu)
                self.OptMenu.Txt2V:SetPos(self.OptMenu:GetWide() - 120, self.OptMenu:GetTall() - 25)
                self.OptMenu.Txt2V:SetSize(120, 20)
                self.OptMenu.Txt2V:SetAlpha(0)
                self.OptMenu.Txt2V:SetFont("ActMod_a3")
                self.OptMenu.Txt2V:SetText(aR:T("AL_i_iefoV2") .. A_AM.ActMod.Mounted["Version ActMod"] .. ")")
                timer.Simple(1.7, function() if IsValid(self.OptMenu) then self.OptMenu.Txt2V:AlphaTo(255, 0.5) end end)
            end
        end)

        local function as1_ss(asa)
            local esOpt = vgui.Create("DPanel", asa)
            esOpt:SetPos(0, 50)
            esOpt:SetSize(asa:GetWide(), asa:GetTall() - 50)
            esOpt:SetText("")
            esOpt.Paint = function(s, w, h) end
            timer.Simple(0.0, function()
                if IsValid(self.OptMenu) then
                    local es = vgui.Create("DPanel", esOpt)
                    es:SetPos(30, 10)
                    es:SetSize(esOpt:GetWide() - 60, 175)
                    es:SetText("")
                    es:SetAlpha(0)
                    es:AlphaTo(255, 0.5)
                    es.Paint = function(ste, w, h)
                        if ply:IsSuperAdmin() then
                            draw.RoundedBox(6, 0, 0, w, h, Color(40, 80, 100, 250))
                        else
                            draw.RoundedBox(6, 0, 0, w, h, Color(50, 40, 40, 250))
                        end
                    end

                    local FpsText = vgui.Create("DLabel", es)
                    FpsText:SetPos(2, 2)
                    FpsText:SetText(aR:T("AL_SOS"))
                    FpsText:SetFont("ActMod_a1")
                    FpsText:SizeToContents()
                    timer.Simple(0.05, function()
                        if IsValid(self.OptMenu) then
                            Button_DLabel(es, 2, 30, 250, 40, aR:T("AL_SOS_EA"), "actmod_sv_enabled")
                            timer.Simple(0.05, function()
                                if IsValid(self.OptMenu) then
                                    Button_DLabel(es, 2, 65, 250, 40, aR:T("AL_SOS_AF"), "actmod_sv_enabled_addef")
                                    timer.Simple(0.05, function() if IsValid(self.OptMenu) then Button_DLabel(es, 2, 100, 250, 40, aR:T("AL_SOS_AS"), "actmod_sv_enabled_addso") end end)
                                    timer.Simple(0.1, function() if IsValid(self.OptMenu) then Button_DLabel(es, 2, 135, 250, 40, aR:T("LAchievements"), "actmod_sv_avs") end end)
                                end
                            end)
                        end
                    end)
                end
            end)

            timer.Simple(0.1, function()
                if IsValid(self.OptMenu) then
                    local es = vgui.Create("DPanel", esOpt)
                    es:SetPos(30, 205)
                    es:SetSize(esOpt:GetWide() - 60, 270)
                    es:SetText("")
                    es:SetAlpha(0)
                    es:AlphaTo(255, 0.5)
                    es.Paint = function(ste, w, h) draw.RoundedBox(6, 0, 0, w, h, Color(40, 80, 60, 250)) end
                    local FpsText = vgui.Create("DLabel", es)
                    FpsText:SetPos(2, 2)
                    FpsText:SetText(aR:T("AL_COS"))
                    FpsText:SetFont("ActMod_a1")
                    FpsText:SizeToContents()
                    timer.Simple(0.0, function()
                        if IsValid(self.OptMenu) then
                            local FpsText = vgui.Create("DLabel", es)
                            FpsText:SetPos(2, 35)
                            FpsText:SetAlpha(0)
                            FpsText:SetText(aR:T("AL_COS_Ky"))
                            FpsText:SetFont("DermaLarge")
                            FpsText:SizeToContents()
                            FpsText:AlphaTo(255, 0.5)
                            local button_open = vgui.Create("DBinder", es)
                            button_open:SetPos(es:GetWide() - 200, 32)
                            button_open:SetSize(180, 40)
                            button_open:SetAlpha(0)
                            button_open:AlphaTo(255, 0.5)
                            button_open:SetValue(GetConVar("actmod_key_iconmenu"):GetInt())
                            button_open:SetFont("ActMod_a1")
                            button_open.kyT = false
                            button_open.Paint = function(self, w, h)
                                if button_open.kyT == true then
                                    draw.RoundedBox(10, 0, 0, w, h, Color(math.max(200 + (55 * math.sin(CurTime() * 7)), 200), 150, 80, 255))
                                else
                                    draw.RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 255))
                                end
                            end

                            function button_open:OnChange(num)
                                if num == 66 or num == 83 or num == 107 or num == 108 or num == 109 or num == 112 or num == 113 or num == GetConVar("actmod_keyo_h"):GetInt() then
                                    button_open:SetText(aR:T("AL_COS_CKy"))
                                    button_open.kyT = true
                                    button_open:SetFont("ActMod_a5")
                                else
                                    button_open.kyT = false
                                    button_open:SetFont("ActMod_a1")
                                    RunConsoleCommand("actmod_key_iconmenu", num)
                                end
                            end

                            timer.Simple(0.05, function()
                                if IsValid(self.OptMenu) then
                                    Button_DLabel(es, 2, 75, 250, 40, aR:T("AL_COS_EF"), "actmod_cl_effects", true)
                                    timer.Simple(0.05, function()
                                        if IsValid(self.OptMenu) then
                                            Button_DLabel(es, 2, 115, 250, 40, aR:T("AL_COS_ES"), "actmod_cl_sound", true)
                                            timer.Simple(0.05, function()
                                                if IsValid(self.OptMenu) then
                                                    Button_DLabel(es, 2, 155, 250, 40, aR:T("AL_COS_EH"), "actmod_cl_showbhelp", true)
                                                    timer.Simple(0.05, function()
                                                        if IsValid(self.OptMenu) then
                                                            Button_DLabel(es, 2, 195, 250, 40, aR:T("AL_COS_EC"), "actmod_cl_cam180", true)
                                                            local tl = GetConVarString("actmod_cl_lang") or ""
                                                            local DPa_ = vgui.Create("DPanel", es)
                                                            DPa_:SetSize(35, 25)
                                                            DPa_:SetPos(4, 240)
                                                            DPa_:SetAlpha(0)
                                                            DPa_:AlphaTo(255, 0.5, 0.3)
                                                            DPa_.Paint = function(ste, w, h)
                                                                surface.SetDrawColor(color_white)
                                                                if tl == "ru" then
                                                                    surface.SetMaterial(Material("flags16/ru.png", "noclamp smooth"))
                                                                elseif tl == "zh-CN" then
                                                                    surface.SetMaterial(Material("flags16/cn.png", "noclamp smooth"))
                                                                elseif tl == "de" then
                                                                    surface.SetMaterial(Material("flags16/de.png", "noclamp smooth"))
                                                                else
                                                                    surface.SetMaterial(Material("flags16/gb.png", "noclamp smooth"))
                                                                end

                                                                surface.DrawTexturedRect(0, 0, w, h)
                                                            end

                                                            local DButCh = vgui.Create("DComboBox", DPa_)
                                                            DButCh:SetSize(35, 25)
                                                            DButCh:SetPos(0, 0)
                                                            DButCh:SetAlpha(0)
                                                            DButCh:SetText("")
                                                            DButCh:AddChoice("1- English", "en", false, "flags16/gb.png")
                                                            DButCh:AddChoice("2- Russian", "ru", false, "flags16/ru.png")
                                                            DButCh:AddChoice("3- China", "zh-CN", false, "flags16/cn.png")
                                                            DButCh:AddChoice("5- Germany", "de", false, "flags16/de.png")
                                                            DButCh.OnSelect = function(pl, index, value, data)
                                                                surface.PlaySound("garrysmod/content_downloaded.wav")
                                                                LocalPlayer():ConCommand("actmod_cl_lang " .. data .. "\n")
                                                                tl = data
                                                                if IsValid(self.OptMenu.mMun1) then
                                                                    self.OptMenu.mMun1:Remove()
                                                                    timer.Simple(0.1, function()
                                                                        if IsValid(self.OptMenu) then
                                                                            self.OptMenu.mMun1 = as1_ss(self.OptMenu)
                                                                            self.OptMenu.B1:SetText(aR:T("AL_Optin"))
                                                                            self.OptMenu.B1:SizeToContents()
                                                                            self.OptMenu.B2:SetText(aR:T("AL_About"))
                                                                            self.OptMenu.B2:SizeToContents()
                                                                            self.OptMenu.TxtV:SetText(" " .. aR:T("AL_i_iefoV") .. "  AhmedMake400")
                                                                            self.OptMenu.Txt2V:SetText(aR:T("AL_i_iefoV2") .. A_AM.ActMod.Mounted["Version ActMod"] .. ")")
                                                                        end
                                                                    end)
                                                                end
                                                            end

                                                            local t2 = GetConVarNumber("actmod_cl_stibox") or 1
                                                            local aa_ = vgui.Create("DPanel", es)
                                                            aa_:SetSize(25, 25)
                                                            aa_:SetPos(60, 240)
                                                            aa_:SetAlpha(0)
                                                            aa_:AlphaTo(255, 0.5, 0.3)
                                                            aa_.Paint = function(ste, w, h)
                                                                surface.SetDrawColor(color_white)
                                                                if GetConVarNumber("actmod_cl_stibox") > 1 then
                                                                    surface.SetMaterial(Material("materials/actmod/sm_hover" .. tostring(GetConVarNumber("actmod_cl_stibox")) .. ".png", "noclamp smooth"))
                                                                else
                                                                    surface.SetMaterial(Material("materials/actmod/sm_hover.png", "noclamp smooth"))
                                                                end

                                                                surface.DrawTexturedRect(0, 0, w, h)
                                                            end

                                                            local DBu1 = vgui.Create("DButton", aa_)
                                                            DBu1:SetSize(aa_:GetWide(), aa_:GetTall())
                                                            DBu1:SetText("")
                                                            DBu1:SetAlpha(0)
                                                            DBu1.Paint = function() end
                                                            DBu1.DoClick = function(s) A_AM.ActMod:MunChIBox() end
                                                            local DBu = vgui.Create("DButton", es)
                                                            DBu:SetPos(es:GetWide() - 195, es:GetTall() - 30)
                                                            DBu:SetSize(190, 25)
                                                            DBu:SetText(aR:T("LReplace_txt_RAll"))
                                                            DBu:SetDark(true)
                                                            DBu:SetAlpha(0)
                                                            DBu:AlphaTo(255, 0.5, 0.5)
                                                            DBu.DoClick = function(s)
                                                                Derma_Query(aR:T("LReplace_txt_R_t1"), aR:T("LReplace_txt_RAll"), aR:T("LORTR_Yes"), function()
                                                                    Derma_Query(aR:T("LReplace_txt_R_t3") .. "\n" .. aR:T("LReplace_txt_R_t2"), aR:T("LReplace_txt_RAll"), aR:T("LReplace_txt_R_t4"), function()
                                                                        local function Rre(t, s)
                                                                            local as = s
                                                                            if isnumber(s) then
                                                                                as = math.floor(s)
                                                                            elseif isstring(s) then
                                                                                as = tostring(s)
                                                                            end

                                                                            LocalPlayer():ConCommand(t .. " " .. as .. "\n")
                                                                        end

                                                                        Rre("actmod_cl_menuformat", 1)
                                                                        Rre("actmod_cl_menuformat2", 1)
                                                                        Rre("actmod_cl_loop", 2)
                                                                        Rre("actmod_cl_effects", 1)
                                                                        Rre("actmod_cl_sound", 1)
                                                                        Rre("actmod_cl_setcamera", 0)
                                                                        Rre("actmod_cl_stext", "taunt")
                                                                        Rre("actmod_cl_showmodl", 0)
                                                                        Rre("actmod_cl_sortemote", 1)
                                                                        Rre("actmod_cl_showbhelp", 1)
                                                                        Rre("actmod_cl_cam180", 0)
                                                                        if file.Exists(A_AM.ActMod:A_BED(2, "bm5sai5qc29u"), "DATA") then
                                                                            file.Delete(A_AM.ActMod:A_BED(2, "bm5sai5qc29u"), "DATA")
                                                                            timer.Create("Acl_t1", 0.2, 1, function() if IsValid(LocalPlayer()) then A_AM.ActMod:A_ReGD() end end)
                                                                        end

                                                                        ActojiClear()
                                                                        self:Close(true)
                                                                        if IsValid(self.OptMenu) then self.OptMenu:Remove() end
                                                                        if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
                                                                        Derma_Message(aR:T("LReplace_txt_R_t6"), aR:T("LReplace_txt_R_t5"), aR:T("LReplace_txt_R_t7"))
                                                                    end, aR:T("LORTR_No"), function() end)
                                                                end, aR:T("LORTR_No"), function() end)
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
                end
            end)
            return esOpt
        end

        timer.Simple(0.4, function() if IsValid(self.OptMenu) then self.OptMenu.mMun1 = as1_ss(self.OptMenu) end end)
        self.OptMenu.B1 = vgui.Create("DButton", self.OptMenu)
        self.OptMenu.B1:SetPos(10, 15)
        self.OptMenu.B1:SetText(aR:T("AL_Optin"))
        self.OptMenu.B1:SetFont("ActMod_a1")
        self.OptMenu.B1:SetTextColor(Color(205, 255, 255))
        self.OptMenu.B1:SizeToContents()
        self.OptMenu.B1.Paint = function(s, w, h)
            if self.OptMenu.mTy == 1 then
                draw.RoundedBox(6, 0, 0, w, h, Color(100, 100, 50, 250))
            elseif (self.OptMenu.TimeR or 0) > CurTime() then
                draw.RoundedBox(6, 0, 0, w, h, Color(20, 20, 20, 250))
            else
                draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 50, 250))
            end
        end

        self.OptMenu.B1.DoClick = function()
            if self.OptMenu.mTy == 2 and (self.OptMenu.TimeR or 0) < CurTime() then
                self.OptMenu.TimeR = CurTime() + 0.5
                surface.PlaySound("garrysmod/ui_return.wav")
                if IsValid(self.OptMenu.mMun1) then self.OptMenu.mMun1:Remove() end
                self.OptMenu.mMun1 = as1_ss(self.OptMenu)
                self.OptMenu.mTy = 1
            end
        end

        self.OptMenu.B2 = vgui.Create("DButton", self.OptMenu)
        self.OptMenu.B2:SetPos(240, 15)
        self.OptMenu.B2:SetText(aR:T("AL_About"))
        self.OptMenu.B2:SetFont("ActMod_a1")
        self.OptMenu.B2:SetTextColor(Color(205, 255, 255))
        self.OptMenu.B2:SizeToContents()
        self.OptMenu.B2.Paint = function(s, w, h)
            if self.OptMenu.mTy == 2 then
                draw.RoundedBox(6, 0, 0, w, h, Color(100, 100, 50, 250))
            elseif (self.OptMenu.TimeR or 0) > CurTime() then
                draw.RoundedBox(6, 0, 0, w, h, Color(20, 20, 20, 250))
            else
                draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 50, 250))
            end
        end

        self.OptMenu.B2.DoClick = function()
            if self.OptMenu.mTy == 1 and (self.OptMenu.TimeR or 0) < CurTime() then
                surface.PlaySound("garrysmod/ui_return.wav")
                if IsValid(self.OptMenu.mMun1) then self.OptMenu.mMun1:Remove() end
                self.OptMenu.mMun1 = as2_ss(self.OptMenu)
                self.OptMenu.mTy = 2
            end
        end
    end
end

Actoji.HelpFixActMod = function(self, Slot) gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2535949423") end
Actoji.Crt_MenuPly = function(self, ply2)
    if IsValid(self.i_MenuPly) then self.i_MenuPly:Remove() end
    local Pl = LocalPlayer()
    local S_Pos1, S_Pos2, S_Siz1, S_Siz2 = ScrW() / 2, ScrH() / 5, 500, 250
    local function Ri_Table_Ply(Ply, Ret)
        Ply.GetR_i = Ret and Ply.GetR_i or {
            ["P_iFPS"] = "nil_",
            ["P_Ping"] = "nil_",
            ["P_Health"] = "nil_",
            ["P_HealthMax"] = "nil_",
            ["P_ddd"] = "nil_",
            ["P_Pos"] = "nil_",
            ["P_Ang"] = "nil_",
            ["P_Length"] = "nil_",
            ["P_Weap"] = "nil_"
        }
    end

    Ri_Table_Ply(ply2)
    local function CButt1(vch, ps1, ps2, sz1, zs2, txt)
        local SButton = vgui.Create("DButton", vch)
        SButton:SetText(txt or "")
        SButton:SetFont("ActMod_a1")
        SButton:SetAlpha(80)
        SButton:SetTextColor(Color(120, 215, 255))
        SButton:SetPos(ps1, ps2)
        SButton:SetSize(sz1, zs2)
        return SButton
    end

    local function Bdt(ps1, ps2, tcon)
        local ZZ, pp, N_mat, N_txt, N_fnt = self.i_MenuPly:GetWide() - 230, 35, "icon16/control_repeat_blue.png", "None :: ", "ActMod_a1"
        if tcon == "fps" then
            ZZ = 135
            N_mat = "icon16/control_repeat_blue.png"
            N_txt = "Fps : "
        elseif tcon == "Ping" then
            ZZ = 130
            N_mat = "icon16/transmit_blue.png"
            N_txt = "Ping : "
        elseif tcon == "ddd" then
            N_mat = "icon16/time.png"
            N_txt = "TimePlayer : "
        elseif tcon == "Health" then
            N_mat = "icon16/heart.png"
            N_txt = "Health : "
        elseif tcon == "Pos" then
            N_mat = "icon16/arrow_in.png"
            N_txt = "Pos : "
        elseif tcon == "Ang" then
            N_mat = "icon16/arrow_rotate_clockwise.png"
            N_txt = "Angle : "
        elseif tcon == "Length" then
            N_mat = "icon16/arrow_right.png"
            N_txt = "Velocity : "
        elseif tcon == "Weap" then
            N_mat = "icon16/gun.png"
            N_txt = "Weapon : "
        end

        local rh = vgui.Create("DPanel", self.i_MenuPly)
        rh:SetPos(ps1, ps2)
        rh:SetSize(ZZ, 25)
        rh:SetText("")
        rh:SetAlpha(255)
        rh.ttaa = false
        rh.Paint = function(s, w, h)
            if not IsValid(ply2) then return end
            if s:IsHovered() then
                draw.RoundedBox(10, 0, 0, w, h, Color(70, 70, 60, 255))
            else
                draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
            end

            draw.SimpleText(N_txt, N_fnt, pp, 0, color_white)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(Material(N_mat, "noclamp smooth"))
            surface.DrawTexturedRect(5, 0, 25, 25)
            if tcon == "fps" then
                draw.SimpleText(ply2.GetR_i["P_iFPS"], N_fnt, w - 10, 0, Color(200, 220, 255, 255), 2)
            elseif tcon == "Ping" then
                draw.SimpleText(ply2.GetR_i["P_Ping"], N_fnt, w - 10, 0, Color(200, 220, 255, 255), 2)
            elseif tcon == "Health" then
                draw.SimpleText(ply2.GetR_i["P_Health"] .. " / " .. ply2.GetR_i["P_HealthMax"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "ddd" then
                draw.SimpleText(ply2.GetR_i["P_ddd"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "Pos" then
                draw.SimpleText(ply2.GetR_i["P_Pos"], "ActMod_a4", w - 10, 6, Color(255, 235, 215, 255), 2)
            elseif tcon == "Ang" then
                draw.SimpleText(ply2.GetR_i["P_Ang"], "ActMod_a5", w - 10, 4, Color(255, 235, 215, 255), 2)
            elseif tcon == "Length" then
                draw.SimpleText(ply2.GetR_i["P_Length"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "Weap" then
                draw.SimpleText(ply2.GetR_i["P_Weap"], "ActMod_a5", w - 10, 3, Color(255, 235, 215, 255), 2)
            end
        end

        rh.Think = function()
            if IsValid(ply2) and (self.i_MenuPly.TimeR or 0) < CurTime() then
                self.i_MenuPly.TimeR = CurTime() + 0.5
                net.Start("A_AM.SC_T_PlyP_ToSv")
                net.WriteEntity(Pl)
                net.WriteEntity(ply2)
                net.WriteString("GetTabiPly_1To2_Start")
                net.WriteTable(ply2.GetR_i)
                net.SendToServer()
            end
        end
    end

    self.i_MenuPly = vgui.Create("DFrame")
    self.i_MenuPly:SetTitle(ply2:Nick() or "None")
    self.i_MenuPly:MakePopup()
    self.i_MenuPly:ShowCloseButton(false)
    self.i_MenuPly:SetSize(S_Siz1, S_Siz2)
    self.i_MenuPly:SetPos(S_Pos1 - S_Siz1 / 2, S_Pos2)
    self.i_MenuPly:SetAlpha(0)
    self.i_MenuPly:AlphaTo(255, 0.5)
    self.i_MenuPly.TimeR = CurTime() + 0.7
    self.i_MenuPly.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(50, 60, 80, 255)) end
    local CB1 = CButt1(self.i_MenuPly, self.i_MenuPly:GetWide() - 25, -25, 20, 20, "X")
    CB1:AlphaTo(255, 0.7, 0.5)
    CB1:MoveTo(self.i_MenuPly:GetWide() - 25, 5, 0.4, 0.5)
    CB1.Paint = function(SS, w, h)
        if SS:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
        end
    end

    CB1.DoClick = function()
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if IsValid(self.i_MenuPly) then self.i_MenuPly:Remove() end
    end

    local CB2 = CButt1(self.i_MenuPly, self.i_MenuPly:GetWide() - 50, -25, 20, 20, "-")
    CB2:AlphaTo(255, 0.7, 0.6)
    CB2:MoveTo(self.i_MenuPly:GetWide() - 50, 5, 0.4, 0.6)
    CB2.B_a = false
    CB2.Paint = function(SS, w, h)
        if CB2.B_a == true then
            if SS:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 80, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(30, 20, 20, 255))
            end
        elseif SS:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 80, 255))
        end
    end

    CB2.DoClick = function()
        if CB2.B_a == false then
            CB2.B_a = true
            surface.PlaySound("bot/a.wav")
            self.i_MenuPly:AlphaTo(140, 0.2)
            if IsValid(self.i_MenuPly) then
                self.i_MenuPly:SetKeyboardInputEnabled(false)
                self.i_MenuPly:SetMouseInputEnabled(false)
            end
        else
            CB2.B_a = false
            surface.PlaySound("bot/b.wav")
            self.i_MenuPly:AlphaTo(255, 0.2)
            if IsValid(self.i_MenuPly) then
                self.i_MenuPly:SetKeyboardInputEnabled(true)
                self.i_MenuPly:SetMouseInputEnabled(true)
            end
        end
    end

    local AAvatar = vgui.Create("AvatarImage", self.i_MenuPly)
    local zz = 210
    AAvatar:SetSize(zz, zz)
    AAvatar:SetPos(10, 20)
    AAvatar:SetPlayer(ply2, zz)
    local hh, adh = 30, 30
    Bdt(zz + 10, hh, "fps")
    Bdt(zz + 150, hh, "Ping")
    hh = hh + adh
    Bdt(zz + 10, hh, "ddd")
    hh = hh + adh
    Bdt(zz + 10, hh, "Health")
    hh = hh + adh
    Bdt(zz + 10, hh, "Pos")
    hh = hh + adh
    Bdt(zz + 10, hh, "Ang")
    hh = hh + adh
    Bdt(zz + 10, hh, "Length")
    hh = hh + adh
    Bdt(zz + 10, hh, "Weap")
    hh = hh + adh
end

Actoji.HelpActMod = function(self, Slot) A_AM.ActMod:MListHlp() end
Actoji.Replace = function(self, Slot, isS, callback, ava)
    local Dled
    if Slot == 1001 or Slot == 1002 then Dled = true end
    if not IsValid(self.Frame) and (Slot ~= 1001 and Slot ~= 1002) then return end
    local TmpData = {}
    local ActDataNew = LocalPlayer():GetPData("ActojiDNew1", false) or nil
    if ActDataNew and ActDataNew ~= "false" then
        local TActDataNew = util.JSONToTable(ActDataNew)
        if TActDataNew[1] and TActDataNew[1] == A_AM.ActMod.Mounted["Version ActMod"] then
            TmpData = TActDataNew
        else
            TActDataNew = {}
            table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
            TmpData = TActDataNew
            LocalPlayer():SetPData("ActojiDNew1", util.TableToJSON(TmpData))
        end

        TActDataNew = nil
    else
        local TActDataNew = {}
        table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
        TmpData = TActDataNew
        LocalPlayer():SetPData("ActojiDNew1", util.TableToJSON(TmpData))
        TActDataNew = nil
    end

    local function MarkNew_TabDataRn(tbl, str, TYP)
        local RNMR = 0
        if tbl and tbl ~= "false" then
            for k, v in pairs(tbl) do
                if A_AM.ActMod:ATabData(TmpData, v) == false then
                    if str == 1 and A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, ReString(v)) == true and not string.find(v, "amod_") and not string.find(v, "wos_tf2_") then RNMR = RNMR + 1 end
                    if (str == 2 or str == 3) and string.find(string.sub(v, 1, 2), "f_") and not string.find(v, "original_dance") and not string.find(v, "amod_") then RNMR = RNMR + 1 end
                    if str == 4 and string.find(v, "original_dance") then RNMR = RNMR + 1 end
                    if str == 5 and (string.find(v, "amod_") or string.find(v, "amod_am4") or string.find(v, "amod_m_")) and not string.find(v, "amod_pubg_") and not string.find(v, "amod_mixamo_") and not string.find(v, "amod_mmd_") and not string.find(v, "amod_fortnite_") then RNMR = RNMR + 1 end
                    if str == 11 and string.find(v, "amod_pubg_") then RNMR = RNMR + 1 end
                    if str == 10 and string.find(v, "amod_mixamo_") then RNMR = RNMR + 1 end
                    if str == 6 and string.find(v, "amod_mmd_") then RNMR = RNMR + 1 end
                    if str == 7 and string.find(v, "amod_fortnite_") then RNMR = RNMR + 1 end
                    if str == 8 and string.find(v, "wos_tf2_") then RNMR = RNMR + 1 end
                end
            end
        end
        return RNMR
    end

    local ply = LocalPlayer()
    local ThemeN = GetConVarNumber("actmod_cl_thememenu")
    local TmpB = GetConVarNumber("actmod_cl_sortemote")
    local Underlay = vgui.Create("DButton")
    Underlay.OnRemove = function(pan)
        if IsValid(Underlay.Cmenu) then Underlay.Cmenu:Remove() end
        if IsValid(self.Aar) and not Dled then self.Aar:Remove() end
    end

    Underlay:SetText("")
    Underlay:SetCursor("arrow")
    Underlay:SetSize(ScrW(), ScrH())
    Underlay:SetAlpha(0)
    Underlay:AlphaTo(255, 0.5)
    Underlay.DoClick = function(s) if IsValid(Underlay) then Underlay:Remove() end end
    Underlay.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
    Underlay:MakePopup()
    Underlay.Think = function(s) if not IsValid(self.Frame) and not Dled and IsValid(s) then s:Remove() end end
    Underlay.Display = ply:GetModel()
    local Panel2
    if Dled then
        Panel2 = nil
    else
        Panel2 = vgui.Create("DPanel", Underlay)
        Panel2:SetSize(240, 35)
        Panel2:SetPos(5, 5)
        Panel2.Paint = function(s, w, h) draw.RoundedBox(10, 0, 0, w, h, (ThemeN == 1 and Color(50, 100, 150, 255)) or (ThemeN == 2 and Color(0, 0, 0, 150))) end
    end

    local Thh = 30
    local alfh = 1000
    local Panel = vgui.Create("DPanel", Underlay)
    Panel:SetSize(760, math.max(355, math.min(ScrH() / 1.3, 680)) + Thh)
    Panel:Center()
    Panel.Paint = function(s, w, h)
        draw.RoundedBox(10, 0, 0, w, h, (ThemeN == 1 and Color(50, 100, 150, 255)) or (ThemeN == 2 and Color(0, 0, 0, 150)))
        if GetConVarNumber("actmod_cl_showmodl") == 1 and alfh > 0 then
            alfh = math.max(0, alfh - 130 * FrameTime())
            draw.SimpleText(aR:T("LReplace_mu_hl1"), "ActMod_a6", 20, 55, Color(255, 255, 255, 255 * alfh / 100))
            draw.SimpleText(aR:T("LReplace_mu_hl2"), "ActMod_a6", 20, 90, Color(255, 255, 255, 255 * alfh / 100))
        end
    end

    local CrMP = true
    local fw, fh = Panel:GetSize()
    local padx = fh * 0.025
    local pady = padx
    Underlay.modelmenu = vgui.Create("DAdjustableModelPanel", Panel)
    Underlay.modelmenu:SetPos(padx + 2, pady)
    Underlay.modelmenu:SetSize(fw / 1.04, fh / 1.15)
    Underlay.modelmenu.LayoutEntity = function()
        local ent = Underlay.modelmenu:GetEntity()
        ent:SetEyeTarget(Underlay.modelmenu:GetCamPos())
        ent:FrameAdvance(FrameTime())
    end

    Underlay.modelmenu:SetVisible(false)
    function Underlay.modelmenu:ChangePage(ActAnime, SetPbR)
        if not ActAnime then return end
        local ent = Underlay.modelmenu:GetEntity()
        ent:ResetSequence(ActAnime)
        ent:SetCycle(0)
        ent:SetPlaybackRate(SetPbR)
    end

    function Underlay.modelmenu:RebuildModel(faSt)
        Underlay.modelmenu:SetModel(Underlay.Display)
        local ent = Underlay.modelmenu:GetEntity()
        local pos = ent:GetPos()
        local campos = pos + Vector(130, 0, 0)
        Underlay.modelmenu:SetCamPos(campos + Vector(50, 0, 50))
        Underlay.modelmenu:SetFOV(45)
        if GetConVar("cl_playercolor") and tostring(GetConVar("cl_playercolor")) == "ConVar [cl_playercolor]" and isstring(GetConVarString("cl_playercolor")) then
            Underlay.modelmenu.Entity.GetPlayerColor = function() return Vector(GetConVarString("cl_playercolor")) end
        else
            Underlay.modelmenu.Entity.GetPlayerColor = function() end
        end

        Underlay.modelmenu:SetLookAng((campos * -1):Angle())
        if GetConVarNumber("actmod_cl_showmodl") == 1 then
            if not faSt then
                Underlay.modelmenu:SetAlpha(0)
                Underlay.modelmenu:SetVisible(false)
                timer.Simple(0.5, function()
                    if IsValid(Underlay.modelmenu) and GetConVarNumber("actmod_cl_showmodl") == 1 then
                        Underlay.modelmenu:SetAlpha(255)
                        Underlay.modelmenu:SetVisible(true)
                    end
                end)
            else
                Underlay.modelmenu:SetAlpha(255)
                Underlay.modelmenu:SetVisible(true)
            end
        end
    end

    Underlay.modelmenu:RebuildModel()
    function Panel:Think()
        if GetConVarNumber("actmod_cl_showmodl") == 1 then
            if CrMP == nil and IsValid(Underlay.modelmenu) then
                Underlay.modelmenu:RebuildModel(true)
                CrMP = true
                alfh = 255
            end
        elseif GetConVarNumber("actmod_cl_showmodl") == 0 and CrMP == true and IsValid(Underlay.modelmenu) then
            Underlay.modelmenu:SetAlpha(0)
            Underlay.modelmenu:SetVisible(false)
            CrMP = nil
        end
    end

    local List
    local Buttons = {}
    local function Update()
        List:SetSpaceY(self.Scale / 4)
        List:SetSpaceX(self.Scale / 4)
        for _, v in pairs(Buttons or {}) do
            v:SetSize(self.Scale, self.Scale)
        end
    end

    local DermaNumSlider = vgui.Create("DNumSlider", Panel)
    if Dled then
        DermaNumSlider:SetPos(520, Panel:GetTall() - (-5 + Thh))
        DermaNumSlider:SetSize(180, 20)
    else
        DermaNumSlider:SetPos(3, Panel:GetTall() - (25 + Thh))
        DermaNumSlider:SetSize(165, 20)
    end

    DermaNumSlider:SetText(aR:T("LReplace_AGSize"))
    DermaNumSlider:SetMin(100)
    DermaNumSlider:SetMax(153)
    DermaNumSlider:SetDecimals(0)
    DermaNumSlider:SetValue(self.Scale)
    DermaNumSlider.OnValueChanged = function(s, dfn)
        self.Scale = dfn
        Update()
    end

    local function Wnds_ComboBox3(aPos, bPos, aSize, bSize, cPos, dPos, cSize, dSize, TextN, comm, comm_1, comm_2, comm_3, comm_4, ic_1, ic_2, ic_3, ic_4, ShIc)
        local rh = vgui.Create("DPanel", (ShIc == "CTheme" and Panel2) or Panel)
        rh:SetPos(aPos, (ShIc == "CTheme" and bPos) or Panel:GetTall() - (bPos + Thh))
        rh:SetSize(aSize, bSize)
        rh:SetText("")
        rh:SetAlpha(255)
        rh.Paint = function(s, w, h)
            if ThemeN == 1 then draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255)) end
            if ShIc == "SCamV" then
                if GetConVarNumber(comm) == 0 then
                    draw.SimpleText(aR:T("LReplace_BxC_0"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 1 then
                    draw.SimpleText(aR:T("LReplace_BxC_1"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 2 then
                    draw.SimpleText(aR:T("LReplace_BxC_2"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 3 then
                    draw.SimpleText(aR:T("LReplace_BxC_3"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                end
            end
        end

        local rs = vgui.Create("DPanel", rh)
        rs:SetPos(1, 0)
        if ShIc == "SCamV" then
            rs:SetSize(29, 30)
        else
            rs:SetSize(25, 25)
        end

        rs:SetText("")
        rs:SetAlpha(255)
        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)
            if ShIc == "SCamV" then
                surface.SetMaterial(Material("icon16/camera.png", "noclamp smooth"))
            else
                if GetConVarNumber(comm) == 0 and comm_1 then
                    surface.SetMaterial(Material(ic_1, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 1 then
                    surface.SetMaterial(Material(ic_2, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 2 then
                    surface.SetMaterial(Material(ic_3, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 3 and comm_4 then
                    surface.SetMaterial(Material(ic_4, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 4 then
                    surface.SetMaterial(Material("icon16/bullet_black.png", "noclamp smooth"))
                elseif GetConVarNumber(comm) == 5 then
                    surface.SetMaterial(Material("icon16/collision_on.png", "noclamp smooth"))
                end
            end

            surface.DrawTexturedRect(0, 0, w, h)
        end

        if ShIc == "SCamV" then
            local DButt = vgui.Create("DButton", rs)
            DButt:SetPos(0, 0)
            DButt:SetSize(rs:GetWide(), rs:GetTall())
            DButt:SetText("")
            DButt.Paint = function(ss, w, h)
                if IsValid(ss.aar) then
                    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, w, h)
                end
            end

            DButt.OClick = false
            DButt.DoClick = function(ss)
                if IsValid(ss.aar) then
                    ss.aar:Remove()
                    ss.OClick = false
                else
                    ss.OClick = true
                    ss.aar = vgui.Create("DPanel", rh)
                    ss.aar:SetPos(rs:GetWide(), 0)
                    ss.aar:SetText("")
                    ss.aar:SetSize(rh:GetWide() - ss.aar:GetWide() / 2 + 4, rh:GetTall())
                    ss.aar.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255)) end
                    local CBox = vgui.Create("DCheckBoxLabel", ss.aar)
                    CBox:SetPos(2, 2)
                    CBox:SetText("SmoothCam")
                    CBox:SetSize(ss.aar:GetWide() - 5, 10)
                    CBox:SetConVar("actmod_cl_smshcam_on")
                    local DCBox = vgui.Create("DNumSlider", ss.aar)
                    DCBox:SetPos(-80, 15)
                    DCBox:SetSize(ss.aar:GetWide() + 107, 15)
                    DCBox:SetText("")
                    DCBox:SetMin(1)
                    DCBox:SetMax(10)
                    DCBox:SetDecimals(0)
                    DCBox:SetValue(ply:GetNWInt("actmod_camsp", 5))
                    DCBox.OnValueChanged = function(s, dfn) ply:SetNWInt("actmod_camsp", dfn) end
                    DCBox.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 255, 150)) end
                end
            end
        end

        local DButton = vgui.Create("DComboBox", rh)
        DButton:SetPos(cPos, dPos)
        DButton:SetSize(cSize, dSize)
        if ShIc == "ShowCh" then
            if GetConVarNumber(comm) == 0 then
                DButton:SetText(aR:T("LReplace_BxSh_0"))
            elseif GetConVarNumber(comm) == 1 then
                DButton:SetText(aR:T("LReplace_BxSh_1"))
            elseif GetConVarNumber(comm) == 2 then
                DButton:SetText(aR:T("LReplace_BxSh_2"))
            end
        else
            DButton:SetText(TextN)
        end

        if comm_1 then DButton:AddChoice(comm_1, 0, false, ic_1) end
        if comm_2 then DButton:AddChoice(comm_2, 1, false, (ShIc == "SEmote" and "actmod/imenu/16imll1_1.png") or ic_2) end
        if comm_3 then DButton:AddChoice(comm_3, 2, false, ic_3) end
        if comm_4 then DButton:AddChoice(comm_4, 3, false, ic_4) end
        if ShIc == "CommTh" then
            DButton:AddChoice(aR:T("LReplace_MF04"), 4, false, "icon16/bullet_black.png")
            DButton:AddChoice(aR:T("LReplace_MF05"), 5, false, "icon16/collision_on.png")
        end

        DButton.OnSelect = function(pl, index, value, data)
            ply:ConCommand(comm .. " " .. data .. "\n")
            if ShIc == "ShowCh" then
                if GetConVarNumber(comm) == 0 then
                    DButton:SetText(aR:T("LReplace_BxSh_0"))
                elseif GetConVarNumber(comm) == 1 then
                    DButton:SetText(aR:T("LReplace_BxSh_1"))
                elseif GetConVarNumber(comm) == 2 then
                    DButton:SetText(aR:T("LReplace_BxSh_2"))
                end

                timer.Simple(0.1, function()
                    if IsValid(self.Frame) then
                        if GetConVarNumber(comm) == 0 then
                            DButton:SetText(aR:T("LReplace_BxSh_0"))
                        elseif GetConVarNumber(comm) == 1 then
                            DButton:SetText(aR:T("LReplace_BxSh_1"))
                        elseif GetConVarNumber(comm) == 2 then
                            DButton:SetText(aR:T("LReplace_BxSh_2"))
                        end
                    end
                end)
            elseif ShIc == "CTheme" then
                DButton:SetText(aR:T("LReplace_BxCTh"))
                if IsValid(Underlay) and ThemeN ~= data then
                    Underlay:Remove()
                    timer.Simple(0.1, function() if IsValid(self.Frame) then self:Replace(Slot) end end)
                end
            elseif ShIc == "SEmote" then
                DButton:SetText(aR:T("LReplace_BxSEm"))
                if IsValid(Underlay) and TmpB ~= data then
                    Underlay:Remove()
                    if IsValid(self.Frame) then self.Frame:Remove() end
                    self:Close("nOw")
                end
            else
                DButton:SetText(TextN)
            end
        end
    end

    local function Wnds_CheckBox1(aPos, bPos, aSize, bSize, cPos, dPos, cSize, dSize, TextN, comm, ic_1, ic_2, commsv, ic_3)
        local rh = vgui.Create("DPanel", Panel)
        rh:SetPos(aPos, Panel:GetTall() - (bPos + Thh))
        rh:SetSize(aSize, bSize)
        rh:SetText("")
        rh:SetAlpha(255)
        rh.Paint = function(s, w, h) if ThemeN == 1 then draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255)) end end
        local rs = vgui.Create("DPanel", rh)
        rs:SetPos(1, 0)
        rs:SetSize(cSize, dSize)
        rs:SetText("")
        rs:SetAlpha(255)
        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)
            if commsv then
                if GetConVarNumber(commsv) == 1 then
                    if GetConVarNumber(comm) == 1 then
                        surface.SetMaterial(Material(ic_2, "noclamp smooth"))
                    else
                        surface.SetMaterial(Material(ic_1, "noclamp smooth"))
                    end
                else
                    surface.SetMaterial(Material(ic_3, "noclamp smooth"))
                end
            else
                if GetConVarNumber(comm) == 1 then
                    surface.SetMaterial(Material(ic_2, "noclamp smooth"))
                else
                    surface.SetMaterial(Material(ic_1, "noclamp smooth"))
                end
            end

            surface.DrawTexturedRect(0, 0, w, h)
        end

        local DButton = vgui.Create("DCheckBoxLabel", rh)
        DButton:SetPos(cPos, dPos)
        DButton:SetText(TextN)
        DButton:SetConVar(comm)
        DButton:SizeToContents()
    end

    if not Dled then
        Wnds_ComboBox3(145, 28, 145, 25, 30, -0.1, 110, 25, nil, "actmod_cl_loop", aR:T("LReplace_BxSh_00"), aR:T("LReplace_BxSh_01"), aR:T("LReplace_BxSh_02"), nil, "icon16/control_stop_blue.png", "icon16/control_repeat_blue.png", "icon16/control_equalizer_blue.png", nil, "ShowCh")
        Wnds_CheckBox1(295, 28, 90, 25, 30, 5, 25, 25, aR:T("LReplace_txt_Sound"), "actmod_cl_sound", "icon16/sound_mute.png", "icon16/sound.png", "actmod_sv_enabled_addso", "icon32/muted.png")
        Wnds_CheckBox1(390, 28, 95, 25, 30, 5, 25, 25, aR:T("LReplace_txt_Effects"), "actmod_cl_effects", "actmod/imenu/ic_star_02.png", "actmod/imenu/ic_star_01.png", "actmod_sv_enabled_addef", "actmod/imenu/ic_star_03.png")
        if GetConVarNumber("actmod_cl_sortemote") == 1 then
            Wnds_ComboBox3(490, 28, 125, 25, 30, -0.1, 90, 25, aR:T("LReplace_txt_MFormat"), "actmod_cl_menuformat", aR:T("LReplace_MF0"), aR:T("LReplace_MF1"), aR:T("LReplace_MF2"), nil, "icon16/collision_off.png", "icon16/pencil.png", "actmod/imenu/isk1_1.png")
        elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
            Wnds_ComboBox3(490, 28, 125, 25, 30, -0.1, 90, 25, aR:T("LReplace_txt_MFormat"), "actmod_cl_menuformat2", aR:T("LReplace_MF0"), aR:T("LReplace_MF01"), aR:T("LReplace_MF02"), aR:T("LReplace_MF03"), "icon16/collision_off.png", "icon16/bullet_blue.png", "icon16/bullet_red.png", "icon16/bullet_purple.png", "CommTh")
        end

        Wnds_ComboBox3(5, 5, 137, 25, 30, -0.1, 105, 25, aR:T("LReplace_BxCTh"), "actmod_cl_thememenu", nil, aR:T("LReplace_BxCTh1"), aR:T("LReplace_BxCTh2"), nil, nil, "icon16/application_xp.png", "icon16/application_xp_terminal.png", nil, "CTheme")
    end

    local Scroll = vgui.Create("AM4_DScrollPanel", Panel)
    Scroll:SetPos(10, 50)
    if Dled then
        Scroll:SetSize(Panel:GetWide() - 20, Panel:GetTall() - (55 + Thh))
    else
        Scroll:SetSize(Panel:GetWide() - 20, Panel:GetTall() - (80 + Thh))
    end

    Scroll.Paint = function(s, w, h)
        if GetConVarNumber("actmod_cl_showmodl") == 0 then
            if ply:GetNWInt("A_ActMod.IMeun_Num", 0) > 0 then
                surface.SetDrawColor(color_white)
                if ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 1 then
                    surface.SetMaterial(Material("actmod/imenu/i_gmod" .. (ThemeN == 1 and ".png" or "2.png"), "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 2 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 7 then
                    surface.SetMaterial(Material("actmod/imenu/i_fortnite.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 4 then
                    surface.SetMaterial(Material("actmod/imenu/i_mmd.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 5 then
                    surface.SetMaterial(Material("actmod/imenu/i_am4.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 6 then
                    surface.SetMaterial(Material("actmod/imenu/i_mmd2.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 8 then
                    surface.SetMaterial(Material("actmod/imenu/i_team_fortress2.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 10 then
                    surface.SetMaterial(Material("actmod/imenu/i_mixamo.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 11 then
                    surface.SetMaterial(Material("actmod/imenu/i_pubg.png", "noclamp smooth"))
                elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 20 then
                    surface.SetMaterial(Material("actmod/imenu/i_featured.png", "noclamp smooth"))
                else
                    surface.SetMaterial(Material("widgets/disc.png", "noclamp smooth"))
                    if Underlay.Finding and Underlay.Finding == true then draw.SimpleText("Loading...", "ActMod_a6", w / 2, h / 2, color_white, 1, 1) end
                end

                surface.DrawTexturedRect(0, 0, w, h)
            end

            if ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 1 then
                draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 180))
            elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 2 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 7 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 20, 200))
            elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 4 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 6 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 7 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 11 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 20, 170))
            elseif ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 5 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 10 or ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 20 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 40, 180))
            end
        end
    end

    local b = Scroll:GetVBar()
    function b.btnUp:Paint(w, h)
    end

    function b.btnDown:Paint(w, h)
    end

    function b:Paint(w, h)
        draw.RoundedBox(0, w / 2 - 2, 0, 5, h, Color(0, 0, 0, 50))
    end

    function b.btnGrip:Paint(w, h)
        draw.RoundedBox(4, w / 2 - 3, 0, 6, h, Color(0, 0, 0, 200))
    end

    List = vgui.Create("DIconLayout", Scroll)
    List:SetPos(0, 0)
    List:SetSize(Scroll:GetWide(), Scroll:GetTall())
    List:SetSpaceY(self.Scale / 4)
    List:SetSpaceX(self.Scale / 4)
    local function AS(gg)
        surface.PlaySound("actmod/s/lock.wav")
        if IsValid(gg.trh) then gg.trh:Remove() end
        gg.trh = vgui.Create("DLabel", gg)
        gg.trh:SetSize(self.Scale, self.Scale)
        gg.trh:SetPos(0, 0)
        gg.trh:SetText("")
        gg.trh:SetAlpha(255)
        gg.trh:AlphaTo(0, 0.5, 0.6, function(s) if IsValid(gg.trh) then gg.trh:Remove() end end)
        gg.trh.Paint = function(s, w, h)
            draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
            draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    local function MakeButton(Name)
        local ListItem = List:Add("DButton")
        table.insert(Buttons, ListItem)
        ListItem:SetSize(self.Scale, self.Scale)
        ListItem:SetText("")
        ListItem.file = Name
        ListItem.Material = Material(ASettings["IconsActs"] .. "/" .. Name, "noclamp smooth")
        ListItem.DoRightClick = function(s)
            if IsValid(Underlay.Cmenu) then Underlay.Cmenu:Remove() end
            local ATData = {}
            local ATDataNew = LocalPlayer():GetPData("Actojifavo", false) or false
            if ATDataNew and ATDataNew ~= "false" then ATData = util.JSONToTable(ATDataNew) end
            Underlay.Cmenu = DermaMenu()
            Underlay.Cmenu:AddOption("---->", function()
                if not Name then return end
                if GetReadyFUse(ply) ~= true or (ply.ActMod_TimMenRe or 0) > CurTime() then return end
                if GetConVar("actmod_sv_avs"):GetInt() > 0 and A_AM.ActMod:LokTabData(LocalPlayer(), A_AM.ActMod.ActLck, ReString(Name)) == true then
                    surface.PlaySound("actmod/s/lock.wav")
                    if IsValid(List.txh) then List.txh:Remove() end
                    List.txh = vgui.Create("DLabel", ListItem)
                    List.txh:SetSize(ListItem:GetWide(), ListItem:GetTall())
                    List.txh:SetPos(0, 0)
                    List.txh:SetText("")
                    List.txh:SetAlpha(255)
                    List.txh:AlphaTo(0, 0.6, 0.2, function() if IsValid(List.txh) then List.txh:Remove() end end)
                    List.txh.Paint = function(s, w, h)
                        draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
                        draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                else
                    ply.ActMod_TimMenRe = CurTime() + 0.5
                    ply:SetNWString("A_ActMod_cl_actLoop", Name)
                    ply.AGSped_f = 0
                    ply.AGSped_b = 0
                    if GetConVar("actmod_sy_tovs"):GetInt() == 1 then
                        net.Start("A_AM.ActMod.Start")
                        net.WriteString(Name)
                        net.SendToServer()
                    else
                        local cl_s, cl_e, cl_l = "0", "0", "0"
                        if GetConVarNumber("actmod_cl_sound") == 1 then
                            ply:SetNWBool("A_ActMod_cl_Sound", true)
                            cl_s = "1"
                        else
                            ply:SetNWBool("A_ActMod_cl_Sound", false)
                        end

                        if GetConVarNumber("actmod_cl_effects") == 1 then
                            ply:SetNWBool("A_ActMod_cl_Effects", true)
                            cl_e = "1"
                        else
                            ply:SetNWBool("A_ActMod_cl_Effects", false)
                        end

                        if GetConVarNumber("actmod_cl_loop") == 1 then
                            ply:SetNWInt("A_ActMod_cl_Loop", 1)
                            cl_l = "1"
                        elseif GetConVarNumber("actmod_cl_loop") == 2 then
                            ply:SetNWInt("A_ActMod_cl_Loop", 2)
                            cl_l = "2"
                        else
                            ply:SetNWInt("A_ActMod_cl_Loop", 0)
                        end

                        ply:ConCommand("actmod_wts wts " .. Name .. " " .. cl_s .. " " .. cl_e .. " " .. cl_l .. "\n")
                    end
                end
            end):SetIcon("icon16/bullet_go.png")

            if GetConVarNumber("actmod_cl_showmodl") == 1 then
                Underlay.Cmenu:AddOption("Play Anim", function()
                    if IsValid(Underlay.modelmenu) then
                        local Strg, Rspeed = ReString(Name), 1
                        if string.find(string.sub(Strg, 1, 2), "f_") or string.find(Strg, "original_dance") then Rspeed = 0.5 end
                        if string.find(string.sub(Strg, 1, 2), "f_") and not string.find(Strg, "amod") then
                            Strg = string.Replace(Strg, "f_", "")
                        elseif string.find(string.sub(Strg, 1, 14), "original_dance") and not string.find(Strg, "amod") then
                            Strg = string.Replace(Strg, "original_dance", "fulldance")
                        end

                        Underlay.modelmenu:ChangePage(Strg, Rspeed)
                    end
                end):SetIcon("icon16/application_go.png")

                Underlay.Cmenu:AddSpacer()
                Underlay.Cmenu:AddSpacer()
                Underlay.Cmenu:AddSpacer()
            end

            Underlay.Cmenu:AddOption(aR:T("LReplace_txt_CopyName"), function() SetClipboardText(A_AM.ActMod:ReNameAct(RvString(ReString(Name)))) end):SetIcon("icon16/page_copy.png")
            if input.IsMouseDown(MOUSE_LEFT) then Underlay.Cmenu:AddOption("name_act", function() SetClipboardText(ReString(Name)) end):SetIcon("icon16/page_copy.png") end
            Underlay.Cmenu:AddSpacer()
            if ATData and A_AM.ActMod:ATabData(ATData, s.file) == true then
                Underlay.Cmenu:AddOption("Remove from F", function()
                    RemveFvite(s.file)
                    if ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 20 then
                        if IsValid(List) then List:Remove() end
                        Buttons = {}
                        List = vgui.Create("DIconLayout", Scroll)
                        List:SetPos(0, 0)
                        List:SetSize(Scroll:GetWide(), Scroll:GetTall())
                        List:SetSpaceY(self.Scale / 4)
                        List:SetSpaceX(self.Scale / 4)
                        Underlay.Spawnacti()
                    end
                end):SetIcon("icon16/drive_delete.png")
            else
                Underlay.Cmenu:AddOption(aR:T("LReplace_txt_AddF"), function() AddToFvite(s.file) end):SetIcon("icon16/drive_disk.png")
            end

            Underlay.Cmenu:Open()
        end

        if GetConVar("actmod_sv_avs"):GetInt() > 0 and not ava and A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(ListItem.file)) == true then
            ListItem.GLok = true
            ListItem.GLokC = 100
            ListItem.tt = CurTime() + 0.7
            ListItem.Think = function(s)
                if (s.tt or 0) < CurTime() then
                    s.tt = CurTime() + 0.7
                    if GetConVar("actmod_sv_avs"):GetInt() > 0 and not ava and A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(s.file)) == true then
                        s.GLok = true
                        s.GLokC = 100
                    else
                        s.GLok = false
                        s.GLokC = 0
                    end
                end
            end
        else
            ListItem.GLok = false
            ListItem.GLokC = 0
        end

        ListItem.DoClick = function(s)
            if s.GLok == true then
                AS(s)
                return
            end

            if Slot == 1001 and isS and Dled then
                isS.str = s.file
                if IsValid(Underlay) then Underlay:Remove() end
            elseif Slot == 1002 and Dled then
                callback(s.file)
                if IsValid(Underlay) then Underlay:Remove() end
            else
                if self.table[Slot] then
                    self.table[Slot] = s.file
                    LocalPlayer():SetPData("ActojiDial", util.TableToJSON(self.table))
                    if IsValid(Underlay) then Underlay:Remove() end
                    if isS then
                        timer.Simple(0.1, function() if IsValid(isS) then isS.ASpow() end end)
                    else
                        self:Close(true)
                    end
                else
                    if IsValid(Underlay) then Underlay:Remove() end
                end
            end

            if A_AM.ActMod:ATabData(TmpData, ReString(s.file)) == false and A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, ReString(s.file)) == true then
                table.insert(TmpData, ReString(s.file))
                LocalPlayer():SetPData("ActojiDNew1", util.TableToJSON(TmpData))
            end
        end

        ListItem.amov1 = 0
        ListItem.amov2 = 0
        ListItem.Paint = function(s, w, h)
            if not s.Material then return end
            if s:IsHovered() then
                if s:IsDown() then
                    ListItem.amov2 = Lerp(FrameTime() * 12.5, ListItem.amov2, h / 2)
                else
                    ListItem.amov2 = Lerp(0.2, ListItem.amov2, 0)
                end

                ListItem.amov1 = Lerp(0.3, ListItem.amov1, 20)
            else
                ListItem.amov1 = Lerp(0.1, ListItem.amov1, 0)
                ListItem.amov2 = Lerp(0.5, ListItem.amov2, 0)
            end

            draw.RoundedBox(w / 8, 0, 0, w, h, Color(s.GLokC * 2, 250 - s.GLokC, 120 - s.GLokC + 100 * ListItem.amov2 / 50, 255 * ListItem.amov1 / 70))
            draw.RoundedBox(w / 8, 0, h - ListItem.amov1, w, ListItem.amov1, Color(150 + s.GLokC, 215 - s.GLokC, 255 - s.GLokC * 2, 150 * ListItem.amov1 / 20))
            draw.RoundedBox(w / 8, 0, h - ListItem.amov2, w, ListItem.amov2, Color(150 + s.GLokC, 215 - s.GLokC, 255 - s.GLokC * 2, 150 * ListItem.amov2 / 20))
            if A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, ReString(s.file)) == true and A_AM.ActMod:ATabData(TmpData, ReString(s.file)) == false then if not s:IsHovered() then draw.RoundedBox(w / 2, 0, 0, w, h, Color(255, 255, 0, math.max(15 + (25 * math.sin(CurTime() * 8)), 0))) end end
            surface.SetDrawColor(color_white)
            surface.SetMaterial(s.Material)
            if s:IsHovered() then
                surface.DrawTexturedRect(0, 0, w, h)
                if IsValid(ListItem.rh) then ListItem.rh:SetPos(1, ListItem:GetTall() - 16) end
            else
                surface.DrawTexturedRect(5, 5, w - 10, h - 10)
                if IsValid(ListItem.rh) then ListItem.rh:SetPos(1, ListItem:GetTall() - 16) end
            end

            if s.GLok == true then
                if s:IsHovered() then
                    surface.SetDrawColor(Color(255, 255, 255, 140))
                else
                    surface.SetDrawColor(Color(255, 255, 255, 55))
                end

                local acw = math.max(0, math.min(30, 30 + (30 * math.sin(CurTime() * 3))))
                surface.SetMaterial(Material("icon16/lock.png", "noclamp smooth"))
                surface.DrawTexturedRect(20 + acw / 2, 20 + acw / 2, h - 40 - acw, h - 40 - acw)
            end

            if A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, ReString(s.file)) == true and A_AM.ActMod:ATabData(TmpData, ReString(s.file)) == false then
                surface.SetDrawColor(Color(255, 255, 255, math.max(150 + (100 * math.sin(CurTime() * 7)), 0)))
                surface.SetMaterial(Material("icon16/new.png", "noclamp smooth"))
                surface.DrawTexturedRect(0, -3 + (3 * math.sin(CurTime() * 3)), 20, 20)
            end
        end

        ListItem.rh = vgui.Create("DLabel", ListItem)
        ListItem.rh:SetPos(1, ListItem:GetTall() - 16)
        ListItem.rh:SetText(" " .. A_AM.ActMod:ReNameAct(RvString(ReString(Name))))
        ListItem.rh:SizeToContents()
        ListItem.rh:SetFont("ActMod_a4")
        ListItem.rh:SetAlpha(255)
        ListItem.rh.Paint = function(s, w, h) if ListItem:IsHovered() then draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 80, 255)) end end
    end

    Underlay.Spawnacti = function()
        local Actimenu = {}
        local Yt = ply:GetNWInt("A_ActMod.IMeun_Num", 0)
        if Yt == 20 then
            local ATDa = {}
            local ATDNew = LocalPlayer():GetPData("Actojifavo", false) or false
            if ATDNew and ATDNew ~= "false" then ATDa = util.JSONToTable(ATDNew) end
            for k, v in pairs(ATDa or {}) do
                MakeButton(v)
            end
        else
            for _, v in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*.png", "GAME")) do
                if not table.HasValue(Actimenu, v) then
                    if Yt == 1 and A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, ReString(v)) == true and not string.find(v, "amod_") and not string.find(v, "wos_tf2_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 2 and string.find(string.sub(v, 1, 2), "f_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 3 and string.find(string.sub(v, 1, 2), "f_") and not string.find(v, "original_dance") and not string.find(v, "amod_") and (string.find(v, "._mo_.") or string.find(v, "._ef_.") or string.find(v, "._so_.")) then
                        table.insert(Actimenu, v)
                    elseif Yt == 4 and string.find(v, "original_dance") then
                        table.insert(Actimenu, v)
                    elseif Yt == 5 and (string.find(v, "amod_") or string.find(v, "amod_am4") or string.find(v, "amod_m_")) and not string.find(v, "amod_pubg_") and not string.find(v, "amod_mixamo_") and not string.find(v, "amod_mmd_") and not string.find(v, "amod_fortnite_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 11 and string.find(v, "amod_pubg_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 10 and string.find(v, "amod_mixamo_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 6 and string.find(v, "amod_mmd_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 7 and string.find(v, "amod_fortnite_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 8 and string.find(v, "wos_tf2_") then
                        table.insert(Actimenu, v)
                    elseif Yt == 15 then
                        if A_AM.ActMod.FindIt and istable(A_AM.ActMod.FindIt) then Actimenu = A_AM.ActMod.FindIt end
                    end
                end
            end

            for k, v in pairs(Actimenu or {}) do
                MakeButton(v)
            end
        end

        Yt = nil
    end

    Underlay.Spawnacti()
    local Passq = vgui.Create("DLabel", Panel)
    Passq:SetPos(10, 50)
    Passq:SetSize(Scroll:GetWide(), Scroll:GetTall())
    Passq:SetAlpha(0)
    Passq.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(180, 190, 200, 255)) end
    local function Button_NWInt(aPos, bPos, aSize, bSize, iconn, aText, comm, srvr, ARe)
        local SButton = vgui.Create("DButton", Panel)
        SButton:SetText("")
        SButton:SetFont("ActMod_a1")
        SButton:SetAlpha(50)
        SButton:SetPos(aPos, bPos)
        SButton:SetSize(aSize, bSize)
        SButton.tButt = false
        SButton:AlphaTo(255, 0.5)
        timer.Simple((ARe and 0.2) or 0.7, function() if IsValid(SButton) then SButton.tButt = true end end)
        SButton.Paint = function(self, w, h)
            if ply:GetNWInt(comm, 0) == srvr then draw.RoundedBox(4, 0, 0, w, h, Color(90, 200, 90, 255)) end
            if SButton:IsHovered() and SButton.tButt == true then
                draw.RoundedBox(4, 0, 0, w, h, Color(100, 100, 250, 155))
            else
                draw.RoundedBox(4, 0, 0, w, h, (ThemeN == 1 and Color(70, 70, 50, 155)) or (ThemeN == 2 and Color(70, 70, 90, 80)))
            end

            draw.SimpleText(aText, "ActMod_a1", 41, h / 2, Color(0, 0, 0), 0, 1)
            draw.SimpleText(aText, "ActMod_a1", 41.5, h / 2 + 0.5, Color(255, 255, 255), 0, 1)
        end

        SButton.Think = function()
            if ply:GetNWInt(comm, 0) ~= srvr then
                SButton:SetDisabled(false)
                if IsValid(SButton.pk) then SButton.pk:Remove() end
            else
                SButton:SetDisabled(true)
                if not IsValid(SButton.pk) then
                    SButton.pk = vgui.Create("DPanel", SButton)
                    SButton.pk:SetAlpha(0)
                    SButton.pk:SetPos(0, 0)
                    SButton.pk:SetSize(SButton:GetWide(), SButton:GetTall())
                end
            end
        end

        SButton.DoClick = function(s)
            if SButton.tButt == true and ply:GetNWInt(comm, 0) ~= srvr and (Underlay.PutMark_TimCRe or 0) < CurTime() then
                Underlay.PutMark_TimCRe = CurTime() + 0.3
                ply:SetNWInt(comm, srvr)
                if srvr == 1 then
                    surface.PlaySound("garrysmod/ui_click.wav")
                elseif srvr == 2 or srvr == 3 or srvr == 7 or srvr == 9 then
                    surface.PlaySound("actmod/i_menu/Fortnite.wav")
                elseif srvr == 8 then
                    surface.PlaySound("actmod/i_menu/TF2.wav")
                elseif srvr == 4 or srvr == 6 then
                    surface.PlaySound("actmod/i_menu/MMD.wav")
                elseif srvr == 5 then
                    surface.PlaySound("actmod/i_menu/AM4.wav")
                elseif srvr == 11 then
                    surface.PlaySound("actmod/i_menu/pubg.mp3")
                elseif srvr == 10 then
                    surface.PlaySound("actmod/i_menu/Mixamo.mp3")
                elseif srvr == 20 then
                    surface.PlaySound("garrysmod/save_load3.wav")
                end

                Passq:SetAlpha(255)
                Passq:AlphaTo(0, 0.2)
                if IsValid(List) then List:Remove() end
                Buttons = nil
                Buttons = {}
                List = vgui.Create("DIconLayout", Scroll)
                List:SetPos(0, 0)
                List:SetSize(Scroll:GetWide(), Scroll:GetTall())
                List:SetSpaceY(self.Scale / 4)
                List:SetSpaceX(self.Scale / 4)
                Underlay.Spawnacti()
            end
        end

        local rs = vgui.Create("DLabel", SButton)
        rs:SetPos(1, 0)
        rs:SetSize(40, 40)
        rs:SetText("")
        rs:SetAlpha(255)
        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(Material(iconn, "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        end

        if MarkNew_TabDataRn(A_AM.ActMod.ActNewV, srvr) > 0 then
            local nw = vgui.Create("DLabel", Panel)
            nw:SetPos(aPos + aSize / 2, bPos - 10)
            nw:SetSize(20, 20)
            nw:SetText("")
            nw:SetAlpha(0)
            nw:AlphaTo(255, 0.2)
            nw.Paint = function(s, w, h)
                draw.RoundedBox(w / 2, 0, 0, w, h, Color(180, 110, math.max(50 + (80 * math.sin(CurTime() * 7)), 0), math.max(150 + (50 * math.sin(CurTime() * 7)), 0)))
                draw.SimpleText(MarkNew_TabDataRn(A_AM.ActMod.ActNewV, srvr), "ActMod_a3", w / 2 - 1, h / 2 - 1, color_white, 1, 1)
                draw.SimpleText(MarkNew_TabDataRn(A_AM.ActMod.ActNewV, srvr), "ActMod_a3", w / 2, h / 2, Color(80, 255, 255), 1, 1)
            end

            SButton.OnRemove = function(pan) if IsValid(nw) then nw:Remove() end end
        end
        return SButton
    end

    local rh = vgui.Create("DPanel", Panel)
    rh:SetPos(10, Panel:GetTall() - (-2 + Thh))
    rh:SetSize(280, 25)
    rh:SetText("")
    rh:SetAlpha(255)
    rh.Paint = function(s, w, h)
        if ThemeN == 1 then draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255)) end
        draw.SimpleText(aR:T("LReplace_txt_Search"), "ActMod_a3", 2, 2, color_white)
    end

    local AButxtbar = vgui.Create("DButton", rh)
    AButxtbar:SetPos(62, 2)
    AButxtbar:SetSize(185, 20)
    AButxtbar:SetText("")
    AButxtbar.OnRemove = function() if IsValid(self.Aar) then self.Aar:Remove() end end
    AButxtbar.Paint = function(pan, ww, hh)
        draw.RoundedBox(5, 0, 0, ww, hh, Color(230, 240, 255, 255))
        draw.SimpleText(GetConVarString("actmod_cl_stext"), "ActMod_a5", 2, 0, Color(0, 0, 0, 255))
    end

    AButxtbar.DoClick = function(s)
        surface.PlaySound("garrysmod/content_downloaded.wav")
        if IsValid(self.Aar) then self.Aar:Remove() end
        self.Aar = vgui.Create("DFrame")
        self.Aar.OnRemove = function(pan)
            gui.EnableScreenClicker(false)
            self.OnDfind = nil
        end

        self.OnDfind = true
        self.Aar:SetSize(219, 25)
        self.Aar:SetPos(ScrW() / 2 - 310, ScrH() / 2 + Panel:GetTall() / 2 - 28)
        self.Aar:MakePopup()
        self.Aar:SetTitle("")
        self.Aar:SetDraggable(false)
        self.Aar:ShowCloseButton(false)
        self.Aar.Paint = function(pan, ww, hh) end
        if not vgui.CursorVisible() then gui.EnableScreenClicker(true) end
        local DButton = vgui.Create("DButton", self.Aar)
        DButton:SetPos(self.Aar:GetWide() - 28, 0)
        DButton:SetSize(28, 25)
        DButton:SetText(aR:T("LReplace_txt_ok"))
        DButton:SetFont("ActMod_a5")
        DButton:SetDark(true)
        DButton.DoClick = function(s) if IsValid(self.Aar) then self.Aar:Remove() end end
        local txtbar = vgui.Create("DTextEntry", self.Aar)
        txtbar:SetPos(0, 0)
        txtbar:SetSize(188, 25)
        txtbar:SetFont("ActMod_a5")
        txtbar:SetText("")
        txtbar:SetConVar("actmod_cl_stext")
    end

    local DBu = vgui.Create("DButton", rh)
    DBu:SetPos(rh:GetWide() - 26, Gh)
    DBu:SetSize(25, 25)
    DBu:SetText("")
    DBu.Cmo = GCN
    Underlay.Finding = false
    DBu.Paint = function(ste, w, h)
        surface.SetDrawColor(color_white)
        if Underlay.Finding == true then end
        if Underlay.Finding == true then
            surface.SetMaterial(Material("icon16/folder_magnify.png", "noclamp smooth"))
        elseif ste:IsDown() then
            surface.SetMaterial(Material("icon16/zoom.png", "noclamp smooth"))
        elseif ste:IsHovered() then
            surface.SetMaterial(Material("icon16/magnifier_zoom_in.png", "noclamp smooth"))
        else
            surface.SetMaterial(Material("icon16/magnifier.png", "noclamp smooth"))
        end

        surface.DrawTexturedRect(0, 0, w, h)
    end

    DBu.DoClick = function(ss)
        if Underlay.Finding == true then return end
        if ply:GetNWInt("A_ActMod.IMeun_Num", 0) ~= 15 then
            ply:SetNWInt("A_ActMod.IMeun_Num", 15)
            Passq:SetAlpha(255)
            Passq:AlphaTo(0, 0.2)
        end

        Underlay.PutMark_TimCRe = CurTime() + 0.3
        surface.PlaySound("garrysmod/ui_click.wav")
        if IsValid(List) then List:Remove() end
        Buttons = nil
        Buttons = {}
        List = vgui.Create("DIconLayout", Scroll)
        List:SetPos(0, 0)
        List:SetSize(Scroll:GetWide(), Scroll:GetTall())
        List:SetSpaceY(self.Scale / 4)
        List:SetSpaceX(self.Scale / 4)
        A_AM.ActMod.FindIt = {}
        Underlay.Finding = true
        timer.Create("AaA_finding", 0.1, 1, function()
            if IsValid(ply) then
                for _, v in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*.png", "GAME")) do
                    if not table.HasValue(A_AM.ActMod.FindIt, v) then
                        if ply:GetNWInt("A_ActMod.IMeun_Num", 0) == 15 then
                            for k, av in pairs(A_AM.ActMod.tNamsAct) do
                                if string.find(RvString(ReString(v)), k) and A_AM.ActMod:ATabData(A_AM.ActMod.FindIt, v) == false then if string.lower(av) == string.lower(GetConVarString("actmod_cl_stext")) or string.find(av, GetConVarString("actmod_cl_stext")) then table.insert(A_AM.ActMod.FindIt, v) end end
                            end

                            if string.find(v, GetConVarString("actmod_cl_stext")) and A_AM.ActMod:ATabData(A_AM.ActMod.FindIt, v) == false then table.insert(A_AM.ActMod.FindIt, v) end
                        end
                    end
                end

                for k, v in pairs(A_AM.ActMod.FindIt or {}) do
                    MakeButton(v)
                end

                timer.Create("AaA_finding", 0.6, 1, function() if IsValid(ply) then Underlay.Finding = false end end)
            end
        end)
    end

    Wnds_CheckBox1(295, -2, 190, 25, 30, 5, 25, 25, aR:T("LReplace_BxSModel"), "actmod_cl_showmodl", "icon16/image.png", "icon16/user_gray.png")
    if not Dled then
        Wnds_ComboBox3(490, -2, 124, 25, 30, -0.1, 90, 25, aR:T("LReplace_BxSEm"), "actmod_cl_sortemote", nil, aR:T("LReplace_MF1"), aR:T("LReplace_MF2_2"), nil, nil, "actmod/imenu/imll1_1.png", "icon16/application_view_tile.png", nil, "SEmote")
        Wnds_ComboBox3(619, 3, 134, 30, 30, -0.1, 104, 15, aR:T("LReplace_BxSCView"), "actmod_cl_setcamera", aR:T("LReplace_BxSCView0"), aR:T("LReplace_BxSCView1"), aR:T("LReplace_BxSCView2"), aR:T("LReplace_BxSCView3"), "icon16/page_white_text.png", "icon16/arrow_in.png", "icon16/anchor.png", "icon16/eye.png", "SCamV")
        local function AaA(g)
            local ao = 0
            for k, v in pairs(g) do
                if v["ok"] == "yes" then ao = ao + 1 end
            end
            return ao
        end

        local aaw = 0
        if file.Exists(A_AM.ActMod:A_BED(2, "bm5sai5qc29u"), "DATA") then
            local tmp = file.Read(util.Base64Decode("bm5sai5qc29u"), "DATA")
            local commit = util.JSONToTable(A_AM.ActMod:A_BED(2, tmp))
            if not commit then
                aaw = 0
                file.Delete(A_AM.ActMod:A_BED(2, "bm5sai5qc29u"), "DATA")
            elseif A_AM.ActMod:A_BED(1, commit.inopn) == "QWN0TW9kIFtBTTRd" then
                aaw = 1
                if AaA(commit) > 0 then aaw = 2 end
            end
        end

        local rha = vgui.Create("DPanel", Panel2)
        rha:SetPos(147, 2)
        rha:SetSize(85, 31)
        rha:SetText("")
        rha:SetAlpha(255)
        rha.Paint = function(s, w, h)
            local acw = math.max(0, math.min(200, 255 + (300 * math.sin(CurTime() * 4))))
            if aaw == 0 then
                draw.RoundedBox(5, 0, 0, w, h, Color(50 + acw, 55 + acw, 55, 255))
            elseif aaw == 2 then
                draw.RoundedBox(5, 0, 0, w, h, Color(50 + acw / 3, 55 + acw, 55, 255))
            else
                draw.RoundedBox(5, 0, 0, w, h, Color(50, 55, 55, 255))
            end
        end

        local DBut = vgui.Create("DButton", rha)
        DBut:SetPos(5, 5)
        DBut:SetSize(75, 20)
        DBut:SetText(aR:T("LAchievements"))
        DBut:SetDark(true)
        DBut:SetDark(true)
        DBut.Paint = function(p, w, h)
            if p:IsDown() then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
            else
                draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
                draw.RoundedBox(0, 0, h / 2, w, h / 2, Color(200, 200, 200, 255))
            end

            CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LAchievements"), "CreditsText")
        end

        DBut.DoClick = function(s)
            surface.PlaySound("garrysmod/content_downloaded.wav")
            if IsValid(LocalPlayer().OAvs) then LocalPlayer().OAvs:Remove() end
            LocalPlayer().OAvs = vgui.Create("ActMod_Avs")
            LocalPlayer().OAvs.GetPly = LocalPlayer()
            self:Close()
            if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
        end
    end

    local rh = vgui.Create("DPanel", Panel)
    rh:SetPos(10, 0)
    rh:SetSize(740, 50)
    rh:SetText("")
    rh:SetAlpha(255)
    rh.Paint = function(s, w, h)
        if ThemeN == 1 then
            draw.RoundedBox(15, 0, 0, w, h + 15, Color(80, 80, 100, 255))
            draw.RoundedBox(10, 160, 10, 570, 50, Color(50, 100, 150, 255))
        elseif ThemeN == 2 then
            draw.RoundedBox(15, 0, 0, w, h + 15, Color(20, 20, 20, 200))
            draw.RoundedBox(10, 160, 10, 570, 50, Color(140, 150, 100, 35))
        end

        if ply:GetNWInt("A_ActMod.Select_Base", 0) == 1 then
            draw.SimpleText("= Gmod =", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 2 then
            draw.SimpleText("CTE-Taunt", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 3 then
            draw.SimpleText("AM4-Pack", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    local TrCl_CTE = ply:GetNWBool("A_ActMod.GetSeqTr_SV_Base__cl", false) == true and ply:GetNWBool("A_ActMod.GetSeqTr_SV_ECTE__cl", false) == true
    local TrCl_AM4 = ply:GetNWBool("A_ActMod.GetSeqTr_SV_BAM4__cl", false) == true and ply:GetNWBool("A_ActMod.GetSeqTr_SV_EAM4__cl", false) == true
    local rs = vgui.Create("DPanel", rh)
    rs:SetPos(1, 0)
    rs:SetSize(50, 50)
    rs:SetText("")
    rs:SetAlpha(255)
    rs.Paint = function(s, w, h)
        surface.SetDrawColor(color_white)
        if ply:GetNWInt("A_ActMod.Select_Base", 0) == 1 then
            surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 2 then
            surface.SetMaterial(Material("actmod/imenu/ifrom_cte.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
            if not TrCl_CTE then
                surface.SetDrawColor(255, 255, 255, math.max(200 + (100 * math.sin(CurTime() * 12)), 0))
                surface.SetMaterial(Material("icon16/error.png", "noclamp smooth"))
                surface.DrawTexturedRect(30, 30, 20, 20)
            end
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 3 then
            surface.SetMaterial(Material("actmod/imenu/ifrom_am4.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
            if not TrCl_AM4 then
                surface.SetDrawColor(255, 255, 255, math.max(200 + (100 * math.sin(CurTime() * 12)), 0))
                surface.SetMaterial(Material("icon16/error.png", "noclamp smooth"))
                surface.DrawTexturedRect(30, 30, 20, 20)
            end
        else
            surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        end
    end

    local function Bsa(ay)
        if ply:GetNWInt("A_ActMod.Select_Base", 0) == 1 then
            Underlay.IBu0 = Button_NWInt(260, 10, 170, 40, "actmod/imenu/is_gmod.png", " Garry's Mod", "A_ActMod.IMeun_Num", 1, ay)
            Underlay.IBuS = Button_NWInt(500, 10, 130, 40, "actmod/imenu/is_featured.png", " Favorite", "A_ActMod.IMeun_Num", 20, ay)
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 2 then
            Underlay.IBu1 = Button_NWInt(200, 10, 120, 40, "actmod/imenu/Is_fortnite.png", " Fortnite", "A_ActMod.IMeun_Num", 2, ay)
            Underlay.IBu3 = Button_NWInt(355, 10, 210, 40, "actmod/imenu/is_team_fortress2.png", " Team Fortress 2", "A_ActMod.IMeun_Num", 8, ay)
            Underlay.IBu2 = Button_NWInt(590, 10, 100, 40, "actmod/imenu/is_mmd.png", " MMD", "A_ActMod.IMeun_Num", 4, ay)
        elseif ply:GetNWInt("A_ActMod.Select_Base", 0) == 3 then
            Underlay.IBu4 = Button_NWInt(175, 10, 100, 40, "actmod/imenu/is_am4.png", "Other", "A_ActMod.IMeun_Num", 5, ay)
            Underlay.IBu6 = Button_NWInt(284, 10, 100, 40, "actmod/imenu/is_pubg.png", "PUBG", "A_ActMod.IMeun_Num", 11, ay)
            Underlay.IBu5 = Button_NWInt(391, 10, 120, 40, "actmod/imenu/is_mixamo.png", "Mixamo", "A_ActMod.IMeun_Num", 10, ay)
            Underlay.IBu2 = Button_NWInt(517, 10, 95, 40, "actmod/imenu/is_mmd2.png", "MMD", "A_ActMod.IMeun_Num", 6, ay)
            Underlay.IBu3 = Button_NWInt(618, 10, 117, 40, "actmod/imenu/Is_fortnite.png", "Fortnite", "A_ActMod.IMeun_Num", 7, ay)
        end
    end

    local DButCh = vgui.Create("DComboBox", rh)
    DButCh:SetPos(52, 0)
    DButCh:SetSize(100, 25)
    DButCh:SetText(aR:T("LReplace_txt_SAFrom"))
    DButCh:AddChoice("1- Garry's Mod", 1, false, TrCl_CTE and "icon16/folder_page.png" or "icon16/folder_error.png")
    DButCh:AddChoice("2-[wOS] Animation Extension - Custom Taunt", 2, false, TrCl_CTE and "icon16/folder_page.png" or "icon16/folder_error.png")
    DButCh:AddChoice("3-[(AM4-Anim)] Pack Animatoin   for ActMod", 3, false, TrCl_AM4 and "icon16/folder_page.png" or "icon16/folder_error.png")
    DButCh.OnSelect = function(pl, index, value, data)
        if ply:GetNWInt("A_ActMod.Select_Base", 0) ~= data then
            if IsValid(Underlay.IBu0) then Underlay.IBu0:Remove() end
            if IsValid(Underlay.IBuS) then Underlay.IBuS:Remove() end
            if IsValid(Underlay.IBu1) then Underlay.IBu1:Remove() end
            if IsValid(Underlay.IBu2) then Underlay.IBu2:Remove() end
            if IsValid(Underlay.IBu3) then Underlay.IBu3:Remove() end
            if IsValid(Underlay.IBu4) then Underlay.IBu4:Remove() end
            if IsValid(Underlay.IBu5) then Underlay.IBu5:Remove() end
            if IsValid(Underlay.IBu6) then Underlay.IBu6:Remove() end
            surface.PlaySound("garrysmod/content_downloaded.wav")
            ply:SetNWInt("A_ActMod.Select_Base", data)
            Bsa(true)
        end

        DButCh:SetText(aR:T("LReplace_txt_SAFrom"))
    end

    Bsa()
    if not Dled then
        local DButton = vgui.Create("DButton", Panel)
        DButton:SetPos(620, Panel:GetTall() - (27 + Thh))
        DButton:SetSize(75, 20)
        DButton:SetText(aR:T("LReplace_txt_REmot"))
        DButton:SetDark(true)
        DButton.Paint = function(p, w, h)
            if p:IsDown() then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
            else
                draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
                draw.RoundedBox(0, 0, h / 2, w, h / 2, Color(200, 200, 200, 255))
            end

            CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LReplace_txt_REmot"), "CreditsText", 1)
        end

        DButton.DoClick = function(s)
            Derma_Query(aR:T("LReplace_txt_REmott1"), aR:T("LReplace_txt_REmott2"), aR:T("LReplace_txt_REmott3"), function()
                ActojiClear()
                self:Close(true)
                if IsValid(Underlay) then Underlay:Remove() end
            end, aR:T("LReplace_txt_REmott4"), function() end)
        end

        local DButton = vgui.Create("DButton", Panel)
        DButton:SetPos(700, Panel:GetTall() - (27 + Thh))
        DButton:SetSize(50, 20)
        DButton:SetText(aR:T("LReplace_txt_Options"))
        DButton:SetDark(true)
        DButton.Paint = function(p, w, h)
            if p:IsDown() then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
            else
                draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
                draw.RoundedBox(0, 0, h / 2, w, h / 2, Color(200, 200, 200, 255))
            end

            CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LReplace_txt_Options"), "CreditsText", 2)
        end

        DButton.DoClick = function(s)
            self:AMenuOption(LocalPlayer())
            self:Close()
            if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
        end
    end
end