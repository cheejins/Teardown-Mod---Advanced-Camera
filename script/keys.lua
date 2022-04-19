function InitKeys()

    KEYS = util.structured_table("savegame.mod.keys",

        {
            runChain = {
                key =       {'string', 'f1'},
                title =     {'string', 'Run Chain'},
                desc =      {'string', 'Run the item chain of cameras and events.'}
            },
            camView = {
                key =       {'string', 'v'},
                title =     {'string', 'Camera View'},
                desc =      {'string', 'View the current camera.'}
            },
            restartChain = {
                key =       {'string', 'r'},
                title =     {'string', 'Restart Chain'},
                desc =      {'string', 'Restart the item chain.'}
            },


            nextCamera = {
                key =       {'string', 'f5'},
                title =     {'string', 'Prev Camera'},
                desc =      {'string', ''}
            },
            prevCamera = {
                key =       {'string', 'f6'},
                title =     {'string', 'Next Camera'},
                desc =      {'string', ''}
            },
            nextEvent = {
                key =       {'string', 'f5'},
                title =     {'string', 'Prev Event'},
                desc =      {'string', ''}
            },
            prevEvent = {
                key =       {'string', 'f6'},
                title =     {'string', 'Next Event'},
                desc =      {'string', ''}
            },


            detailedMode = {
                key =       {'string', 'i'},
                title =     {'string', 'Detailed Mode'},
                desc =      {'string', 'Show extra item details.'}
            },
            drawCameras = {
                key =       {'string', 'o'},
                title =     {'string', 'Draw Cameras'},
                desc =      {'string', 'Show the location and direction of each camera.'}
            },
            deleteAll = {
                key =       {'string', 'x'},
                title =     {'string', 'Delete All'},
                desc =      {'string', 'Delete all items.'}
            },
            pinPanel = {
                key =       {'string', 'p'},
                title =     {'string', 'Pin Panel'},
                desc =      {'string', 'Pin the control panel (always show)'}
            },
        }

    )

end
