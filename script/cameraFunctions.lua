function cam_reset(self)
    self.time = DeepCopy(self.time_default) -- Reset camera time.
    self.tr = DeepCopy(self.trStart) -- Reset camera transform.
end


--- Create a camera in game.
function instantiateCamera()

    CAMERA_IDS = CAMERA_IDS + 1

    local camTr = GetCameraTransform()
    local camObj = createCameraObject(camTr, CAMERA_IDS)

    table.insert(CAMERA_OBJECTS, camObj)

end

function autoLerpCameras()

    local cam = CAMERA_OBJECTS[SELECTED_CAMERA] -- Current camera running

    local nextCam = CAMERA_OBJECTS[getNextCamera()] -- Next camera AKA the one being approached.
    local prevCam = CAMERA_OBJECTS[getPrevCamera()]

    nextCam:reset()
    prevCam:reset()


    if cam.time > 0 then -- Camera is still approaching the next camera
        cam.time = cam.time - GetTimeStep() -- Reduce time each tick the camera has time left.

        local lerpFraction = (cam.time_default - gtZero(cam.time)) / cam.time_default

        cam.tr.pos = VecLerp(cam.trStart.pos, nextCam.trStart.pos, lerpFraction)
        cam.tr.rot = QuatSlerp(cam.trStart.rot, nextCam.trStart.rot, lerpFraction)

        dbl(cam.trStart.pos, nextCam.trStart.pos, 0,1,1, 1)
        dbw('lerpFraction', lerpFraction)

    elseif cam.time <= 0 then -- Camera is done approaching the next camera.

        cam:reset()
        SELECTED_CAMERA = getNextCamera() -- Change to the next camera.

    end

end
