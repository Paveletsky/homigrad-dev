include("shared.lua")

surface.CreateFont("HomigradFont",{
	font = "Roboto",
	size = 18,
	weight = 1100,
	outline = false
})

surface.CreateFont("HomigradFontBig",{
	font = "Roboto",
	size = 25,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("HomigradFontLarge",{
	font = "Roboto",
	size = ScreenScale(30),
	weight = 1100,
	outline = false
})

surface.CreateFont("HomigradFontSmall",{
	font = "Roboto",
	size = ScreenScale(10),
	weight = 1100,
	outline = false
})

net.Receive("round_active",function(len)
	roundActive = net.ReadBool()
	roundTimeStart = net.ReadFloat()
	roundTime = net.ReadFloat()
end)

local view = {}

hook.Add("PreCalcView","spectate",function(lply,pos,ang,fov,znear,zfar)
	lply = LocalPlayer()
	if lply:Alive() or GetViewEntity() ~= lply then return end

	view.fov = CameraSetFOV

	local spec = lply:GetNWEntity("HeSpectateOn")
	if not IsValid(spec) then
		view.origin = lply:EyePos()
		view.angles = ang

		return view
	end

	spec = IsValid(spec:GetNWEntity("Ragdoll")) and spec:GetNWEntity("Ragdoll") or spec

	local dir = Vector(1,0,0)
	dir:Rotate(ang)
	local tr = {}

	-- local head = spec:LookupBone("ValveBiped.Bip01_Head1")
	-- tr.start = head and  or spec:EyePos()
	-- tr.endpos = tr.start - dir
	-- tr.filter = {lply,spec,lply:GetVehicle()}
	local head = spec:LookupBone("ValveBiped.Bip01_Head1")
	local matrix = spec:GetBoneMatrix(head)
	local eye = spec:GetAttachment(spec:LookupAttachment("eyes"))
	local pos = matrix:GetTranslation()
	local ang =  eye.Ang

	-- att.Pos = (eye and bodypos + bodyang:Up() * 0 + bodyang:Forward() * 10 + bodyang:Right() * -8) or lply:EyePos()
	pos = (eye and pos + ang:Up() * 7 + ang:Forward() * 12)
	

	pos.x = pos.x + 0
	pos.y = pos.y + 0
	pos.z = pos.z + 0



	-- ang.x = ang.x + -90
	-- ang.y = ang.y + 0
	-- ang.z = ang.z + -100

	view.origin = pos
	view.angles = ang

	return view
end)
local huy = math.random(1,10)
local triangle = {
	{ x = 1770, y =	150 },
	{ x = 1820, y = 50 },
	{ x = 1870, y = 150 }
}

local tab = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0.1,
	[ "$pp_colour_brightness" ] = -0.05,
	[ "$pp_colour_contrast" ] = 1.5,
	[ "$pp_colour_colour" ] = 0.3,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0.5
}

local tab2 = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

local mat = Material("pp/texturize/plain.png")

local blurMat2, Dynamic2 = Material("pp/blurscreen"), 0

local function BlurScreen(den,alp)
	local layers, density, alpha = 1, den, alph
	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetMaterial(blurMat2)
	local FrameRate, Num, Dark = 1 / FrameTime(), 3, 150

	for i = 1, Num do
		blurMat2:SetFloat("$blur", (i / layers) * density * Dynamic2)
		blurMat2:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end

	Dynamic2 = math.Clamp(Dynamic2 + (1 / FrameRate) * 7, 0, 1)
end
local addmat_r = Material("CA/add_r")
local addmat_g = Material("CA/add_g")
local addmat_b = Material("CA/add_b")
local vgbm = Material("vgui/black")

local function DrawCA(rx, gx, bx, ry, gy, by)
    render.UpdateScreenEffectTexture()
    addmat_r:SetTexture("$basetexture", render.GetScreenEffectTexture())
    addmat_g:SetTexture("$basetexture", render.GetScreenEffectTexture())
    addmat_b:SetTexture("$basetexture", render.GetScreenEffectTexture())
    render.SetMaterial(vgbm)
    render.DrawScreenQuad()
    render.SetMaterial(addmat_r)
    render.DrawScreenQuadEx(-rx / 2, -ry / 2, ScrW() + rx, ScrH() + ry)
    render.SetMaterial(addmat_g)
    render.DrawScreenQuadEx(-gx / 2, -gy / 2, ScrW() + gx, ScrH() + gy)
    render.SetMaterial(addmat_b)
    render.DrawScreenQuadEx(-bx / 2, -by / 2, ScrW() + bx, ScrH() + by)
end
hook.Add("RenderScreenspaceEffects","SpecGoPro_Aga_Da",function()
	if not LocalPlayer():Alive() then
		local splitTbl = string.Split(util.DateStamp()," ")
		local date,time = splitTbl[1],splitTbl[2]
		time = string.Replace(time,"-",":")

		-- draw.Text( {
		-- 	text = date.." "..time.." -0400",
		-- 	font = "BodyCamFont",
		-- 	pos = { ScrW() - 650, 50 }
		-- } )
		-- draw.Text( {
		-- 	text = "GoPro "..huy.." XG8A754GH",
		-- 	font = "BodyCamFont",
		-- 	pos = { ScrW() - 650, 100 }
		-- } )

		surface.SetDrawColor( 255, 255, 0, 255 )
		draw.NoTexture()
		surface.DrawPoly(triangle)

		-- DrawBloom( 0.5, 1, 9, 9, 1, 1.2, 0.8, 0.8, 1.2 )
		--DrawTexturize(1,mat)
		-- DrawSharpen( 1, 1.2 )
		-- DrawColorModify(tab)
		-- BlurScreen(0.3,55)
		-- LocalPlayer():SetDSP(55,true)
		-- DrawMotionBlur(0.2,0.3,0.001)
		--DrawToyTown(1,ScrH() / 2)
		local k3 = 6
		DrawCA(4 * k3, 2 * k3, 0, 2 * k3, 1 * k3, 0)
	end

	if not LocalPlayer():Alive() then
		LocalPlayer():SetDSP(1)
	end

	if LocalPlayer():Alive() then
		tab2["$pp_colour_colour"] = LocalPlayer():Health() / 150
		DrawColorModify(tab2)
	end

	if !LocalPlayer():Alive() and timer.Exists("DeathCam") then
		DrawMotionBlur(0.5,0.3,0.02)
		DrawSharpen( 1, 0.2 )
		local k3 = 15
		DrawCA(4 * k3, 2 * k3, 0, 2 * k3, 1 * k3, 0)
		tab2["$pp_colour_colour"] = 0.2
		tab2[ "$pp_colour_mulb" ] = 0.5
		DrawColorModify(tab2)
		BlurScreen(1,155)
		draw.Text( {
			text = deathtext,
			font = "BodyCamFont",
			pos = { ScrW()/2, ScrH()/1.2 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,35,35,220)
		} )
		LocalPlayer():SetDSP(15)
	elseif not LocalPlayer():Alive() then
		LocalPlayer():SetDSP(1)
	end

end)


SpectateHideNick = SpectateHideNick or false

local keyOld,keyOld2
local lply
flashlight = flashlight or nil
flashlightOn = flashlightOn or false

local gradient_d = Material("vgui/gradient-d")

hook.Add("HUDPaint","spectate",function()
	local lply = LocalPlayer()
	
	local spec = lply:GetNWEntity("HeSpectateOn")

	if lply:Alive() then
		if IsValid(flashlight) then
			flashlight:Remove()
			flashlight = nil
		end
	end

	local result = lply:PlayerClassEvent("CanUseSpectateHUD")
	if result == false then return end



	if
		(((not lply:Alive() or lply:Team() == 1002 or spec and lply:GetObserverMode() != OBS_MODE_NONE) or lply:GetMoveType() == MOVETYPE_NOCLIP)
		and not lply:InVehicle()) or result or hook.Run("CanUseSpectateHUD")
	then
		local ent = spec

		if IsValid(ent) then
			surface.SetFont("HomigradFont")
			local tw = surface.GetTextSize(ent:GetName())
			draw.SimpleText(ent:GetName(),"HomigradFont",ScrW() / 2 - tw / 2,ScrH() - 100,TEXT_ALING_CENTER,TEXT_ALING_CENTER)
			tw = surface.GetTextSize("Здоровье: " .. ent:Health())
			draw.SimpleText("Здоровье: " .. ent:Health(),"HomigradFont",ScrW() / 2 - tw / 2,ScrH() - 75,TEXT_ALING_CENTER,TEXT_ALING_CENTER)

			local func = TableRound().HUDPaint_Spectate
			if func then func(ent) end
		end

		local key = lply:KeyDown(IN_WALK)
		if keyOld ~= key and key then
			SpectateHideNick = not SpectateHideNick

			--chat.AddText("Ники игроков: " .. tostring(not SpectateHideNick))
		end
		keyOld = key

		draw.SimpleText("Отключение / Включение отображение ников на ALT","HomigradFont",15,ScrH() - 15,showRoundInfoColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)

		local key = input.IsButtonDown(KEY_F)
		if not lply:Alive() and keyOld2 ~= key and key then
			flashlightOn = not flashlightOn

			if flashlightOn then
				if not IsValid(flashlight) then
					flashlight = ProjectedTexture()
					flashlight:SetTexture("effects/flashlight001")
					flashlight:SetFarZ(900)
					flashlight:SetFOV(70)
					flashlight:SetEnableShadows( false )
				end
			else
				if IsValid(flashlight) then
					flashlight:Remove()
					flashlight = nil
				end
			end
		end
		keyOld2 = key

		if flashlight then
			flashlight:SetPos(EyePos())
			flashlight:SetAngles(EyeAngles())
			flashlight:Update()
		end

		if not SpectateHideNick then
			local func = TableRound().HUDPaint_ESP
			if func then func() end

			for _, v in ipairs(player.GetAll()) do --ESP
				if !v:Alive() or v == ent then continue end

				local ent = IsValid(v:GetNWEntity("Ragdoll")) and v:GetNWEntity("Ragdoll") or v
				local screenPosition = ent:GetPos():ToScreen()
				local x, y = screenPosition.x, screenPosition.y
				local teamColor = v:GetPlayerColor():ToColor()
				local distance = lply:GetPos():Distance(v:GetPos())
				local factor = 1 - math.Clamp(distance / 1024, 0, 1)
				local size = math.max(10, 32 * factor)
				local alpha = math.max(255 * factor, 80)

				local text = v:Name()
				surface.SetFont("Trebuchet18")
				local tw, th = surface.GetTextSize(text)

				surface.SetDrawColor(teamColor.r, teamColor.g, teamColor.b, alpha * 0.5)
				surface.SetMaterial(gradient_d)
				surface.DrawTexturedRect(x - size / 2 - tw / 2, y - th / 2, size + tw, th)

				surface.SetTextColor(255, 255, 255, alpha)
				surface.SetTextPos(x - tw / 2, y - th / 2)
				surface.DrawText(text)

				local barWidth = math.Clamp((v:Health() / 150) * (size + tw), 0, size + tw)
				local healthcolor = v:Health() / 150 * 255

				surface.SetDrawColor(255, healthcolor, healthcolor, alpha)
				surface.DrawRect(x - barWidth / 2, y + th / 1.5, barWidth, ScreenScale(1))
			end
		end
	end
end)

hook.Add("HUDDrawTargetID","no",function() return false end)

local laserweps = {
	["weapon_xm1014"] = true,
	["weapon_mp40"] = true,
	["weapon_m249"] = true,
	["weapon_fiveseven"] = true,
	["weapon_hk_usp"] = true,
	["weapon_mk18"] = true,
	["weapon_fiveseven"] = true,
	["weapon_hk_usps"] = true,
	["weapon_m4a1"] = true,
	["weapon_ar15"] = true,
	["weapon_m3super"] = true,
	["weapon_mp7"] = true,
	["weapon_p220"] = true,
	["weapon_galil"] = true,
	["weapon_deagle"] = true,
	["weapon_beanbag"] = true,
	["weapon_glock"] = true
}

lasertec_da = true

local mat = Material("sprites/bluelaser1")
local mat2 = Material("Sprites/light_glow02_add_noz")
hook.Add("PostDrawOpaqueRenderables", "laser22811375", function()
	if not lasertec_da then return end
	for i,ply in pairs(player.GetAll()) do
		
		if not IsValid(LocalPlayer()) then return end
		
		local wep = LocalPlayer():GetActiveWeapon()
		if wep.Base != "salat_base" then return end
		
		-- if true then
			
			local att = wep:GetAttachment(wep:LookupAttachment("muzzle"))
			
			if att==nil then continue end
			
			local pos = att.Pos
			local ang = att.Ang

			local t = {}

			t.start = pos+ang:Right()*2+ang:Forward()*-5
			
			t.endpos = t.start + ang:Forward()*3000 +ang:Right()*35 +ang:Up()*20
			
			t.filter = {LocalPlayer(),wep,LocalPlayer()}
			t.mask = MASK_SOLID
			local tr = util.TraceLine(t)

			local angle = (tr.StartPos - tr.HitPos):Angle()
			
			cam.Start3D(EyePos(),EyeAngles())
			render.SetMaterial(mat)
			
			render.DrawBeam(tr.StartPos, tr.HitPos, 0.3, 0, 15.5, Color(0,47,255,113))
			
			local Size = 16
			render.SetMaterial(mat2)
			local tra = util.TraceLine({
				start = tr.HitPos - (tr.HitPos - EyePos()):GetNormalized(),
				endpos = EyePos(),
				filter = {LocalPlayer(),wep,ply:GetNWEntity("Ragdoll")},
				-- mask = MASK_SHOT
			})

			if not tra.Hit then
				render.DrawSprite(tr.HitPos, Size, Size,Color(0,47,255))
			end
			-- render.DrawQuadEasy(tr.HitPos, (tr.StartPos - tr.HitPos):GetNormal(), Size, Size, Color(255,0,0), 0)

			cam.End3D()
		-- end
	end
	
end)

local function ToggleMenu(toggle)
    if toggle then
        local w,h = ScrW(), ScrH()
        if IsValid(wepMenu) then wepMenu:Remove() end
        local lply = LocalPlayer()
        local wep = lply:GetActiveWeapon()
        if !IsValid(wep) then return end
        wepMenu = vgui.Create("DMenu")
        wepMenu:SetPos(w/3,h/2)
        wepMenu:MakePopup()
        wepMenu:SetKeyboardInputEnabled(false)
		if wep:GetClass()!="weapon_hands" then
			wepMenu:AddOption("Выкинуть",function()
				LocalPlayer():ConCommand("say *drop")
			end)
		end
        if wep:Clip1()>0 then
            wepMenu:AddOption("Разрядить",function()
                net.Start("Unload")
                net.WriteEntity(wep)
                net.SendToServer()
            end)
        end
		if wep.Base == "salat_base" then
            wepMenu:AddOption("Вкл/Выкл Лазер",function()
                lasertec_da = not lasertec_da
            end)
        end

		plyMenu = vgui.Create("DMenu")
        plyMenu:SetPos(w/1.7,h/2)
        plyMenu:MakePopup()
        plyMenu:SetKeyboardInputEnabled(false)

		plyMenu:AddOption("Меню Брони",function()
            LocalPlayer():ConCommand("jmod_ez_inv")
        end)
		plyMenu:AddOption("Меню Патрон",function()
			LocalPlayer():ConCommand("hg_ammomenu")
		end)
		local EZarmor = LocalPlayer().EZarmor
		if JMod.GetItemInSlot(EZarmor, "eyes") then
			plyMenu:AddOption("Активировать Маску/Забрало",function()
				LocalPlayer():ConCommand("jmod_ez_toggleeyes")
			end)
		end
    else
		if IsValid(wepMenu) then
        	wepMenu:Remove()
		end
		if IsValid(plyMenu) then
        	plyMenu:Remove()
		end
    end
end

local active,oldValue
hook.Add("Think","Thinkhuyhuy",function()
	active = input.IsKeyDown(KEY_C)
	if oldValue ~= active then
		oldValue = active
		
		if active then
			ToggleMenu(true)
		else
			ToggleMenu(false)
		end
	end
end)

net.Receive("lasertgg",function(len)
	local ply = net.ReadEntity()
	local boolen = net.ReadBool()
	if boolen then
		laserplayers[ply:EntIndex()] = ply
	else
		laserplayers[ply:EntIndex()] = nil
	end
	ply.Laser = boolen
end)

hook.Add("OnEntityCreated", "homigrad-colorragdolls", function(ent)
	if ent:IsRagdoll() then
		timer.Create("ragdollcolors-timer" .. tostring(ent), 0.1, 0, function()
			--ent.ply = ent.ply or RagdollOwner(ent)
			--local ply = ent.ply
			--if IsValid(ply) then
			if IsValid(ent) then
				ent.playerColor = ent:GetNWVector("plycolor")
				--print(ent.ply,ent.playerColor)
				ent.GetPlayerColor = function()
					return ent.playerColor
				end
				timer.Remove("ragdollcolors-timer" .. tostring(ent))
			end
		end)
	end
end)

local function GetClipForCurrentWeapon( ply )
	if ( !IsValid( ply ) ) then return -1 end

	local wep = ply:GetActiveWeapon()
	if ( !IsValid( wep ) ) then return -1 end

	return wep:Clip1(), wep:GetMaxClip1(), ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
end

hook.Add("HUDShouldDraw","HideHUD_ammo",function(name)
    if name == "CHudAmmo" then return false end
end)

local clipcolor = color_white
local clipcolorlow = Color(247, 178, 40, 255)
local clipcolorempty = Color(247, 40, 40, 255)
local colorgray = Color(200, 200, 200)
local shadow = color_black

--[[hook.Add("HUDPaint","homigrad-fancyammo",function()
	--[[local ply = LocalPlayer()
	local clip, maxclip, ammo = GetClipForCurrentWeapon(ply)
	local clipstring = tostring(clip)
	local sw, sh = ScrW(), ScrH()
	if clip != -1 and maxclip > 0 then
		if oldclip != clip then
			randomx = math.random(0, 10)
			randomy = math.random(0, 10)
			timer.Simple(0.15, function()
				oldclip = clip
			end)
		else
			randomx = 0
			randomy = 0
		end

		if clip == 0 then
			clipcolor = clipcolorempty
		elseif maxclip / clip >= 6 or clip == 1 and maxclip != 1 then
			clipcolor = clipcolorlow
		else
			clipcolor = color_white
		end

		draw.SimpleText("/ " .. ammo, "HomigradFontSmall", sw * 0.9 + 2 + #clipstring * sw * 0.02, sh * 0.97 + 2, shadow)
		draw.SimpleText("/ " .. ammo, "HomigradFontSmall", sw * 0.9 + #clipstring * sw * 0.02, sh * 0.97, colorgray)

		draw.SimpleText(clip, "HomigradFontLarge", sw * 0.89 + 5 + randomx, sh * 0.92 + 5 + randomy, shadow)
		draw.SimpleText(clip, "HomigradFontLarge", sw * 0.89 + randomx, sh * 0.92 + randomy, clipcolor)
	end
end)
]]
net.Receive("remove_jmod_effects",function(len)
	LocalPlayer().EZvisionBlur = 0
	LocalPlayer().EZflashbanged = 0
end)

local meta = FindMetaTable("Player")

function meta:HasGodMode() return self:GetNWBool("HasGodMode") end

concommand.Add("hg_getentity",function()
	local ent = LocalPlayer():GetEyeTrace().Entity
	print(ent)
	if not IsValid(ent) then return end
	print(ent:GetModel())
	print(ent:GetClass())
end)

gameevent.Listen("player_spawn")
hook.Add("player_spawn","gg",function(data)
	local ply = Player(data.userid)

	if ply.SetHull then
		ply:SetHull(ply:GetNWVector("HullMin"),ply:GetNWVector("Hull"))
		ply:SetHullDuck(ply:GetNWVector("HullMin"),ply:GetNWVector("HullDuck"))
	end

	hook.Run("Player Spawn",ply)
end)

hook.Add("DrawDeathNotice","no",function() return false end)


local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()

	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 8, 0, 0, 0 )
	self.LabelName:SetTextColor( color_white )

	self.Color = color_transparent

	self:SetSize( 250, 22 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( TOP )

end

function PANEL:Setup( ply )

	self.ply = ply
	self.LabelName:SetText( ply:Nick() )
	-- self.Avatar:SetPlayer( ply )
	
	self.Color = team.GetColor( ply:Team() )
	
	self:InvalidateLayout()

end

function PANEL:Paint( w, h )

	if ( !IsValid( self.ply ) ) then return end
	draw.RoundedBox( 4, 0, 0, w, h, Color( 0, self.ply:VoiceVolume() * 255, 0, 125 ) )

end

function PANEL:Think()
	
	if ( IsValid( self.ply ) ) then
		self.LabelName:SetText( self.ply:Nick() )
	end

	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end

end

function PANEL:FadeOut( anim, delta, data )
	
	if ( anim.Finished ) then
	
		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end
		
	return end
	
	self:SetAlpha( 255 - ( 255 * delta ) )

end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )



function GM:PlayerStartVoice( ply )

	if ( !IsValid( g_VoicePanelList ) ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl

end

local function VoiceClean()

	for k, v in pairs( PlayerVoicePanels ) do
	
		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	
	end

end
timer.Create( "VoiceClean", 10, 0, VoiceClean )

function GM:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 2 )

	end

end

local function CreateVoiceVGUI()

	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( 25, 25 )
	g_VoicePanelList:SetSize( 250, ScrH() - 200 )
	g_VoicePanelList:SetPaintBackground( false )

end
-- CreateVoiceVGUI()
hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )


