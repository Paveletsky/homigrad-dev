fundot.items = {}

function fundot.CanUseIsActive(item)
	return !item:GetData('active', false)
end

function fundot.registerItem(name, data)
	fundot.items[name] = data
	return fundot.items[name]
end

bok.util.IncludeDir('plugins/shop/cats')

hook.Add('HG:PlayerLoaded', 'GiveUniqueFeatures', function(client)
	
end)