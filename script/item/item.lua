ITEM_OBJECTS = {}
ITEM_IDS = 0


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

function duplicateItem(_item, index)

    local comp = DeepCopy(_item.item)

    if _item.type == 'camera' then

        cam_reset(comp)

        CAMERA_IDS = CAMERA_IDS + 1
        comp.id = CAMERA_IDS
        cam_replaceDef(comp)

        table.insert(CAMERA_OBJECTS, comp)

    elseif _item.type == 'event' then

        event_reset(comp)

        EVENT_IDS = EVENT_IDS + 1
        comp.id = EVENT_IDS
        event_replaceDef(comp)

        table.insert(EVENT_OBJECTS, comp)

    end

    local item = DeepCopy(_item)

    ITEM_IDS = ITEM_IDS + 1
    item.id = ITEM_IDS

    item.item = comp

    table.insert(ITEM_CHAIN, index, item)

end


function createUninitializedItem(tb, index)

    local event = instantiateEvent('uninitialized')
    local item = getItemByEventId(event.id)
    item.type = 'uninitialized'

    table.insert(tb, index, item)
    table.remove(tb, #tb)

end
function convertUninitializedItem(tb, index, itemType, itemSubType)

    local eventId = tb[index].item.id -- Delete temp event.
    local e, i = getEventById(eventId)
    table.remove(EVENT_OBJECTS, i) -- Delete temp event.

    tb[index].type = itemType

    if itemType == 'camera' then

        local cam = createCameraObject(GetCameraTransform(), itemSubType)
        tb[index].item = cam

        cam_replaceDef(tb[index].item)

        table.insert(CAMERA_OBJECTS, tb[index].item)

    elseif itemType == 'event' then

        local event = createEventObject(itemSubType)
        tb[index].item = event


        if itemSubType == 'lerpConst' then
            event.val.speed = 0.1
        end

        event_replaceDef(tb[index].item)

        table.insert(EVENT_OBJECTS, tb[index].item)

    end

end
