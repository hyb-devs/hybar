print("START CONF LOAD")
local _, _hyb = ...


local function SetupConf()

    local conf = {}

    local defaults = {
        enabled = true,
        locked = false,
        welcomeMsg = true,
        point = "CENTER",
        rel_point = "CENTER",
        x_offset = 0,
        y_offset = -200,
    }

    function conf.SetUser()
        _hybar_user = _hybar_user or {}
        local user = _hybar_user
        for k, v in pairs(defaults) do
            if user[k] == nil then
                user[k] = v
            end
        end
        _hybar_user = user
    end


    conf.UpdateConfVal = function(k, v) conf.user[k] = v end


    function conf:IsEnabledCheckBoxOnClick()
        _hybar_user.enabled = self:GetChecked()
        if _hybar_user.enabled then
            _G["HYBAR_BAR_FRAME"]:Show()
        else
            _G["HYBAR_BAR_FRAME"]:Hide()
        end
    end


    function conf:IsLockedCheckBoxOnClick()
        _hybar_user.locked = self:GetChecked()
    end


    function conf:WelcomeCheckBoxOnClick()
        _hybar_user.welcomeMsg = self:GetChecked()
    end


    function conf:SetConf()
        _hyb.conf = conf
    end

    return conf
end

if not _hyb.conf then
    _hyb.conf = SetupConf()
end

print('END CONF LOAD')