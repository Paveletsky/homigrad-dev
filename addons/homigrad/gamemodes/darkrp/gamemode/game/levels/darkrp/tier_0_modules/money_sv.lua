function darkrp.SetMoney(ply, value)
    ply:SetNWInt("DarkRPMoney", value)
end

function darkrp.AddMoney(ply, value)
    ply:SetNWInt("DarkRPMoney", ply:GetNWInt("DarkRPMoney", 0) + value)
end

local function send(ply, money)
    darkrp.AddMoney(ply, money)
    darkrp.Notify("Тебе выдали: " .. money .. "$", NOTIFY_GENERIC, 5, ply)
end

COMMANDS.addmoney = {
    function(ply, args)
        local money = tonumber(args[2])
        if args[1] == "^" then
            send(ply, money)
        else
            for i, ply2 in pairs(player.GetAll()) do
                if string.find(ply2:Name(), args[1]) then
                    send(ply2, money)
                    return
                end
            end
        end
    end
}

COMMANDS.dropmoney = {
    function(ply, args)
        local money = darkrp.GetMoney(ply)
        local subMoney = tonumber(args[1])
        if subMoney <= 0 or subMoney > money then
            darkrp.Notify("Недостаточно средств.", NOTIFY_ERROR, 2, ply)
            return
        end

        local trace = {
            start = ply:EyePos()
        }

        local dir = Vector(75, 0, 0)
        dir:Rotate(ply:EyeAngles())
        tr.endpos = tr.start + dir
        local ent = ents.Create("darkrp_money")
        ent:SetNWInt("Amount", subMoney)
        ent:SetPos(trace.HitPos)
        ent:Spawn()
        darkrp.AddMoney(ply, -subMoney)
    end,
    0
}

local CD = CurTime() + 1
hook.Add("Think", "SuperIdolMoneyDayDa", function()
    if CD - CurTime() < 0 then
        for z, ply in pairs(player.GetAll()) do
            local r = darkrp.GetRole(ply)
            r.sol = r.sol or 200
            darkrp.AddMoney(ply, r.sol)
            darkrp.Notify("Зарплата: +" .. r.sol .. "$", NOTIFY_GENERIC, 5, ply)
            -- print("ASDASASDASDSA", ply) 
            if #ents.FindByClass("prop_ragdoll") > 35 then
                for i = 1, #ents.FindByClass("prop_ragdoll") do
                    ents.FindByClass("prop_ragdoll")[i]:Remove()
                end
            end
        end

        CD = CurTime() + 120
    end
end)

hook.Add("PlayerDisconnected", "SaveMoneyGovno", function(ply)
    local money = ply:GetNWInt("DarkRPMoney", 0)
    file.Write(ply:SteamID64() .. ".txt", money)
end)

hook.Add("PlayerInitialSpawn", "HobAloadHovbnaMoney", function(ply, bool)
    local mon = file.Read(ply:SteamID64() .. ".txt", "DATA")
    darkrp.SetMoney(ply, mon)
end)