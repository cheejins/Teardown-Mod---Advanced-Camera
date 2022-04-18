KEYS = {

    runChain = {
        key = 'f1',
        desc = 'Run the item chain of cameras and events.'
    },

    camView = {
        key = 'v',
        desc = 'View the current camera.'
    },

    restartChain = {
        key = 'r',
        desc = 'Restart the item chain.'
    },

    nextEvent = {
        key = 'f4',
        desc = ''
    },

    prevEvent = {
        key = 'f4',
        desc = ''
    },

    detailedMode = {
        key = 'i',
        desc = 'Show extra item details.'
    },

    drawCameras = {
        key = 'o',
        desc = 'Show the location and direction of each camera.'
    },

    deleteAll = {
        key = 'x',
        desc = 'Delete all items.'
    },

    pinPanel = {
        key = 'p',
        desc = 'Pin the control panel (always show)'
    },

}

function keyPressed(self)
    return InputPressed(self.key)
end

function keyDown(self)
    return InputDown(self.key)
end

-- KEYS table functions
for i, k in pairs(KEYS) do
    k.pressed = keyPressed
    k.down = keyDown
end
