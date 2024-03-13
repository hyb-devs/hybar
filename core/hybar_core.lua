local _, _hyb = ...
local L, util, conf = _hyb.locales, _hyb.util, _hyb.conf


local coreFrame = util.Frame("Frame", "CORE_FRAME", UIParent)
coreFrame:RegisterEvent("ADDON_LOADED")

local version = "v1.0.0-alpha"

local load_message = {}

load_message[1] = L["hybar"]
load_message[2] = "  @hyb-devs"
load_message[3] = "   " .. version .. " | " .. L["config"]


local function OnAddonLoaded()
    _hyb.conf.user = _hyb.conf.SetUserConf()
    if _hyb.conf.user.welcomeMsg then
        for _, line in ipairs(load_message) do
		    util.PrintMsg(line)
        end
	end
end

local function OnEvent(_, _, addOnName)
    if addOnName == "hybar" then OnAddonLoaded() end
end

coreFrame:SetScript("OnEvent", OnEvent)