#include "script/camera.lua"
#include "script/cameraFunctions.lua"
#include "script/mainFunctions.lua"
#include "script/debug.lua"
#include "script/utility.lua"


function init()
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

        for key, camera in pairs(CAMERA_OBJECTS) do -- Draw camera numbers

            if TransformToLocalPoint(camera.trStart, GetCameraTransform())[3] < 0 then

                local x,y = UiWorldToPixel(camera.trStart.pos)
                UiPush()
                    UiTranslate(x,y)
                    UiText(camera.id)
                UiPop()

            end

        end

        UiPush()

            local yMargin = 30

            UiTranslate(UiWidth() - 270, yMargin)

            UiAlign('left top')
            UiText('CAMERA CONTROLS')


            UiTranslate(0, yMargin)
            UiText('g = create camera')

            UiTranslate(0, yMargin)
            UiText('r = camera mode on/off')

            UiTranslate(0, yMargin)
            UiText('e = next camera')

            UiTranslate(0, yMargin)
            UiText('q = previous camera')

            UiTranslate(0, yMargin)
            UiText('t = delete all cameras')

            UiTranslate(0, yMargin)
            UiText('z = delete last camera')

            UiTranslate(0, yMargin)
            UiText('y = auto lerp on/off')

        UiPop()

        UiPush()
            UiTranslate(UiCenter(), UiHeight() - 50)
            UiText('Press ctrl+d to enable/disable adv cam debug mode')
        UiPop()

    end

end
