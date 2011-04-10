--[[
	
	Filger
	Copyright (c) 2009, Nils Ruesch
	All rights reserved.
	
]]

local f_s = Filger_Settings;

local class = select(2, UnitClass("player"));
local classcolor = RAID_CLASS_COLORS[class];
local active, bars = {}, {};

local SetBD = function(parent, backdrop, color, strata)
	local bd = CreateFrame("Frame", nil, parent)
	bd:SetPoint("TOPLEFT", parent , "TOPLEFT", -f_s.border_size, f_s.border_size)
	bd:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", f_s.border_size, -f_s.border_size)
	local s = strata or "background"
	bd:SetFrameStrata(s)
	bd:SetBackdrop(backdrop)
	bd:SetBackdropColor(.1,.1,.1,1)
    bd:SetBackdropBorderColor(.3,.3,.3,1)
	return bd
end

local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/GetCVar("uiScale")
local function scale(x) return mult*math.floor(x+.5) end
local backdrop = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		tile = false, tileSize = 0, edgeSize = scale(2), 
		insets = { left = -scale(2), right = -scale(2), top = -scale(2), bottom = -scale(2)}
    }


--local minuten = string.format("|cff%02x%02x%02m|r", classcolor.r*255, classcolor.g*255, classcolor.b*255);
--local sekunden = string.format("|cff%02x%02x%02s|r", classcolor.r*255, classcolor.g*255, classcolor.b*255);

local MyUnits = {
    player = true,
    vehicle = true,
    pet = true,
}
local time, Update;
local function OnUpdate(self, elapsed)
	time = self.filter == "CD" and self.expirationTime+self.duration-GetTime() or self.expirationTime-GetTime();
	if ( self:GetParent().Mode == "BAR" ) then
		self.statusbar:SetValue(time);
	--	self.time:SetFormattedText(SecondsToTimeAbbrev(time));
		if time <= 60 and time >= 3 then
			self.time:SetFormattedText("%.1f",(time));
			self.time:SetTextColor(0.84, 0.75, 0.65)	
		elseif time <= 3 then
			self.time:SetFormattedText("%.1f",(time));
			self.time:SetTextColor(1, 0, 0)
		else
			--self.time:SetFormattedText("%d:%.1d",(time/60),(time/4));
			self.time:SetFormattedText(SecondsToTimeAbbrev(time));
			self.time:SetTextColor(0.84, 0.75, 0.65)
		end

	elseif ( self:GetParent().Mode == "ICON" ) then
		self.time:SetText(time);
		--self.time:SetFormattedText(SecondsToTimeAbbrev(time));
		if time <= 60 and time >= 3 then
			self.time:SetFormattedText("%.1f",(time));
			self.time:SetTextColor(0.84, 0.75, 0.65)	
		elseif time <= 3 then
			self.time:SetFormattedText("%.1f",(time));
			self.time:SetTextColor(1, 0, 0)
		else
			self.time:SetFormattedText("%dm",(time/60));
			self.time:SetTextColor(0.84, 0.75, 0.65)
		end

	end
	if ( time < 0 and self.filter == "CD") then
		local id = self:GetParent().Id;
		for index, value in ipairs(active[id]) do
			local spn = GetSpellInfo( value.data.spellID or value.data.slotID )
			if ( self.spellName == spn) then
				tremove(active[id], index);
				break;
			end
		end
		self:SetScript("OnUpdate", nil);
		Update(self:GetParent());
	end
end

function Update(self)
	local id = self.Id;
	if ( not bars[id] ) then
		bars[id] = {};
	end
	for index, value in ipairs(bars[id]) do
		value:Hide();
	end
	local bar;
	for index, value in ipairs(active[id]) do
		bar = bars[id][index];
		if ( not bar ) then
			bar = CreateFrame("Frame", "FilgerAnker"..id.."Frame"..index, self);
			if ( self.Mode == "ICON" ) then
				bar:SetWidth(value.data.size);
			else
				bar:SetWidth(value.data.barWidth);
			end
			bar:SetHeight(value.data.size);
			bar:SetScale(1);
			bar:SetFrameStrata("BACKGROUND")
			if ( index == 1 ) then
				if ( f_s.configmode ) then
					bar:SetFrameStrata("BACKGROUND");
				end
				bar:SetPoint(unpack(self.setPoint));
			else
				if ( self.Direction == "UP" ) then
					bar:SetPoint("BOTTOM", bars[id][index-1], "TOP", 0, self.Interval+(f_s.border_size*2));
				elseif ( self.Direction == "RIGHT" ) then
					bar:SetPoint("LEFT", bars[id][index-1], "RIGHT", self.Mode == "ICON" and self.Interval+(f_s.border_size*2), 0);
				elseif ( self.Direction == "LEFT" ) then
					bar:SetPoint("RIGHT", bars[id][index-1], "LEFT", self.Mode == "ICON" and -(self.Interval+(f_s.border_size*2)), 0);
				else
					bar:SetPoint("TOP", bars[id][index-1], "BOTTOM", 0, -(self.Interval+(f_s.border_size*2)));
				end
			end
			if ( self.Mode == "ICON" ) then			
				bar.bd = SetBD(bar, backdrop, f_s.bcolor);
				bar.button = CreateFrame('Frame', nil, bar)
				bar.button:SetHeight(value.data.size)
				bar.button:SetWidth(value.data.size)
				bar.button:SetPoint('LEFT', bar, 'LEFT', 0, 0)

				bar.icon = bar.button:CreateTexture("$parentIcon", "OVERLAY");
				bar.icon:SetAllPoints(bar.button)
				bar.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

				bar.time = bar.button:CreateFontString(nil, "OVERLAY");
				bar.time:SetFont(f_s.main_font, f_s.main_font_size, f_s.main_font_style);
			--	bar.time:SetAllPoints(bar.button)
				bar.time:SetPoint("BOTTOM", bar.button, "BOTTOM",0, -2);
				bar.time:SetJustifyH("LEFT");


				bar.count = bar.button:CreateFontString(nil, "OVERLAY");
				bar.count:SetFont(f_s.main_font, f_s.main_font_size, f_s.main_font_style);
				bar.count:SetPoint("BOTTOMRIGHT", 5, -5);
				bar.count:SetJustifyH("RIGHT");
				
				bar.cooldown = CreateFrame("Cooldown", nil, bar, "CooldownFrameTemplate");
				bar.cooldown:SetAllPoints();
				bar.cooldown:SetReverse();
				bar.cooldown.noOCC = true
				bar.cooldown.noCooldownCount = true

			else

				if (f_s.baricon == true) then
					bar.button = CreateFrame('Frame', nil, bar)
					bar.button:SetHeight(value.data.size)
					bar.button:SetWidth(value.data.size)
					bar.button:SetPoint('LEFT', bar, 'LEFT', f_s.border_size, 0)
					bar.button.bd = SetBD(bar.button, backdrop, f_s.bcolor);

					bar.icon = bar.button.bd:CreateTexture(nil, "ARTWORK");
					bar.icon:SetAllPoints(bar.button)
					bar.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);

					bar.count = bar.button:CreateFontString(nil, "ARTWORK");
					bar.count:SetFont(f_s.main_font, f_s.main_font_size, f_s.main_font_style);
					bar.count:SetPoint("CENTER", 0, 0);
					bar.count:SetJustifyH("RIGHT");
				end

				bar.statusbar = CreateFrame("StatusBar", nil, bar);
				if ( f_s.configmode ) then
					bar.statusbar:SetFrameStrata("BACKGROUND");
				end

				bar.statusbar:SetHeight(value.data.size);
				bar.statusbar:SetFrameStrata("LOW");
				bar.statusbar:SetStatusBarTexture(f_s.bartex);
				bar.statusbar:GetStatusBarTexture():SetHorizTile(false)
				if (f_s.classcolor == true) then
					bar.statusbar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1);
				else
					bar.statusbar:SetStatusBarColor(unpack(f_s.barcolor));
				end
				if (f_s.baricon == true) then
					bar.statusbar:SetPoint("LEFT", bar.button, "RIGHT", (f_s.border_size*2)+f_s.iconoffset, 0);
					bar.statusbar:SetPoint("RIGHT", bar, "RIGHT", -f_s.border_size, 0);
				else
					bar.statusbar:SetPoint("LEFT", bar, "LEFT", f_s.border_size, 0);
					bar.statusbar:SetPoint("RIGHT", bar, "RIGHT", -f_s.border_size, 0);
				end
				bar.statusbar:SetMinMaxValues(0, 1);
				bar.statusbar:SetValue(0);
				bar.statusbar.bd = SetBD(bar.statusbar, backdrop, f_s.bcolor);
				
				bar.time = bar.statusbar:CreateFontString(nil, "ARTWORK");
				bar.time:SetFont(f_s.main_font, f_s.main_font_size, f_s.main_font_style);
--				bar.time:SetPoint("BOTTOMRIGHT", bar.statusbar, "TOPRIGHT", -2, 1);
				bar.time:SetPoint("BOTTOMRIGHT", bar.statusbar, "BOTTOMRIGHT", -2, 1);
				
				bar.spellname = bar.statusbar:CreateFontString(nil, "ARTWORK");
				bar.spellname:SetFont(f_s.main_font, f_s.main_font_size, f_s.main_font_style);
--				bar.spellname:SetPoint("BOTTOMLEFT", bar.statusbar, "TOPLEFT", 5, 1);
				bar.spellname:SetPoint("BOTTOMLEFT", bar.statusbar, "BOTTOMLEFT", 5, 1);
				bar.spellname:SetPoint("RIGHT", bar.time, "LEFT");
				bar.spellname:SetJustifyH("LEFT");
			end
			
			tinsert(bars[id], bar);
		end
		
		bar.spellName = GetSpellInfo( value.data.spellID or value.data.slotID );
		if (f_s.baricon == true or  self.Mode == "ICON" ) then
			bar.icon:SetTexture(value.icon);
			bar.count:SetText(value.count > 1 and value.count or "");
		end
		if ( self.Mode == "BAR" ) then
			bar.spellname:SetText(value.data.displayName or GetSpellInfo( value.data.spellID ));
		end
		if ( value.duration > 0 ) then
			if ( self.Mode == "ICON" ) then
				CooldownFrame_SetTimer(bar.cooldown, value.data.filter == "CD" and value.expirationTime or value.expirationTime-value.duration, value.duration, 1);
					bar.expirationTime = value.expirationTime;
					bar.duration = value.duration;
					bar.filter = value.data.filter;
					bar:SetScript("OnUpdate", OnUpdate);
			else
				bar.statusbar:SetMinMaxValues(0, value.duration);
				bar.expirationTime = value.expirationTime;
				bar.duration = value.duration;
				bar.filter = value.data.filter;
				bar:SetScript("OnUpdate", OnUpdate);
			end
		else
			if ( self.Mode == "ICON" ) then
				bar.cooldown:Hide();
			else
				bar.statusbar:SetMinMaxValues(0, 1);
				bar.statusbar:SetValue(1);
				bar.time:SetText("");
				bar:SetScript("OnUpdate", nil);
			end
		end
		
		bar:Show();
	end
end

local function OnEvent(self, event, ...)
	local unit = ...;
	if ( ( unit == "target" or unit == "player" ) or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_COOLDOWN" ) then
		local data, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, start, enabled, slotLink, spn;
		local id = self.Id;
		for i=1, #Filger_Spells[class][id], 1 do
			data = Filger_Spells[class][id][i];
			if ( data.filter == "BUFF" ) then
				spn = GetSpellInfo( data.spellID )
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff(data.unitId, spn);
			elseif ( data.filter == "DEBUFF" ) then
				spn = GetSpellInfo( data.spellID )
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(data.unitId, spn);
			else
				if ( data.spellID ) then
					spn = GetSpellInfo( data.spellID )
					start, duration, enabled = GetSpellCooldown( spn );
					_,_,icon = GetSpellInfo( data.spellID );
				else
					slotLink = GetInventoryItemLink("player", data.slotID);
					if ( slotLink ) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink);
						if ( not data.displayName ) then
							data.displayName = name;
						end
						start, duration, enabled = GetInventoryItemCooldown("player", data.slotID);
					end
				end
				count = 0;
				caster = "all";
			end
			if ( not active[id] ) then
				active[id] = {};
			end
			for index, value in ipairs(active[id]) do
				if ( data.spellID == value.data.spellID ) then
					tremove(active[id], index);
					break;
				end
			end
			if ( ( name and ( data.caster ~= 1 and ( caster == data.caster or data.caster == "all" ) or MyUnits[caster] )) or ( ( enabled or 0 ) > 0 and ( duration or 0 ) > 1.5 ) ) then
				table.insert(active[id], { data = data, icon = icon, count = count, duration = duration, expirationTime = expirationTime or start });
			end
		end
		Update(self);
	end
end

if ( Filger_Spells and Filger_Spells[class] ) then
	for index in pairs(Filger_Spells) do
		if ( index ~= class ) then
			Filger_Spells[index] = nil;
		end
	end
	local data, frame;
	for i=1, #Filger_Spells[class], 1 do
		data = Filger_Spells[class][i];
		
		frame = CreateFrame("Frame", "FilgerAnker"..i, UIParent);
		frame.Id = i;
		frame.Name = data.Name;
		frame.Direction = data.Direction or "DOWN";
		frame.Interval = data.Interval or 3;
		frame.Mode = data.Mode or "ICON";
		frame.setPoint = data.setPoint or "CENTER";
		frame:SetWidth(Filger_Spells[class][i][1] and Filger_Spells[class][i][1].size or 100);
		frame:SetHeight(Filger_Spells[class][i][1] and Filger_Spells[class][i][1].size or 20);
		frame:SetPoint(unpack(data.setPoint));

		if ( f_s.configmode ) then
			for j=1, #Filger_Spells[class][i], 1 do
				data = Filger_Spells[class][i][j];
				if ( not active[i] ) then
					active[i] = {};
				end
				if ( data.spellID ) then
					_,_,spellIcon = GetSpellInfo(data.spellID)
				else
					slotLink = GetInventoryItemLink("player", data.slotID);
					if ( slotLink ) then
						name, _, _, _, _, _, _, _, _, spellIcon = GetItemInfo(slotLink);
					end
				end
				table.insert(active[i], { data = data, icon = spellIcon, count = 9, duration = 0, expirationTime = 0 });
			end
			Update(frame);
		else
			for j=1, #Filger_Spells[class][i], 1 do
				data = Filger_Spells[class][i][j];
				if ( data.filter == "CD" ) then
					frame:RegisterEvent("SPELL_UPDATE_COOLDOWN");
					break;
				end
			end
			frame:RegisterEvent("UNIT_AURA");
			frame:RegisterEvent("PLAYER_TARGET_CHANGED");
			frame:RegisterEvent("PLAYER_ENTERING_WORLD");
			frame:SetScript("OnEvent", OnEvent);
		end
	end
end