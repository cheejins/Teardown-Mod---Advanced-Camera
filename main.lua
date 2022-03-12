#include "script/utility.lua"
#include "script/tool.lua"
#include "script/mainFunctions.lua"
#include "script/keys.lua"
#include "script/event_functions.lua"
#include "script/event.lua"
#include "script/draw.lua"
#include "script/debug.lua"
#include "script/cameraFunctions.lua"
#include "script/camera.lua"


function init()

    initTool()
    initKeys()

end


function tick(dt)

    runCameraSystem()

    manageDebugMode()
    debugMod()

end


function update(dt)
end
function draw(dt)

    UiAlign('center middle')
    UiFont('bold.ttf', 24)
    UiColor(0,0,0,1)

    if db then
        drawCameraNumbers()
        drawControls()
    end

end
