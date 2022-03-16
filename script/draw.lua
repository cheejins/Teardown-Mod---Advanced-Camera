UI_SHOW_OPTIONS = false


function drawControls()

    do UiPush()

        local yMargin = 30

        margin(50, 350)
        UiAlign('left top')

        UiColor(0,0,0, 0.5)
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
        UiColor(0,0,0, 0.5)

        -- Background
        UiRect(500, 400)

        margin(20, 20)
        UiColor(1,1,1, 1)
        UiText('Item Objects')

        margin(0, 10)
        for index, item in ipairs(ITEM_OBJECTS) do

            margin(0, 30)

            do UiPush()

                local itemValues = {
                    item = item.type,
                    type = item.item.type,
                }

                local text = ''
                for key, value in pairs(itemValues) do
                    text = text .. '[' .. key .. '=' .. value .. ']'
                end

                UiText('['..item.id..']  ' .. text)

            UiPop() end

        end

    UiPop() end

    do UiPush()

        margin(UiCenter()+400, 420)

        UiAlign('left top')
        UiFont('bold.ttf', 24)
        UiColor(0,0,0, 0.5)

        -- Background
        UiRect(500, 400)

        margin(20, 20)
        UiColor(1,1,1, 1)
        UiText('Item Chain')

        margin(0, 10)

        -- local itemChain = {}
        -- for key, event in pairs(EVENT_OBJECTS) do

        --     local master = getCameraById(event.link.camera.master)
        --     table.insert(itemChain, master)

        --     table.insert(itemChain, event)

        -- end

        for index, item in ipairs(ITEM_OBJECTS) do

            margin(0, 30)

            do UiPush()

                if item.item == EVENT_OBJECTS[EVENT_SELECTED] or item.item == CAMERA_OBJECTS[SELECTED_CAMERA] then
                    UiColor(0.5,1,0.5, 1)
                end

                local time = ''
                if item.item.type == 'wait' then
                    time = 'Time = ' .. sfn(item.item.val.time)
                end

                UiText('['.. index ..']  ' .. ' [Type=' .. item.item.type .. '] ' .. time .. '')

            UiPop() end

        end

    UiPop() end

end

function margin(x,y)
    UiTranslate(x,y)
end
