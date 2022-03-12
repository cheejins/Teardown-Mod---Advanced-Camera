function createCameraObject(tr, id)

    local cam = {

        id = id,
        tr = tr,

        vehicle = nil,
        zoom = nil,

    }

    cam.reset = cam_reset

    return DeepCopy(cam)

end

--- Create a camera in game.
function instantiateCamera()

    CAMERA_IDS = CAMERA_IDS + 1

    local camObj = createCameraObject(GetCameraTransform(), CAMERA_IDS)
    camObj.def = DeepCopy(camObj) -- Cloned camera used for the camera's default values.

    table.insert(CAMERA_OBJECTS, camObj)

end

-- function autoLerpCameras()

--     local cam = CAMERA_OBJECTS[SELECTED_CAMERA] -- Current camera running.

--     local nextCam = CAMERA_OBJECTS[getNextCamera()] -- Next camera AKA the one being approached.
--     local prevCam = CAMERA_OBJECTS[getPrevCamera()]

--     nextCam:reset()
--     prevCam:reset()

--     if cam.time > 0 then -- Camera is still approaching the next camera.
--         cam.time = cam.time - GetTimeStep() -- Reduce time each tick the camera has time left.

--         local lerpFraction = (cam.def.time - gtZero(cam.time)) / cam.def.time

--         cam.tr.pos = VecLerp(cam.def.tr.pos, nextCam.def.tr.pos, lerpFraction)
--         cam.tr.rot = QuatSlerp(cam.def.tr.rot, nextCam.def.tr.rot, lerpFraction)

--         dbl(cam.def.tr.pos, nextCam.def.tr.pos, 0,1,1, 1)
--         dbw('lerpFraction', lerpFraction)

--     elseif cam.time <= 0 then -- Camera is done approaching the next camera.

--         cam:reset()
--         SELECTED_CAMERA = getNextCamera() -- Change to the next camera.

--     end

-- end

function cam_reset(self)

    for key, value in pairs(self) do

        if key ~= 'def' then -- self.def does not have a def key.
            self[key] = DeepCopy(self.def[key]) -- Replace all self values with default self values.
        end

    end

end
