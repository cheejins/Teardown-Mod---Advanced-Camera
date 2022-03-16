-- Item objects are used as base containers for event and camera objects.


ITEM_OBJECTS = {}
ITEM_IDS = 0


function createItemObject(id, type)

    local eg = {

        id = id,
        type = type, -- event, camera, etc...

        item = {} -- Holds the actual item (event, camera, etc...)

    }

    return eg

end


--- Used as a base container for events and cameras.
function instantiateItem(type)

    ITEM_IDS = ITEM_IDS + 1
    local type = type or 'NA'

    local item = createItemObject(ITEM_IDS, type)

    table.insert(ITEM_OBJECTS, item)

    return ITEM_OBJECTS[#ITEM_OBJECTS]

end


--- Return a table of every item with the specified properties
function getItems(type, subtype, itemGroup)
    local items = {}
    for key, item in pairs(ITEM_OBJECTS) do
        if item.type == type then

            if subtype ~= nil and item.subType == subtype then -- Evaluate subtype.
                table.insert(items, item)
            else
                table.insert(items, item) -- subtype irrelevant, only evaluate type.
            end

        end
    end
    return items
end


function event_group_startEvent()
end
function event_group_startEventGroup()
end
function event_group_stopEvent()
end
function event_group_restartEvent()
end