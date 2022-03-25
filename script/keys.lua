KEYS = {

    cameraMode = {
        key = 'g',
        desc = 'toggle view camera'
    },

    initChain = {
        key = 'f1',
        desc = 'chain init'
    },

    -- f2 = {
    --     key = 'f2',
    --     desc = ''
    -- },

    -- f3 = {
    --     key = 'f3',
    --     desc = ''
    -- },

    toggleChain = {
        key = 'f4',
        desc = 'toggle chain'
    },

    createCameraStatic = {
        key = 'f5',
        desc = 'create statis camera'
    },

    createCameraLookey = {
        key = 'f6',
        desc = 'create lookey camera'
    },

    createCameraDynamic = {
        key = 'f7',
        desc = 'create dynamic camera'
    },

    -- f8 = {
    --     key = 'f8',
    --     desc = ''
    -- },

    createEventWait = {
        key = 'f9',
        desc = 'create event: wait'
    },

    createEventLerpTimed = {
        key = 'f10',
        desc = 'create event: lerpTimed'
    },

    createEventLerpConst = {
        key = 'f11',
        desc = 'create event: lerpConst'
    },

    -- f12 = {
    --     key = 'f12',
    --     desc = ''
    -- },

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
