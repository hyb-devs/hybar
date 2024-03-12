local _, _hyb = ...
local L, config, util  = _hyb.locales, _hyb.config, _hyb.util

local padding = 16
local f = CreateFrame("Frame", L["ns"] .. "_CONFIG_FRAME", UIParent)


-- HYBAR_CONFIG_FRAME
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
local panel = CreateFrame("Frame", L["ns"] .. "_CONFIG_PANEL", f)
panel:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding)
panel:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- title text
local titleText = util.Text(panel, L["hybar"], "SystemFont_Huge1")
titleText:SetPoint("TOP", panel)


-- options
