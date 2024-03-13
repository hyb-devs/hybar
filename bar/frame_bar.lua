local _, _hyb = ...
local L, util, conf, bar = _hyb.locales, _hyb.util, _hyb.conf, _hyb.bar


local BUTTON_SIZE = 32
local PADDING = 2
local NUM_BUTTONS = 2
local BUTTON_SPACING = 2.2

-- local f = CreateFrame("Frame", _hybName .. "barFrame", UIParent, "SecureHandlerStateTemplate")
local f = util.Frame("Frame", "BAR_FRAME", UIParent, "SecureHandlerStateTemplate")

local fbg = f:CreateTexture("BACKGROUND")
fbg:SetAllPoints(true)
fbg:SetColorTexture(0, 0, 0, 0.8)

local buttons = {}

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

    buttons[i] = button
end

-- Resize the frame to fit the new button sizes
local totalWidth = (BUTTON_SIZE * NUM_BUTTONS) + (BUTTON_SPACING * (NUM_BUTTONS - 1)) + (PADDING * 2)
local totalHeight = BUTTON_SIZE + (PADDING * 2)

f:SetSize(totalWidth, totalHeight)

f:SetMovable(true)
-- f:EnableMouse(not conf.user.locked)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", bar.OnFrameDragStart)
f:SetScript("OnDragStop", bar.OnFrameDragStop)
f:SetClampedToScreen(true)
