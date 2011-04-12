
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
				{ spellID = 49039, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Divine Plea
				{ spellID = 54428, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Hand of Protection
				{ spellID = 1022, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Pain Suppression
				{ spellID = 33206, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Divine Shield
				{ spellID = 642, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Shield Wall
				{ spellID = 871, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster = "all"},
				-- Icebound Fortitude
				{ spellID = 48792, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Barkskin
				{ spellID = 22812, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Dispersion
				{ spellID = 47585, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Ice Block
				{ spellID = 45438, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Divine Protection
				{ spellID = 498, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Recklesness
				{ spellID = 1719, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Avenging Wrath
				{ spellID = 31884, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Berserk
				{ spellID = 50334, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Master Aura
				{ spellID = 31821, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Deterrence
				{ spellID = 19263, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Strength of Soul
				{ spellID = 96267, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Hand of Sacrifice
				{ spellID = 6940, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- The Beast Within
				{ spellID = 34471, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Evasion
				{ spellID = 5277, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Unholy Frenzy
				{ spellID = 49016, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Icy Veins
				{ spellID = 12472, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Frenzy Regeneration
				{ spellID = 22842, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Anti-Magic Shell
				{ spellID = 48707, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Retaliation
				{ spellID = 20240, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Death Wish
				{ spellID = 12292, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Spell Reflection
				{ spellID = 23920, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
				-- Deadly Calm
				{ spellID = 85730, size = 48, scale = 1, filter = "BUFF", unitId = "target", caster="all"},
			},
			{
				Name = "FOCUS",
				Direction = "RIGHT",
				Interval = 3,
				Mode = "ICON",
				setPoint = { "CENTER", "UIParent", "CENTER", 300, 100 },
								
				-- Unholy Frenzy
				{ spellID = 49016, size = 48, scale = 1, filter = "BUFF", unitId = "focus", caster="all"},
				-- Icebound Fortitude
				{ spellID = 48792, size = 48, scale = 1, filter = "BUFF", unitId = "focus", caster="all"},
				-- Anti-Magic Shell
				{ spellID = 48707, size = 48, scale = 1, filter = "BUFF", unitId = "focus", caster="all"},
			},
		},

}