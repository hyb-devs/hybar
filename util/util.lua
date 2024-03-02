local _hybName, _hyb = ...
local _util = {}

_util.PrintMsg = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cFF00FFB0" .. _hybName .. ": |r" .. msg)
end

-- Rounds the given number to the given step.
_util.SimpleRound = function(num, step)
    return floor(num / step) * step
end

_hyb.util = _util