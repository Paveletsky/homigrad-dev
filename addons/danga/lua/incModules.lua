dangautils.fs.include('modules/database.lua', 'sv')
dangautils.fs.include('modules/onLoaded.lua', 'sh')
dangautils.fs.include('modules/playerData.lua', 'sv')

dangautils.fs.include('modules/lib/mysql.lua', 'sv')
dangautils.fs.include('modules/lib/mysqloo.lua', 'sv')

dangautils.fs.include('modules/lib/netstream.lua', 'sh')
dangautils.fs.include('modules/lib/netstream2.lua', 'sh')

dangautils.fs.include('modules/lib/pon.lua', 'sh')
dangautils.fs.include('modules/lib/von.lua', 'sh')

dangautils.fs.include('modules/lib/promise.lua', 'sh')

if CLIENT then

    local WepToIgnore = {
        ['weapon_physgun'] = true,
        ['gmod_tool'] = true,
        ['weapon_hands'] = true,
    }

    hook.Add("PlayerBindPress", "DisableQEBindings", function(ply, bind, pressed)
        if IsValid(ply) and ply:Alive() and ply:IsPlayer() then
            local weapon = ply:GetActiveWeapon()
            local ent = ply:GetEyeTrace().Entity
            local distance = ply:GetPos():Distance(ent:GetPos())

            if IsValid(weapon) and weapon:IsWeapon() and !WepToIgnore[weapon:GetClass()] then                            
                if distance < 100 and ent:GetClass() != 'worldspawn' then return end

                if bind == "+menu" then
                    PressedAlt1 = PressedAlt1 == '-alt1' and '+alt1' or '-alt1'
                    ply:ConCommand(PressedAlt1)

                    if !pressed then
                        PressedAlt1 = '-alt1'
                        ply:ConCommand('-alt1')
                    end

                    return true
                end
                 
                if bind == "+use" then
                    PressedAlt2 = PressedAlt2 == '-alt2' and '+alt2' or '-alt2'
                    ply:ConCommand(PressedAlt2)
                
                    if !pressed then
                        PressedAlt2 = '-alt2'
                        ply:ConCommand('-alt2')
                    end

                    return true
                end
            end
        end
    end)
    
end