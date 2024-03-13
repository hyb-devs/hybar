local _, _hyb = ...
local L, util, conf = _hyb.locales, _hyb.util, _hyb.conf


local load_message = { L["WELCOME_LINE_1"], L["WELCOME_LINE_2"], L["WELCOME_LINE_3"]}

local coreFrame = util.Frame("Frame", "CORE_FRAME", UIParent)
coreFrame:RegisterEvent("ADDON_LOADED")


local function OnAddonLoaded()
    conf.user = conf.SetUserConf()
    if conf.user.welcomeMsg then
        for _, line in ipairs(load_message) do
		    util.PrintMsg(line)
        end
	end
end


local function OnEvent(_, _, addOnName)
    if addOnName == "hybar" then OnAddonLoaded() end
end


coreFrame:SetScript("OnEvent", OnEvent)