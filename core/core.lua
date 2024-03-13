local _, _hyb = ...
local L, util, bar, conf = _hyb.locales, _hyb.util, _hyb.bar, _hyb.conf

local load_message = { L["WELCOME_LINE_2"] , L["WELCOME_LINE_3"] }

local coreFrame = util.Frame("Frame", "CORE_FRAME", UIParent)
coreFrame:RegisterEvent("ADDON_LOADED")


local function OnEvent(_, _, addOnName)
    if addOnName == "hybar" then
        conf.SetUser()
        local user = _hybar_user

        _G["HYBAR_BAR_FRAME"]:EnableMouse(not _hybar_user.locked)
        
        if user.enabled then
            _G["HYBAR_BAR_FRAME"]:Show()
            _G["HYBAR_BAR_FRAME"]:ClearAllPoints()
            _G["HYBAR_BAR_FRAME"]:SetPoint(user.point, UIParent, user.rel_point, user.x_offset, user.y_offset)
        else
            _G["HYBAR_BAR_FRAME"]:Hide()
        end

        if user.welcomeMsg then
            util.SystemMsgEm()
            for _, line in ipairs(load_message) do
                util.SystemMsg(line)
            end
        end
    end
end


coreFrame:SetScript("OnEvent", OnEvent)
