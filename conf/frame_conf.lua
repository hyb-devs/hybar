local _, _hyb = ...
local L, conf, util  = _hyb.locales, _hyb.conf, _hyb.util

local padding = 16

-- HYBAR_CONFIG_FRAME
local f = util.Frame("Frame", "CONFIG_FRAME", UIParent)

f:SetPoint("CENTER")
f:SetSize(300,230)
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) self:StartMoving() end)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:SetClampedToScreen(true)

table.insert(UISpecialFrames, "HYBAR_CONFIG_FRAME")

-- background
local fbg = f:CreateTexture(nil, "BACKGROUND")

fbg:SetAllPoints()
fbg:SetColorTexture(0, 0, 0, 0.8)


-- HYBAR_CONFIG_PANEL
local panel = CreateFrame("Frame", L["ns"] .. "CONFIG_PANEL", f)

panel:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding)
panel:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- title text
local titleText = util.Text(panel, "|cFF00FFFF" .. L["hybar"] .. "|r", "SystemFont_Huge1")

titleText:SetPoint("TOP", panel)

local footerText = util.Text(panel, "|cFF00FFFF" .. L["VERSION"] .. "|r" .." | " .. L["GITHUB_URL"], "SystemFont_Tiny")
footerText:SetPoint("BOTTOM", panel)

-- hr
local hr = panel:CreateLine()
hr:SetThickness(0.5)
hr:SetColorTexture(1, 1, 1, 0.5)
hr:SetStartPoint("TOPLEFT", panel, 0, -padding * 4 - 2)
hr:SetEndPoint("TOPRIGHT", panel, 0, -padding * 4 - 2)

-- options frame
local optionsFrame = util.Frame("Frame", "OPTIONS_FRAME", f)

optionsFrame:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding * 4)
optionsFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)

-- options text
local optionsText = util.Text(optionsFrame, "Options", "SystemFont_Med1")

optionsText:SetPoint("TOPLEFT", optionsFrame)


-- options

-- enabled
local cbEnabled = util.Checkbox(optionsFrame, "ENABLED", 0, -padding - 6, L["USER_ENABLED"])

cbEnabled.tooltip = L["USER_ENABLED_TOOLTIP"] 
cbEnabled:SetScript("OnClick", conf.EnabledCheckBoxOnClick)

-- locked
local cbLocked = util.Checkbox(optionsFrame, "LOCKED", 0, -padding * 3 - 6, L["USER_LOCKED"])

cbLocked.tooltip = L["USER_LOCKED_TOOLTIP"]
cbLocked:SetScript("OnClick", conf.LockedCheckBoxOnClick)

-- welcomeMsg
local cbWelcome = util.Checkbox(optionsFrame, "WELCOME_MSG", 0, -padding * 5 - 6, L["USER_WELCOME_MSG"])

cbWelcome.tooltip = L["USER_WELCOME_MSG_TOOLTIP"]
cbWelcome:SetScript("OnClick", conf.WelcomeCheckBoxOnClick)
