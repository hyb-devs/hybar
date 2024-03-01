
local _hybar, _hyb = ...

_hyb.utils = {}

-- Sends the given message to the chat frame with the addon name in front.
_hyb.utils.PrintMsg = function(msg)
	local chat_msg = "|cFF00FFB0" .. _hybar .. ": |r" .. msg
	DEFAULT_CHAT_FRAME:AddMessage(chat_msg)
end

-- Rounds the given number to the given step.
-- If num was 1.17 and step was 0.1 then this would return 1.1

_hyb.utils.SimpleRound = function(num, step)
    return floor(num / step) * step
end