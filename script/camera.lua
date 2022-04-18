-- Cameras are items which usually don't control any other items.


CAMERA_OBJECTS = {}
CAMERA_IDS = 0



function createCameraObject(tr, type)

    CAMERA_IDS = CAMERA_IDS + 1

    local cam = {
        id = CAMERA_IDS,
        type = type,

        tr = tr,
        viewTr = tr,
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
-- Replace the cam.def with the current version of cam.
function cam_replaceDef(self)
    self.def = DeepCopy(self)
end



function setCameraRelativeShape(cam, shape)
    cam.shape = shape
    cam.relativeTr = TransformToLocalTransform(GetShapeWorldTransform(shape), cam.tr)
end

function manageCameras()

    if tableContainsComponentType(ITEM_CHAIN, 'camera') then -- If there is at least one camera.

        local camera = getCameraById(SELECTED_CAMERA)

        for index, item in ipairs(ITEM_CHAIN) do

            local cam = item.item

            if isUsingTool then
                if item.item.shape and item.id == UI_SELECTED_ITEM then
                    drawShape(item.item.shape)
                end
            end

            if cam.shape then
                cam.tr = TransformToParentTransform(GetShapeWorldTransform(cam.shape), cam.relativeTr) -- Keep the tr relative to the shape's tr.
            end

            if cam ~= camera then
                cam.viewTr = TransformCopy(cam.tr) -- Adhere viewTr to tr. The item chain is called after this and uses viewTr how it needs.
            end

        end

    end

end
