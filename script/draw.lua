UI_SHOW_OPTIONS = true

pad = 20
pad2 = 40

function draw()

    UiAlign('center middle')
    UiFont('bold.ttf', 20)
    UiColor(0,0,0,1)


    if not RUN_ITEM_CHAIN then
        drawCameras()
    end

    -- Is wielding tool
    -- if TOOL:active() then
        if db then

            do UiPush()

                drawControls()

                margin(350, 10)
                drawItemChain()

                margin(400, 0)
                -- drawItemObjects()

                margin(400, 0)
                drawCameraList()

                margin(400, 0)
                drawEventList()

            UiPop() end

        end
    -- end

    -- Main UI
    if UI_SHOW_OPTIONS then
        ui_Panes()
    end

    do UiPush()
        -- Update component properties.
        uiSetFont(48)
        if UI_SET_CAMERA then
            ui_Mod_Camera_Set(getUiSelectedItem())
        elseif UI_SET_CAMERA_SHAPE then
            ui_Mod_Camera_SetShape(getUiSelectedItem())
        end
    UiPop() end

    -- local videoDesc = 'The user can now create, delete, update, duplicate and re-order items in the chain. The option to set a sticky object will keep a camera relative to that object. The lerp events work to smoothly move between cameras. There is a time based lerp and a speed based lerp.'
    -- drawVideoDesc(videoDesc)

end

function ui_Panes()

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
            scrolly = clamp(scrolly, 0, #ITEM_CHAIN * 40)

            UiColor(0,0,0, 1)
            UiWindow(UiWidth(), UiHeight() - 100, true)
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


function drawCameras()
    for key, cam in pairs(CAMERA_OBJECTS) do

        local item = getItemByCameraId(cam.id)
        local camItemIndex = getItemIndex(ITEM_CHAIN, getItemByCameraId(cam.id))

        local isSelectedCamera = cam.id == SELECTED_CAMERA
        local isSelectedItem = item == ITEM_CHAIN[UI_SELECTED_ITEM]

        -- Selected item flashes.
        local a = ternary(isSelectedItem, osc, 1)


        local fs = 25 -- Font size.
        UiFont('bold.ttf', fs)


        -- Line from camera to camera target.
        DebugLine(cam.viewTr.pos, TransformToParentPoint(cam.viewTr, Vec(0,0,-5)), 1,1,1, a)

        -- Line from camera to camera target.
        if cam.shape then
            DebugLine(cam.tr.pos, AabbGetShapeCenterPos(cam.shape), 1,1,1, a)
        end

        -- If the camera is infront of the player cam.
        if TransformToLocalPoint(GetCameraTransform(), cam.viewTr.pos)[3] < 0 then

            -- Draw camera direction dot.
            do UiPush()
                local pos = TransformToParentPoint(cam.viewTr, Vec(0,0,-5))
                local x,y = UiWorldToPixel(pos)
                margin(x,y)

                UiColor(0,0,0, a)
                UiImageBox('ui/hud/dot-small.png', 35,35, 0,0)

                UiColor(1,1,1, a)
                UiImageBox('ui/hud/dot-small.png', 32,32, 0,0)
            UiPop() end

            -- Draw camera viewTr icon.
            do UiPush()
                local pos = cam.viewTr.pos
                local x,y = UiWorldToPixel(pos)
                margin(x,y)

                UiColor(0,0,0, a)
                UiImageBox('MOD/img/icon_camera_frame.png', 45,45, 0,0)

                UiColor(1,1,1, a)
                UiImageBox('MOD/img/icon_camera_frame.png', 42,42, 0,0)
            UiPop() end

        end

        -- If the camera is infront of the player cam.
        if TransformToLocalPoint(GetCameraTransform(), cam.tr.pos)[3] < 0 then

            -- Draw camera tr icon
            do UiPush()
                local pos = cam.tr.pos
                local x,y = UiWorldToPixel(pos)
                margin(x,y)

                UiColor(0,0,0, a)
                UiImageBox('MOD/img/icon_camera_classic.png', 45,45, 0,0)

                UiColor(0.4,0.4,0.4, 1)
                if isSelectedCamera then

                    UiColor(0,0,1, 1)

                    if isSelectedItem then
                        UiColor(0,0,1, a)
                    end

                elseif isSelectedItem then
                    UiColor(1,1,1, a)
                end

                UiImageBox('MOD/img/icon_camera_classic.png', 40,40, 0,0)
            UiPop() end

            -- Draw camera number
            do UiPush()
                local x,y = UiWorldToPixel(cam.tr.pos)
                margin(x,y-35)

                UiColor(0,0,0, 0.5)
                UiRect(fs, fs)

                UiColor(1,1,1, 1)
                UiText(camItemIndex)
            UiPop() end

        end

    end
end
