local require = require
local util = util
local GWSockets = GWSockets
local print = print
local net = net
local timer = timer
local heartbeat = heartbeat
local PrintTable = PrintTable
local createHeartbeat = createHeartbeat
local string = string
local Discord = Discord
require("gwsockets")
util.AddNetworkString("!!discord-receive")
Discord.isSocketReloaded = false
if Discord.socket ~= nil then
    Discord.isSocketReloaded = true
    Discord.socket:closeNow()
end

Discord.socket = Discord.socket or GWSockets.createWebSocket("wss://gateway.discord.gg/?encoding=json", false)
local socket = Discord.socket
local function broadcastMsg(msg)
    print('[Discord] ' .. msg.author .. ': ' .. msg.content)
    net.Start('!!discord-receive')
    net.WriteTable(msg)
    net.Broadcast()
end

function heartbeat()
    socket:write([[
    {
        "op": 1,
        "d": null
    }
    ]])
end

function createHeartbeat()
    timer.Create('!!discord_hearbeat', 10, 0, function() heartbeat() end)
end

function socket:onMessage(txt)
    local resp = util.JSONToTable(txt)
    if not resp then return end
    if Discord.debug then
        print('[Discord] Received: ')
        PrintTable(resp)
    end

    if resp.op == 10 and resp.t == nil then createHeartbeat() end
    if resp.op == 1 then heartbeat() end
    if resp.d then
        if resp.t == 'MESSAGE_CREATE' and resp.d.channel_id == Discord.readChannelID and resp.d.content ~= '' then
            if resp.d.author.bot == true then return end
            if string.sub(resp.d.content, 0, 1) == Discord.botPrefix then
                command = string.Split(string.sub(resp.d.content, 2), " ")[1]
                if Discord.commands[command] then Discord.commands[command](resp) end
                return
            end

            broadcastMsg({
                ['author'] = resp.d.author.username,
                ['content'] = resp.d.content
            })
        end
    end
end

function socket:onError(txt)
    print('[Discord] Error: ', txt)
end

function socket:onConnected()
    print('[Discord] connected to Discord server')
    local req = [[
    {
      "op": 2,
      "d": {
        "token": "]] .. Discord.botToken .. [[",
        "compress": true,
        "intents": 512,
        "properties": {
          "os": "linux",
          "browser": "gmod",
          "device": "pc"
        },
        "presence": {
          "activities": [{
            "name": "Homice-Box",
            "type": 0
          }]
        }
      }
    }
    ]]
    heartbeat()
    timer.Simple(3, function() socket:write(req) end)
end

function socket:onDisconnected()
    print('[Discord] WebSocket disconnected')
    timer.Remove('!!discord_hearbeat')
    if Discord.isSocketReloaded ~= true then
        print('[Discord] WebSocket reload in 5 sec...')
        timer.Simple(5, function() socket:open() end)
    end
end

print('[Discord] Socket init...')
timer.Simple(3, function()
    socket:open()
    --socket:onConnected()
    heartbeat()
    Discord.isSocketReloaded = false
end)