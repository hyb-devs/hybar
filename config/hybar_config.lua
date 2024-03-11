local _hybName, _hyb = ...
local L, config, core = _hyb.locales, _hyb.config or {}, _hyb.core


function config:InitializeVisuals()
    ---@type panel
    local panel = CreateFrame("Frame", _hybName .. "ConfigParentPanel", UIParent)
    print(type(panel))
    self.parent_panel = panel

    panel:SetSize(1, 1)
    panel.config_panel = self.CreateConfigPanel(panel)
    panel.config_panel:SetPoint('TOPLEFT', 10, -10)
    panel.config_panel:SetSize(1, 1)

    panel.name = "hybar"
    panel.default = _hyb.config.OnDefault
    InterfaceOptions_AddCategory(panel)

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

config.CreateConfigPanel = function(parent_panel)
    _hyb.config.config_frame = CreateFrame("Frame", _hybName .. "GlobalConfigPanel", parent_panel)
    local panel = _hyb.config.config_frame

    -- Title Text
    panel.title_text = _hyb.util.TextFactory(panel, L["Settings"], 20)
    panel.title_text:SetPoint("TOPLEFT", 0, 0)
    panel.title_text:SetTextColor(1, 0.9, 0, 1)
    
    -- Enabled
    panel.is_enabled_checkbox = _hyb.util.CheckBoxFactory(
        "IsEnabledCheckBox",
        panel,
        L["Enabled"],
        L["Uncheck to disable"],
        _hyb.config.IsEnabledCheckBoxOnClick)
    panel.is_enabled_checkbox:SetPoint("TOPLEFT", 0, -30)

    -- Locked
    panel.is_locked_checkbox = _hyb.util.CheckBoxFactory(
        "IsLockedCheckBox",
        panel,
        L["Lock Bar"],
        L["Prevents bar from being dragged"],
        _hyb.config.IsLockedCheckBoxOnClick)
    panel.is_locked_checkbox:SetPoint("TOPLEFT", 0, -60)

	-- Welcome
    panel.welcome_checkbox = _hyb.util.CheckBoxFactory(
        "WelcomeCheckBox",
        panel,
        L["Welcome Message"],
        L["Uncheck to disable display of the welcome message"],
        _hyb.config.WelcomeCheckBoxOnClick)
    panel.welcome_checkbox:SetPoint("TOPLEFT", 0, -90)

    -- Return the final panel
    _hyb.config.UpdateConfigValues()
    return panel
end

_hyb.config = config