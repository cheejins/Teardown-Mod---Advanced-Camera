--- Set the selected camera and selected event to the first camera and first event in the item chain.
function initializeItemChain()

    -- First camera in ITEM_CHAIN.
    for index, item in ipairs(ITEM_CHAIN) do
        if item.type == 'camera' then
            setSelectedCameraId(item.item.id)
            cam_reset(item.item)
            break
        end
    end

    -- First event in ITEM_CHAIN.
    for index, item in ipairs(ITEM_CHAIN) do
        if item.type == 'event' then
            setSelectedEventId(item.item.id)
            event_reset(item.item)
            break
        end
    end

end


--- Manages the camera and event selection and actions.
function runItemChain()

    local event = getEventById(SELECTED_EVENT)
    local cam = getCameraById(SELECTED_CAMERA)

    if event.status.done then -- Event finished.

        -- Reset selected camera.
        cam_reset(getCameraById(SELECTED_CAMERA))

        local eventItem = getItemByEventId(SELECTED_EVENT)
        local eventItemIndex = getItemIndex(ITEM_CHAIN, eventItem)
        local nextCamItem = getNextCameraItem(eventItemIndex)
        local nextCamItemIndex = getItemIndex(ITEM_CHAIN, nextCamItem)

        -- Switch to next camera if the next event is ahead of it.
        if GetTableNextIndex(ITEM_CHAIN, eventItemIndex) == nextCamItemIndex then
            SELECTED_CAMERA = nextCamItem.item.id
            cam_replaceDef(nextCamItem.item)
        end

        -- Switch to next event.
        event_reset(event)
        SELECTED_EVENT = getNextEventItem().item.id

        PrintTable(event, 2)

    elseif event.type == 'wait' then -- Wait until timer is 100% consumed.

        waitCamera(cam)
        event.val.time = event.val.time - GetTimeStep()
        if event.val.time <= 0 then event.status.done = true end

    elseif event.type == 'lerpTimed' or event.type == 'lerpConst' then -- Lerp between cameras.

        local eventItem = getItemByEventId(SELECTED_EVENT)
        local eventItemIndex = getItemIndex(ITEM_CHAIN, eventItem)
        local nextCamItem = getNextCameraItem(eventItemIndex)

        lerpCamera(eventItem.item, getCameraById(SELECTED_CAMERA), nextCamItem.item)

    end

end


function clearAllObjects()
    ITEM_OBJECTS = {}
    ITEM_CHAIN = {}
    EVENT_OBJECTS = {}
    CAMERA_OBJECTS = {}
end
