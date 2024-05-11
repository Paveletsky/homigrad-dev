hook.Add("HG:OnPlayerTouched", "ohLogs", function(client, target)

    if (not target) then return end

    local targetStr = target and target:Name() .. '('..target:SteamID()..') ' or target:GetClass()
    local clientStr = client:Name() .. '('..client:SteamID()..') '

    Discord.log('', clientStr .. 'трогает игрока ' .. targetStr, Discord.whKills)

end)

hook.Add("HG:OnPlayerKilled", "ohLogs", function(client, attacker, hitGroup, dmgData, reason)

    local attackerStr = attacker:Name() .. '('..attacker:SteamID()..') '
    local clientStr = client:Name() .. '('..client:SteamID()..') '

    Discord.log('', attackerStr .. 'убил игрока ' .. clientStr, Discord.whKills)

end)

hook.Add("HG:OnRoundStarted", "ohLogs", function(active, nextRound)

    -- Discord.log(attackerStr .. 'убил игрока ' .. clientStr, nil, Discord.whKills)

end)


hook.Add("HG:OnRoundEnded", "ohLogs", function(nextRound)

end)


hook.Add("HG:OnBalanceChanged", "ohLogs", function(nextRound)

end)


