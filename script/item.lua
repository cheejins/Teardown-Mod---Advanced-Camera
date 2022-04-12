-- Item objects are used as base containers for components (event and camera objects).


ITEM_OBJECTS = {}
ITEM_IDS = 0

ITEM_CHAIN = {}
RUN_ITEM_CHAIN = false

SELECTED_CAMERA = 1 -- camera id
SELECTED_EVENT = 1 -- event id



function createItemObject(type)
    ITEM_IDS = ITEM_IDS + 1
    return {
        id = ITEM_IDS,
        type = type, -- event, camera, etc...
        item = {} -- Holds the actual item (event, camera, etc...)
    }
end
--- Used as a base container for components.
function instantiateItem(type)

    local item = createItemObject(type)
    table.insert(ITEM_CHAIN, item)

    return ITEM_CHAIN[#ITEM_CHAIN]
end

-- Delete an item and its component.
function deleteItem(tb, index)

    local item = tb[index]
    local id = item.item.id

    if item.type == 'camera' then

        local c, i = getCameraById(id)
        table.remove(CAMERA_OBJECTS, i)

    elseif item.type == 'event' or item.type == 'uninitialized' then

        local e, i = getEventById(id)
        table.remove(EVENT_OBJECTS, i)

    end

    table.remove(tb, index)
end


function createUninitializedItem(tb, index)

    local event = instantiateEvent('uninitialized')
    local item = getItemByEventId(event.id)
    item.type = 'uninitialized'

    table.insert(tb, index, item)
    table.remove(tb, #tb)

end

function duplicateItem(_item)

    local item = instantiateItem(_item.type)
    item.item = DeepCopy(_item.item)

    if item.type == 'camera' then

        CAMERA_IDS = CAMERA_IDS + 1
        item.item.id = CAMERA_IDS
        cam_replaceDef(item.item)

        table.insert(CAMERA_OBJECTS, item.item)

    elseif item.type == 'event' then

        EVENT_IDS = EVENT_IDS + 1
        item.item.id = EVENT_IDS
        event_replaceDef(item.item)

        table.insert(EVENT_OBJECTS, item.item)

    end

end
