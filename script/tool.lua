TOOL = {}

TOOL.setup = {
    name = 'advancedCamera',
    title = 'Advanced Camera',
    voxPath = 'MOD/vox/camera.vox',
}


TOOL.init = function(self, enabled)
    RegisterTool(self.setup.name, self.setup.title, self.setup.voxPath)
    SetBool('game.tool.'..self.setup.name..'.enabled', enabled or true)
end

TOOL.active = function(self)
    return GetString('game.player.tool') == self.setup.name and GetPlayerVehicle() == 0
end


TOOL:init()
