_G.whoLoaded = _G.whoLoaded or {}

hook.Add('CanProperty', 'bkCanProperty', function(client, property, entity)
	if (property == "remover" or property == "collision") then
		return true
	end

	-- return false
end)

CAMI.RegisterPrivilege{
	Name = "Доступ к pac3",
	MinAccess = "superadmin"
}

CAMI.RegisterPrivilege{
    Name = "Доступ к моделям",
    MinAccess = "superadmin" -- By default only superadmins can change settings
}

CAMI.RegisterPrivilege{
    Name = "Команды уровень 1",
    MinAccess = "superadmin" -- By default only superadmins can change settings
}

CAMI.RegisterPrivilege{
    Name = "Команды уровень 2",
    MinAccess = "superadmin" -- By default only superadmins can change settings
}

CAMI.RegisterPrivilege{
    Name = "Смена режимов",
    MinAccess = "superadmin" -- By default only superadmins can change settings
}

CAMI.RegisterPrivilege{
    Name = "Доступ к спавнменю",
    MinAccess = "superadmin" -- By default only superadmins can change settings
}