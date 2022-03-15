EVENT_GROUPS = {}
EVENT_GROUP_IDS = 0


function createEventGroupObject(id)

    local eg = {

        id = id

    }

    return eg

end


function instantiateEventGroup()

    EVENT_GROUP_IDS = EVENT_GROUP_IDS + 1

    local eventGroupObject = createEventGroupObject(EVENT_GROUP_IDS)

    table.insert(EVENT_GROUPS, eventGroupObject)

end

function event_group_startEvent()

end

function event_group_startEventGroup()

end

function event_group_stopEvent()

end

function event_group_restartEvent()

end