local _, _hyb = ...
local conf = _hyb.conf or {}

if _hyb.conf then return end

conf.defaults = {
    enabled = true,
    locked = false,
    welcomeMsg = true,
    point = "CENTER",
	rel_point = "CENTER",
	x_offset = 0,
	y_offset = -200,
}


conf.UpdateConfigValues = function()
    _G["HYBAR_ENABLED"]:SetChecked(settings_core.is_enabled)
    panel.is_locked_checkbox:SetChecked(settings.is_locked)
	panel.welcome_checkbox:SetChecked(settings_core.welcome_message)
end


function conf:IsEnabledCheckBoxOnClick()
    _hyb.conf.enabled = self:GetChecked()
end


function conf:IsLockedCheckBoxOnClick()
    _hyb.conf.locked = self:GetChecked()
end


function conf:WelcomeCheckBoxOnClick()
	_hyb.conf.welcomeMsg = self:GetChecked()
end


_hyb.conf = conf