local _, _hyb = ...
local conf = _hyb.conf or {}

local defaults = {
    enabled = true,
    locked = false,
    welcomeMsg = true,
    point = "CENTER",
	rel_point = "CENTER",
	x_offset = 0,
	y_offset = -200,
}


conf.SetUserConf = function()
    local userConf = conf.user or {}
    for k, v in pairs(defaults) do
        if userConf[k] == nil then
            userConf[k] = v
        end
    end

    return userConf
end


conf.UpdateConfVal = function(k, v) conf.user[k] = v end


function conf:IsEnabledCheckBoxOnClick()
    conf.user.enabled = self:GetChecked()
    -- print(_hyb.conf.user.enabled)
    if conf.user.enabled then
        _G["HYBAR_BAR_FRAME"]:Show()
    else
        _G["HYBAR_BAR_FRAME"]:Hide()
    end
end


function conf:IsLockedCheckBoxOnClick()
    conf.user.locked = self:GetChecked()
end


function conf:WelcomeCheckBoxOnClick()
	conf.user.welcomeMsg = self:GetChecked()
end

conf.user = conf.SetUserConf()

_hyb.conf = conf