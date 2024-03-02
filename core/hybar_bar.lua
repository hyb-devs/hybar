local _hybName, _hyb = ...
local L = _hyb.locales

_hyb.bar = {}

--[[===================================== SETTINGS =====================================]]--

_hyb.bar.default_settings = {
    point = "CENTER",
	rel_point = "CENTER",
	x_offset = 0,
	y_offset = -200,
	is_locked = false,
}

_hyb.bar.LoadSettings = function()
    if not hybar_bar_settings then
        hybar_bar_settings = {}
    end

    for setting, value in pairs(_hyb.bar.default_settings) do
        if hybar_bar_settings[setting] == nil then
            hybar_bar_settings[setting] = value
        end
    end
end

_hyb.bar.RestoreDefaults = function()
    for setting, value in pairs(_hyb.bar.default_settings) do
        hybar_bar_settings[setting] = value
    end
    _hyb.bar.UpdateVisualsOnSettingsChange()
    _hyb.bar.UpdateConfigPanelValues()
end

--[[====================================== LOGIC =======================================]]--

_hyb.bar.OnUpdate = function(elapsed)
    if hybar_core_settings.is_enabled then
        -- Update the visuals
        _hyb.bar.UpdateVisualsOnUpdate()
    end
end

--[[===================================== UI ===========================================]]--

_hyb.bar.UpdateVisualsOnUpdate = function()
    local settings = hybar_bar_settings
    local frame = _hyb.bar.frame
    if settings.enabled then
        
    end
end

_hyb.bar.UpdateVisualsOnSettingsChange = function()
    local frame = _hyb.bar.frame
    local settings = hybar_bar_settings
    local core_settings = hybar_core_settings
    if core_settings.is_enabled then
        frame:Show()
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, UIParent, settings.rel_point, settings.x_offset, settings.y_offset)
    else
        frame:Hide()
    end
end

_hyb.bar.OnFrameDragStart = function()
    if not hybar_bar_settings.is_locked then
        _hyb.bar.frame:StartMoving()
    end
end

_hyb.bar.OnFrameDragStop = function()
    local frame = _hyb.bar.frame
    local settings = hybar_bar_settings
    frame:StopMovingOrSizing()
    point, _, rel_point, x_offset, y_offset = frame:GetPoint()
    if x_offset < 20 and x_offset > -20 then
        x_offset = 0
    end
    settings.point = point
    settings.rel_point = rel_point
    settings.x_offset = _hyb.util.SimpleRound(x_offset, 1)
    settings.y_offset = _hyb.util.SimpleRound(y_offset, 1)
    _hyb.bar.UpdateVisualsOnSettingsChange()
    -- _hyb.bar.UpdateConfigPanelValues()
end

-- _hyb.bar.HandleButtons = function()
--     local frame = _hyb.bar.frame
--     local settings = hybar_bar_settings

--     frame.buttons = {}

--     for i = 1, 2 do
--         local button = CreateFrame("Button", "$parentButton" .. i, frame, "SecureActionButtonTemplate, ActionButtonTemplate")
--         button.icon = _G[button:GetName() .. "Icon"]
--         button.icon:SetTexture(L["icon" .. tostring(i)])
--         button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
--         button:SetSize(settings.height, settings.height)
--         button:SetAttribute("type", "macro")
--         button:SetAttribute("macrotext", L["tooltip" .. tostring(i)] .. " ".. L["hyb" .. tostring(i)])
--         button:SetNormalTexture(0)

--         button:SetScript("OnEnter", function(self)
--             GameTooltip:SetOwner(self, "ANCHOR_TOP")
--             GameTooltip:SetText(L["tooltip" .. tostring(i)], 1, 1, 1)
--             local fontName, fontHeight, fontFlags = GameTooltipTextLeft1:GetFont()
--             GameTooltipTextLeft1:SetFont(fontName, 8, fontFlags)
--             GameTooltip:Show()
--         end)
--         button:SetScript("OnLeave", function(self)
--             GameTooltip:Hide()
--         end)

--         frame.buttons[i] = button
--     end

--     for i, button in ipairs(frame.buttons) do
--         button:SetSize(settings.height, settings.height)
--         button:SetPoint("LEFT", frame, "LEFT", settings.padding + ((i-1) * (settings.button_size + settings.button_spacing)), 0)
--     end

--     -- Resize the frame to fit the new button sizes
--     settings.totalWidth = (settings.button_size * settings.num_buttons) + (settings.button_spacing * (settings.num_buttons - 1)) + (settings.padding * 2)
--     settings.totalHeight = settings.button_size + (settings.padding * 2)


--     frame:SetSize(settings.totalWidth, settings.totalHeight)
-- end

_hyb.bar.InitializeVisuals = function()
    local settings = hybar_bar_settings

    local BUTTON_SIZE = 32
    local PADDING = 2
    local NUM_BUTTONS = 2
    local BUTTON_SPACING = 2.2

    _hyb.bar.frame = CreateFrame("Frame", _hybName .. "barFrame", UIParent, "SecureHandlerStateTemplate")
    local frame = _hyb.bar.frame

    frame.background = frame:CreateTexture("BACKGROUND")
    frame.background:SetAllPoints(true)
    frame.background:SetColorTexture(0, 0, 0, 0.8)

    frame.buttons = {}

    for i = 1, 2 do
        local button = CreateFrame("Button", "$parentButton" .. i, frame, "SecureActionButtonTemplate, ActionButtonTemplate")
        
        button.icon = _G[button:GetName() .. "Icon"]
        button.icon:SetTexture(L["icon" .. tostring(i)])
        button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        
        -- button:SetSize(settings.height, settings.height)
        -- button:SetPoint("LEFT", frame, "LEFT", settings.padding + ((i-1) * (settings.button_size + settings.button_spacing)), 0)

        button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
        button:SetPoint("LEFT", frame, "LEFT", PADDING + ((i-1) * (BUTTON_SIZE + BUTTON_SPACING)), 0)

        button:SetAttribute("type", "macro")
        button:SetAttribute("macrotext", L["tooltip" .. tostring(i)] .. " ".. L["hyb" .. tostring(i)])
        button:SetNormalTexture(0)

        button:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L["tooltip" .. tostring(i)], 1, 1, 1)
            local fontName, fontHeight, fontFlags = GameTooltipTextLeft1:GetFont()
            GameTooltipTextLeft1:SetFont(fontName, 12, fontFlags)
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        button:GetHighlightTexture():SetTexture(nil)
        button:GetPushedTexture():SetTexture(nil)

        frame.buttons[i] = button
    end

    -- Resize the frame to fit the new button sizes
    local totalWidth = (BUTTON_SIZE * NUM_BUTTONS) + (BUTTON_SPACING * (NUM_BUTTONS - 1)) + (PADDING * 2)
    local totalHeight = BUTTON_SIZE + (PADDING * 2)
    
    frame:SetSize(totalWidth, totalHeight)

    frame:SetMovable(true)
    frame:EnableMouse(not settings.is_locked)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", _hyb.bar.OnFrameDragStart)
    frame:SetScript("OnDragStop", _hyb.bar.OnFrameDragStop)
    frame:SetClampedToScreen(true)

    -- Show it off
    _hyb.bar.UpdateVisualsOnSettingsChange()
    _hyb.bar.UpdateVisualsOnUpdate()
    
    frame:Show()
end

--[[================================== CONFIG WINDOW ===================================]]--

-- _hyb.bar.UpdateConfigPanelValues = function()
--     local panel = _hyb.bar.config_frame
--     local settings = hybar_bar_settings
--     panel.height_editbox:SetText(tostring(settings.height))
--     panel.height_editbox:SetCursorPosition(0)
--     panel.x_offset_editbox:SetText(tostring(settings.x_offset))
--     panel.x_offset_editbox:SetCursorPosition(0)
--     panel.y_offset_editbox:SetText(tostring(settings.y_offset))
--     panel.y_offset_editbox:SetCursorPosition(0)
-- end

-- _hyb.bar.HeightEditBoxOnEnter = function(self)
--     hybar_bar_settings.height = tonumber(self:GetText())
--     _hyb.bar.UpdateVisualsOnSettingsChange()
-- end

-- _hyb.bar.XOffsetEditBoxOnEnter = function(self)
--     hybar_bar_settings.x_offset = tonumber(self:GetText())
--     _hyb.bar.UpdateVisualsOnSettingsChange()
-- end

-- _hyb.bar.YOffsetEditBoxOnEnter = function(self)
--     hybar_bar_settings.y_offset = tonumber(self:GetText())
--     _hyb.bar.UpdateVisualsOnSettingsChange()
-- end

-- _hyb.bar.CreateConfigPanel = function(parent_panel)
--     _hyb.bar.config_frame = CreateFrame("Frame", _hybName .. "BarConfigPanel", parent_panel)
--     local panel = _hyb.bar.config_frame
--     local settings = hybar_bar_settings
    
--     -- Height EditBox
--     panel.height_editbox = _hyb.config.EditBoxFactory(
--         "barHeightEditBox",
--         panel,
--         L["Bar Height"],
--         75,
--         25,
--         _hyb.bar.HeightEditBoxOnEnter)
--     panel.height_editbox:SetPoint("TOPLEFT", 320, -60, "BOTTOMRIGHT", 355, -85)
--     -- X Offset EditBox
--     panel.x_offset_editbox = _hyb.config.EditBoxFactory(
--         "barXOffsetEditBox",
--         panel,
--         L["X Offset"],
--         75,
--         25,
--         _hyb.bar.XOffsetEditBoxOnEnter)
--     panel.x_offset_editbox:SetPoint("TOPLEFT", 200, -110, "BOTTOMRIGHT", 275, -135)
--     -- Y Offset EditBox
--     panel.y_offset_editbox = _hyb.config.EditBoxFactory(
--         "barYOffsetEditBox",
--         panel,
--         L["Y Offset"],
--         75,
--         25,
--         _hyb.bar.YOffsetEditBoxOnEnter)
--     panel.y_offset_editbox:SetPoint("TOPLEFT", 280, -110, "BOTTOMRIGHT", 355, -135)

--     -- Return the final panel
--     _hyb.bar.UpdateConfigPanelValues()
--     return panel
-- end
