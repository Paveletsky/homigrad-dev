local dataSync = {}
local function syncItemsData()

	for id, item in pairs(dataSync) do

        dangautils.db:PrepareQuery([[
			UPDATE homigrad_users
				SET data = ?
				WHERE id = ?
		]], { util.TableToJSON(item.data), item.id }, function(q, st, data)
			if st then
				print('User data updated for ID: ' .. item.id)
			else
				print('Failed to update user data for ID: ' .. item.id .. ', error:')
				print(data)
			end
		end)

		dataSync[id] = nil
        
	end

end
hook.Add('Think', 'fundot.dataSync', syncItemsData)

hook.Add('HG:PlayerLoaded', 'player-data', function(client)

	dangautils.db:PrepareQuery([[
		SELECT id, data FROM homigrad_users
			WHERE steamID = ?
	]], {
		client:SteamID()
	}, function(q, st, data)

		if not IsValid(client) then return end

		data = istable(data) and data[1]
		if data then
			-- load data
			client.id = data.id
			client.dbvars = util.JSONToTable(data.data)
		else
			-- new player
			print('New player: ' .. tostring(client))
			dangautils.db:PrepareQuery([[
				INSERT INTO homigrad_users (steamID, data)
				VALUES (?, '')
			]], {
				client:SteamID(),
			}, function(q, st, data)
				if not IsValid(client) then return end

				if st then
                    client.id = q:lastInsert()
                    client.dbvars = {}
				else
					print('ERROR: Could not initialize player: ' .. tostring(client))
					client:Kick('Мы не смогли загрузить твои данные.')
				end

			end)
		end
        
	end)

end)

local meta = FindMetaTable 'Player'
function meta:SetDBVar(name, val)
	if not name or isfunction(val) then return end

    if not self.dbvars or type(self.dbvars) ~= "table" then
        self.dbvars = self.dbvars or {}
    end
	
	self.dbvars[name] = val

    if self.id then
        dataSync[name] = {id = self.id, data = self.dbvars}
    else
        timer.Simple(0.1, function() self:SetDBVar(name, val) end)
    end

    return self

end

function meta:GetDBVar(name, backup)

	return self.dbvars and self.dbvars[name] or backup

end