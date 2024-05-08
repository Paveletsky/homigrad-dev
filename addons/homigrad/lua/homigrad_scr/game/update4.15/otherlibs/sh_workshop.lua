if SERVER then
    for id, addon in ipairs(engine.GetAddons()) do
        resource.AddWorkshop(addon.wsid)
    end
end
