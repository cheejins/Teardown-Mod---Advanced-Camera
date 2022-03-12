function initKeys()

    KEYS = {

        createCamera = {
            key = 'c',
            desc = 'create camera'
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

    }

    -- KEYS table functions
    for i, k in pairs(KEYS) do
        k.pressed = keyPressed
        k.down = keyDown
    end

end

function keyPressed(self)
    return InputPressed(self.key)
end

function keyDown(self)
    return InputDown(self.key)
end
