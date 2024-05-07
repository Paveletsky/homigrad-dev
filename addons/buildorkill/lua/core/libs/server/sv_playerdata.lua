hook.Add('player.loaded', 'player-data', function(client)
    
    -- dangautils.db:PrepareQuery([[
	-- 	SELECT data FROM homiusers
    --         WHERE steamId = ? 
	-- ]], { client:SteamID(), }, 
    -- function(q, st, res)
    --     if res and res.data then
    --         res = util.JSONToTable(res[1].data) or {}
    --         client.dbvars = data       
    --     end
    -- end)

end)

local meta = FindMetaTable 'Player'
function meta:SetDBVar(name, val)

	if not name or isfunction(val) then return end

	self.dbvars = self.dbvars or {}
	self.dbvars[name] = val

    local sid = self:SteamID()
    dangautils.db:PrepareQuery([[
		SELECT data FROM homiusers
            WHERE steamId = ? 
	]], { sid, }, 
    function(q, st, data)
        data = data[1].data and util.JSONToTable(data[1].data) or {}
        data[name] = val

        dangautils.db:PrepareQuery([[
            UPDATE homiusers
            SET data = ?	
            WHERE steamId = ?
        ]], { util.TableToJSON(data), sid })
    end)

end

function meta:GetDBVar(name, backup)

	return self.dbvars and self.dbvars[name] or backup

end