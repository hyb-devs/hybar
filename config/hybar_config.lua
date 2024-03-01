local _hybName, _hyb = ...
local L = _hyb.localization_table

_hyb.config = {}

_hyb.config.OnDefault = function()
    _hyb.core.RestoreAllDefaults()
    _hyb.config.UpdateConfigValues()
end

_hyb.config.InitializeVisuals = function()

    _hyb.config.config_parent_panel = CreateFrame("Frame", "hybarConfigParentPanel", UIParent)
    local panel = _hyb.config.config_parent_panel

    panel:SetSize(1, 1)
    panel.config_panel = _hyb.config.CreateConfigPanel(panel)
    panel.config_panel:SetPoint('TOPLEFT', 10, -10)
    panel.config_panel:SetSize(1, 1)

    panel.name = "hybar"
    panel.default = _hyb.config.OnDefault
    InterfaceOptions_AddCategory(panel)

end

_hyb.config.TextFactory = function(parent, text, size)
    local text_obj = parent:CreateFontString(nil, "ARTWORK")
    text_obj:SetFont("Fonts/FRIZQT__.ttf", size)
    text_obj:SetJustifyV("CENTER")
    text_obj:SetJustifyH("CENTER")
    text_obj:SetText(text)
    return text_obj
end

_hyb.config.CheckBoxFactory = function(g_name, parent, checkbtn_text, tooltip_text, on_click_func)
    local checkbox = CreateFrame("CheckButton", _hybName .. g_name, parent, "ChatConfigCheckButtonTemplate")
    getglobal(checkbox:GetName() .. 'Text'):SetText(checkbtn_text)
    checkbox.tooltip = tooltip_text
    checkbox:SetScript("OnClick", function(self)
        on_click_func(self)
    end)
    checkbox:SetScale(1.1)
    return checkbox
end

_hyb.config.EditBoxFactory = function(g_name, parent, title, w, h, enter_func)
    local edit_box_obj = CreateFrame("EditBox", _hybName .. g_name, parent, "BackdropTemplate")
    edit_box_obj.title_text = _hyb.config.TextFactory(edit_box_obj, title, 12)
    edit_box_obj.title_text:SetPoint("TOP", 0, 12)
    edit_box_obj:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 26,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4}
    })
    edit_box_obj:SetBackdropColor(0,0,0,1)
    edit_box_obj:SetSize(w, h)
    edit_box_obj:SetMultiLine(false)
    edit_box_obj:SetAutoFocus(false)
    edit_box_obj:SetMaxLetters(4)
    edit_box_obj:SetJustifyH("CENTER")
	edit_box_obj:SetJustifyV("CENTER")
    edit_box_obj:SetFontObject(GameFontNormal)
    edit_box_obj:SetScript("OnEnterPressed", function(self)
        enter_func(self)
        self:ClearFocus()
    end)
    edit_box_obj:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= "" then
            enter_func(self)
        end
    end)
    edit_box_obj:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    return edit_box_obj
end

_hyb.config.SliderFactory = function(g_name, parent, title, min_val, max_val, val_step, func)
    local slider = CreateFrame("Slider", _hybName .. g_name, parent, "OptionsSliderTemplate")
    local editbox = CreateFrame("EditBox", "$parentEditBox", slider, "InputBoxTemplate")
    slider:SetMinMaxValues(min_val, max_val)
    slider:SetValueStep(val_step)
    slider.text = _G[_hybName .. g_name .. "Text"]
    slider.text:SetText(title)
    slider.textLow = _G[_hybName .. g_name .. "Low"]
    slider.textHigh = _G[_hybName .. g_name .. "High"]
    slider.textLow:SetText(floor(min_val))
    slider.textHigh:SetText(floor(max_val))
    slider.textLow:SetTextColor(0.8,0.8,0.8)
    slider.textHigh:SetTextColor(0.8,0.8,0.8)
    slider:SetObeyStepOnDrag(true)
    editbox:SetSize(45,30)
    editbox:ClearAllPoints()
    editbox:SetPoint("LEFT", slider, "RIGHT", 15, 0)
    editbox:SetText(slider:GetValue())
    editbox:SetAutoFocus(false)
    slider:SetScript("OnValueChanged", function(self)
        editbox:SetText(tostring(_hyb.utils.SimpleRound(self:GetValue(), val_step)))
        func(self)
    end)
    editbox:SetScript("OnTextChanged", function(self)
        local val = self:GetText()
        if tonumber(val) then
            self:GetParent():SetValue(val)
        end
    end)
    editbox:SetScript("OnEnterPressed", function(self)
        local val = self:GetText()
        if tonumber(val) then
            self:GetParent():SetValue(val)
            self:ClearFocus()
        end
    end)
    slider.editbox = editbox
    return slider
end

_hyb.config.UpdateConfigValues = function()
    local panel = _hyb.config.config_frame
    local settings = hybar_bar_settings
    local settings_core = hybar_core_settings

    panel.is_enabled_checkbox:SetChecked(settings_core.is_enabled)
    panel.is_locked_checkbox:SetChecked(settings.is_locked)
	panel.welcome_checkbox:SetChecked(settings_core.welcome_message)
end

_hyb.config.IsEnabledCheckBoxOnClick = function(self)
    hybar_core_settings.is_enabled = self:GetChecked()
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end

_hyb.config.IsLockedCheckBoxOnClick = function(self)
    hybar_bar_settings.is_locked = self:GetChecked()
    _hyb.bar.frame:EnableMouse(not hybar_bar_settings.is_locked)
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end

_hyb.config.WelcomeCheckBoxOnClick = function(self)
	hybar_core_settings.welcome_message = self:GetChecked()
    _hyb.core.UpdateAllVisualsOnSettingsChange()
end

_hyb.config.CreateConfigPanel = function(parent_panel)
    _hyb.config.config_frame = CreateFrame("Frame", _hybName .. "GlobalConfigPanel", parent_panel)
    local panel = _hyb.config.config_frame

    -- Title Text
    panel.title_text = _hyb.config.TextFactory(panel, L["Settings"], 20)
    panel.title_text:SetPoint("TOPLEFT", 0, 0)
    panel.title_text:SetTextColor(1, 0.9, 0, 1)
    
    -- Enabled
    panel.is_enabled_checkbox = _hyb.config.CheckBoxFactory(
        "IsEnabledCheckBox",
        panel,
        L["Enabled"],
        L["Uncheck to disable"],
        _hyb.config.IsEnabledCheckBoxOnClick)
    panel.is_enabled_checkbox:SetPoint("TOPLEFT", 0, -30)

    -- Locked
    panel.is_locked_checkbox = _hyb.config.CheckBoxFactory(
        "IsLockedCheckBox",
        panel,
        L["Lock Bar"],
        L["Prevents bar from being dragged"],
        _hyb.config.IsLockedCheckBoxOnClick)
    panel.is_locked_checkbox:SetPoint("TOPLEFT", 0, -60)

	-- Welcome
    panel.welcome_checkbox = _hyb.config.CheckBoxFactory(
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
