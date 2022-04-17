UI_SELECTED_ITEM = 1

UI_SET_CAMERA = false
UI_SET_CAMERA_SHAPE = false

scrolly = 0


--- Draw the pane containing the list of items.
function drawItemListMenu()

    local listH = 50
    local w = UiWidth() - listH
    local h = listH

    if #ITEM_CHAIN >= 1 then

        -- List items
        do UiPush()
            for index, item in ipairs(ITEM_CHAIN) do
                uiList_Item(item.item.type, index, item, listH)
                margin(0, listH)
            end
        end UiPop()

        -- Draw dynamic list buttons.
        do UiPush()
            for index, item in ipairs(ITEM_CHAIN) do
                uiList_dynamicButtons(w,h, index)
                margin(0, listH)
            end
        end UiPop()

    else

        -- No items = draw add button.
        do UiPush()
            margin(UiWidth()/2, h/2)
            uiList_addItem(1)
        end UiPop()

    end

end

-- Draw a single item in the list of items.
function uiList_Item(text, itemChainIndex, item, listH)
    do UiPush()

        UiAlign('left top')

        local w = UiWidth() - listH
        local h = listH

        local bw = listH / 2
        local bh = listH / 2

        local r,g,b,a = 0.6,0.6,0.6,1 -- Button solid color
        local ro,go,bo,ao = 1,1,1,0 -- Button outline color

        -- Selected item.
        if itemChainIndex == UI_SELECTED_ITEM then
            ro,go,bo,ao = 1,1,1,1
            r,g,b,a = osc + 0.5 ,osc + 0.5 ,osc + 0.5 ,1
        end

        -- Uninitiazlied item.
        if item.type == 'uninitialized' then
            r,g,b =
            1 - oscillate(1.5)/2,
            1 - oscillate(1.5)/2,
            0 - oscillate(1.5)/2
        end

        -- Invalid items
        local sequentialCameras =
            item.type == 'camera'
            and (ITEM_CHAIN[GetTableNextIndex(ITEM_CHAIN, itemChainIndex)].type == 'camera'
                or ITEM_CHAIN[GetTablePrevIndex(ITEM_CHAIN, itemChainIndex)].type == 'camera')

        local hasEvents = tableContainsComponentType(ITEM_CHAIN, 'event')

        if sequentialCameras and hasEvents then
            r,g,b = oscillate(1.5)/2 + 0.5, 0.25, 0.25
        end


        -- Button base
        UiButtonImageBox('ui/common/box-solid-6.png', 10,10, r,g,b, a)
        if UiTextButton(' ', w,h) then
            UI_SELECTED_ITEM = itemChainIndex -- Changed selected ui item
        end


        -- Left side
        do UiPush()

            UiAlign('center middle')
            UiColor(0,0,0, 1)


            margin(bw/1.5, bh)
            UiText(tostring(itemChainIndex)) -- Item number index.

            margin(bw*1.5, 0)
            UiAlign('center middle')

            if item.type == 'camera' and item.item.id == SELECTED_CAMERA then
                UiColor(0,0,1, 1)
            elseif item.type == 'event' and item.item.id == SELECTED_EVENT then
                UiColor(0,0,1, 1)
            end
            -- Icon: Item type
            if item.type == 'camera' then
                UiImageBox('MOD/img/icon_camera.png', bw * 1.25, bh * 1.25, 0,0)
            elseif item.type == 'event' then
                UiImageBox('MOD/img/icon_event.png', bw * 1.25, bh * 1.25, 0,0)
            end

            UiColor(0,0,0, 1)

            UiAlign('left middle')
            margin(bw*1.5, 0)
            UiText(item.item.type)

            margin(130, 0)
            UiText('Name')

        end UiPop()


        -- Button: Delete item
        do UiPush()

            margin(w-bw, h/2)

            UiAlign('center middle')
            UiColor(1,0,0, 1)

            local mult = 1.25
            if UiIsMouseInRect(bw*mult, bh*mult) then
                mult = 1.25
            end
            UiButtonImageBox('MOD/img/button_garbage.png', 0,0, 1,0,0, 1)
            if UiTextButton(' ', bw * mult, bh * mult) then
                deleteItem(ITEM_CHAIN, itemChainIndex)
            end

            margin(-bw*1.5, 0)
            local c = {0,0,0,1}
            -- if UI_SELECTED_ITEM == itemChainIndex and RUN_CAMERAS then
            --     c = {0,1,0,1}
            -- end
            UiButtonImageBox('MOD/img/icon_eye.png', 0,0, c[1],c[2],c[3],c[4])
            if UiTextButton(' ', bw * mult, bh * mult) then
                UI_SELECTED_ITEM = itemChainIndex

                local tr = TransformCopy(ITEM_CHAIN[UI_SELECTED_ITEM].item.tr)
                tr.pos = VecSub(tr.pos, playerRelCamPos) -- Compensate for player tr to cam tr

                SetPlayerTransform(tr)
            end

        end UiPop()


        -- Buttons: Reorder
        do UiPush()

            margin(w + 10, 5)

            UiButtonImageBox('MOD/img/icon_arrow_up.png', 0,0, 1,1,1,0.8)
            UiButtonHoverColor(0.5,0.5,0.5, 1)
            if UiTextButton(' ', bw,bh) then
                local index = GetTablePrevIndex(ITEM_CHAIN, itemChainIndex)
                ITEM_CHAIN = TableSwapIndex(ITEM_CHAIN, itemChainIndex, index)
                UI_SELECTED_ITEM = index
            end

            margin(0, bh/2+10)

            UiButtonImageBox('MOD/img/icon_arrow_down.png', 0,0, 1,1,1,0.8)
            UiButtonHoverColor(0.5,0.5,0.5, 1)
            if UiTextButton(' ', bw,bh) then
                local index = GetTableNextIndex(ITEM_CHAIN, itemChainIndex)
                ITEM_CHAIN = TableSwapIndex(ITEM_CHAIN, itemChainIndex, index)
                UI_SELECTED_ITEM = index
            end

        end UiPop()

        UiColor(ro,go,bo, ao)
        for i = 0, 4 do
            do UiPush()
                margin(i,i)
                UiImageBox('ui/common/box-outline-6.png', w-(i*2), h-(i*2), 10, 10)
            end UiPop()
        end

    end UiPop()
end

-- Dynamic buttons.
function uiList_dynamicButtons(w,h, index)
    do UiPush()

        margin(0, -h/3)
        UiColor(1,1,0, 0.5)
        if UiIsMouseInRect(w, h * 1.75) then

            margin(0, h/3)

            if index == 1 then
                do UiPush() -- Before selected item.

                    margin(w/2, 0)
                    uiList_addItem(index)

                    margin(45, 0)
                    uiList_duplicateItem(index)

                end UiPop()
            end

            do UiPush() -- After selected item.

                margin(w/2,h)
                uiList_addItem(index + 1)

                margin(45, 0)
                uiList_duplicateItem(index)

            end UiPop()
        end

    end UiPop()
end

-- Add item.
function uiList_addItem(index)
    do UiPush()

        UiColor(1,1,1,1)
        UiAlign('center middle')

        UiButtonImageBox('MOD/img/button_plus.png', 0,0, 1,1,1, 1)
        UiButtonHoverColor(1,1,1, 1)
        if UiTextButton('.', 40, 40) then
            UI_SELECTED_ITEM = index
            createUninitializedItem(ITEM_CHAIN, index)
        end

    end UiPop()
end

-- Duplicate item.
function uiList_duplicateItem(index)
    do UiPush()

        UiColor(1,1,1,1)
        UiAlign('center middle')

        UiButtonImageBox('MOD/img/icon_duplicate.png', 0,0, 1,1,1, 1)
        UiButtonHoverColor(1,1,1, 1)
        if UiTextButton(' ', 40, 40) then
            UI_SELECTED_ITEM = index
            duplicateItem(ITEM_CHAIN[index], index)
        end

    end UiPop()
end

function uiDrawControlPanel(_w, _h, rectH)

    local w = _w/#UiControls
    local h = _h

    UiWindow(_w, rectH)

    for i = 1, #UiControls do

        local control = UiControls[i]

        UiColor(0,0,0, 0.5)
        UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 0,0,0, 0.5)
        UiButtonHoverColor(0,0,0, 0.5)
        if UiTextButton(' ', w, rectH) then
            control.func()
        end

        UiColor(0,0,0, 0.5)
        UiImageBox('ui/common/box-outline-6.png', w, rectH, 10,10)

        UiColor(1,1,1, 1)
        do UiPush()

            do UiPush()
                margin(w/2, h/2)
                UiAlign('center middle')
                UiImageBox(control.icon, h/2, h/2)
            UiPop() end

            margin(w/2, h)

            UiAlign('center top')
            UiText(control.title)

            margin(0, 32)

            UiFont('bold.ttf', 28)
            UiText(control.keybind)

        UiPop() end

        margin(w, 0)

    end

end
