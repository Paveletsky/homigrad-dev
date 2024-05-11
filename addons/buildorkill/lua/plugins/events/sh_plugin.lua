bok.util.IncludeDir("plugins/events/rb_lib")
bok.util.IncludeDir("plugins/events/rb_sit")

-- PrintTable(ULib.ucl.authed[ player.GetBySteamID('STEAM_0:0:30588797'):UniqueID() ])

hook.Add( "ShutDown", "ServerShuttingDown", function()  
    -- for k, v in pairs(player.GetAll()) do
    --     v:Kick('Сервер перезапускается, либо же возникли технические неполадки.')
    -- end
end)