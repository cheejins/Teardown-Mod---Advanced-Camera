UI_SHOW_OPTIONS = true

pad = 20
pad2 = 40

function draw()

    UiAlign('center middle')
    UiFont('bold.ttf', 20)
    UiColor(0,0,0,1)

    -- Debug
    -- if db then drawCameraNumbers() end
    drawCameraNumbers()
    debugCameraLines()

    -- Is wielding tool
    if TOOL:active() then
        if db then

            do UiPush()

                drawControls()

                margin(350, 10)
                drawItemChain()

                margin(400, 0)
                drawItemObjects()

                margin(400, 0)
                drawCameraList()

                margin(400, 0)
                drawEventList()

            UiPop() end

        end
    end

    -- Main UI
    if UI_SHOW_OPTIONS then
        drawMainUI()
    end

    -- Update component properties.
    uiSetFont(48)
    if UI_SET_CAMERA then
        ui_Mod_Camera_Set(getUiSelectedItem())
    elseif UI_SET_CAMERA_SHAPE then
        ui_Mod_Camera_SetShape(getUiSelectedItem())
    end


    -- local videoDesc = 'This video demonstrates the way different types of events can be inserted into the item chain. The two events right now are "wait" and "lerp". Lerp is the event which move between the current and next camera. More events and event modifications are on the way'
    -- drawVideoDesc(videoDesc)

end

function drawMainUI()

    UiMakeInteractive()

    do UiPush()

        do UiPush()
        UiPop() end

        UiAlign('left top')
        UiColor(0,0,0, 0.8)

        local mouseInUi = false


        -- PANE 1
        do UiPush()

            margin(pad, pad)
            UiRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            mouseInUi = mouseInUi or UiIsMouseInRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            UiWindow(UiWidth()/3 - pad2, UiHeight() - pad2, true)

            UiColor(1,1,1, 0.8)
            do UiPush()
                UiAlign('center top')
                UiFont('regular.ttf', 36)
                margin(UiCenter(), pad)
                UiText('OPTIONS')
            UiPop() end
            margin(pad/2,70)

        UiPop() end
        margin(UiWidth()/3, 0)


        -- PANE 2
        do UiPush()

            margin(pad, pad)
            UiRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            mouseInUi = mouseInUi or UiIsMouseInRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            UiWindow(UiWidth()/3 - pad2, UiHeight() - pad2, true)

            UiColor(1,1,1, 0.8)
            do UiPush()
                UiAlign('center top')
                UiFont('regular.ttf', 36)
                margin(UiCenter(), pad)
                UiText('ITEMS')
            UiPop() end
            margin(pad/2,70)

            scrolly = scrolly + (InputValue('mousewheel') * -30)
            scrolly = clamp(scrolly, 0, #ITEM_CHAIN * 50)

            UiColor(0,0,0, 1)
            -- UiWindow(UiWidth(), UiHeight() - 100, true)
            UiWindow(UiWidth(), UiHeight() - 100)
            margin(0, -scrolly)
            drawItemListMenu()

        UiPop() end
        margin(UiWidth()/3, 0)


        -- PANE 3
        do UiPush()

            margin(pad, pad)
            UiRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            mouseInUi = mouseInUi or UiIsMouseInRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            UiWindow(UiWidth()/3 - pad2, UiHeight() - pad2, true)
            UiWindow(UiWidth() - pad/2, UiHeight() - pad, true)


            UiColor(1,1,1, 0.8)
            do UiPush()
                UiAlign('center top')
                UiFont('regular.ttf', 36)
                margin(UiCenter(), pad)
                UiText('MODIFY ITEM')
            UiPop() end
            margin(pad/2,70)

            if #ITEM_CHAIN >= 1 then
                local item = ITEM_CHAIN[UI_SELECTED_ITEM] or ITEM_CHAIN[1]
                uiMod_Item(item)
            end

        UiPop() end
        margin(UiWidth()/3, 0)


        -- Close UI if mouse is clicked off of a panel.
        if InputPressed('lmb') and not mouseInUi then
            UI_SHOW_OPTIONS = not UI_SHOW_OPTIONS
        end


    end UiPop()

end
