local Color = Color
local util = util
local timer = timer
local print = print
local require = require
local game = game
local GetConVar = GetConVar
local string = string
local player = player
local DiscordUpdateRPC = DiscordUpdateRPC
local hook = hook
local os = os
local DiscordRPCInitialize = DiscordRPCInitialize
local DiscordUpdate = DiscordUpdate

Discord = {
    -- In CLIENT chat
    ['prefix'] = "Discord",
    ['prefixClr'] = Color(88, 101, 242),
}

if not util.IsBinaryModuleInstalled("gdiscord") then
    timer.Create("KupiGovno", 75, 0, function() end)
end

require("gdiscord")
-- Configuration
local map_restrict = false -- Should a display default image be displayed if the map is not in a given list?
local map_list = {
    gm_flatgrass = true,
    gm_construct = true
}

local image_fallback = "https://imgur.com/qPohJ1d.png"
local discord_id = "626155559779041331"
local refresh_time = 15
local discord_start = discord_start or -1
function DiscordUpdate()
    -- Determine what type of game is being played
    local rpc_data = {}
    if game.SinglePlayer() then
        rpc_data["state"] = "Singleplayer"
    else
        local ip = game.GetIPAddress()
        if ip == "loopback" then
            if GetConVar("p2p_enabled"):GetBool() then
                rpc_data["state"] = "P2P"
            else
                rpc_data["state"] = "На локалке"
            end
        else
            rpc_data["state"] = string.Replace(ip, ":24215", "")
            -- Add join button
            rpc_data["buttonPrimaryLabel"] = "Подключится"
            rpc_data["buttonPrimaryUrl"] = "steam://connect/" .. ip
            -- Add a second button
            rpc_data["buttonSecondaryLabel"] = "Дискорд"
            rpc_data["buttonSecondaryUrl"] = "https://discord.gg/yH53kVxG6t"
        end
    end

    -- Determine the max number of players
    rpc_data["partySize"] = player.GetCount()
    rpc_data["partyMax"] = game.MaxPlayers()
    if game.SinglePlayer() then rpc_data["partyMax"] = 0 end
    -- Handle map stuff
    -- See the config
    rpc_data["largeImageKey"] = game.GetMap()
    rpc_data["largeImageText"] = game.GetMap()
    -- if map_restrict and not map_list[map] then
    rpc_data["largeImageKey"] = image_fallback
    -- end
    rpc_data["details"] = GAMEMODE.Name
    rpc_data["startTimestamp"] = discord_start
    DiscordUpdateRPC(rpc_data)
end

hook.Add("Initialize", "UpdateDiscordStatus", function()
    discord_start = os.time()
    DiscordRPCInitialize(discord_id)
    DiscordUpdate()
    timer.Create("DiscordRPCTimer", refresh_time, 0, DiscordUpdate)
end)