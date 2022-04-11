UI_SELECTED_ITEM = 1

-- typeTitles = {
--     lerpConst = 'Lerp Constant',
--     lerpTimed = 'Lerp Timed',
--     wait = 'Wait',
-- }

scrolly = 0


function drawItemListMenu()
    local listH = 60
    local w = UiWidth() - listH
    local h = listH
    if #ITEM_CHAIN >= 1 then
        do UiPush()
            for index, item in ipairs(ITEM_CHAIN) do
                uiListItem(item.item.type, index, item, listH)
                margin(0, listH)
            end
        end UiPop()
        do UiPush()
            for index, item in ipairs(ITEM_CHAIN) do
                uiList_addItemDynamic(w,h, index)
                margin(0, listH)
            end
        end UiPop()
    else
        do UiPush()
            margin(UiWidth()/2, h/2)
            uiList_addItem(1)
        end UiPop()
    end
end

function uiListItem(text, itemChainIndex, item, listH)
    do UiPush()

        UiAlign('left top')

        local w = UiWidth() - listH
        local h = listH

        local bw = listH / 2
        local bh = listH / 2

        local r,g,b,a = 1,1,1,0.75 -- Button solid color
        local ro,go,bo,ao = 1,1,1,0 -- Button outline color


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


        -- Selected item.
        if itemChainIndex == UI_SELECTED_ITEM then
            ro,go,bo,ao = 0.5, 0.5, 1, 1
        end


        -- Button base
        UiButtonImageBox('ui/common/box-solid-6.png', 10,10, r,g,b, a)
        if UiTextButton(' ', w,h) then
            UI_SELECTED_ITEM = itemChainIndex -- Changed selected ui item
        end


        -- Left side
        do UiPush()

            UiColor(0,0,0, 1)
            UiAlign('center middle')

            margin(bw/1.5, bh)
            UiText(tostring(itemChainIndex)) -- Item number index.

            margin(bw*1.5, 0)
            UiAlign('center middle')

            -- Icon: Item type
            if item.type == 'camera' then
                UiImageBox('MOD/img/icon_camera.png', bw * 1.25, bh * 1.25, 0,0)
            elseif item.type == 'event' then
                UiImageBox('MOD/img/icon_event.png', bw * 1.25, bh * 1.25, 0,0)
            end

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

            local mult = 1
            if UiIsMouseInRect(bw*mult, bh*mult) then
                mult = 1.25
            end
            UiButtonImageBox('MOD/img/button_garbage.png', 0,0, 1,0,0, 1)
            if UiTextButton(' ', bw * mult, bh * mult) then
                deleteItem(ITEM_CHAIN, itemChainIndex)
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

function uiList_addItemDynamic(w,h, index)
    do UiPush()

        margin(0, -h/3)
        if UiIsMouseInRect(w, h * 1.5) then

            margin(0, h/3)

            do UiPush()

                margin(w/2, 0)
                uiList_addItem(index)

                margin(45, 0)
                uiList_duplicateItem(index)

            end UiPop()

            do UiPush()

                margin(w/2,h)
                uiList_addItem(index)

                margin(45, 0)
                uiList_duplicateItem(index)

            end UiPop()

        end

    end UiPop()
end

function uiList_addItem(index)
    do UiPush()

        UiColor(1,1,1,1)
        UiAlign('center middle')

        UiButtonImageBox('MOD/img/button_plus.png', 0,0, 1,1,1, 1)
        UiButtonHoverColor(1,1,1, 1)
        if UiTextButton('.', 40, 40) then
            createUninitializedItem(ITEM_CHAIN, index)
            UI_SELECTED_ITEM = index
        end

    end UiPop()
end

function uiList_duplicateItem(index)
    do UiPush()

        UiColor(1,1,1,1)
        UiAlign('center middle')

        UiButtonImageBox('MOD/img/icon_duplicate.png', 0,0, 1,1,1, 1)
        UiButtonHoverColor(1,1,1, 1)
        if UiTextButton(' ', 40, 40) then
            duplicateItem(ITEM_CHAIN[index])
        end

    end UiPop()
end



function uiMod_Item(item)

    if item.type == 'uninitialized' then

        uiMod_UninitializedItem(ITEM_CHAIN, UI_SELECTED_ITEM)

    elseif item.type == 'camera' then

        UiText('type: ' .. item.type)
        margin(0, 32)
        UiText(item.type .. ' type: ' .. item.item.type)
        margin(0, 32)

    elseif item.type == 'event' then

        UiText('type: ' .. item.type)
        margin(0, 32)
        UiText(item.type .. ' type: ' .. item.item.type)
        margin(0, 32)

    end

end

function uiMod_UninitializedItem(tb, index)
    do UiPush()

        local fs = 24
        local btnW = UiCenter()
        local btnH = 80

        itemType = nil
        itemSubType = nil

        UiFont('regular.ttf', fs)
        UiAlign('left top')

        do UiPush()
            margin(UiCenter(), fs*3)
            UiAlign('center top')
            UiFont('regular.ttf', fs*1.25)
            UiText('Select an item to create...')
        UiPop() end


        margin(0, fs*4)
        do UiPush()
            margin(0, fs)
            UiText('Cameras:')

            UiColor(0,0,0, 1)

            do UiPush()
                margin(pad/4, fs*1.5)
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Static', btnW - pad, btnH - pad) then
                    itemType = 'camera'
                    itemSubType = 'static'
                end
                margin(btnW, 0)
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Relative', btnW - pad, btnH - pad) then
                    itemType = 'camera'
                    itemSubType = 'relative'
                end
            UiPop() end

            margin(0, fs*3)
            do UiPush()
                margin(pad/4, fs*1.5)
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Orbit', btnW - pad, btnH - pad) then
                    itemType = 'camera'
                    itemSubType = 'orbit'
                end
                -- margin(btnW, 0)
                -- UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                -- if UiTextButton(' ', btnW - pad, btnH - pad) then
                --     itemType = 'camera'
                --     itemSubType = ''
                -- end
            UiPop() end

        UiPop() end


        margin(0, fs*2 + btnH*2)
        do UiPush()
            margin(0, fs*1.5)
            UiText('Event:')

            UiColor(0,0,0, 1)


            margin(pad/4, fs*1.5)
            do UiPush()
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Wait', btnW - pad, btnH - pad) then
                    itemType = 'event'
                    itemSubType = 'wait'
                end
                -- margin(btnW, 0)
                -- UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                -- if UiTextButton('idk yet', btnW - pad, btnH - pad) then
                --     -- itemType = 'event'
                --     -- itemSubType = ''
                -- end
            UiPop() end


            margin(0, fs*3)
            do UiPush()
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Lerp Timed', btnW - pad, btnH - pad) then
                    itemType = 'event'
                    itemSubType = 'lerpTimed'
                end
                margin(btnW, 0)
                UiButtonImageBox('ui/common/box-solid-6.png', 10,10, 1,1,1, 1)
                if UiTextButton('Lerp Const', btnW - pad, btnH - pad) then
                    itemType = 'event'
                    itemSubType = 'lerpConst'
                end
            UiPop() end

        UiPop() end

        if itemType then

            local eventId = tb[index].item.id -- Delete temp event.
            local e, i = getEventById(eventId)
            table.remove(EVENT_OBJECTS, i) -- Delete temp event.

            tb[index].type = itemType

            if itemType == 'camera' then

                local cam = createCameraObject(Transform(), itemSubType)
                tb[index].item = cam
                table.insert(CAMERA_OBJECTS, tb[index].item)

            elseif itemType == 'event' then

                local event = createEventObject(itemSubType)
                tb[index].item = event
                table.insert(EVENT_OBJECTS, tb[index].item)

            end

        end

    UiPop() end
end
