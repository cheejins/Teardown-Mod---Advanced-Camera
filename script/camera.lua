-- Cameras are items which usually don't control any other items.


CAMERA_OBJECTS = {}
CAMERA_IDS = 0

RUN_CAMERAS = false


cameraTargetPos = Vec()
cameraTargetRot = Quat()


function createCameraObject(tr, type)

    CAMERA_IDS = CAMERA_IDS + 1

    local cam = {

        id = CAMERA_IDS,
        type = type,

        tr = tr,

        entity = {
            body = nil,
            relTr = nil
        },

        zoom = 0, -- Meters

    }

    return DeepCopy(cam)

end
--- Create a camera in game.
function instantiateCamera(tr, type)

    -- Instantiate a new camera.
    local camera = createCameraObject(tr or GetCameraTransform(), type)
    camera.def = DeepCopy(camera) -- Cloned camera used for the camera's default values.
    table.insert(CAMERA_OBJECTS, camera)

    -- Wrap the camera in a new item object.
    local item = instantiateItem('camera')
    item.item = CAMERA_OBJECTS[#CAMERA_OBJECTS]

    return CAMERA_OBJECTS[#CAMERA_OBJECTS]

end



function cam_reset(self)
    for key, value in pairs(self) do
        if key ~= 'def' then -- self.def does not have a def key.
            self[key] = DeepCopy(self.def[key]) -- Replace all self values with default self values.
        end
    end
end
function cam_replaceDef(self) -- Replace the cam.def with the current version of cam.
    self.def = DeepCopy(self)
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




function GetCamAimPos()
    local b = GetCameraTransform()
    local dr = TransformToParentVec(b, {0, 0, -1})
	local hit, dist, normal, shape = QueryRaycast(b.pos, dr, 10)

    if hit then
        local hitPoint = VecAdd(b.pos, VecScale(dr, dist))
    end
end

-- Create a lookey camera
function moveCamera(type)

    local hit, hitPoint, shape = RaycastFromTransform(GetCameraTransform(), 500)
    local camObj = createCameraObject(Transform(hitPoint), type)
    camObj.def = DeepCopy(camObj) -- Cloned camera used for the camera's default values.

	camObj.shape = shape
	camObj.relativePos = GetPointInsideShape(shape, GetCameraTransform().pos)
	camObj.relativeTarget = GetPointInsideShape(shape, hitPoint)
    table.insert(CAMERA_OBJECTS, camObj)

    -- Wrap the camera in a new item object.
    local item = instantiateItem('camera')
    item.item = CAMERA_OBJECTS[#CAMERA_OBJECTS]

    return CAMERA_OBJECTS[#CAMERA_OBJECTS]
end

-- Create a moveable camera
function dynamicCamera(type)

    local hit, hitPoint, shape = RaycastFromTransform(GetCameraTransform(), 500)
    local camObj = createCameraObject(Transform(hitPoint), type)
    camObj.def = DeepCopy(camObj) -- Cloned camera used for the camera's default values.

	camObj.shape = shape
	camObj.relativePos = GetPointInsideShape(shape, GetCameraTransform().pos)
	camObj.relativeTarget = GetPointInsideShape(shape, hitPoint)
    table.insert(CAMERA_OBJECTS, camObj)

    -- Wrap the camera in a new item object.
    local item = instantiateItem('camera')
    item.item = CAMERA_OBJECTS[#CAMERA_OBJECTS]

    return CAMERA_OBJECTS[#CAMERA_OBJECTS]
end
