CAMERA_OBJECTS = {}
CAMERA_IDS = 0

SELECTED_CAMERA = 1
RUN_CAMERAS = false
RUN_AUTOLERP = false


function runCameraSystem()

    local cam = CAMERA_OBJECTS[SELECTED_CAMERA]


    -- If there is at least one camera.
    if #CAMERA_OBJECTS >= 1 then

        if RUN_CAMERAS then
            SetCameraTransform(cam.tr) -- View the camera.
        end

        -- Change camera
        if KEYS.nextCamera:pressed() then -- Next camera
            cam:reset()
            SELECTED_CAMERA = getNextCamera()
        elseif KEYS.prevCamera:pressed() then -- Previous camera
            cam:reset()
            SELECTED_CAMERA = getPrevCamera()
        end

        -- Delete all cameras
        if KEYS.deleteAllCameras:pressed() then
            CAMERA_OBJECTS = {}
            beep()
        end

        -- Delete last camera created.
        if KEYS.deleteLastCamera:pressed() then
            table.remove(CAMERA_OBJECTS, #CAMERA_OBJECTS)
            buzz()
        end

    else
        resetCameraSystem()
    end

    if #CAMERA_OBJECTS >= 2 and RUN_AUTOLERP then -- Only run autoLerp if there are at least 2 cameras.
        autoLerpCameras()
    end

    -- Create camera
    if KEYS.createCamera:pressed() then
        instantiateCamera()
        shine()
    end

    -- Activate camera mode
    if KEYS.toggleCameraMode:pressed() then
        RUN_CAMERAS = not RUN_CAMERAS
    end

    -- Toggle lerp mode
    if KEYS.toggleAutoLerp:pressed() then

        RUN_AUTOLERP = not RUN_AUTOLERP

        for key, cam in pairs(CAMERA_OBJECTS) do
            cam:reset()
        end

    end

end
