fundot.items = {}

function fundot.CanUseIsActive(item)
	return !item:GetData('active', false)
end

function fundot.registerItem(name, data)
	fundot.items[name] = data
	return fundot.items[name]
end

bok.util.IncludeDir('plugins/shop/cats')

-- проверка баланса
timer.Create('HG:Balance', 120, 0, function()

	octolib.func.throttle(player.GetAll(), 10, 0.2, function(ply)
		if not IsValid(ply) then return end

		local oldBalance = ply.osBalance
		ply:osSyncBalance(function(newBalance) 		
			if (newBalance ~= oldBalance) then
				netstream.Start(ply, 'HG:Notify', 'Баланс в магазине обновлен!', 5, 'ui/hint.wav' )
			end 
		end)
		
	end)

end)
