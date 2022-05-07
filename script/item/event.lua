-- An event is a component used to control cameras or other events.


EVENT_OBJECTS = {}
EVENT_IDS = 0


function createEventObject(type)

    EVENT_IDS = EVENT_IDS + 1

    local event = {

        id = EVENT_IDS,
        type = type or 'wait',
        name = '',

        status = {
            active = false,
            started = false,
            running = false,
            done = false,
        },

        val = {
            time = 2 + math.random()*2,
            -- speed = ternary(type == 'lerpConst', 0.01, 0),
            speed = 0,
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



function waitCamera(cam)
    if cam.shape then
        cam.viewTr = TransformToParentTransform(GetShapeWorldTransform(cam.shape), cam.relativeTr) -- Keep the tr relative to the shape's tr.
    end
end
function lerpCamera(event, camMaster, camNext)

    local lerpFraction = (event.def.val.time - gtZero(event.val.time)) / event.def.val.time

    if event.val.time <= 0 then
        event.status.done = true -- Camera has reached its target
    end

    if event.type == 'lerpTimed' then

        event.val.time = event.val.time - GetTimeStep()

        camMaster.viewTr.pos = VecLerp(camMaster.tr.pos, camNext.tr.pos, lerpFraction)
        camMaster.viewTr.rot = QuatSlerp(camMaster.tr.rot, camNext.tr.rot, lerpFraction)

    elseif event.type == 'lerpConst' then

        local speed = event.val.speed
        local dist = VecDist(camMaster.viewTr.pos, camNext.tr.pos)

        local time = dist / speed / 60
        event.val.time = time

        local defDist = VecDist(camMaster.tr.pos, camNext.tr.pos)
        local lerpFraction = (defDist - dist) / defDist

        camMaster.viewTr.pos = VecApproach(camMaster.viewTr.pos, camNext.tr.pos, event.val.speed)
        camMaster.viewTr.rot = QuatSlerp(camMaster.tr.rot, camNext.tr.rot, lerpFraction)

        if dist <= speed then
            event.status.done = true -- Camera has reached its target
        end

    end

end
