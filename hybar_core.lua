local addon_name, addon_data = ...
local L = addon_data.localization_table

addon_data.core = {}

addon_data.core.core_frame = CreateFrame("Frame", addon_name .. "CoreFrame", UIParent)
addon_data.core.core_frame:RegisterEvent("ADDON_LOADED")

local version = "v1.0.0-alpha"

local load_message = {}

load_message[1] = L["hybar"]
load_message[2] = "  @hyb-devs"
load_message[3] = "   " .. version .. " | " .. L["config"]

addon_data.core.default_settings = {
	welcome_message = true,
    is_enabled = true
}

local function LoadAllSettings()
    addon_data.core.LoadSettings()
    addon_data.bar.LoadSettings()
end

addon_data.core.RestoreAllDefaults = function()
    addon_data.core.RestoreDefaults()
    addon_data.bar.RestoreDefaults()
end

local function InitializeAllVisuals()
    addon_data.bar.InitializeVisuals()
    addon_data.config.InitializeVisuals()
end

addon_data.core.UpdateAllVisualsOnSettingsChange = function()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.core.LoadSettings = function()
    if not hybar_core_settings then
        hybar_core_settings = {}
    end

    for setting, value in pairs(addon_data.core.default_settings) do
        if hybar_core_settings[setting] == nil then
            hybar_core_settings[setting] = value
        end
    end
end

addon_data.core.RestoreDefaults = function()
    for setting, value in pairs(addon_data.core.default_settings) do
        hybar_core_settings[setting] = value
    end
end

local function CoreFrame_OnUpdate(self, elapsed)
    addon_data.bar.OnUpdate(elapsed)
end

local function OnAddonLoaded(self)
    addon_data.core.core_frame:SetScript("OnUpdate", CoreFrame_OnUpdate)

    LoadAllSettings()
    InitializeAllVisuals()

    if hybar_core_settings.welcome_message then
        for _, line in ipairs(load_message) do
		    addon_data.utils.PrintMsg(line)
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

-- slash cmds
SLASH_HYB_CONFIG1 = "/hellyeahbar"
SLASH_HYB_CONFIG2 = "/hybar"
SLASH_HYB_CONFIG3 = "/hyb"
SlashCmdList["HYB_CONFIG"] = function(option)
    InterfaceOptionsFrame_OpenToCategory("hybar")
    InterfaceOptionsFrame_OpenToCategory("hybar")
end

-- setup core
addon_data.core.core_frame:SetScript("OnEvent", CoreFrame_OnEvent)
