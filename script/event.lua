EVENT_OBJECTS = {}
EVENT_IDS = 0

EVENT_RUN = false

EVENT_SELECTED = 1


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

        id = nil,
        type = nil,

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
                master = 0,
                next = 0,
            },
            camera = {
                master = 0,
                next = 0,
            },
        },

        val = {
            time = math.random(1,2) + math.random(),
            speed = 0,
            dist = 0,
        },

    }

    return event
end

function instantiateEvent(type)

    EVENT_IDS = EVENT_IDS + 1

    local event = createEventObject()
    event.id = EVENT_IDS
    event.type = type

    event.def = DeepCopy(event)

    table.insert(EVENT_OBJECTS, event)
    return EVENT_OBJECTS[#EVENT_OBJECTS]

end



function runEvents()

    if EVENT_RUN then

        local event = EVENT_OBJECTS[EVENT_SELECTED]

        event.val.time = event.val.time - GetTimeStep()

        if event.val.time <= 0 then

            EVENT_SELECTED = getNextEvent()

            local camObj, camIndex = getCameraById(event.link.camera.next)
            SELECTED_CAMERA = camIndex

            event_reset(event)

        end

    end

end



function event_reset(self)
    for key, value in pairs(self) do
        if key ~= 'def' then -- self.def does not have a def key.
            self[key] = DeepCopy(self.def[key]) -- Replace all self values with default self values.
        end
    end
end
function event_replaceDef(self) -- Replace the event.def with the current version of event.
    self.def = DeepCopy(self)
end



function event_convertToWait(self, time)
    self.val.time = time
    event_replaceDef(self)
end



function event_setMasterEvent(self, event, doReset)
    self.link.event.next = event
    if doReset then
        self.link.event.next:reset()
    end
end
function event_setNextEvent(self, event, doReset)
    self.link.event.next = event
    if doReset then
        self.link.event.next:reset()
    end
end

function event_setMasterCamera(self, cameraId, doReset)
    self.link.camera.next = cameraId
    if doReset then
        self.link.camera.next:reset()
    end
end
function event_setNextCamera(self, cameraId, doReset)
    self.link.camera.next = cameraId
    if doReset then
        self.link.camera.next:reset()
    end
end

function getNextEvent(addIndex)
    if EVENT_SELECTED + 1 > #EVENT_OBJECTS then
        return 1 + (addIndex or 0)
    else
        return EVENT_SELECTED + 1 + (addIndex or 0)
    end
end
function getPrevEvent()
    if EVENT_SELECTED - 1 <= 0 then
        return #EVENT_OBJECTS
    else
        return EVENT_SELECTED - 1
    end
end

---@param id number
---@return table tb - Camera object.
---@return number i -- Index of the camera in the table.
function getEventById(id)
    for i = 1, #EVENT_OBJECTS do
        if EVENT_OBJECTS[i].id == id then
            return EVENT_OBJECTS[i], i
        end
    end
end
