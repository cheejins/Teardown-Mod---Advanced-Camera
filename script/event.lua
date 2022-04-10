-- An event is an item that is used to control cameras or other events.


EVENT_OBJECTS = {}
EVENT_IDS = 0

--[[
    EVENT TYPES
        wait
        lerpConst
        lerpTimed
]]

function createEventObject(type)

    EVENT_IDS = EVENT_IDS + 1

    local event = {

        id = EVENT_IDS,
        type = type or 'wait',

        status = {
            active = false,
            started = false,
            running = false,
            done = false,
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
            speed = ternary(type == 'lerpConst', 0.01, 0),
            dist = 0,
        },

    }

    return event

end
function instantiateEvent(type)

    local event = createEventObject(type)
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




function lerpCameraTimed(event, camMaster, camNext)

    local lerpFraction = (event.def.val.time - gtZero(event.val.time)) / event.def.val.time

    camMaster.tr.pos = VecLerp(camMaster.def.tr.pos, camNext.def.tr.pos, lerpFraction)
    camMaster.tr.rot = QuatSlerp(camMaster.def.tr.rot, camNext.def.tr.rot, lerpFraction)

end

function lerpCameraConst(event, camMaster, camNext)

    local speed = event.val.speed
    local camDist = VecDist(camMaster.tr.pos, camNext.tr.pos)
    local camDistDef = VecDist(camMaster.def.tr.pos, camNext.def.tr.pos)

    event.val.time = camDist / speed / 60

    if camDist <= speed then
        event.status.done = true
    end

    local lerpFraction = (camDistDef - camDist) / camDistDef

    camMaster.tr.pos = VecApproach(camMaster.tr.pos, camNext.tr.pos, speed)
    camMaster.tr.rot = QuatSlerp(camMaster.def.tr.rot, camNext.tr.rot, lerpFraction)

    -- Slerp 0.5 between def-tr and nextdef-nexttr

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
