local hg_discrodmsg = CreateClientConVar("hg_discrodmsg", "1", true, false)

net.Receive("!!discord-receive", function()
    if not hg_discrodmsg:GetBool() then return end
	local msg = net.ReadTable()

	chat.AddText( Discord.prefixClr, "["..Discord.prefix.."] ", Color(255, 255, 255), Color(255, 255, 105), msg.author..": ",Color(255, 255, 255), msg.content )
end)