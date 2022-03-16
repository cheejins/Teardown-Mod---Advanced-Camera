-- Cameras are items which usually don't control any other items.


CAMERA_OBJECTS = {}
CAMERA_IDS = 0

SELECTED_CAMERA = 1
RUN_CAMERAS = false
-- RUN_AUTOLERP = false


function createCameraObject(tr, id)

    local cam = {

        id = id,
        tr = tr,

        type = 'camera',

        vehicle = nil,
        zoom = nil,

    }

    return DeepCopy(cam)

end


--- Create a camera in game.
function instantiateCamera(tr)

    CAMERA_IDS = CAMERA_IDS + 1

    -- Instantiate a new camera.
    local camera = createCameraObject(tr or GetCameraTransform(), CAMERA_IDS)
    camera.def = DeepCopy(camera) -- Cloned camera used for the camera's default values.
    table.insert(CAMERA_OBJECTS, camera)

    -- Wrap the camera in a new item object.
    local item = instantiateItem('camera')
    item.item = CAMERA_OBJECTS[#CAMERA_OBJECTS]

    return CAMERA_OBJECTS[#CAMERA_OBJECTS]

end

function autoLerpCameras()

    local cam = CAMERA_OBJECTS[SELECTED_CAMERA] -- Current camera running.

    local nextCam = CAMERA_OBJECTS[getNextCamera()] -- Next camera AKA the one being approached.
    local prevCam = CAMERA_OBJECTS[getPrevCamera()]

    cam_reset(nextCam)
    cam_reset(prevCam)

    if cam.time > 0 then -- Camera is still approaching the next camera.
        cam.time = cam.time - GetTimeStep() -- Reduce time each tick the camera has time left.

        local lerpFraction = (cam.def.time - gtZero(cam.time)) / cam.def.time

        cam.tr.pos = VecLerp(cam.def.tr.pos, nextCam.def.tr.pos, lerpFraction)
        cam.tr.rot = QuatSlerp(cam.def.tr.rot, nextCam.def.tr.rot, lerpFraction)

        dbl(cam.def.tr.pos, nextCam.def.tr.pos, 0,1,1, 1)
        dbw('lerpFraction', lerpFraction)

    elseif cam.time <= 0 then -- Camera is done approaching the next camera.

        cam_reset(cam)
        SELECTED_CAMERA = getNextCamera() -- Change to the next camera.

    end

end

function cam_reset(self)
    for key, value in pairs(self) do
        if key ~= 'def' then -- self.def does not have a def key.
            self[key] = DeepCopy(self.def[key]) -- Replace all self values with default self values.
        end
    end
end

function resetCameraSystem()
    -- CAMERA_IDS = 0
    SELECTED_CAMERA = 1
    RUN_CAMERAS = false
    RUN_AUTOLERP = false
end

function getNextCamera(addIndex)
    if SELECTED_CAMERA + 1 > #CAMERA_OBJECTS then
        return 1 + (addIndex or 0)
    else
        return SELECTED_CAMERA + 1 + (addIndex or 0)
    end
end

function getPrevCamera()
    if SELECTED_CAMERA - 1 <= 0 then
        return #CAMERA_OBJECTS
    else
        return SELECTED_CAMERA - 1
    end
end


---@param id number
---@return table tb - Camera object.
---@return number i -- Index of the camera in the table.
function getCameraById(id)
    for i = 1, #CAMERA_OBJECTS do
        if CAMERA_OBJECTS[i].id == id then
            return CAMERA_OBJECTS[i], i
        end
    end
end
