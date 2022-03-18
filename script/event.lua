-- An event is an item that is used to control cameras or other events.


EVENT_OBJECTS = {}
EVENT_IDS = 0


function createEventObject(id, type)

    local event = {

        id = id,
        type = 'wait',

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
            time = 2 + math.random()*2,
            speed = 0,
            dist = 0,
        },

    }

    return event

end

function instantiateEvent()

    EVENT_IDS = EVENT_IDS + 1

    local event = createEventObject(EVENT_IDS)
    event.def = DeepCopy(event)
    table.insert(EVENT_OBJECTS, event)

    local item = instantiateItem('event')
    item.item = EVENT_OBJECTS[#EVENT_OBJECTS]

    return EVENT_OBJECTS[#EVENT_OBJECTS]

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



-- function event_set_wait(self, time)
--     self.val.time = time
--     self.type = 'Wait'
--     event_replaceDef(self)
-- end
-- function event_set_trigger(self, time)
--     self.type = 'Trigger'
--     event_replaceDef(self)
-- end
-- --- Switch the camera immeadiatly.
-- function event_set_cameraSwitch(self, time)
--     self.type = 'Switch'
--     event_replaceDef(self)
-- end
-- --- Lerp camera at a constant speed regardless of time.
-- function event_set_cameraLerp_const(self, speed)
--     self.type = 'LerpConst'
--     event_replaceDef(self)
-- end
-- --- Lerp camera over a specific time period.
-- function event_set_cameraLerp_timed(self, time)
--     self.type = 'LerpTimed'
--     event_replaceDef(self)
-- end



function getNextEvent(addIndex)
    if SELECTED_EVENT + 1 > #EVENT_OBJECTS then
        return 1 + (addIndex or 0)
    else
        return SELECTED_EVENT + 1 + (addIndex or 0)
    end
end
function getPrevEvent()
    if SELECTED_EVENT - 1 <= 0 then
        return #EVENT_OBJECTS
    else
        return SELECTED_EVENT - 1
    end
end
function getCurrentEvent()
    return EVENT_OBJECTS[SELECTED_EVENT]
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

