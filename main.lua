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

    cam1 = instantiateCamera(Transform(Vec(5,5,5), QuatLookAt(Vec(5,5,5), Vec(0,0,0))))
    cam2 = instantiateCamera(Transform(Vec(-5,5,-5), QuatLookAt(Vec(-5,5,-5), Vec(0,0,0))))

    e1 = instantiateEvent('wait')
    e2 = instantiateEvent('wait')

    table.insert(ITEM_CHAIN, getCameraItemById(cam1.id))
    table.insert(ITEM_CHAIN, getEventItemById(e1.id))

    table.insert(ITEM_CHAIN, getCameraItemById(cam2.id))
    table.insert(ITEM_CHAIN, getEventItemById(e2.id))

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

    if db then
        drawCameraNumbers()
    end

    if TOOL:active() then
        drawUi()
        if db then
            drawControls()
        end
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


        if #CAMERA_OBJECTS >= 2 and RUN_AUTOLERP then -- Only run autoLerp if there are at least 2 cameras.
            autoLerpCameras()
        end

    else
        resetCameraSystem()
    end

end


UpdateQuickloadPatch()
