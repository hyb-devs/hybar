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

    util.Text = function(parent, text, template)
        local text_obj = parent:CreateFontString(nil, "ARTWORK", template)
        text_obj:SetText(text)

        return text_obj
    end

    return util

end
