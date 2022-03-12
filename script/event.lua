EVENT_OBJECTS = {}
EVENT_IDS = 0


--[[

    CAMERA1
    Switch to camera tool
    New camera
    Set tr
    Create camera
    (Add camera to view group)

    CAMERA2
    Switch to camera tool
    New camera
    Set tr
    Create camera
    (Add camera to view group)

    EVENT:WAIT
    Switch to camera tool
    New event
    Select event type: wait
    Set time = 5s
    Set camera master
    Set camera next
    (Add event to view group)

    EVENT:LERP
    Switch to camera tool
    New event
    Select event type: lerp speed
    Select 0.5m/s
    Set camera master
    Set camera next
    (Add event to view group)

    EVENT:GOTO
    Switch to camera tool
    New event
    Select event type: goto
    Set event master
    Set event next
    (Add event to view group)

]]



function createEventObject()

    local event = {

        status = {
            active = false,
            started = false,
            running = false,
            done = false,
            progress = 0, -- Universal value between 0.0 and 1.0 used to track exactly how far along the event is. 1.0 = done.
                          -- For example: a dist lerp event which is 0.5m/s, 25m/75m would have progress of 0.33/1.0
        },

        link = {
            event = {
                master = {},
                next = {},
            },
            camera = {
                master = {},
                next = {},
            },
        },

        val = {
            time = math.random(1,4) + math.random(),
            speed = 0,
            dist = 0,
        },

        reset = event_reset,
        replaceDef = event_replaceDef,

        -- event.link functions
        setNextEvent = event_setNextEvent,
        setMasterEvent = event_setMasterEvent,
        setNextCamera = event_setNextCamera,
        setMasterCamera = event_setMasterCamera,

    }

    event.def = DeepCopy(event)

    return event
end

function instantiateEvent(EVENT_IDS)

    EVENT_IDS = EVENT_IDS + 1

    local event = createEventObject(EVENT_IDS)

    table.insert(CAMERA_OBJECTS, event)

end


function runEvent(event)


    local progress = nil

end

local tb = {
    x = 0,
    func = tablefunc,
}

function tableFunc(self)
    self.x = self.x+1
end
