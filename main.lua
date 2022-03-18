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

    local x = 5

    cam1 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    x = x + 5

    cam2 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    x = x + 5

    cam3 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    x = x + 5



    e1 = instantiateEvent()
    e2 = instantiateEvent()
    e3 = instantiateEvent()
    e4 = instantiateEvent()
    e5 = instantiateEvent()

    table.insert(ITEM_CHAIN, getItemByCameraId(cam2.id))
    table.insert(ITEM_CHAIN, getItemByEventId(e1.id))

    table.insert(ITEM_CHAIN, getItemByCameraId(cam1.id))
    table.insert(ITEM_CHAIN, getItemByEventId(e2.id))
    table.insert(ITEM_CHAIN, getItemByEventId(e3.id))

    table.insert(ITEM_CHAIN, getItemByCameraId(cam3.id))
    table.insert(ITEM_CHAIN, getItemByEventId(e4.id))
    table.insert(ITEM_CHAIN, getItemByEventId(e5.id))


end

function tick()

    if toolSet == nil then SetString('game.player.tool', 'advancedCamera') toolSet = true end

    runCameraSystem()


    if InputPressed('f1') then
        initializeItemChain()
    end
    if InputPressed('f2') then
        SELECTED_CAMERA = SELECTED_CAMERA + 1
    end
    if InputPressed('f3') then
        SELECTED_EVENT = SELECTED_EVENT + 1
    end


    if RUN_ITEM_CHAIN then
        runItemChain()
    end


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
            RUN_ITEM_CHAIN = not RUN_ITEM_CHAIN
        end

    end

end


UpdateQuickloadPatch()
