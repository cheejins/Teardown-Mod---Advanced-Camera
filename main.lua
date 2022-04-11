#include "script/camera.lua"
#include "script/debug.lua"
#include "script/draw.lua"
#include "script/drawDebug.lua"
#include "script/event.lua"
#include "script/item.lua"
#include "script/itemChain.lua"
#include "script/itemSelection.lua"
#include "script/keys.lua"
#include "script/tool.lua"
#include "script/ui.lua"
#include "script/uiTools.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"



function init()

    local x = 2

    -- cam1 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))), 'static')
    -- x = x + 2

    -- cam2 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))), 'static')
    -- x = x + 2

    -- cam3 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))), 'static')
    -- x = x + 2

    -- cam4 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))), 'static')
    -- x = x + 2

    -- cam5 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))), 'static')
    -- x = x + 2

    -- e1 = instantiateEvent('wait')
    -- e2 = instantiateEvent('lerpConst')
    -- e3 = instantiateEvent('wait')
    -- e4 = instantiateEvent('lerpConst')
    -- e5 = instantiateEvent('lerpTimed')
    -- e6 = instantiateEvent('wait')
    -- e7 = instantiateEvent('lerpConst')
    -- e8 = instantiateEvent('wait')

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam3.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e1.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam2.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e2.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e3.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam5.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e5.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam1.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e4.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam4.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e7.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam4.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e7.id))

    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam1.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e1.id))
    -- table.insert(ITEM_CHAIN, getItemByCameraId(cam2.id))
    -- table.insert(ITEM_CHAIN, getItemByEventId(e2.id))


    cam1 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(0,0,0))), 'static')
    x = x + 10

    e1 = instantiateEvent('wait')

    cam2 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(0,0,0))), 'static')
    x = x + 10

    e2 = instantiateEvent('lerpConst')

end

function tick()

    runMod()
    manageInput()

    manageDebugMode()
    debugMod()

    startWithTool()

end

function runMod()

    -- If there is at least one camera.
    if tableContainsComponentType(ITEM_CHAIN, 'camera') then

        local cam = getItemByCameraId(SELECTED_CAMERA).item

        for key, cam in pairs(ITEM_CHAIN) do

            if cam.shape then
                local camPos = GetPointOutOfShape(cam.shape, cam.relativePos)
                local camRot = QuatLookAt(GetPointOutOfShape(cam.shape, cam.relativePos), GetPointOutOfShape(cam.shape, cam.relativeTarget))
                cam.tr = Transform(camPos, camRot)
            end

        end

        if RUN_CAMERAS then
            SetCameraTransform(cam.tr) -- View the camera.
        end

    end

end

function manageInput()

    if KEYS.initChain:pressed() then
        initializeItemChain()
    end
    if KEYS.toggleChain:pressed() then -- Run item chain.
        RUN_ITEM_CHAIN = not RUN_ITEM_CHAIN
        beep()
    end


    if KEYS.createCameraStatic:pressed() then
        getItemByCameraId(instantiateCamera(nil, 'static').id)
        beep()
    end
    if KEYS.createCameraLookey:pressed() then
        getItemByCameraId(moveCamera('orbit').id)
        beep()
    end
    if KEYS.createCameraDynamic:pressed() then
        getItemByCameraId(dynamicCamera('relative').id)
        beep()
    end


    if KEYS.createEventWait:pressed() then
        getItemByEventId(instantiateEvent('wait').id)
        beep()
    end
    if KEYS.createEventLerpTimed:pressed() then
        getItemByEventId(instantiateEvent('lerpTimed').id)
        beep()
    end
    if KEYS.createEventLerpConst:pressed() then
        getItemByEventId(instantiateEvent('lerpConst').id)
        beep()
    end


    if InputPressed('r') then
        ITEM_OBJECTS = {}
        ITEM_CHAIN = {}
        EVENT_OBJECTS = {}
        CAMERA_OBJECTS = {}
        beep()
    end

    if KEYS.cameraMode:pressed() then -- Activate camera mode.
        RUN_CAMERAS = not RUN_CAMERAS
    end

    if RUN_ITEM_CHAIN then
        runItemChain()
    end

    if TOOL:active() and InputPressed('rmb') then
        UI_SHOW_OPTIONS = not UI_SHOW_OPTIONS
        beep()
    end

end

function startWithTool()
    if toolSet == nil then SetString('game.player.tool', 'advancedCamera') toolSet = true end
end

UpdateQuickloadPatch()
