-- Item objects are used as base containers for event and camera objects.


ITEM_OBJECTS = {}
ITEM_IDS = 0

ITEM_CHAIN = {}
RUN_ITEM_CHAIN = false

SELECTED_CAMERA = 1 -- camera id
SELECTED_EVENT = 1 -- event id



function createItemObject(id, type)
    return {
        id = id,
        type = type, -- event, camera, etc...
        item = {} -- Holds the actual item (event, camera, etc...)
    }
end
--- Used as a base container for events and cameras.
function instantiateItem(type)
    ITEM_IDS = ITEM_IDS + 1
    local item = createItemObject(ITEM_IDS, type)
    table.insert(ITEM_OBJECTS, item)

    return ITEM_OBJECTS[#ITEM_OBJECTS]
end



---Get an item based on its type the id of the type.
---@param type string 'camera' or 'event'
---@param id integer ID number of a camera or event.
---@return table -- Item object
function getItemByTypeId(type, id)
    for i = 1, #ITEM_OBJECTS do

        local item = ITEM_OBJECTS[i]

        if item.type == type and item.item.id == id then
            return item
        end

    end
end
function getItemByCameraId(camera_id) return getItemByTypeId('camera', camera_id) end
function getItemByEventId(event_id) return getItemByTypeId('event', event_id) end



-- Selected Item
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


-- --- Return a table of every item with the specified properties
-- function getItems(type, subtype)
--     local items = {}
--     for key, item in pairs(ITEM_OBJECTS) do
--         if item.type == type then

--             if subtype ~= nil and item.subType == subtype then -- Evaluate subtype.
--                 table.insert(items, item)
--             else
--                 table.insert(items, item) -- subtype irrelevant, only evaluate type.
--             end

--         end
--     end
--     return items
-- end



function getItemIndex(item_table, item)
    for index, it in ipairs(item_table) do
        if it == item then
            return index -- Index of item in item_table.
        end
    end
end
function tableContainsItemType(table, type) -- Check if ITEM_CHAIN contains a type of item (camera, event).
    for key, item in pairs(table) do
        if item.type == type then
            return true
        end
    end
end
