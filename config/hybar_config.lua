local _, _hyb = ...
local L, config, core, util  = _hyb.locales, _hyb.config or {}, _hyb.core, _hyb.util

local padding = 16
local f = CreateFrame("Frame", L["ns"] .. "_CONFIG_FRAME", UIParent)

config.OnFrameDragStart = function()
    f:StartMoving()
end

config.OnFrameDragStop = function()
    f:StopMovingOrSizing()
end

config.UpdateConfigValues = function()
    local panel = _hyb.config.config_frame
    local settings = _hybar_char
    local settings_core = _hybar_core

    panel.is_enabled_checkbox:SetChecked(settings_core.is_enabled)
    panel.is_locked_checkbox:SetChecked(settings.is_locked)
	panel.welcome_checkbox:SetChecked(settings_core.welcome_message)
end

config.IsEnabledCheckBoxOnClick = function(self)
    _hybar_core.is_enabled = self:GetChecked()
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end

config.IsLockedCheckBoxOnClick = function(self)
    _hybar_char.is_locked = self:GetChecked()
    _hyb.bar.frame:EnableMouse(not _hybar_char.is_locked)
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end

config.WelcomeCheckBoxOnClick = function(self)
	_hybar_core.welcome_message = self:GetChecked()
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end


-- HYBAR_CONFIG_FRAME
f:SetPoint("CENTER")
f:SetSize(500,500)
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", config.OnFrameDragStart)
f:SetScript("OnDragStop", config.OnFrameDragStop)
f:SetClampedToScreen(true)


local fbg = f:CreateTexture(nil, "BACKGROUND")
fbg:SetAllPoints()
fbg:SetColorTexture(0, 0, 0, 0.5)


-- HYBAR_CONFIG_PANEL
local panel = CreateFrame("Frame", L["ns"] .. "_CONFIG_PANEL", f)
panel:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding)
panel:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- title text
local titleText = util.TextFactory(panel, L["hybar"], 10)
titleText:SetPoint("TOP", panel)


-- options panel
