local addon_name, addon_data = ...
local L = addon_data.localization_table

addon_data.bar = {}

--[[============================================================================================]]--
--[[===================================== SETTINGS RELATED =====================================]]--
--[[============================================================================================]]--

addon_data.bar.default_settings = {
    point = "CENTER",
	rel_point = "CENTER",
	x_offset = 0,
	y_offset = -200,
	is_locked = false,
}

addon_data.bar.LoadSettings = function()
    -- If the carried over settings dont exist then make them
    if not character_bar_settings then
        character_bar_settings = {}
    end
    -- If the carried over settings aren't set then set them to the defaults
    for setting, value in pairs(addon_data.bar.default_settings) do
        -- print(character_bar_settings[setting])
        if character_bar_settings[setting] == nil then
            character_bar_settings[setting] = value
        end
    end
end

addon_data.bar.RestoreDefaults = function()
    for setting, value in pairs(addon_data.bar.default_settings) do
        character_bar_settings[setting] = value
    end
    addon_data.bar.UpdateVisualsOnSettingsChange()
    addon_data.bar.UpdateConfigPanelValues()
end

--[[============================================================================================]]--
--[[====================================== LOGIC RELATED =======================================]]--
--[[============================================================================================]]--
addon_data.bar.OnUpdate = function(elapsed)
    if character_core_settings.is_enabled then
        -- Update the visuals
        addon_data.bar.UpdateVisualsOnUpdate()
    end
end

--[[============================================================================================]]--
--[[===================================== UI RELATED ===========================================]]--
--[[============================================================================================]]--
addon_data.bar.UpdateVisualsOnUpdate = function()
    local settings = character_bar_settings
    local frame = addon_data.bar.frame
    if settings.enabled then
        
    end
end

addon_data.bar.UpdateVisualsOnSettingsChange = function()
    local frame = addon_data.bar.frame
    local settings = character_bar_settings
    local core_settings = character_core_settings
    if core_settings.is_enabled then
        frame:Show()
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, UIParent, settings.rel_point, settings.x_offset, settings.y_offset)
    else
        frame:Hide()
    end
end

addon_data.bar.OnFrameDragStart = function()
    if not character_bar_settings.is_locked then
        addon_data.bar.frame:StartMoving()
    end
end

addon_data.bar.OnFrameDragStop = function()
    local frame = addon_data.bar.frame
    local settings = character_bar_settings
    frame:StopMovingOrSizing()
    point, _, rel_point, x_offset, y_offset = frame:GetPoint()
    if x_offset < 20 and x_offset > -20 then
        x_offset = 0
    end
    settings.point = point
    settings.rel_point = rel_point
    settings.x_offset = addon_data.utils.SimpleRound(x_offset, 1)
    settings.y_offset = addon_data.utils.SimpleRound(y_offset, 1)
    addon_data.bar.UpdateVisualsOnSettingsChange()
    -- addon_data.bar.UpdateConfigPanelValues()
end

-- addon_data.bar.HandleButtons = function()
--     local frame = addon_data.bar.frame
--     local settings = character_bar_settings

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

addon_data.bar.InitializeVisuals = function()
    local settings = character_bar_settings

    local BUTTON_SIZE = 32
    local PADDING = 2
    local NUM_BUTTONS = 2
    local BUTTON_SPACING = 2.2

    addon_data.bar.frame = CreateFrame("Frame", addon_name .. "barFrame", UIParent, "SecureHandlerStateTemplate")
    local frame = addon_data.bar.frame

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
    frame:SetScript("OnDragStart", addon_data.bar.OnFrameDragStart)
    frame:SetScript("OnDragStop", addon_data.bar.OnFrameDragStop)
    frame:SetClampedToScreen(true)

    -- Show it off
    addon_data.bar.UpdateVisualsOnSettingsChange()
    addon_data.bar.UpdateVisualsOnUpdate()
    
    frame:Show()
end

--[[============================================================================================]]--
--[[================================== CONFIG WINDOW RELATED ===================================]]--
--[[============================================================================================]]--

-- addon_data.bar.UpdateConfigPanelValues = function()
--     local panel = addon_data.bar.config_frame
--     local settings = character_bar_settings
--     panel.height_editbox:SetText(tostring(settings.height))
--     panel.height_editbox:SetCursorPosition(0)
--     panel.x_offset_editbox:SetText(tostring(settings.x_offset))
--     panel.x_offset_editbox:SetCursorPosition(0)
--     panel.y_offset_editbox:SetText(tostring(settings.y_offset))
--     panel.y_offset_editbox:SetCursorPosition(0)
-- end

-- addon_data.bar.HeightEditBoxOnEnter = function(self)
--     character_bar_settings.height = tonumber(self:GetText())
--     addon_data.bar.UpdateVisualsOnSettingsChange()
-- end

-- addon_data.bar.XOffsetEditBoxOnEnter = function(self)
--     character_bar_settings.x_offset = tonumber(self:GetText())
--     addon_data.bar.UpdateVisualsOnSettingsChange()
-- end

-- addon_data.bar.YOffsetEditBoxOnEnter = function(self)
--     character_bar_settings.y_offset = tonumber(self:GetText())
--     addon_data.bar.UpdateVisualsOnSettingsChange()
-- end

-- addon_data.bar.CreateConfigPanel = function(parent_panel)
--     addon_data.bar.config_frame = CreateFrame("Frame", addon_name .. "BarConfigPanel", parent_panel)
--     local panel = addon_data.bar.config_frame
--     local settings = character_bar_settings
    
--     -- Height EditBox
--     panel.height_editbox = addon_data.config.EditBoxFactory(
--         "barHeightEditBox",
--         panel,
--         L["Bar Height"],
--         75,
--         25,
--         addon_data.bar.HeightEditBoxOnEnter)
--     panel.height_editbox:SetPoint("TOPLEFT", 320, -60, "BOTTOMRIGHT", 355, -85)
--     -- X Offset EditBox
--     panel.x_offset_editbox = addon_data.config.EditBoxFactory(
--         "barXOffsetEditBox",
--         panel,
--         L["X Offset"],
--         75,
--         25,
--         addon_data.bar.XOffsetEditBoxOnEnter)
--     panel.x_offset_editbox:SetPoint("TOPLEFT", 200, -110, "BOTTOMRIGHT", 275, -135)
--     -- Y Offset EditBox
--     panel.y_offset_editbox = addon_data.config.EditBoxFactory(
--         "barYOffsetEditBox",
--         panel,
--         L["Y Offset"],
--         75,
--         25,
--         addon_data.bar.YOffsetEditBoxOnEnter)
--     panel.y_offset_editbox:SetPoint("TOPLEFT", 280, -110, "BOTTOMRIGHT", 355, -135)

--     -- Return the final panel
--     addon_data.bar.UpdateConfigPanelValues()
--     return panel
-- end
