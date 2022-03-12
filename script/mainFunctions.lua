function resetCameraSystem()
    CAMERA_IDS = 0
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