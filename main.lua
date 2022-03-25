#include "script/camera.lua"
#include "script/debug.lua"
#include "script/draw.lua"
#include "script/event.lua"
#include "script/item.lua"
#include "script/itemChain.lua"
#include "script/keys.lua"
#include "script/tool.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"


function init()

    -- local x = 2

    -- cam1 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    -- x = x + 2

    -- cam2 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    -- x = x + 2

    -- cam3 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    -- x = x + 2

    -- cam4 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    -- x = x + 2

    -- cam5 = instantiateCamera(Transform(Vec(x,5,5), QuatLookAt(Vec(x,5,5), Vec(x,0,0))))
    -- x = x + 2

    -- e1 = instantiateEvent()
    -- e2 = instantiateEvent()
    -- e3 = instantiateEvent()
    -- e4 = instantiateEvent()
    -- e5 = instantiateEvent()
    -- e6 = instantiateEvent()
    -- e7 = instantiateEvent()
    -- e8 = instantiateEvent()

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


end

function tick()

    if toolSet == nil then SetString('game.player.tool', 'advancedCamera') toolSet = true end


    runCameraSystem()


    if KEYS.initChain:pressed() then
        initializeItemChain()
    end
    if KEYS.toggleChain:pressed() then -- Run item chain.
        RUN_ITEM_CHAIN = not RUN_ITEM_CHAIN
        beep()
    end


    if KEYS.createCameraStatic:pressed() then -- Create camera
        local item = getItemByCameraId(instantiateCamera(nil, 'static').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end
    if KEYS.createCameraLookey:pressed() then -- Create camera
        local item = getItemByCameraId(moveCamera('orbit').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end
    if KEYS.createCameraDynamic:pressed() then -- Create camera
        local item = getItemByCameraId(dynamicCamera('relative').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end


    if KEYS.createEventWait:pressed() then
        local item = getItemByEventId(instantiateEvent('wait').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end
    if KEYS.createEventLerpTimed:pressed() then
        local item = getItemByEventId(instantiateEvent('lerpTimed').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end
    if KEYS.createEventLerpConst:pressed() then
        local item = getItemByEventId(instantiateEvent('lerpConst').id)
        table.insert(ITEM_CHAIN, item)
        beep()
    end



    if RUN_ITEM_CHAIN then
        runItemChain()
    end


    manageDebugMode()
    debugMod()

end

function update()
end


function runCameraSystem()

    local cam = CAMERA_OBJECTS[SELECTED_CAMERA]
    SELECTED_CAMERA_OBJECT = cam

    -- If there is at least one camera.
    if #CAMERA_OBJECTS >= 1 then

        for key, cam in pairs(CAMERA_OBJECTS) do

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

    if KEYS.cameraMode:pressed() then -- Activate camera mode.
        RUN_CAMERAS = not RUN_CAMERAS
    end

end


UpdateQuickloadPatch()
