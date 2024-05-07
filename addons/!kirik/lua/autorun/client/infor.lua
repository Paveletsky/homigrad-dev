surface.CreateFont("kissafsdf", {
    font = "Roboto",
    extended = false,
    size = 19,
    weight = 500
})

hook.Add("HUDPaint", "DisplayDateTime", function()
    -- local dateTime = os.date("%H:%M:%S | %d.%m.%Y")
    -- local x = ScrW() /2
    -- local y = 26

    -- local ply = LocalPlayer()
    -- local nick = ply:Nick()
    -- local steamID = ply:SteamID()
    -- local text = nick .. " | " .. steamID

    -- draw.SimpleText(text, "kissafsdf", ScrW()/2, 46, Color(255, 255, 255, 20), 1, 1)
    -- draw.SimpleText(dateTime, "kissafsdf", ScrW()/2, 65, Color(255, 255, 255, 20), 1, 1)

    -- local additionalText = "Старый Хомиград"
    -- local textWidth, textHeight = surface.GetTextSize(additionalText)
    -- draw.SimpleText(additionalText, "kissafsdf", ScrW() - textWidth - 50, ScrH() - textHeight - 1, Color(255, 255, 255, 20), 0, 0)
end)
