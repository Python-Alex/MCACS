local colors = require("colors")

local RedstoneController = {}

function enableSignal(side, color)
    local currentOutput = redstone.getBundledOutput(side)
    redstone.setBundledOutput(side, currentOutput | color)

end

-- Function to clear (turn off) a specific color on a bundled cable
function clearSignal(side, color)
    local currentOutput = redstone.getBundledOutput(side) or 0
    redstone.setBundledOutput(side, currentOutput & ~color)
end

-- Function to check if a specific color is on or off on a bundled cable
function isSignalOn(side, color)
    local currentOutput = redstone.getBundledOutput(side) or 0
    return (currentOutput & color) ~= 0
end

-- Function to get the current state of all colors on a bundled cable
function getAllSignals(side)
    return redstone.getBundledOutput(side) or 0
end