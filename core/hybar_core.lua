local hybName, _hyb = ...
local L = _hyb.locales

if not _hyb.util then
    _hyb.util = _hyb.SetupUtil()
end

_hyb.core = {}

_hyb.core.core_frame = CreateFrame("Frame", hybName .. "CoreFrame", UIParent)
_hyb.core.core_frame:RegisterEvent("ADDON_LOADED")

local version = "v1.0.0-alpha"

local load_message = {}

load_message[1] = L["hybar"]
load_message[2] = "  @hyb-devs"
load_message[3] = "   " .. version .. " | " .. L["config"]

_hyb.core.default_settings = {
	welcome_message = true,
    is_enabled = true
}

local function LoadAllSettings()
    _hyb.core.LoadSettings()
    _hyb.bar.LoadSettings()
end

local function InitializeAllVisuals()
    _hyb.bar.InitializeVisuals()
    _hyb.config:InitializeVisuals()
end

_hyb.core.UpdateAllVisualsOnSettingsChange = function()
    _hyb.bar.UpdateVisualsOnSettingsChange()
end

_hyb.core.LoadSettings = function()
    if not _hybar_core then
        _hybar_core = {}
    end

    for setting, value in pairs(_hyb.core.default_settings) do
        if _hybar_core[setting] == nil then
            _hybar_core[setting] = value
        end
    end
end

_hyb.core.RestoreDefaults = function()
    for setting, value in pairs(_hyb.core.default_settings) do
        _hybar_core[setting] = value
    end
end

local function CoreFrame_OnUpdate(self, elapsed)
    _hyb.bar.OnUpdate(elapsed)
end

local function OnAddonLoaded(self)
    _hyb.core.core_frame:SetScript("OnUpdate", CoreFrame_OnUpdate)

    LoadAllSettings()
    InitializeAllVisuals()

    if _hybar_core.welcome_message then
        for _, line in ipairs(load_message) do
		    _hyb.util.PrintMsg(line)
        end
	end
end

local function CoreFrame_OnEvent(self, event, ...)
    local args = {...}
    if event == "ADDON_LOADED" then
        if args[1] == "hybar" then
            OnAddonLoaded()
        end
    end
end

-- setup core
_hyb.core.core_frame:SetScript("OnEvent", CoreFrame_OnEvent)
