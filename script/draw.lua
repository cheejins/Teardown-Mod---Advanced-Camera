UI_SHOW_OPTIONS = false


function drawControls()

    do UiPush()

        local yMargin = 30

        UiTranslate(UiWidth() - 270, yMargin)
        UiAlign('left top')
        UiText('CAMERA CONTROLS')

        for key, k in pairs(KEYS) do
            UiTranslate(0, yMargin)
            UiText(k.key .. ' = ' .. k.desc)
        end

    UiPop() end

    do UiPush()

        UiTranslate(UiCenter(), UiHeight() - 50)
        UiText('Press ctrl+d to enable/disable adv cam debug mode')

    UiPop() end

end

function drawCameraNumbers()
    for key, camera in pairs(CAMERA_OBJECTS) do -- Draw camera numbers

        if TransformToLocalPoint(GetCameraTransform(), camera.def.tr.pos)[3] < 0 then

            local x,y = UiWorldToPixel(camera.def.tr.pos)

            do UiPush()
                UiTranslate(x,y)
                UiText(camera.id)
            UiPop() end

        end

    end
end

function drawUi()

    if TOOL:active() then

        if UI_SHOW_OPTIONS then
            UiMakeInteractive()
        end

        do UiPush()

            margin(UiCenter()*1.25, UiMiddle()/5)

            UiAlign('left top')
            UiFont('regular.ttf', 24)
            UiColor(0,0,0, 0.9)

            -- Background
            UiRect(400, 400)

            margin(20, 20)
            UiColor(1,1,1, 1)
            UiText('Event Objects')

            UiFont('regular.ttf', 20)
            margin(0, 10)
            for index, event in ipairs(EVENT_OBJECTS) do

                margin(0, 30)

                do UiPush()

                    if event == EVENT_OBJECTS[EVENT_SELECTED] then
                        UiColor(0.5,1,0.5, 1)
                    end

                    UiText('[' .. index .. ']' .. 'Event ID = ' .. event.id .. '       Type = ' .. event.type .. '       Time = ' .. sfn(event.val.time))

                UiPop() end

            end

        UiPop() end

        do UiPush()

            margin(UiCenter()*1.25, UiMiddle()/5 + 420)

            UiAlign('left top')
            UiFont('regular.ttf', 24)
            UiColor(0,0,0, 0.9)

            -- Background
            UiRect(400, 400)

            margin(20, 20)
            UiColor(1,1,1, 1)
            UiText('Camera Objects')

            UiFont('regular.ttf', 20)
            margin(0, 10)
            for index, camera in ipairs(CAMERA_OBJECTS) do

                margin(0, 30)

                do UiPush()

                    if camera == CAMERA_OBJECTS[SELECTED_CAMERA] then
                        UiColor(0.5,1,0.5, 1)
                    end

                    UiText('[' .. index .. ']' .. ' Camera ID = ' .. camera.id)

                UiPop() end

            end

        UiPop() end

    end

end

function margin(x,y)
    UiTranslate(x,y)
end