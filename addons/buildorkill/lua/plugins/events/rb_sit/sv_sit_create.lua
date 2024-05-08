resource.AddFile("materials/entities/sit_trigger.png")

local EnableScreenClicker = false
hook.Add("PostGamemodeLoaded", "GamemodeLoad", function()
    function GAMEMODE:ShowHelp(ply)
        rb_lib.ShowHelp(ply)
    end
    
    function GAMEMODE:ShowTeam(ply)
        rb_lib.ShowTeam(ply)
    end

    function GAMEMODE:ShowSpare1(ply)
        rb_lib.ShowSpare1(ply)
    end
end)

util.AddNetworkString("rb_sit_server")
util.AddNetworkString("rb_sit_client")
util.AddNetworkString("rb_sit_join")

net.Receive("rb_sit_server", function(num, ply)
    local act = net.ReadString()
    if act == "CheckCreateSit" then
        local data = net.ReadTable()
        local BorderTrigger = ents.Create("sit_trigger")
        BorderTrigger:SetPos(data.pos)
        BorderTrigger:Spawn()
        BorderTrigger:SetCollisionBounds(data.mins, data.maxs)
        local id = BorderTrigger:EntIndex()

        ply:SetNWBool("rb_OwnSit", true)
        ply:SetNWInt("rb_OwnSit_id", id)

        local BorderChecker = ents.Create("prop_physics")
        BorderChecker:SetModel("models/hunter/plates/plate.mdl")
        BorderChecker:SetMaterial("null")
        BorderChecker:SetPos(data.pos)
        BorderChecker:SetAngles(Angle(0, 0, 0))
        BorderChecker:Spawn()

        BorderChecker:SetNWEntity("rb_Owner", ply)
        BorderChecker:SetNWBool("rb_Checker", true)

        BorderChecker:SetSolid(SOLID_BBOX)
        BorderChecker:SetCollisionBounds(data.mins, data.maxs)
        BorderChecker:GetPhysicsObject():EnableGravity(false)
        timer.Simple(1, function() BorderChecker:Remove() end)
    elseif act == "CreateSit" then
        local data = net.ReadTable()
        local id = ply:GetNWInt("rb_OwnSit_id")
        local BorderTrigger = Entity(id)
        
        ply:PrintMessage(4, "[RB] Вы создали ситуацию!")

        table.insert(rb_sits, id, data.sit)
        print("\n[RB_DEBUG] Player: "..ply:GetName().."( "..ply:SteamID().." ) was created situation")
        PrintTable(rb_sits)

        function BorderTrigger:StartTouch(ent)
            if ent:IsPlayer() then /* && !ent:GetNWBool("rb_OwnSit", false)*/
                net.Start("rb_sit_join")
                    net.WriteString("JoinSit")
                    net.WriteTable(data.sit)
                net.Send(ent)
            elseif ent:GetNWBool("rb_Checker", false) then
                local ply_owner = ent:GetNWEntity("rb_Owner")
                local id = ply_owner:GetNWInt("rb_OwnSit_id", -1)

                ply_owner:SetNWBool("rb_OwnSit", false)
                ply_owner:SetNWInt("rb_OwnSit_id", -1)

                net.Start("rb_sit_client")
                    net.WriteString("ErrorCreateSit")
                net.Send(ply_owner)
                Entity(id):Remove()
            end
        end
    elseif act == "DeleteSit" then
        local own_sit = ply:GetNWBool("rb_OwnSit", false)
        local id = ply:GetNWInt("rb_OwnSit_id", -1)

        if own_sit && id != -1 then
            Entity(id):Remove()
            table.remove(rb_sits, id)
            ply:SetNWBool("rb_OwnSit", false)
            ply:SetNWInt("rb_OwnSit_id", -1)
        end
    end
end)