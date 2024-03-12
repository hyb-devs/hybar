-- slash cmds
SLASH_HYB_CONFIG1 = "/hellyeahbar"
SLASH_HYB_CONFIG2 = "/hybar"
SLASH_HYB_CONFIG3 = "/hyb"
SlashCmdList["HYB_CONFIG"] = function()
    if _G["HYBAR_CONFIG_FRAME"]:IsVisible() then
        _G["HYBAR_CONFIG_FRAME"]:Hide()
    else 
        _G["HYBAR_CONFIG_FRAME"]:Show()
    end
end