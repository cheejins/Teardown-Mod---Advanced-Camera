function InitKeys()

    KEYS = util.structured_table("savegame.mod.keys",

        {
            runChain = {
                key =      {'string', '-'},
                key2 =     {'string', 'f1'},
                title =    {'string', 'Run Chain'},
                desc =     {'string', 'Run the item chain of cameras and events.'}
            },
            camView = {
                key =      {'string', '-'},
                key2 =     {'string', 'v'},
                title =    {'string', 'Camera View'},
                desc =     {'string', 'View the current camera.'}
            },
            restartChain = {
                key =      {'string', '-'},
                key2 =     {'string', 'r'},
                title =    {'string', 'Restart Chain'},
                desc =     {'string', 'Restart the item chain.'}
            },


            prevCamera = {
                key =      {'string', '-'},
                key2 =     {'string', 'f6'},
                title =    {'string', 'Prev Camera'},
                desc =     {'string', ''}
            },
            nextCamera = {
                key =      {'string', '-'},
                key2 =     {'string', 'f5'},
                title =    {'string', 'Next Camera'},
                desc =     {'string', ''}
            },
            prevEvent = {
                key =      {'string', '-'},
                key2 =     {'string', 'f6'},
                title =    {'string', 'Prev Event'},
                desc =     {'string', ''}
            },
            nextEvent = {
                key =      {'string', '-'},
                key2 =     {'string', 'f5'},
                title =    {'string', 'Next Event'},
                desc =     {'string', ''}
            },


            detailedMode = {
                key =      {'string', '-'},
                key2 =     {'string', 'i'},
                title =    {'string', 'Detailed Mode'},
                desc =     {'string', 'Show extra item details.'}
            },
            drawCameras = {
                key =      {'string', '-'},
                key2 =     {'string', 'o'},
                title =    {'string', 'Draw Cameras'},
                desc =     {'string', 'Show the location and direction of each camera.'}
            },
            deleteAll = {
                key =      {'string', '-'},
                key2 =     {'string', 'x'},
                title =    {'string', 'Delete All'},
                desc =     {'string', 'Delete all items.'}
            },
            pinPanel = {
                key =      {'string', '-'},
                key2 =     {'string', 'p'},
                title =    {'string', 'Pin Panel'},
                desc =     {'string', 'Pin the control panel (always show)'}
            },
        }

    )

end
