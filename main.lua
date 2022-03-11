#include "script/camera.lua"
#include "script/cameraFunctions.lua"
#include "script/debug.lua"
#include "script/draw.lua"
#include "script/keys.lua"
#include "script/mainFunctions.lua"
#include "script/tool.lua"
#include "script/utility.lua"


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
    UiColor(0,0,0,1)
    UiFont('bold.ttf', 24)

    if db then

        drawCameraNumbers()
        drawControls()

    end

end
