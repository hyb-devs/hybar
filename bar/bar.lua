local _, _hyb = ...
local L, conf, bar = _hyb.locales, _hyb.conf, _hyb.bar or {}


bar.UpdateVisualsOnSettingsChange = function()
    if conf.user.enabled then
        frame:Show()
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, UIParent, settings.rel_point, settings.x_offset, settings.y_offset)
    else
        frame:Hide()
    end
end

bar.OnFrameDragStart = function()
    if not conf.user.locked then
        _hyb.bar.frame:StartMoving()
    end
end

bar.OnFrameDragStop = function()
    local frame = _hyb.bar.frame
    local settings = _hybar_char
    frame:StopMovingOrSizing()
    point, _, rel_point, x_offset, y_offset = frame:GetPoint()
    if x_offset < 20 and x_offset > -20 then
        x_offset = 0
    end
    settings.point = point
    settings.rel_point = rel_point
    settings.x_offset = _hyb.util.SimpleRound(x_offset, 1)
    settings.y_offset = _hyb.util.SimpleRound(y_offset, 1)
    _hyb.bar.UpdateVisualsOnSettingsChange()
end

_hyb.bar = bar