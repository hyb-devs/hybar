local _, _hyb = ...
local L, util, conf = _hyb.locales, _hyb.util, _hyb.conf
local bar = _hyb.bar or {}
local user = conf.user


local BUTTON_SIZE = 32
local PADDING = 2
local NUM_BUTTONS = 2
local BUTTON_SPACING = 2.2

local f = util.Frame("Frame", "BAR_FRAME", UIParent, "SecureHandlerStateTemplate")

local fbg = f:CreateTexture("BACKGROUND")

fbg:SetAllPoints(true)
fbg:SetColorTexture(0, 0, 0, 0.8)

for i = 1, 2 do
    local buttons = {}
    local button = CreateFrame("Button", "$parentButton" .. i, f, "SecureActionButtonTemplate, ActionButtonTemplate")
    
    button.icon = _G[button:GetName() .. "Icon"]
    button.icon:SetTexture(L["icon" .. tostring(i)])
    button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    
    button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    button:SetPoint("LEFT", f, "LEFT", PADDING + ((i-1) * (BUTTON_SIZE + BUTTON_SPACING)), 0)

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

    buttons[i] = button
end


bar.SetVisibility = function()
    if user.enabled then
        _G["HYBAR_BAR_FRAME"]:Show()
        _G["HYBAR_BAR_FRAME"]:ClearAllPoints()
        _G["HYBAR_BAR_FRAME"]:SetPoint(user.point, UIParent, user.rel_point, user.x_offset, user.y_offset)
    else
        _G["HYBAR_BAR_FRAME"]:Hide()
    end
end


local OnFrameDragStart = function()
    if not user.locked then
        f:StartMoving()
    end
end


local OnFrameDragStop = function()
    f:StopMovingOrSizing()
    point, _, rel_point, x_offset, y_offset = f:GetPoint()
    if x_offset < 20 and x_offset > -20 then
        x_offset = 0
    end
    user.point = point
    user.rel_point = rel_point
    user.x_offset = _hyb.util.SimpleRound(x_offset, 1)
    user.y_offset = _hyb.util.SimpleRound(y_offset, 1)
    bar.SetVisibility()
end


-- Resize the frame to fit the new button sizes
local totalWidth = (BUTTON_SIZE * NUM_BUTTONS) + (BUTTON_SPACING * (NUM_BUTTONS - 1)) + (PADDING * 2)
local totalHeight = BUTTON_SIZE + (PADDING * 2)

f:SetSize(totalWidth, totalHeight)

f:SetMovable(true)
f:EnableMouse(not _hyb.conf.user.locked)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", OnFrameDragStart)
f:SetScript("OnDragStop", OnFrameDragStop)
f:SetClampedToScreen(true)

_hyb.bar = bar