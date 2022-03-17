-- Item objects are used as base containers for event and camera objects.


ITEM_OBJECTS = {}
ITEM_IDS = 0

ITEM_CHAIN = {}


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



function itemChain_insertEvent(self)



end
