UI_SHOW_OPTIONS = false


function drawControls()

    do UiPush()

        local yMargin = 30

        margin(50, 350)
        UiAlign('left top')

        UiColor(0,0,0, 0.7)
        UiRect(250, (GetTableSize(KEYS) + 1) * 30 + 40)

        margin(20,20)
        UiColor(1,1,1, 1)
        UiText('CONTROLS')
        UiFont('regular.ttf', 24)
        UiTextShadow(0,0,0,0.5, 0.5,0)

        for key, k in pairs(KEYS) do
            margin(0, yMargin)
            UiText(k.key .. ' = ' .. k.desc)
        end

    UiPop() end

    do UiPush()

        margin(UiCenter(), UiHeight() - 50)
        UiText('Press ctrl+d to enable/disable adv cam debug mode')

    UiPop() end

end

function drawCameraNumbers()
    for key, camera in pairs(CAMERA_OBJECTS) do -- Draw camera numbers

        if TransformToLocalPoint(GetCameraTransform(), camera.def.tr.pos)[3] < 0 then

            local x,y = UiWorldToPixel(camera.def.tr.pos)

            do UiPush()
                margin(x,y)
                UiText(camera.id)
            UiPop() end

        end

    end
end

function drawUi()

    UiTextShadow(0,0,0,0.5, 0.5,0)


    if UI_SHOW_OPTIONS then
        UiMakeInteractive()
    end

    do UiPush()

        margin(UiCenter()+400, 0)

        UiAlign('left top')
        UiFont('bold.ttf', 24)
        UiColor(0,0,0, 0.7)

        -- Background
        UiRect(500, 500)

        margin(20, 20)
        UiColor(1,1,1, 1)
        UiText('Item Chain')

        margin(0, 10)
        UiColor(1,1,1, 0.5)


        for index, item in ipairs(ITEM_OBJECTS) do

            margin(0, 30)

            do UiPush()

                local nextEvent = getEventById(EVENT_OBJECTS[EVENT_SELECTED].link.event.next)

                if item.item == EVENT_OBJECTS[EVENT_SELECTED]
                or item.item == CAMERA_OBJECTS[SELECTED_CAMERA] then
                    UiColor(0.5,1,0.5, 1)
                end

                if item.type == 'event' then
                    if item.item == nextEvent then
                        UiColor(1,0.5,0.2, 1)
                    end
                end

                if item.type == 'camera' then
                    if item.item == getCameraById(nextEvent.link.camera.master) and item.item ~= CAMERA_OBJECTS[SELECTED_CAMERA] then
                        UiColor(1,0.5,0.2, 1)
                    end
                end

                local time = ''
                if item.item.type == 'wait' then
                    time = 'Time = ' .. sfn(item.item.val.time)
                end


                UiText(item.item.type .. item.item.id..' - '  .. time .. '')


            UiPop() end

        end

        margin(0, 60)

        local event = EVENT_OBJECTS[EVENT_SELECTED]
        local camera = CAMERA_OBJECTS[SELECTED_CAMERA]

        local nextEvent = getEventById(event.link.event.next)
        local nextCamera = getCameraById(nextEvent.link.camera.master)

        UiColor(1,1,1, 1)
        UiText(camera.type .. camera.id .. ' -> ' .. nextCamera.type .. nextCamera.id)

        margin(0, 30)
        UiText(event.type .. event.id .. '  ->  '.. nextEvent.type .. nextEvent.id)


    UiPop() end

end

function margin(x,y)
    UiTranslate(x,y)
end
