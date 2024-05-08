local client = FindMetaTable('Player')
function client:GetSession()
	return CurTime() - self:GetNetVar('time.session', CurTime())
end

function client:GetTotalTime()
	return self:GetNetVar('time.total', 0) + self:GetSession()
end