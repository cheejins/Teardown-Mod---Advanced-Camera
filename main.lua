#include "script/debug.lua"
#include "script/ui/draw.lua"
#include "script/ui/drawDebug.lua"
#include "script/item/camera.lua"
#include "script/item/event.lua"
#include "script/item/item.lua"
#include "script/item/itemChain.lua"
#include "script/item/itemSelection.lua"
#include "script/keys.lua"
#include "script/tool.lua"
#include "script/ui/ui.lua"
#include "script/ui/uiBinding.lua"
#include "script/ui/uiPresetSystem.lua"
#include "script/ui/uiControlPanel.lua"
#include "script/ui/uiModItem.lua"
#include "script/ui/uiTools.lua"
#include "script/input.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"


-- Item objects are used as base containers for components (event and camera objects).

OPTIONS = false

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

    InitKeys()
    initUiControlPanel()
    initPresets()

    if OPTIONS then -- Do not run mod for options.lua.
        return
    end

    playerRelCamPos = TransformToLocalPoint(GetPlayerTransform(), GetCameraTransform().pos)

end


function tick()

    if OPTIONS then -- Do not run mod for options.lua.
        return
    end

    isUsingTool = TOOL:active()
    osc = oscillate(1.5)/2
    startWithTool()

    runMod()

    manageDebugMode(UI_SHOW_DETAILS)
    debugMod()


    local spinner = FindJoint('spinner', true)
    SetJointMotor(spinner, 0.5, 50)

end


function draw()

    if OPTIONS then -- Do not run mod for options.lua.
        return
    end

    drawUi()

end

-- Control center for the mod.
function runMod()

    manageInput()
    manageCameras()
    manageUiBinding()

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

        local comboKey = ternary(KEYS[control.name].key1 == '-', '', KEYS[control.name].key1)

        if InputDown(comboKey) and InputPressed(KEYS[control.name].key2) then
            _G[control.func]()
        end

    end

    if InputPressed('rmb') and isUsingTool then
        UI_SHOW_OPTIONS = not UI_SHOW_OPTIONS
    end

end


UpdateQuickloadPatch()
