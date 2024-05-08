_G.whoLoaded = _G.whoLoaded or {}

hook.Add('CanProperty', 'bkCanProperty', function(client, property, entity)
	if (property == "remover" or property == "collision") then
		return true
	end

	return false
end)