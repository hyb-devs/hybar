local _hybName, _hyb = ...
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
    if not _hybar_char.is_locked then
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

bar.InitializeVisuals = function()
    local BUTTON_SIZE = 32
    local PADDING = 2
    local NUM_BUTTONS = 2
    local BUTTON_SPACING = 2.2

    _hyb.bar.frame = CreateFrame("Frame", _hybName .. "barFrame", UIParent, "SecureHandlerStateTemplate")
    local frame = _hyb.bar.frame

    frame.background = frame:CreateTexture("BACKGROUND")
    frame.background:SetAllPoints(true)
    frame.background:SetColorTexture(0, 0, 0, 0.8)

    frame.buttons = {}

    for i = 1, 2 do
        local button = CreateFrame("Button", "$parentButton" .. i, frame, "SecureActionButtonTemplate, ActionButtonTemplate")
        
        button.icon = _G[button:GetName() .. "Icon"]
        button.icon:SetTexture(L["icon" .. tostring(i)])
        button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        
        -- button:SetSize(settings.height, settings.height)
        -- button:SetPoint("LEFT", frame, "LEFT", settings.padding + ((i-1) * (settings.button_size + settings.button_spacing)), 0)

        button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
        button:SetPoint("LEFT", frame, "LEFT", PADDING + ((i-1) * (BUTTON_SIZE + BUTTON_SPACING)), 0)

        button:SetAttribute("type", "macro")
        button:SetAttribute("macrotext", L["tooltip" .. tostring(i)] .. " ".. L["hyb" .. tostring(i)])
        button:SetNormalTexture(0)

        button:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L["tooltip" .. tostring(i)], 1, 1, 1)
            local fontName, fontHeight, fontFlags = GameTooltipTextLeft1:GetFont()
            GameTooltipTextLeft1:SetFont(fontName, 12, fontFlags)
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        button:GetHighlightTexture():SetTexture(nil)
        button:GetPushedTexture():SetTexture(nil)

        frame.buttons[i] = button
    end

    -- Resize the frame to fit the new button sizes
    local totalWidth = (BUTTON_SIZE * NUM_BUTTONS) + (BUTTON_SPACING * (NUM_BUTTONS - 1)) + (PADDING * 2)
    local totalHeight = BUTTON_SIZE + (PADDING * 2)
    
    frame:SetSize(totalWidth, totalHeight)

    frame:SetMovable(true)
    frame:EnableMouse(not settings.is_locked)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", _hyb.bar.OnFrameDragStart)
    frame:SetScript("OnDragStop", _hyb.bar.OnFrameDragStop)
    frame:SetClampedToScreen(true)

    -- Show it off
    _hyb.bar.UpdateVisualsOnSettingsChange()
    _hyb.bar.UpdateVisualsOnUpdate()
    
    frame:Show()
end

_hyb.bar = bar