function runItemChain()

    local event = getEventById(SELECTED_EVENT)

    if event.val.time <= 0 or event.status.done then -- Event finished.

        -- Reset selected camera.
        cam_reset(getCameraById(SELECTED_CAMERA))

        local eventItem = getItemByEventId(SELECTED_EVENT)
        local eventItemIndex = getItemIndex(ITEM_CHAIN, eventItem)
        local nextCamItem = getNextCameraItem(eventItemIndex)
        local nextCamItemIndex = getItemIndex(ITEM_CHAIN, nextCamItem)

        -- Switch to next camera if the next event is ahead of it.
        if GetTableNextIndex(ITEM_CHAIN, eventItemIndex) == nextCamItemIndex then
            SELECTED_CAMERA = nextCamItem.item.id
        end

        -- Switch to next event.
        event_reset(event)
        SELECTED_EVENT = getNextEventItem().item.id

    elseif event.type == 'wait' then

        event.val.time = event.val.time - GetTimeStep()

    elseif event.type == 'lerpTimed' or event.type == 'lerpConst' then

        local eventItem = getItemByEventId(SELECTED_EVENT)
        local eventItemIndex = getItemIndex(ITEM_CHAIN, eventItem)
        local nextCamItem = getNextCameraItem(eventItemIndex)

        if event.val.speed > 0 then -- Lerp speed based.
            lerpCameraConst(eventItem.item, getCameraById(SELECTED_CAMERA), nextCamItem.item)
        else -- Time based lerp.
            lerpCameraTimed(eventItem.item, getCameraById(SELECTED_CAMERA), nextCamItem.item)
            event.val.time = event.val.time - GetTimeStep()
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


function clearAllObjects()
    ITEM_OBJECTS = {}
    ITEM_CHAIN = {}
    EVENT_OBJECTS = {}
    CAMERA_OBJECTS = {}
end

function setUiSelectedItem(item)
    UI_SELECTED_ITEM = getItemIndex(ITEM_CHAIN, item)
end

function getUiSelectedItem()
    return ITEM_CHAIN[UI_SELECTED_ITEM]
end