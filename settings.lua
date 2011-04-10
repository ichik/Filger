
Filger_Settings = {
	border_size = "2",
	iconoffset = "1",
	bartex = "Interface\\AddOns\\Filger\\Textures\\statusbar",
	main_font = "Interface\\AddOns\\Filger\\Textures\\font.ttf",
	main_font_size = "12",
	main_font_style = "Outline",
	bcolor = {3,.3,.3,1},
	classcolor = false,
	barcolor = {1, .25, .35, 1},
	configmode = false,
	baricon = true,
}

Filger_Spells = {	
		
		["PALADIN"] = {		
			{
				Name = "TARGET",
				Direction = "RIGHT",
				Interval = 3,
				Mode = "ICON",
				setPoint = { "CENTER", "UIParent", "CENTER", 0, 100 },
				
				-- Lichborne
				{ spellID = 49039, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Divine Plea
				{ spellID = 54428, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Hand of Protection
				{ spellID = 1022, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Pain Suppression
				{ spellID = 33206, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Divine Shield
				{ spellID = 642, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Shield Wall
				{ spellID = 871, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Icebound Fortitude
				{ spellID = 48792, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Barkskin
				{ spellID = 22812, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Dispersion
				{ spellID = 47585, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Ice Block
				{ spellID = 45438, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Divine Protection
				{ spellID = 498, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Recklesness
				{ spellID = 1719, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Avenging Wrath
				{ spellID = 31884, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Berserk
				{ spellID = 50334, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Master Aura
				{ spellID = 31821, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Deterrence
				{ spellID = 19263, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Strength of Soul
				{ spellID = 96267, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Hand of Sacrifice
				{ spellID = 6940, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- The Beast Within
				{ spellID = 34471, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Evasion
				{ spellID = 5277, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
				-- Unholy Frenzy
				{ spellID = 49016, size = 48, scale = 1, filter = "BUFF", unitId = "target", },
			},
			{
				Name = "FOCUS",
				Direction = "RIGHT",
				Interval = 3,
				Mode = "ICON",
				setPoint = { "CENTER", "UIParent", "CENTER", 300, 100 },
								
				-- Unholy Frenzy
				{ spellID = 49016, size = 48, scale = 1, filter = "BUFF", unitId = "focus", },
				-- Icebound Fortitude
				{ spellID = 48792, size = 48, scale = 1, filter = "BUFF", unitId = "focus", },
			},
		},

}