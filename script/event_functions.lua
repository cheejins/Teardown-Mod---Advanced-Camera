function event_reset(self)
    for key, value in pairs(self) do
        if key ~= 'def' then -- self.def does not have a def key.
            self[key] = DeepCopy(self.def[key]) -- Replace all self values with default self values.
        end
    end
end
function event_replaceDef(self) -- Replace the event.def with the current version of event.
    self.def = DeepCopy(self)
end





function event_convertToWait(self, time)
    self.val.time = time
    self:replaceDef()
end





function event_setMasterEvent(self, event, doReset)
    self.link.event.next = event
    if doReset then
        self.link.event.next:reset()
    end
end
function event_setNextEvent(self, event, doReset)
    self.link.event.next = event
    if doReset then
        self.link.event.next:reset()
    end
end
function event_setMasterCamera(self, camera, doReset)
    self.link.camera.next = camera
    if doReset then
        self.link.camera.next:reset()
    end
end
function event_setNextCamera(self, camera, doReset)
    self.link.camera.next = camera
    if doReset then
        self.link.camera.next:reset()
    end
end

