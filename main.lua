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
#include "script/uiControlPanel.lua"
#include "script/uiTools.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"


-- Item objects are used as base containers for components (event and camera objects).


-- UI middle pane.
UI_SELECTED_ITEM = 1
UI_SET_CAMERA = false
UI_SET_CAMERA_SHAPE = false

-- Control panel.
UI_SHOW_OPTIONS = true
UI_PIN_CONTROL_PANEL = true
UI_SHOW_DETAILS = false
DRAW_CAMERAS = true
RUN_CAMERAS = false



function init()
    playerRelCamPos = TransformToLocalPoint(GetPlayerTransform(), GetCameraTransform().pos)
    initUiControlPanel()
end

function tick()

    isUsingTool = TOOL:active()
    osc = oscillate(1.5)/2
    startWithTool()

    runMod()

    manageDebugMode(UI_SHOW_DETAILS)
    debugMod()


    local spinner = FindJoint('spinner', true)
    SetJointMotor(spinner, 0.5, 50)

end

-- Control center for the mod.
function runMod()

    manageInput()
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

    for i = 1, #UiControls do

        local control = UiControls[i]

        if InputPressed(control.keybind) then
            _G[control.func]()
        end

    end

end


UpdateQuickloadPatch()
