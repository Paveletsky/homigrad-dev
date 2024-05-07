function darkrp.StartRoundSV()
    tdm.DirectOtherTeam(2, 1)
    for i, ply in pairs(player.GetAll()) do
        jailbreak.ReadRank(ply)
        ply:SetNWFloat("Arest", CurTime() + darkrp.ArestTime)
    end

    local aviable = homicide.Spawns()
    tdm.SpawnCommand(team.GetPlayers(1), aviable, function(ply)
        darkrp.SetRole(ply, 1)
        -- darkrp.CanUseSpawnMenu(ply,"prop")
        local md = darkrp.GetMoney(ply) or 1000
        darkrp.SetMoney(ply, md)
    end)

    for name in pairs(darkrp.doors) do
        for i, ent in pairs(ents.FindByClass(name)) do
            ent.buy = nil
        end
    end
end

local empty = {}
function darkrp.PlayerSpawn(ply)
    local role = darkrp.GetRole(ply)
    ply:SetPlayerColor(role[2]:ToVector())
    local id = ply.darkrpModelID
    ply:SetModel((id and role.models[id]) or role.models[math.random(1, #role.models)])
    if role.PlayerSpawn then role.PlayerSpawn(ply) end
    for i, weapon in pairs(role.weapons or empty) do
        ply:Give(weapon)
    end

    ply:Give("darkrp_key")
    ply:Give("weapon_hands")
    ply:Give("weapon_physcannon")
    tdm.GiveSwep(ply, role.main_weapon, 12)
    tdm.GiveSwep(ply, role.secondary_weapon, 12)
    if role.secondary_weapon or role.main_weapon then
        for k, v in pairs(role.main_weapon) do
            ply:Give(v)
        end
    end

    if role.mapss then
        local bool = role.mapss[game.GetMap()]
        print(bool, ply, role[1])
        if bool then
            local i = math.random(1, #role.mapss[game.GetMap()])
            ply:SetPos(role.mapss[game.GetMap()][i])
        end
    end

    ply.tgod = CurTime() + 15
    darkrp.Inv_SetupDef(ply)
end

-- mapss = {
--     "rp_bangclaw" = {
--         Vector(3998.264648, -1069.034180, 137.333817),
--         Vector(3967.291504, -965.112549, 135.928299),
--         Vector(4042.874023, -952.240479, 136.442993),
--         Vector(3946.373535, -1106.069824, 135.312592),
--     },
-- }
function darkrp.PlayerInitialSpawn(ply)
    jailbreak.ReadRank(ply)
    ply:SetTeam(1)
    darkrp.SetRole(ply, 1)
    darkrp.RulesSync(ply)
end

function darkrp.PlayerCanJoinTeam(ply, teamID)
    if teamID == 2 or teamID == 3 then return false end
    if teamID == 1002 and not ply:IsAdmin() then return false end
    return true
end

function darkrp.PlayerDeath(ply)
    local role = darkrp.GetRole(ply)
    if role[1] == "Мэр" then
        darkrp.SetRole(ply, 1)
        darkrp.Notify("Мэр погиб!", NOTIFY_GENERIC, 5)
    end

    local pos = ply:GetPos()
    pos.x = pos.x + 0
    pos.y = pos.y + 0
    pos.z = pos.z + 4
    local val = math.Round(darkrp.GetMoney(ply) / 20)
    local money = ents.Create("darkrp_money")
    money:SetNWInt("Amount", val)
    money:Spawn()
    money:SetPos(pos)
    ply.EnableSpectate = true
    ply:SetNWFloat("DarkRPArestTime", 0)
    if ply:IsAdmin() then
        ply.darkrpDeathWait = CurTime() + 15
        ply:SetNWFloat("DeathWait", ply.darkrpDeathWait)
    else
        ply.darkrpDeathWait = CurTime() + 30
        ply:SetNWFloat("DeathWait", ply.darkrpDeathWait)
    end
end

function darkrp.PlayerDeathThink(ply)
    -- if ply:Team() ~= 1 then return end
    if (ply.darkrpDeathWait or 2) > CurTime() then return false end
    if ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2) or ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then ply:Spawn() end
    return true
end

function darkrp.ShouldSpawnLoot()
    return false
end

util.AddNetworkString("darkrp shop buy")
net.Receive("darkrp shop buy", function(len, ply)
    local role = darkrp.GetRole(ply)
    local item = role.shop[net.ReadInt(16)]
    if not item then --ban
        return
    end

    local price = item[3]
    if darkrp.GetMoney(ply) < price then
        darkrp.Notify("Недотаточно средств.", NOTIFY_ERROR, 5, ply)
        return
    end

    darkrp.AddMoney(ply, -price)
    local ent = ents.Create(item[2])
    ent:SetPos(ply:GetEyeTraceDis(75).HitPos)
    ent:SetAngles(ply:GetAngles())
    ent:Spawn()
    ent:PhysicsInit(SOLID_VPHYSICS)
    ent:SetMoveType(MOVETYPE_VPHYSICS)
    ent:SetSolid(SOLID_VPHYSICS)
    ent:DrawShadow(true)
    ent:SetUseType(SIMPLE_USE)
    ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    ent:CPPISetOwner(ply) --eee
end)

function darkrp.RoundEndCheck()
    for i, ply in pairs(team.GetPlayers(1)) do
        local diff = ply:GetNWFloat("Arest")
        if diff and diff - CurTime() < 0 then darkrp.Arest(ply, false) end
    end
end

function darkrp.GuiltLogic(ply, att, dmgInfo)
    local rolePly, roleAtt = darkrp.GetRole(ply), darkrp.GetRole(att)
    if (rolePly[1] == "Полицейский" or rolePly[1] == "Мэр") and roleAtt[1] == "Полицейский" then dmgInfo:SetDamage(0) end
    -- if not rolePly.isGoverment and not roleAtt.isGoverment then
    --     return 35
    -- -- elseif rolePly.notApas then
    -- --     return 15
    -- -- elseif roleAtt.notApas then
    --     -- att:Kill()
    --     -- return 60
    -- end
    -- -- if rolePly.isGoverment or false and roleAtt.isGoverment or false then return 50 end
    -- if rolePly ~= roleAtt then return true end
    return false
end