local _, _hyb = ...

if not _hyb.conf then _hyb.conf = {} end

local defaults = {
    enabled = true,
    locked = false,
    welcomeMsg = true,
    point = "CENTER",
	rel_point = "CENTER",
	x_offset = 0,
	y_offset = -200,
}


local SetUserConf = function()
    local userConf = _hyb.conf.user or {}
    for k, v in pairs(defaults) do
        if userConf[k] == nil then
            userConf[k] = v
        end
    end

    return userConf
end


_hyb.conf.UpdateConfVal = function(k, v) _hyb.conf.user[k] = v end


function _hyb.conf:IsEnabledCheckBoxOnClick()
    _hyb.conf.user.enabled = self:GetChecked()
end


function _hyb.conf:IsLockedCheckBoxOnClick()
    _hyb.conf.user.locked = self:GetChecked()
end


function _hyb.conf:WelcomeCheckBoxOnClick()
	_hyb.conf.user.welcomeMsg = self:GetChecked()
end

_hyb.conf.user = SetUserConf()