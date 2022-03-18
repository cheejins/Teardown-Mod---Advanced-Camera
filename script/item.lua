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
function runItemChain()
    -- Auto set camera and event order
end
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
function getItemByCameraId(camera_id) --- Find the item object based on the camera id.
    return getItemByTypeId('camera', camera_id)
end
function getItemByEventId(event_id) --- Find the item object based on the event id.
    return getItemByTypeId('event', event_id)
end
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





--- Set the selected camera and selected event to the first camera and first event in the item chain.
function initializeItemChain()

    -- First camera in ITEM_CHAIN.
    for index, item in ipairs(ITEM_CHAIN) do
        if item.type == 'camera' then
            setSelectedCameraId(item.item.id)
            break
        end
    end

    -- First event in ITEM_CHAIN.
    for index, item in ipairs(ITEM_CHAIN) do
        if item.type == 'event' then
            setSelectedEventId(item.item.id)
            break
        end
    end

end




-- Selected
function getSelectedCameraItem()
    return getItemByCameraId(SELECTED_CAMERA)
end
function getSelectedEventItem()
    return getItemByEventId(SELECTED_EVENT)
end
function setSelectedCameraId(camera_id) -- item.item.id
    SELECTED_CAMERA = camera_id
end
function setSelectedEventId(event_id) -- item.item.id
    SELECTED_EVENT = event_id
end



-- Next/Prev
function getNextItem(type)

    local i = getItemIndex(ITEM_CHAIN, getItemByEventId(SELECTED_EVENT))

    if type == 'camera' then
        i = getItemIndex(ITEM_CHAIN, getItemByCameraId(SELECTED_CAMERA))
    end

    for _, value in ipairs(ITEM_CHAIN) do

        i = GetTableNextIndex(ITEM_CHAIN, i)

        if ITEM_CHAIN[i].type == type then
            return ITEM_CHAIN[i]
        end

    end

end
function getPrevItem()
end



function getNextCameraItem()
    return getNextItem('camera')
end
-- function getPrevCameraItem(index)
-- end


function getNextEventItem()
    return getNextItem('event')
end
-- function getPrevEventItem(index)
-- end
