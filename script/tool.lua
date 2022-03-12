function initTool()

    TOOL = {
        objects = {}
    }

    TOOL.input = {
        shoot = '',
        reset = '',
        reload = '',
    }

    TOOL.setup = {
        name = 'advancedCamera',
        title = 'Advanced Camera',
        voxPath = 'MOD/vox/tool.vox',
    }

    TOOL.active = TOOL_active
    TOOL.init = TOOL_init

    TOOL:init()

end

TOOL_init = function(self, enabled)
    RegisterTool(self.setup.name, self.setup.title, self.setup.voxPath)
    SetBool('game.tool.'..self.setup.name..'.enabled', enabled or true)
end

TOOL_active = function(self)
    return GetString('game.player.tool') == self.setup.name and GetPlayerVehicle() == 0
end
