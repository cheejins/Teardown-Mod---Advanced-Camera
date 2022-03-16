#include "script/camera.lua"
#include "script/debug.lua"
#include "script/draw.lua"
#include "script/event.lua"
#include "script/item.lua"
#include "script/keys.lua"
#include "script/tool.lua"
#include "script/umf.lua"
#include "script/utility.lua"


function init()

    local cam1 = instantiateCamera(Transform(Vec(5,5,5), QuatLookAt(Vec(5,5,5), Vec(0,0,0))))
    local cam2 = instantiateCamera(Transform(Vec(-5,5,-5), QuatLookAt(Vec(-5,5,-5), Vec(0,0,0))))
    local e1 = instantiateEvent('wait')
    local e2 = instantiateEvent('wait')
    local e3 = instantiateEvent('wait')
    local e4 = instantiateEvent('wait')

    event_setMasterCamera(e1, cam1.id)
    event_setNextEvent(e1, e2.id)
    event_replaceDef(e1)

    event_setMasterCamera(e2, cam2.id)
    event_setNextEvent(e2, e3.id)
    event_replaceDef(e2)

    event_setMasterCamera(e3, cam2.id)
    event_setNextEvent(e3, e4.id)
    event_replaceDef(e3)

    event_setMasterCamera(e4, cam1.id)
    event_setNextEvent(e4, e1.id)
    event_replaceDef(e4)

end

function tick()

    if toolSet == nil then SetString('game.player.tool', 'advancedCamera') toolSet = true end

    runCameraSystem()
    runEvents()

    manageDebugMode()
    debugMod()

end

function update()
end

function draw()

    UiAlign('center middle')
    UiFont('bold.ttf', 24)
    UiColor(0,0,0,1)

    if TOOL:active() then
        drawUi()
        if db then
            drawControls()
        end
    end

    if db then
        drawCameraNumbers()
    end

end

function runCameraSystem()

    local cam = CAMERA_OBJECTS[SELECTED_CAMERA]
    SELECTED_CAMERA_OBJECT = cam


    -- Create camera
    if KEYS.createCamera:pressed() then
        instantiateCamera()
        shine()
    end


    -- Toggle UI
    if KEYS.showUi:pressed() then
        UI_SHOW_OPTIONS = not UI_SHOW_OPTIONS
    end


    -- If there is at least one camera.
    if #CAMERA_OBJECTS >= 1 then

        if RUN_CAMERAS then
            SetCameraTransform(cam.tr) -- View the camera.
        end

        -- Change camera
        if KEYS.nextCamera:pressed() then -- Next camera.
            cam_reset(cam)
            SELECTED_CAMERA = getNextCamera()
        elseif KEYS.prevCamera:pressed() then -- Previous camera.
            cam_reset(cam)
            SELECTED_CAMERA = getPrevCamera()
        end

        if KEYS.deleteAllCameras:pressed() then -- Delete all cameras
            CAMERA_OBJECTS = {}
            buzz()
        end

        if KEYS.deleteLastCamera:pressed() then -- Delete last camera created.

            if SELECTED_CAMERA == #CAMERA_OBJECTS then
                SELECTED_CAMERA = SELECTED_CAMERA - 1
            end

            CAMERA_OBJECTS[#CAMERA_OBJECTS] = nil

            buzz()
        end

        if KEYS.toggleCameraMode:pressed() then -- Activate camera mode.
            RUN_CAMERAS = not RUN_CAMERAS
        end

        if KEYS.runEvents:pressed() then -- Activate camera mode.
            EVENT_RUN = not EVENT_RUN
        end

        -- if KEYS.toggleAutoLerp:pressed() then -- Toggle lerp mode.

        --     RUN_AUTOLERP = not RUN_AUTOLERP

        --     for key, cam in pairs(CAMERA_OBJECTS) do
        --         cam_reset(cam)
        --     end

        -- end

        if #CAMERA_OBJECTS >= 2 and RUN_AUTOLERP then -- Only run autoLerp if there are at least 2 cameras.
            autoLerpCameras()
        end

    else
        resetCameraSystem()
    end

end


UpdateQuickloadPatch()