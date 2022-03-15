KEYS = {

    createCamera = {
        key = 'c',
        desc = 'create camera'
    },

    createEvent = {
        key = 'b',
        desc = 'create event'
    },

    runEvents = {
        key = 'n',
        desc = 'run events'
    },

    toggleCameraMode = {
        key = 'g',
        desc = 'camera mode on/off'
    },

    nextCamera = {
        key = 'e',
        desc = 'next camera'
    },

    prevCamera = {
        key = 'q',
        desc = 'previous camera'
    },

    deleteAllCameras = {
        key = 'r',
        desc = 'delete all cameras'
    },

    deleteLastCamera = {
        key = 'z',
        desc = 'delete last camera'
    },

    toggleAutoLerp = {
        key = 't',
        desc = 'auto lerp on/off'
    },

    showUi = {
        key = 'u',
        desc = 'auto lerp on/off'
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
