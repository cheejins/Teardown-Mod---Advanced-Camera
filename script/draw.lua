UI_SHOW_OPTIONS = false


function draw()

    UiAlign('center middle')
    UiFont('bold.ttf', 24)
    UiColor(0,0,0,1)

    if db then
        drawCameraNumbers()
    end

    if TOOL:active() then
        drawUi()
        if db then
            drawControls()
        end
    end

end


function drawControls()

    do UiPush()

        local yMargin = 30

        margin(50, 200)
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

        if TransformToLocalPoint(GetCameraTransform(), camera.tr.pos)[3] < 0 then

            local x,y = UiWorldToPixel(camera.tr.pos)

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

    -- UiAlign('center middle')
    -- UiFont('bold.ttf', 24)
    -- UiColor(0.75,0.75,0.75, 0.75)

    -- do UiPush()

    --     local rectW = 300
    --     local rectH = 250

    --     margin(UiCenter(), rectH/2)

    --     UiColor(0.5,0.5,1, 0.5)

    --     UiRect(rectW + 50, rectH)
    --     UiWordWrap(rectW)
    --     UiColor(0,0,0, 1)

    --     UiText('This video demonstrates the way different types of events can be inserted into the item chain. The two events right now are "wait" and "lerp". Lerp is the event which move between the current and next camera. More events and event modifications are on the way')


    -- UiPop() end



    UiTextShadow(0,0,0,0.5, 0.5,0)


    if UI_SHOW_OPTIONS then
        UiMakeInteractive()
    end

    do UiPush()

        margin(UiCenter()+550, 10)

        UiAlign('left top')
        UiFont('bold.ttf', 22)
        UiColor(0,0,0, 0.9)

        -- Background
        UiRect(400, 750)

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

                    margin(40, 0)
                    if item.type == 'event' then
                        UiText(sfn(item.item.val.time))
                    end

                    margin(70, 0)
                    UiText(item.item.type)

                UiPop() end

                margin(0, 50)

            end

        UiPop() end

    UiPop() end

    -- do UiPush()

    --     margin(UiCenter()+100, 0)

    --     UiAlign('left top')
    --     UiFont('bold.ttf', 22)
    --     UiColor(0,0,0, 0.9)

    --     -- Background
    --     UiRect(400, 750)

    --     margin(20, 20)
    --     UiColor(1,1,1, 1)
    --     UiText('ITEM OBJECTS')

    --     UiColor(1,1,1, 0.5)
    --     margin(0, 30)
    --     UiText('Orded by date created')

    --     margin(0, 60)

    --     do UiPush()

    --         for index, item in ipairs(ITEM_OBJECTS) do

    --             do UiPush()

    --                 if item.type == 'camera' and item.item.id == SELECTED_CAMERA then
    --                     UiColor(0.5,1,0.5,1)
    --                 elseif item.type == 'event' and item.item.id == SELECTED_EVENT then
    --                     UiColor(1,1,0,1)
    --                 end

    --                 UiText('['.. index ..'] ' .. item.type)
    --                 margin(120, 0)
    --                 UiText(item.item.id)

    --                 if item.type == 'event' then
    --                     margin(40, 0)
    --                     UiText(sfn(item.item.val.time))
    --                 end

    --             UiPop() end

    --             margin(0, 50)

    --         end

    --     UiPop() end

    -- UiPop() end

end

function margin(x,y)
    UiTranslate(x,y)
end
