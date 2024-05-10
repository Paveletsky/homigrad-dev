hook.Add('Think', 'bkInitSkin', function()
	hook.Remove('Think', 'bkInitSkin')

	local surface = surface
	local Color = Color
	
	local SKIN = {}
	SKIN.PrintName = 'Homigrad'
	SKIN.Author = 'alex@oldhomigrad.ru'
	
	SKIN.fontFrame = 'Trebuchet24'
	SKIN.fontTab = 'Trebuchet24'
	SKIN.fontCategoryHeader = 'Trebuchet24'
	
	SKIN.GwenTexture = Material('gwenskin/GModDefault.png')
	SKIN.Shadow = GWEN.CreateTextureBorder(448, 0, 31, 31, 8, 8, 8, 8)
	
	SKIN.bg_color					= Color(101, 100, 105, 255)
	SKIN.bg_color_sleep				= Color(70, 70, 70, 255)
	SKIN.bg_color_dark				= Color(55, 57, 61, 255)
	SKIN.bg_color_bright			= Color(220, 220, 220, 255)
	SKIN.frame_border				= Color(50, 50, 50, 255)
	
	SKIN.control_color				= Color(120, 120, 120, 255)
	SKIN.control_color_highlight	= Color(150, 150, 150, 255)
	SKIN.control_color_active		= Color(110, 150, 250, 255)
	SKIN.control_color_bright		= Color(255, 200, 100, 255)
	SKIN.control_color_dark			= Color(100, 100, 100, 255)
	
	SKIN.bg_alt1					= Color(50, 50, 50, 255)
	SKIN.bg_alt2					= Color(55, 55, 55, 255)
	
	SKIN.listview_hover				= Color(70, 70, 70, 255)
	SKIN.listview_selected			= Color(100, 170, 220, 255)
	SKIN.combobox_selected			= SKIN.listview_selected
	
	SKIN.text_bright				= Color(255, 255, 255, 255)
	SKIN.text_normal				= Color(180, 180, 180, 255)
	SKIN.text_dark					= Color(255, 255, 255, 255)
	SKIN.text_highlight				= Color(255, 20, 20, 255)
	
	SKIN.panel_transback			= Color(255, 255, 255, 50)
	SKIN.tooltip					= Color(255, 245, 175, 255)
	SKIN.colPropertySheet			= Color(170, 170, 170, 255)
	
	SKIN.colTab						= SKIN.colPropertySheet
	SKIN.colTabInactive				= Color(140, 140, 140, 255)
	SKIN.colTabShadow				= Color(255, 255, 255, 170)
	-- SKIN.colTabText					= Color(255, 255, 255, 255)
	SKIN.colTabTextInactive			= Color(255, 255, 255, 200)
	
	SKIN.colCollapsibleCategory		= Color(255, 255, 255, 20)
	
	SKIN.colCategoryText			= Color(255, 255, 255, 255)
	SKIN.colCategoryTextInactive	= Color(200, 200, 200, 255)
	
	SKIN.colNumberWangBG			= Color( 255, 240, 150, 255 )
	SKIN.colTextEntryBG				= Color( 240, 240, 240, 255 )
	SKIN.colTextEntryBorder			= Color( 255, 255, 255)
	SKIN.colTextEntryText			= Color( 251, 251, 251)
	SKIN.colTextEntryTextHighlight	= Color( 20, 200, 250, 255 )
	SKIN.colTextEntryTextCursor		= Color( 0, 0, 100, 255 )
	SKIN.colTextEntryTextPlaceholder= Color( 128, 128, 128, 255 )
	
	SKIN.colMenuBG					= Color( 255, 255, 255, 200 )
	SKIN.colMenuBorder				= Color( 0, 0, 0, 200 )
	
	SKIN.colButtonText				= Color(255, 255, 255, 255)
	SKIN.colButtonTextDisabled		= Color(255, 255, 255, 55)
	SKIN.colButtonBorder			= Color(20, 20, 20, 255)
	SKIN.colButtonBorderHighlight	= Color(255, 255, 255, 50)
	SKIN.colButtonBorderShadow		= Color(0, 0, 0, 100)
	
	SKIN.Colours = {}
	
	SKIN.Colours.Button = {}
	SKIN.Colours.Button.Disabled = Color(0,0,0,100)
	SKIN.Colours.Button.Down = Color(180,180,180,255)
	SKIN.Colours.Button.Hover = Color(255,255,255,255)
	SKIN.Colours.Button.Normal = Color(255,255,255,255)
	
	SKIN.Colours.Category = {}
	SKIN.Colours.Category.Header = Color(255,255,255,255)
	SKIN.Colours.Category.Header_Closed = Color(255,255,255,150)
	SKIN.Colours.Category.Line = {}
	SKIN.Colours.Category.Line.Button = Color(255,255,255,0)
	SKIN.Colours.Category.Line.Button_Hover = Color(0,0,0,8)
	SKIN.Colours.Category.Line.Button_Selected = Color(255,216,0,255)
	SKIN.Colours.Category.Line.Text = Color(200,200,200,255)
	SKIN.Colours.Category.Line.Text_Hover = Color(255,255,255,255)
	SKIN.Colours.Category.Line.Text_Selected = Color(255,255,255,255)
	SKIN.Colours.Category.LineAlt = {}
	SKIN.Colours.Category.LineAlt.Button = Color(0,0,0,26)
	SKIN.Colours.Category.LineAlt.Button_Hover = Color(0,0,0,32)
	SKIN.Colours.Category.LineAlt.Button_Selected = Color(255,216,0,255)
	SKIN.Colours.Category.LineAlt.Text = Color(200,200,200,255)
	SKIN.Colours.Category.LineAlt.Text_Hover = Color(255,255,255,255)
	SKIN.Colours.Category.LineAlt.Text_Selected = Color(255,255,255,255)
	
	SKIN.Colours.Label = {}
	SKIN.Colours.Label.Bright = Color(255,255,255,255)
	SKIN.Colours.Label.Dark = Color(255,255,255,255)
	SKIN.Colours.Label.Default = Color(255,255,255,255)
	SKIN.Colours.Label.Highlight = Color(255,0,0,255)
	
	SKIN.Colours.Properties = {}
	SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 )
	SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 )
	SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 )
	SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 )
	SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 )
	SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 )
	SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 )
	SKIN.Colours.Properties.Column_Disabled		= Color( 240, 240, 240 )
	SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 )
	SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 )
	SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 )
	SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 )
	SKIN.Colours.Properties.Label_Disabled		= GWEN.TextureColor( 4 + 8 * 16, 508 )
	
	SKIN.Colours.Tab = {}
	SKIN.Colours.Tab.Active = {}
	SKIN.Colours.Tab.Active.Disabled = Color(233,233,233,204)
	SKIN.Colours.Tab.Active.Down = Color(255,255,255,255)
	SKIN.Colours.Tab.Active.Hover = Color(255,255,255,255)
	SKIN.Colours.Tab.Active.Normal = Color(255,255,255,255)
	SKIN.Colours.Tab.Inactive = {}
	SKIN.Colours.Tab.Inactive.Disabled = Color(210,210,210,204)
	SKIN.Colours.Tab.Inactive.Down = Color(255,255,255,255)
	SKIN.Colours.Tab.Inactive.Hover = Color(249,249,249,153)
	SKIN.Colours.Tab.Inactive.Normal = Color(255,255,255,102)
	
	SKIN.Colours.TooltipText = Color(255,255,255,255)
	
	SKIN.Colours.Tree = {}
	SKIN.Colours.Tree.Hover	= Color( 255, 255, 255 )
	SKIN.Colours.Tree.Normal = color_white
	SKIN.Colours.Tree.Lines = Color(155, 50, 0, 255)
	SKIN.Colours.Tree.Selected = color_white
	
	SKIN.Colours.Window = {}
	SKIN.Colours.Window.TitleActive = Color(255,255,255,204)
	SKIN.Colours.Window.TitleInactive = Color(255,255,255,92)
	
	SKIN.Colours.Label = {}
	SKIN.Colours.Label.Default			= Color(255,255,255,204)
	SKIN.Colours.Label.Bright			= Color(255,255,255,255)
	SKIN.Colours.Label.Dark				= Color(255,255,255,144)
	SKIN.Colours.Label.Highlight		= Color(255,255,255,204)
	
	SKIN.Colours.TooltipText = Color(255,255,255,255)
	
	local gradient = surface.GetTextureID("vgui/gradient-d")
	local gradientUp = surface.GetTextureID("vgui/gradient-u")
	local gradientLeft = surface.GetTextureID("vgui/gradient-l")
	
	function SKIN:PaintFrame(pnl, w, h)
		local triangle = {
			{ x = 3, y = h },
			{ x = 3, y = 0 },
			{ x = w - 3, y = 0 },

			{ x = w - 3, y = h },
		}

		-- draw.NoTexture()

		-- m = Matrix()
		-- m:Translate(Vector(0, 0, 0))
		-- m:SetUp(Vector(0, -5, 0))

		-- cam.PushModelMatrix(m)
		-- 	surface.SetDrawColor(127, 61, 155)
		-- 	surface.DrawRect(0, 0, w, h)
		
		-- 	surface.SetDrawColor(ColorAlpha(Color(29, 119, 236), 155))
		-- 	surface.SetTexture(gradientUp)
		-- 	surface.DrawTexturedRect(0, 0, w, h)
		-- cam.PopModelMatrix()

		-- m = Matrix()
		-- local center = Vector( w / 2, h / 2 )
		-- m:Translate(Vector(w*.01-25, -30, 0))
		-- m:SetScale(Vector(1.02, 1.02, 1))

		-- cam.PushModelMatrix(m)
		-- 	local mat = Material( 'sbox/vgui/dframe_top.png', 'smooth' )

		-- 	-- surface.SetMaterial( mat )
		-- 	-- surface.SetDrawColor(Color(255, 255, 255))
		-- 	-- surface.DrawTexturedRect( 0, 0, w, 50 )
		-- cam.PopModelMatrix()
		draw.RoundedBox(5, 0, 0, w, h, Color(41, 41, 41))
		draw.RoundedBoxEx(5, 0, 0, w, 3, Color(77, 77, 77, 220), true, true, true, true)
	end
	
	
	function SKIN:PaintButton(pnl, w, h)
		if not pnl.m_bBackground then return end

		local off = h > 20 and 2 or 1

		draw.RoundedBox(3, 0, 1, w, h - off, Color(65, 65, 65))

		if self.Disabled then
			draw.RoundedBox(2, 0, 1, w, h, Color(0,0,0, 255))
		elseif self.Hovered then
			draw.RoundedBox(2, 0, 1, w, h - off, Color(4, 5, 5))
		end

		-- pnl:SetFontInternal( "Trebuchet24" )
	end
	
	
	function SKIN:PaintListView( pnl, w, h )
	
		if not pnl.m_bBackground then return end
		draw.RoundedBox(4, 0, 0, w, h, Color( 35, 35, 35))

		pnl:SetFontInternal( "fdShopFontRegular" )
	end
	
	function SKIN:PaintListViewLine( pnl, w, h )
	
		if ( pnl:IsSelected() ) then
			draw.RoundedBox(3, 0, 0, w, h, Color(65, 65, 65, 120))
		elseif ( pnl.Hovered ) then
			draw.RoundedBox(4, 0, 0, w, h, Color(250,0,0,1))
		elseif ( pnl.m_bAlt ) then
			draw.RoundedBox(4, 0, 0, w, h, Color(0,0,0, 70))
		end

		-- pnl:SetFont( "fdShopFontRegular" )
	end

	
	surface.CreateFont('ico', {
		font = 'Calibri',
		extended = true,
		size = 30,
		weight = 400,
	})
	
	function SKIN:PaintSliderKnob( pnl, w, h )
	
		if pnl:GetDisabled() then
			return draw.SimpleText('|', 'ico', w/2, h/2, Color(235, 130, 19, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif pnl.Depressed or pnl.Hovered then
			return draw.SimpleText('|', 'ico', w/2, h/2, Color(255, 255, 255, 215), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText('|', 'ico', w/2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	
	end
	
	function SKIN:PaintNumSlider( panel, w, h )
	
		draw.RoundedBox(10, 0, 15, w, h / 6, Color( 47, 47, 47, 200))
	
	end
	
	function SKIN:PaintCategoryButton( panel, w, h )
	
		if ( panel.AltLine ) then
	
			if ( panel.Depressed or panel.m_bSelected ) then draw.RoundedBox(4, 0, 0, w, h, Color(28, 28, 28))
			elseif ( panel.Hovered ) then draw.RoundedBox(4, 0, 0, w, h, Color(27, 27, 27))
			else draw.RoundedBox(4, 0, 0, w, h, Color(255,255,255, 1)) end
	
		else
	
			if ( panel.Depressed or panel.m_bSelected ) then draw.RoundedBox(1, 0, 0, w, h, Color(31, 31, 31))
			elseif ( panel.Hovered ) then draw.RoundedBox(4, 0, 0, w, h, Color(39, 39, 39))
			end
	
		end
	
	end
	
	
	function SKIN:PaintWindowCloseButton(pnl, w, h)
	
		if pnl.Disabled then return end
		
		draw.Text({
			text = '×',
			font = 'fdShopFontBig',
			pos = {10, 10},
			yalign = TEXT_ALIGN_CENTER
		})
	end
	
	function SKIN:PaintWindowMaximizeButton( pnl, w, h )
	end
	
	function SKIN:PaintWindowMinimizeButton( pnl, w, h )
	end
	
	function SKIN:PaintPanel(pnl, w, h)
	
		if not pnl.m_bBackground then return end
		
		draw.RoundedBox(5, 0, 0, w, h, Color( 25, 25, 25, 255))
	end
	
	function SKIN:PaintPropertySheet(pnl, w, h)
	
		draw.RoundedBox(2, 0, 2, w, h-2, Color( 35, 35, 35))
		draw.RoundedBoxEx(2, 0, 2, w, 30, Color(28, 28, 28, 190), true, true, false, false)
	
	end
	
	function SKIN:PaintProgress(pnl, w, h)
		local y = h / 2 - 9
		draw.RoundedBox(6, 0, y, w - 4, 18, Color( 184, 53, 64, 20 ))
		local fr = pnl:GetFraction()
		if fr > 0 then
			draw.RoundedBox(6, 1, y + 1, (w-18) * fr + 12, 16, Color(250, 160, 0, 170) )
		end
		if fr > 0.70 then
			draw.RoundedBox(6, 1, y + 1, (w-18) * fr + 12, 16, Color(207, 54, 67, 240) )
		end
	end
	
	function SKIN:PaintTooltip( pnl, w, h )
	
		surface.DisableClipping(true)
	    local alpha = pnl:IsHovered() and 255 or 0 -- Определяем значение альфа-канала в зависимости от наличия наведения курсора

		draw.RoundedBox(10, -3, 0, w + 6, h, Color(69,54,54, 240))
		draw.NoTexture()
		-- surface.DrawPoly({
		-- 	{x = w/5 - 15, y = h},
		-- 	{x = w/5 + 15, y = h},
		-- 	{x = w/2, y = h + 25},
		-- })
	
		surface.DisableClipping(false)
		pnl:SetFontInternal( "fdShopFontTooltip" )	

	end
	
	
	function SKIN:PaintButtonDown( pnl, w, h )
	
		if not pnl.m_bBackground or pnl:GetDisabled() then return end
	
	
	end
	
	function SKIN:PaintButtonUp( pnl, w, h )
	
		if not pnl.m_bBackground or pnl:GetDisabled() then return end
	
	end
	
	function SKIN:PaintVScrollBar( panel, w, h )
	
		draw.RoundedBox(0, w/2-2, w-12, 6, h - w+8, Color(22,35,76,100))
	
	end
	
	function SKIN:PaintScrollBarGrip( panel, w, h )
	
		draw.RoundedBox(0, w/2-4, 0, 8, h - 10, Color( 54, 54, 54))
		draw.RoundedBox(0, w / 2-4, 5, 50, h - 10, Color( 26, 26, 26, 100))
	
		if ( panel:GetDisabled() ) then
			return draw.RoundedBox(15, w/2-4, 0, 8, h, Color( 31, 31, 31))
		end
	
		-- if ( panel.Depressed ) then
		-- 	return draw.RoundedBox(15, w/2-4, 0, 8, h, Color( 184, 53, 64 ))
		-- end
	
		-- if ( panel.Hovered ) then
		-- 	return draw.RoundedBox(15, w/2-4, 0, 8, h-5, Color( 184, 53, 64 ))
		-- end
	
	end
	
	function SKIN:PaintCategoryList( panel, w, h )
	
		-- self.tex.CategoryList.Outer( 0, 0, w, h )
		
	end
	
	function SKIN:PaintMenuSpacer( pnl, w, h )
	
		surface.SetDrawColor(Color(29, 29, 29))
		surface.DrawRect(0, 0, w, h)
	
	end
	
	function SKIN:PaintCollapsibleCategory(pnl, w, h)
	
		draw.RoundedBox(4, 0, 5, w, h, Color(37, 37, 37, 250))
		draw.RoundedBox(4, 0, 0, w, 20, Color(110, 101, 101))
		
		-- if not pnl.m_TextColorSet then
		-- 	pnl:SetTextColor(Color(255,255,255))
		-- 	pnl.m_TextColorSet = true
		-- end
		
	end
	
	function SKIN:PaintMenu( pnl, w, h )
	
		surface.DisableClipping(true)
		surface.DisableClipping(false)
	
		draw.RoundedBox(4, 0, 0, w, h, Color(50, 35, 35))
		pnl:SetFontInternal( "fdShopFontRegular" )	

	end
	
	function SKIN:PaintMenuOption( pnl, w, h )
	
		if pnl.m_bBackground and (pnl.Hovered or pnl.Highlight) then
			draw.RoundedBox(4, 0, 0, w, h, Color(0, 10, 10, 100))
		end

		if pnl:GetChecked() then
			draw.SimpleText(utf8.char(0xf00c), 'Trebuchet24', 16, h/2, Color(255,255,255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			-- draw.RoundedBox(4, 0, 0, w, h, cols.o)
		end

		if not pnl.m_TextColorSet then
			pnl:SetTextColor(Color(255,255,255))
			pnl.m_TextColorSet = true
		end

		pnl:SetTextColor(Color(250,250,250))
		pnl:SetFont( 'fdShopSemiFont' )
	
	
	end

	function SKIN:PaintMenuBar( pnl, w, h )
	
		draw.RoundedBox(0, 0, 0, w, h, Color(33, 33, 33))
	
	end
	
	function SKIN:PaintSelection( pnl, w, h )
	
		draw.RoundedBox(4, 0, 0, w, h, Color(25, 25, 25, 255))
	
	end
	
	function SKIN:PaintTextEntry(pnl, w, h)
	
		if pnl.m_bBackground then
			if pnl.PaintOffset then
				surface.DisableClipping(true)
				if pnl:GetDisabled() then
					draw.RoundedBox(5, -pnl.PaintOffset, -pnl.PaintOffset, w + pnl.PaintOffset*2, h + pnl.PaintOffset*2, Color(255,255,255, 100))
				elseif pnl:HasFocus() then
					draw.RoundedBox(5, -pnl.PaintOffset, -pnl.PaintOffset, w + pnl.PaintOffset*2, h + pnl.PaintOffset*2, cols.y)
				else
					draw.RoundedBox(5, -pnl.PaintOffset, -pnl.PaintOffset, w + pnl.PaintOffset*2, h + pnl.PaintOffset*2, color_white)
				end
				surface.DisableClipping(false)
			else
				if pnl:GetDisabled() then
					draw.RoundedBox(5, 0, 0, w, h, Color(255,255,255, 30))
				elseif pnl:HasFocus() then
					draw.RoundedBox(5, 0, 0, w, h, Color(15, 35, 55, 90))
				else
					draw.RoundedBox(5, 0, 0, w, h, Color(55, 55, 55, 155))
				end
			end
		end
	
		if (pnl.GetPlaceholderText and pnl.GetPlaceholderColor and pnl:GetPlaceholderText() and pnl:GetPlaceholderText():Trim() ~= "" and pnl:GetPlaceholderColor() and (not pnl:GetText() or pnl:GetText() == "")) then
			local oldText = pnl:GetText()
			local str = pnl:GetPlaceholderText()
			if str:StartWith("#") then str = language.GetPhrase(str:sub(2)) end
	
			pnl:SetText( str)
			pnl:DrawTextEntryText(Color( 255, 255, 255), Color( 255, 255, 255 ), Color( 255, 255, 255 ))
			pnl:SetText(oldText)
	
			return
		end
	
		pnl:DrawTextEntryText( Color( 255, 255, 255 ), pnl:GetHighlightColor(), pnl:GetCursorColor())
	
	end
	
	function SKIN:PaintTab(pnl, w, h)
	
		if pnl:IsActive() then
			draw.RoundedBoxEx(5, 0, 0, w-4, h, Color(65, 65, 65, 225), true, true, false, false)
		end

		pnl:SetFontInternal( "fdShopFontRegular" )	
	end
	
	function SKIN:PaintComboBox( pnl, w, h )
	
		if pnl:GetDisabled() then
			draw.RoundedBox(3, 0, 0, w, h, Color(255,255,255, 255))
		elseif pnl:HasFocus() then
			draw.RoundedBox(3, 0, 0, w, h, Color(171, 0, 14, 255))
		elseif pnl.Depressed or pnl:IsMenuOpen() then
			draw.RoundedBox(3, 0, 0, w, h, Color(255, 255, 255, 255))
		else
			draw.RoundedBox(3, 0, 1, w, h-2, color_white)
		end
	
		if not pnl.m_TextColorSet then
			pnl:SetTextColor(Color(30,30,30))
			pnl.m_TextColorSet = true
		end
	
	end
	
	function SKIN:PaintTree( pnl, w, h )
	
		if not pnl.m_bBackground then return end
	
		draw.RoundedBox(4, 0, 0, w, h, Color(0,0,0, 80))
	end
	
	function SKIN:PaintSelection( pnl, w, h )
	
		draw.RoundedBox(4, 0, 0, w, h, cols.o)
	
	end
	
	function SKIN:PaintTreeNodeButton( pnl, w, h )
	
		if not pnl.m_bSelected then return end
	
		local w, _ = pnl:GetTextSize()
		draw.RoundedBox(4, 38, 2, w + 6, h-3, Color(55, 115, 180, 255))
	
	end
	
	function SKIN:PaintTreeNode( pnl, w, h )
	
		if not pnl.m_bDrawLines then return end
	
		surface.SetDrawColor( self.Colours.Tree.Lines )
		if ( pnl.m_bLastChild ) then
			surface.DrawRect( 9, 0, 1, 8 )
			surface.DrawRect( 10, 7, 8, 1 )
		else
			surface.DrawRect( 9, 0, 1, h )
			surface.DrawRect( 10, 7, 8, 1 )
		end
	
	end
	
	derma.DefineSkin( "bkSkin", "Стиль", SKIN )
	
	hook.Add('ForceDermaSkin', 'bkForceSkin', function()
		return 'bkSkin'
	end)
end)