local _, _hyb = ...

if _hyb.config then return end

local config = {}

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

_hyb.config = config