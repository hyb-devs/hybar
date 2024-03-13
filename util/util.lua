local _hybName, _hyb = ...
local L = _hyb.locales

if _hyb.util then return end

local util = {}

util.OnEvent = function(callback)
    local addOnName = _hybName
    if addOnName == "hybar" then callback() end
end

util.SystemMsg = function(msg)
    _G["DEFAULT_CHAT_FRAME"]:AddMessage("|cFF00FFB0" .. msg .. "|r")
end

util.SystemMsgEm = function()
    _G["DEFAULT_CHAT_FRAME"]:AddMessage("|cFF00FFB0" .. L["hybar"])
end


-- Rounds the given number to the given step.
util.SimpleRound = function(num, step)
    return floor(num / step) * step
end


util.Text = function(parent, text, font)
    local text_obj = parent:CreateFontString(nil, "ARTWORK", font)
    text_obj:SetText(text)

    return text_obj
end


util.Frame = function(type, name, parent, template)
    local f = CreateFrame(type, L["ns"] .. name, parent, template)
    return f
end


util.Checkbox = function(parent, id, x, y, val)
    local cb = CreateFrame("CheckButton", L["ns"] .. "_CHECKBUTTON_" .. id, parent, "ChatConfigCheckButtonTemplate")
    cb:SetPoint("TOPLEFT", x, y)
    getglobal(cb:GetName() .. "Text"):SetText(val)
    return cb
end

_hyb.util = util