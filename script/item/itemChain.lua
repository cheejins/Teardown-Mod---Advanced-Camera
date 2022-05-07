ITEM_CHAIN = {}
RUN_ITEM_CHAIN = false

SELECTED_CAMERA = 1 -- camera id
SELECTED_EVENT = 1 -- event id


--- Manages the camera and event selection and actions.
function runItemChain()

    local event = getEventById(SELECTED_EVENT)
    local cam = getCameraById(SELECTED_CAMERA)


    if event.status.done then -- Event finished.

        ChangeEvent(1)

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


function ChangeEvent(direction, ignoreCamera)

    local event = getEventById(SELECTED_EVENT)


    -- Reset selected event before changing events.
    event_reset(event)

    -- Switch to next or prev event.
    if direction > 0 then
        SELECTED_EVENT = getNextEventItem().item.id
    elseif direction < 0 then
        SELECTED_EVENT = getPrevEventItem().item.id
    end


    -- Reset selected camera.
    cam_reset(getCameraById(SELECTED_CAMERA))

    -- Set the selected camera to the camera before the selected event
    if not ignoreCamera then
        local eventItem = getItemByEventId(SELECTED_EVENT)
        local eventItemIndex = getItemIndex(ITEM_CHAIN, eventItem)
        local prevCamItem = getPrevCameraItem(eventItemIndex)
        SELECTED_CAMERA = prevCamItem.item.id
        cam_replaceDef(prevCamItem.item)
    end

end
function NextEvent() ChangeEvent(1) end
function PrevEvent() ChangeEvent(-1) end


function ChangeCamera(direction)

    -- Reset selected camera.
    cam_reset(getCameraById(SELECTED_CAMERA))


    -- Set the selected camera to the camera before the selected event
    local camItem = getItemByCameraId(SELECTED_CAMERA)
    local camItemIndex = getItemIndex(ITEM_CHAIN, camItem)

    if direction > 0 then

        local nextCamItem = getNextCameraItem(camItemIndex)
        SELECTED_CAMERA = nextCamItem.item.id
        cam_replaceDef(nextCamItem.item)

    elseif direction < 0 then

        local prevCamItem = getPrevCameraItem(camItemIndex)
        SELECTED_CAMERA = prevCamItem.item.id
        cam_replaceDef(prevCamItem.item)

    end

end
function NextCamera() ChangeCamera(1) end
function PrevCamera() ChangeCamera(-1) end


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
function validateItemChain()

    if #CAMERA_OBJECTS >= 1 and #EVENT_OBJECTS >=1 then

        local selectedComponentsInvalid =
            getItemByComponentId('camera', SELECTED_CAMERA) == nil
            or getItemByComponentId('event', SELECTED_EVENT) == nil

        -- Check if selected components are valid
        if selectedComponentsInvalid then
            initializeItemChain()
        end

    end

end
