function InitKeys()

    KEYS = util.structured_table("savegame.mod.keys",

        {
            runChain = {
                key1 =     {'string', 'ctrl'},
                key2 =     {'string', 'x'},
                title =    {'string', 'Run Chain'},
                desc =     {'string', 'Run the item chain of cameras and events.'}
            },
            camView = {
                key1 =     {'string', 'ctrl'},
                key2 =     {'string', 'c'},
                title =    {'string', 'Camera View'},
                desc =     {'string', 'View the current camera.'}
            },
            restartChain = {
                key1 =     {'string', 'ctrl'},
                key2 =     {'string', 'r'},
                title =    {'string', 'Restart Chain'},
                desc =     {'string', 'Restart the item chain.'}
            },


            prevCamera = {
                key1 =     {'string', '-'},
                key2 =     {'string', 'leftarrow'},
                title =    {'string', 'Prev Camera'},
                desc =     {'string', ''}
            },
            nextCamera = {
                key1 =     {'string', '-'},
                key2 =     {'string', 'rightarrow'},
                title =    {'string', 'Next Camera'},
                desc =     {'string', ''}
            },
            prevEvent = {
                key1 =     {'string', '-'},
                key2 =     {'string', 'uparrow'},
                title =    {'string', 'Prev Event'},
                desc =     {'string', ''}
            },
            nextEvent = {
                key1 =     {'string', '-'},
                key2 =     {'string', 'downarrow'},
                title =    {'string', 'Next Event'},
                desc =     {'string', ''}
            },


            detailedMode = {
                key1 =     {'string', 'alt'},
                key2 =     {'string', 'i'},
                title =    {'string', 'Detailed Mode'},
                desc =     {'string', 'Show extra item details.'}
            },
            drawCameras = {
                key1 =     {'string', 'ctrl'},
                key2 =     {'string', 'v'},
                title =    {'string', 'Draw Cameras'},
                desc =     {'string', 'Show the location and direction of each camera.'}
            },
            deleteAll = {
                key1 =     {'string', 'shift'},
                key2 =     {'string', 'q'},
                title =    {'string', 'Delete All'},
                desc =     {'string', 'Delete all items.'}
            },
            toggleUi = {
                key1 =     {'string', '-'},
                key2 =     {'string', 'f1'},
                title =    {'string', 'Toggle UI'},
                desc =     {'string', 'Show the main camera UI screen.'}
            },
            pinPanel = {
                key1 =     {'string', 'alt'},
                key2 =     {'string', 'p'},
                title =    {'string', 'Pin Panel'},
                desc =     {'string', 'Pin the control panel (always show)'}
            },
        }

    )

end
