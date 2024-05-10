hook.Add('HG:PlayerLoaded', 'play-time', function(ply)
	ply:SetNetVar('time.total', ply:GetDBVar('time.total', 0))
	ply:SetNetVar('time.session', CurTime())
end)

hook.Add('PlayerDisconnected', 'play-time', function(ply)
	ply:SaveTime()
end)

local client = FindMetaTable('Player')
function client:SaveTime()

	local ct = CurTime()
	local diff = ct - self:GetNetVar('time.session', ct)
	if diff <= 0 then return end

	local time = self:GetNetVar('time.total', 0) + diff
	self:SetDBVar('time.total', time)
	self:SetNetVar('time.total', time)

	self:SetNetVar('time.session', ct)

end

function client:SetTimeTotal(val)

	self:SetNetVar('time.total', val)
	self:SetDBVar('time.total', val)

end