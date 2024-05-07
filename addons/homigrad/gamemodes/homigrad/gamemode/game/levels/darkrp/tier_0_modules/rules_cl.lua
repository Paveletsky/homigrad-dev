surface.CreateFont( "snoupergov", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 22,
	weight = 600,
	blursize = 0,
} )

net.Receive("darkrp rules",function()
    darkrp.rules = net.ReadString()
end)

darkrp.pages[3] = {"Законы",function(panel)
    local role = darkrp.GetRole(LocalPlayer())

    local textEntry = vgui.Create("DTextEntry",panel)
    textEntry:SetSize( 300, 300 )
    textEntry:SetFont("snoupergov")
    textEntry:SetTextColor(Color(255,255,255))
    textEntry:SetMultiline(true)
    textEntry:SetDrawBackground( false )
    textEntry:Dock(TOP)
    textEntry:SetEditable(role.canChangeRule)
    textEntry:SetValue(darkrp.rules or "Не убивать на спавне!")

    textEntry.OnLoseFocus = function( self )
        print(self:GetValue())
        net.Start("darkrp rules")
            net.WriteString(self:GetValue())
        net.SendToServer()
    end
end}
