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
#include "script/uiModItem.lua"
#include "script/uiTools.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"



function init()

    playerRelCamPos = TransformToLocalPoint(GetPlayerTransform(), GetCameraTransform().pos)

end

function tick()

    isUsingTool = TOOL:active()
    osc = oscillate(1.5)/2

    startWithTool()
    manageInput()

    runMod()

    manageDebugMode()
    debugMod()


    local spinner = FindJoint('spinner', true)
    SetJointMotor(spinner, 0.5, 50)

end

-- Control center for the mod.
function runMod()

    manageCameras()

    if RUN_ITEM_CHAIN then
        runItemChain()
    end

    if RUN_CAMERAS then
        SetCameraTransform(getSelectedCameraItem().item.viewTr) -- View the camera.
    end

end

-- Manages user input.
function manageInput()

    if InputPressed('f1') then
        initializeItemChain()
    end

    if InputPressed('f4') then -- Run item chain.
        RUN_ITEM_CHAIN = not RUN_ITEM_CHAIN
        beep()
    end

    if isUsingTool and InputPressed('r') then
        clearAllObjects()
        beep()
    end

    if InputPressed('g') then -- Activate camera mode.
        RUN_CAMERAS = not RUN_CAMERAS
    end

    if isUsingTool and InputPressed('rmb') then
        UI_SHOW_OPTIONS = not UI_SHOW_OPTIONS
        beep()
    end

end

-- Draw the outline and highlight of a shape
function drawShape(s)
    DrawShapeOutline(s, 1,1,1, 1)
    DrawShapeHighlight(s, 0.25)
end


UpdateQuickloadPatch()
