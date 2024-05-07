hook.Add('dangautils.run', 'player-onLoaded', function()

	if CLIENT then
		hook.Add('Think', 'dangautils.pl.load', function()
			hook.Remove('Think', 'dangautils.pl.load')
	
			netstream.Start('dangautils.pl.load')
		end)
	end
	
	if SERVER then
		local whoLoaded = {}
	
		netstream.Hook('dangautils.pl.load', function(ply)
			if whoLoaded[ply] then return end
	
			hook.Run('player.loaded', ply)
			whoLoaded[ply] = true
		end)
	
		hook.Add('PlayerDisconnected', 'dangautils.pl.load', function(ply)
			whoLoaded[ply] = nil
		end)
	
		hook.Add('PlayerInitialSpawn', 'dangautils.pl.load', function(ply)
			if IsValid(ply) then
				timer.Simple(1, function()
					hook.Run('player.loaded', ply)
				end)
			end
		end)
	end		
	
end)