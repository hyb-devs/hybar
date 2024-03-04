local _hybName, _hyb = ...

_hyb.SetupUtil = function()

    local util = {}

    util.PrintMsg = function(msg)
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FFB0" .. _hybName .. ": |r" .. msg)
    end

    -- Rounds the given number to the given step.
    util.SimpleRound = function(num, step)
        return floor(num / step) * step
    end

    util.TextFactory = function(parent, text, size)
        local text_obj = parent:CreateFontString(nil, "ARTWORK")

        text_obj:SetFont("Fonts/FRIZQT__.ttf", size)
        text_obj:SetJustifyV("CENTER")
        text_obj:SetJustifyH("CENTER")
        text_obj:SetText(text)

        return text_obj
    end

    util.CheckBoxFactory = function(g_name, parent, checkbtn_text, tooltip_text, on_click_func)
        local checkbox = CreateFrame("CheckButton", _hybName .. g_name, parent, "ChatConfigCheckButtonTemplate")

        getglobal(checkbox:GetName() .. 'Text'):SetText(checkbtn_text)

        checkbox.tooltip = tooltip_text
        checkbox:SetScript("OnClick", function(self)
            on_click_func(self)
        end)

        checkbox:SetScale(1.1)

        return checkbox
    end

    util.EditBoxFactory = function(g_name, parent, title, w, h, enter_func)
        local edit_box_obj = CreateFrame("EditBox", _hybName .. g_name, parent, "BackdropTemplate")

        edit_box_obj.title_text = _hyb.config.TextFactory(edit_box_obj, title, 12)
        edit_box_obj.title_text:SetPoint("TOP", 0, 12)

        edit_box_obj:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 26,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4}
        })

        edit_box_obj:SetBackdropColor(0,0,0,1)
        edit_box_obj:SetSize(w, h)
        edit_box_obj:SetMultiLine(false)
        edit_box_obj:SetAutoFocus(false)
        edit_box_obj:SetMaxLetters(4)
        edit_box_obj:SetJustifyH("CENTER")
        edit_box_obj:SetJustifyV("CENTER")
        edit_box_obj:SetFontObject(GameFontNormal)

        edit_box_obj:SetScript("OnEnterPressed", function(self)
            enter_func(self)
            self:ClearFocus()
        end)

        edit_box_obj:SetScript("OnTextChanged", function(self)
            if self:GetText() ~= "" then
                enter_func(self)
            end
        end)

        edit_box_obj:SetScript("OnEscapePressed", function(self)
            self:ClearFocus()
        end)

        return edit_box_obj
    end

    util.SliderFactory = function(g_name, parent, title, min_val, max_val, val_step, func)
        local slider = CreateFrame("Slider", _hybName .. g_name, parent, "OptionsSliderTemplate")
        local editbox = CreateFrame("EditBox", "$parentEditBox", slider, "InputBoxTemplate")

        slider:SetMinMaxValues(min_val, max_val)
        slider:SetValueStep(val_step)
        slider.text = _G[_hybName .. g_name .. "Text"]
        slider.text:SetText(title)
        slider.textLow = _G[_hybName .. g_name .. "Low"]
        slider.textHigh = _G[_hybName .. g_name .. "High"]
        slider.textLow:SetText(floor(min_val))
        slider.textHigh:SetText(floor(max_val))
        slider.textLow:SetTextColor(0.8,0.8,0.8)
        slider.textHigh:SetTextColor(0.8,0.8,0.8)
        slider:SetObeyStepOnDrag(true)
        editbox:SetSize(45,30)
        editbox:ClearAllPoints()
        editbox:SetPoint("LEFT", slider, "RIGHT", 15, 0)
        editbox:SetText(slider:GetValue())
        editbox:SetAutoFocus(false)

        slider:SetScript("OnValueChanged", function(self)
            editbox:SetText(tostring(_hyb.utils.SimpleRound(self:GetValue(), val_step)))
            func(self)
        end)

        editbox:SetScript("OnTextChanged", function(self)
            local val = self:GetText()
            if tonumber(val) then
                self:GetParent():SetValue(val)
            end
        end)

        editbox:SetScript("OnEnterPressed", function(self)
            local val = self:GetText()
            if tonumber(val) then
                self:GetParent():SetValue(val)
                self:ClearFocus()
            end
        end)

        slider.editbox = editbox

        return slider
    end

    return util

end
