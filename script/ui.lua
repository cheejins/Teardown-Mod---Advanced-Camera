UI_SELECTED_ITEM = 1


scrolly = 0

function drawMainUI()

    UiMakeInteractive()

    local pad = 20
    local pad2 = 40

    do UiPush()

        do UiPush()
        UiPop() end

        UiAlign('left top')
        UiColor(0,0,0, 0.8)


        -- PANE 1
        do UiPush()

            margin(pad, pad)
            UiRect(UiWidth()/3 - pad2, UiHeight() - pad2)
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
            UiWindow(UiWidth(), UiHeight() - 100, true)
            margin(0, -scrolly)
            drawItemListMenu()

        UiPop() end
        margin(UiWidth()/3, 0)


        -- PANE 3
        do UiPush()

            margin(pad, pad)
            UiRect(UiWidth()/3 - pad2, UiHeight() - pad2)
            UiWindow(UiWidth()/3 - pad2, UiHeight() - pad2, true)

            UiColor(1,1,1, 0.8)
            do UiPush()
                UiAlign('center top')
                UiFont('regular.ttf', 36)
                margin(UiCenter(), pad)
                UiText('MODIFY ITEM')
            UiPop() end
            margin(pad/2,70)

            local item = ITEM_CHAIN[UI_SELECTED_ITEM]
            UiText('type: ' .. item.type)
            margin(0, 32)
            UiText(item.type .. ' type: ' .. item.item.type)
            margin(0, 32)

        UiPop() end
        margin(UiWidth()/3, 0)


    end UiPop()

end

function drawItemListMenu()
    local listH = 70
    do UiPush()
        for index, item in ipairs(ITEM_CHAIN) do
            uiListItem(item.item.type, index, item, listH)
            margin(0, listH)
        end
    end UiPop()
    do UiPush()
        for index, item in ipairs(ITEM_CHAIN) do
            local w = UiWidth() - listH
            local h = listH
            uiList_addItemDynamic(w,h, index)
            margin(0, listH)
        end
    end UiPop()
end

function uiListItem(text, itemChainIndex, item, listH)
    do UiPush()

        UiAlign('left top')

        local w = UiWidth() - listH
        local h = listH

        local bw = 40
        local bh = 40

        local r,g,b,a = 1,1,1,0.75
        if item.type == 'uninitialized' then
            r,g,b = 1, 0.8, 0.2
        end
        if itemChainIndex == UI_SELECTED_ITEM then
            r,g,b = 0.6, 0.6, 1
        end

        local sequentialCameras =
            item.type == 'camera'
            and (ITEM_CHAIN[GetTableNextIndex(ITEM_CHAIN, itemChainIndex)].type == 'camera'
                or ITEM_CHAIN[GetTablePrevIndex(ITEM_CHAIN, itemChainIndex)].type == 'camera')


        if sequentialCameras then
            r,g,b = oscillate(1.0)+0.25, 0.25, 0.25
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

            margin(bw/2, bh)
            UiText(tostring(itemChainIndex)) -- Item number index.

            margin(bw*1.25, 0)
            UiAlign('center middle')

            -- Icon: Item type
            if item.type == 'camera' then
                UiImageBox('MOD/img/icon_camera.png', bw * 1.25, bh * 1.25, 0,0)
            elseif item.type == 'event' then
                UiImageBox('MOD/img/icon_event.png', bw * 1.25, bh * 1.25, 0,0)
            end

            -- margin(bw*1.5, 0)
            -- UiText(item.id) -- Item number index.

            margin(bw*1.5, 0)
            UiAlign('left middle')
            UiText(item.item.type) -- Item number index.

        end UiPop()


        -- Button: Delete item
        do UiPush()

            margin(w-bw-10, h/2)

            UiAlign('middle middle')
            UiColor(1,0,0, 1)

            local mult = 1
            if UiIsMouseInRect(bw*mult, bh*mult) then
                mult = 1.25
            end

            UiButtonImageBox('MOD/img/button_garbage.png', 0,0, 1,0,0,1)
            if UiTextButton(' ', bw * mult, bh * mult) then
                table.remove(ITEM_CHAIN, itemChainIndex)
            end

        end UiPop()


        do UiPush()

            margin(w + 10, 5)

            if itemChainIndex >= 2 then -- Not first item.

                UiButtonImageBox('MOD/img/icon_arrow_up.png', 0,0, 1,1,1,0.8)
                UiButtonHoverColor(0.5,0.5,0.5, 1)
                if UiTextButton(' ', bw,bh) then
                    local index = GetTablePrevIndex(ITEM_CHAIN, itemChainIndex)
                    ITEM_CHAIN = TableSwapIndex(ITEM_CHAIN, itemChainIndex, index)
                    UI_SELECTED_ITEM = index
                end

            end

            margin(0, bh/2+10)

            if itemChainIndex < #ITEM_CHAIN then -- Not last item.

                UiButtonImageBox('MOD/img/icon_arrow_down.png', 0,0, 1,1,1,0.8)
                UiButtonHoverColor(0.5,0.5,0.5, 1)
                if UiTextButton(' ', bw,bh) then
                    local index = GetTableNextIndex(ITEM_CHAIN, itemChainIndex)
                    ITEM_CHAIN = TableSwapIndex(ITEM_CHAIN, itemChainIndex, index)
                    UI_SELECTED_ITEM = index
                end

            end

        end UiPop()


    end UiPop()
end


function uiList_addItemDynamic(w,h, index)
    do UiPush()

        margin(0, -h/3)
        if UiIsMouseInRect(w, h*1.5) then

            margin(0, h/3)

            do UiPush()
                margin(w/2, 0)
                uiList_addItem(index)
            end UiPop()

            do UiPush()
                margin(w/2,h)
                uiList_addItem(index)
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
        if UiTextButton('.', 50, 50) then
            local item = instantiateItem('uninitialized')
            local event = instantiateEvent('uninitialized')
            item.item = event
            table.insert(ITEM_CHAIN, index, item)
        end

    end UiPop()
end



function drawSquare()
    do UiPush()
        UiAlign('center middle')
        UiColor(1,0.5,1, 1)
        UiRect(5,5)
    UiPop() end
end

function margin(x,y) UiTranslate(x,y) end
