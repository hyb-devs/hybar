local _, _hyb = ...
local L, conf, util  = _hyb.locales, _hyb.conf, _hyb.util

local padding = 16

-- HYBAR_CONFIG_FRAME
local f = util.Frame("Frame", "CONFIG_FRAME", UIParent)

f:SetPoint("CENTER")
f:SetSize(500,500)
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) self:StartMoving() end)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:SetClampedToScreen(true)

-- background
local fbg = f:CreateTexture(nil, "BACKGROUND")

fbg:SetAllPoints()
fbg:SetColorTexture(0, 0, 0, 0.5)


-- HYBAR_CONFIG_PANEL
local panel = CreateFrame("Frame", L["ns"] .. "CONFIG_PANEL", f)

panel:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding)
panel:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- title text
local titleText = util.Text(panel, L["hybar"], "SystemFont_Huge1")

titleText:SetPoint("TOP", panel)


-- options frame
local optionsFrame = util.Frame("Frame", "OPTIONS_FRAME", f)

optionsFrame:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding * 5)
optionsFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)

-- options text
local optionsText = util.Text(optionsFrame, "Options", "SystemFont_Med1")

optionsText:SetPoint("TOPLEFT", optionsFrame)

-- options
local cbEnabled = util.Checkbox(optionsFrame, "ENABLED", 0, -padding, L["USER_ENABLED"])

cbEnabled.tooltip = "HYB"
cbEnabled:SetScript("OnClick", conf.IsEnabledCheckBoxOnClick)
