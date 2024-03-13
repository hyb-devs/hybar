local _, _hyb = ...
local L, conf, bar = _hyb.locales, _hyb.conf, _hyb.bar or {}
local user = conf.user

bar.SetVisibility = function()
    print(tostring(user.enabled))
    if user.enabled then
        _G["HYBAR_BAR_FRAME"]:Show()
        _G["HYBAR_BAR_FRAME"]:ClearAllPoints()
        _G["HYBAR_BAR_FRAME"]:SetPoint(user.point, UIParent, user.rel_point, user.x_offset, user.y_offset)
    else
        _G["HYBAR_BAR_FRAME"]:Hide()
    end
end

_hyb.bar = bar