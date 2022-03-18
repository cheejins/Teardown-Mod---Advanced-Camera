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


    if RUN_ITEM_CHAIN then
        do UiPush()
            margin(UiCenter(), UiMiddle())
            UiColor(1,1,1,1)
            UiFont('regular.ttf', 24)

            -- UiText('CAM: ' .. getCurrentCamera().id)
        UiPop() end
    end

end

function drawUi()

    UiTextShadow(0,0,0,0.5, 0.5,0)


    if UI_SHOW_OPTIONS then
        UiMakeInteractive()
    end

    do UiPush()

        margin(UiCenter()+550, 0)

        UiAlign('left top')
        UiFont('bold.ttf', 22)
        UiColor(0,0,0, 0.9)

        -- Background
        UiRect(400, 700)

        margin(20, 20)
        UiColor(1,1,1, 1)
        UiText('ITEM CHAIN')

        UiColor(1,1,1, 0.5)
        margin(0, 30)
        UiText('Execution order')

        margin(0, 60)

        do UiPush()

            for index, item in ipairs(ITEM_CHAIN) do

                do UiPush()

                    if item.type == 'camera' and item.item.id == SELECTED_CAMERA then
                        UiColor(0.5,1,0.5,1)
                    elseif item.type == 'event' and item.item.id == SELECTED_EVENT then
                        UiColor(1,1,0,1)
                    end

                    UiText('['.. index ..'] ' .. item.type)
                    margin(120, 0)
                    UiText('' .. item.item.id)
                    margin(0, 24)

                UiPop() end

                margin(0, 50)

            end

        UiPop() end

    UiPop() end

    do UiPush()

        margin(UiCenter()+100, 0)

        UiAlign('left top')
        UiFont('bold.ttf', 22)
        UiColor(0,0,0, 0.9)

        -- Background
        UiRect(400, 700)

        margin(20, 20)
        UiColor(1,1,1, 1)
        UiText('ITEM OBJECTS')

        UiColor(1,1,1, 0.5)
        margin(0, 30)
        UiText('Orded by date created')

        margin(0, 60)

        do UiPush()

            for index, item in ipairs(ITEM_OBJECTS) do

                do UiPush()

                    if item.type == 'camera' and item.item.id == SELECTED_CAMERA then
                        UiColor(0.5,1,0.5,1)
                    elseif item.type == 'event' and item.item.id == SELECTED_EVENT then
                        UiColor(1,1,0,1)
                    end

                    UiText('['.. index ..'] ' .. item.type)
                    margin(120, 0)
                    UiText(item.item.id)
                    margin(0, 24)

                UiPop() end

                margin(0, 50)

            end

        UiPop() end

    UiPop() end

end

function margin(x,y)
    UiTranslate(x,y)
end
