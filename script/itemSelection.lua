---Get an item based on its component type and component id.
---@param type string 'camera' or 'event'
---@param id integer ID number of a camera or event.
---@return table -- Item object
function getItemByTypeId(type, id)
    for i = 1, #ITEM_CHAIN do

        local item = ITEM_CHAIN[i]

        if item.type == type and item.item.id == id then
            return item
        end

    end
end
function getItemByCameraId(camera_id) return getItemByTypeId('camera', camera_id) end
function getItemByEventId(event_id) return getItemByTypeId('event', event_id) end



-- Selected component
function getSelectedCameraItem() return getItemByCameraId(SELECTED_CAMERA) end
function getSelectedEventItem() return getItemByEventId(SELECTED_EVENT) end
function setSelectedCameraId(camera_id) SELECTED_CAMERA = camera_id end
function setSelectedEventId(event_id) SELECTED_EVENT = event_id end



-- Next Item
function getNextItem(type, index)

    local i = index or getItemIndex(ITEM_CHAIN, getItemByEventId(SELECTED_EVENT))

    if type == 'camera' then
        i = index or getItemIndex(ITEM_CHAIN, getItemByCameraId(SELECTED_CAMERA))
    end

    for _, value in ipairs(ITEM_CHAIN) do

        i = GetTableNextIndex(ITEM_CHAIN, i)

        if ITEM_CHAIN[i].type == type then
            return ITEM_CHAIN[i]
        end

    end

end
function getNextCameraItem(index) return getNextItem('camera', index) end
function getNextEventItem(index) return getNextItem('event', index) end



-- Prev Item
function getPrevItem(type, index)

    local i = index or getItemIndex(ITEM_CHAIN, getItemByEventId(SELECTED_EVENT))

    if type == 'camera' then
        i = index or getItemIndex(ITEM_CHAIN, getItemByCameraId(SELECTED_CAMERA))
    end

    for _, value in ipairs(ITEM_CHAIN) do

        i = GetTablePrevIndex(ITEM_CHAIN, i)

        if ITEM_CHAIN[i].type == type then
            return ITEM_CHAIN[i]
        end

    end
end
function getPrevCameraItem(index) return getPrevItem('camera', index) end
function getPrevEventItem(index) return getPrevItem('event', index) end



-- Get index of the item in a table based on the item id.
function getItemIndex(item_table, item)
    for index, it in ipairs(item_table) do
        if it == item then
            return index -- Index of item in item_table.
        end
    end
end

-- Check if a table contains a type of component.
function tableContainsComponentType(table, type) -- Check if ITEM_CHAIN contains a type of item (camera, event).
    for key, item in pairs(table) do
        if item.type == type then
            return true
        end
    end
    return false
end
