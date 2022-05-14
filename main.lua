#include "script/debug.lua"
#include "script/input/controlPanel.lua"
#include "script/input/input.lua"
#include "script/input/keybinds.lua"
#include "script/item/camera.lua"
#include "script/item/event.lua"
#include "script/item/item.lua"
#include "script/item/itemChain.lua"
#include "script/item/itemSelection.lua"
#include "script/tool.lua"
#include "script/ui/draw.lua"
#include "script/ui/ui.lua"
#include "script/ui/uiDebug.lua"
#include "script/ui/uiModItem.lua"
#include "script/ui/uiPanes.lua"
#include "script/ui/uiPresetSystem.lua"
#include "script/ui/uiTextBinding.lua"
#include "script/ui/uiTools.lua"
#include "script/umf.lua"
#include "script/util.lua"
#include "script/utility.lua"


RunMod = true

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

    if OPTIONS then -- Do not run the main mod for options.lua.
        return
    end

    debugInit()

    playerRelCamPos = TransformToLocalPoint(GetPlayerTransform(), GetCameraTransform().pos)

end


function tick()

    if OPTIONS then -- Do not run the main mod for options.lua.
        return
    end


    if PauseMenuButton('Show Adv Cam') then
        UI_SHOW_OPTIONS = true
	end

    isUsingTool = TOOL:active()
    osc = oscillate(1.5)/2

    -- The whole entire mod in one funcdsfjl;ktokjl;ansdf
    if RunMod then
        RunMod()
    end

    -- Debug information
    manageDebugMode()
    debugMod()

end


function draw()

    if OPTIONS then -- Do not run the main mod for options.lua.
        return
    end

    if RunMod then
        drawUi()
    end

end

-- Control center for the mod.
function RunMod()

    ManageInput()
    ManageCameras()
    ManageUiBinding()

    if #ITEM_CHAIN <= 2  then
        RUN_ITEM_CHAIN = false
    end

    if RUN_ITEM_CHAIN then
        RunItemChain()
    end

    if RUN_CAMERAS and #CAMERA_OBJECTS >= 1 then
        local viewTr = getSelectedCameraItem().item.viewTr
        SetCameraTransform(viewTr) -- View the selected camera.
    end

end


UpdateQuickloadPatch()
