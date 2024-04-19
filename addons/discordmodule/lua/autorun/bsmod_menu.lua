local function BSModUserOptions(Panel)
	Panel:ClearControls()
	
	local kicklabel = vgui.Create( "DLabel" )
	kicklabel:SetText( "How to Kick: type ''bind <key> bsmod_kick'' into the console." )
	kicklabel:SetColor( Color(0, 0, 0) )
	
	Panel:AddItem(kicklabel)
	
	local killmovelabel = vgui.Create( "DLabel" )
	killmovelabel:SetText( "How to KillMove: type ''bind <key> bsmod_killmove'' into the console." )
	killmovelabel:SetColor( Color(0, 0, 0) )
	
	Panel:AddItem(killmovelabel)
	
	local quotationlabel = vgui.Create( "DLabel" )
	quotationlabel:SetText( "^ Do those commands without the quotation marks which is the '' symbol" )
	quotationlabel:SetColor( Color(47, 149, 241) )
	
	Panel:AddItem(quotationlabel)
					 
	Panel:CheckBox( "Enable KillMove Glow Effect", "bsmod_killmove_glow" )
	Panel:CheckBox( "List all CalcView hooks", "bsmod_debug_calcview" )
	--Panel:CheckBox( "Enable Hints", "bsmod_enable_hints" )
	
	local linebreak = vgui.Create( "DLabel" )
	linebreak:SetText( "" )
	linebreak:SetColor( Color(0, 0, 0) )
	
	Panel:AddItem(linebreak)
	
	Panel:CheckBox( "View KillMoves in Thirdperson", "bsmod_killmove_thirdperson" )
	Panel:NumSlider( "Cam Distance", "bsmod_killmove_thirdperson_distance", 0, 250 )
	Panel:NumSlider( "Cam Pitch", "bsmod_killmove_thirdperson_pitch", -89, 89 )
	Panel:NumSlider( "Cam Yaw", "bsmod_killmove_thirdperson_yaw", -180, 180 )
	Panel:CheckBox( "Random Yaw", "bsmod_killmove_thirdperson_randomyaw" )
	Panel:NumSlider( "Cam Offset Up/Down", "bsmod_killmove_thirdperson_offsetup", -100, 100 )
	Panel:NumSlider( "Cam Offset Left/Right", "bsmod_killmove_thirdperson_offsetright", -100, 100 )
	
	--I wish I was able to add this but gmod limitations don't let me change convars in code
	--Panel:Button( "Reset Camera Settings", "bsmod_reset_camerasettings" )
end

local function BSModAdminOptions(Panel)
	Panel:ClearControls()
	
	Panel:CheckBox( "Enable Kick", "bsmod_kick_enabled" )
	
	Panel:NumSlider( "Kick Delay", "bsmod_kick_delay", 0, 5 )
	
	Panel:NumSlider( "Minimum Kick Damage", "bsmod_kick_damage_min", 1, 500, 0 )
	Panel:NumSlider( "Maximum Kick Damage", "bsmod_kick_damage_max", 1, 500, 0 )
	
	Panel:CheckBox( "Players can be KillMoved", "bsmod_killmove_enable_players" )
	Panel:CheckBox( "NPCs can be KillMoved", "bsmod_killmove_enable_npcs" )
	Panel:CheckBox( "Team Members can be KillMoved", "bsmod_killmove_enable_teammates" )
	Panel:CheckBox( "KillMovable NPCs can't move", "bsmod_killmove_stun_npcs" )
	
	Panel:CheckBox( "Enable KillMoving at any time", "bsmod_killmove_anytime" )
	Panel:CheckBox( "Enable KillMoving at any time from behind", "bsmod_killmove_anytime_behind" )
	
	Panel:CheckBox( "Disable Default KillMoves", "bsmod_killmove_disable_defaults" )
	
	Panel:CheckBox( "Only player damage can make targets killmovable", "bsmod_killmove_player_damage_only" )
	Panel:NumSlider( "Killmovable chance denominator", "bsmod_killmove_chance", 1, 100, 0 )
	
	local labela = vgui.Create( "DLabel" )
	--label:SetSize( 0, 20 )
	labela:SetText( "^ The higher the number, the lower the chance." )
	labela:SetColor( Color(47, 149, 241) )
	
	Panel:AddItem(labela)
	
	Panel:NumSlider( "Minimum HP for KillMoves", "bsmod_killmove_minhealth", 1, 75, 0 )
	Panel:NumSlider( "Target KillMove glow time", "bsmod_killmove_time", 0, 20 )
	
	local label = vgui.Create( "DLabel" )
	--label:SetSize( 0, 20 )
	label:SetText( "^ Set to 0 for infinite glow time." )
	label:SetColor( Color(47, 149, 241) )
	
	Panel:AddItem(label)
	
	Panel:CheckBox( "Spawn a Health Vial after KillMoving", "bsmod_killmove_spawn_healthvial" )
	Panel:CheckBox( "Spawn a Health Kit after KillMoving", "bsmod_killmove_spawn_healthkit" )
	
	local linebreak = vgui.Create( "DLabel" )
	linebreak:SetText( "" )
	linebreak:SetColor( Color(0, 0, 0) )
	
	Panel:AddItem(linebreak)
	
	Panel:CheckBox( "Enable Punch Effect", "bsmod_punch_effect" )
	
	Panel:NumSlider( "Minimum Punch Damage", "bsmod_punch_damage_min", 1, 500, 0 )	
	Panel:NumSlider( "Maximum Punch Damage", "bsmod_punch_damage_max", 1, 500, 0 )	
	
	Panel:NumSlider( "Blocking resistance percent", "bsmod_punch_blocking_resistance", 1, 100, 0 )
	
	local label2 = vgui.Create( "DLabel" )
	--label2:SetSize( 0, 20 )
	label2:SetText( "^ Percent of damage to resist by blocking." )
	label2:SetColor( Color(47, 149, 241) )
	
	Panel:AddItem(label2)
end

local function BSModPopulateToolMenu()
	spawnmenu.AddToolMenuOption("Options", "BSMod", "BSModUserOptions", "User Options", "", "", BSModUserOptions)
	spawnmenu.AddToolMenuOption("Options", "BSMod", "BSModAdminOptions", "Admin Options", "", "", BSModAdminOptions)
end
hook.Remove("PopulateToolMenu", "BSModPopulateToolMenu", BSModPopulateToolMenu)