local _, _hyb = ...
local L, util, conf, bar = _hyb.locales, _hyb.util, _hyb.conf, _hyb.bar


local load_message = { L["WELCOME_LINE_2"] , L["WELCOME_LINE_3"] }

local coreFrame = util.Frame("Frame", "CORE_FRAME", UIParent)
coreFrame:RegisterEvent("ADDON_LOADED")


local function OnAddonLoaded()
    bar.SetVisibility()
    if conf.user.welcomeMsg then
        util.SystemMsgEm()
        for _, line in ipairs(load_message) do
		    util.SystemMsg(line)
        end
	end
end


local function OnEvent(_, _, addOnName)
    if addOnName == "hybar" then OnAddonLoaded() end
end


coreFrame:SetScript("OnEvent", OnEvent)