UiControls = {}

function getImgPath(str)
    return 'MOD/img/icon_' .. str .. '.png'
end

function createUiControl(name, title, icon, func, gb_key)

    local co = {
        name = name,
        keybind = KEYS[name].key,
        title = title,
        icon = getImgPath(icon),
        func = func,
        bool = gb_key
    }

    table.insert(UiControls, co)

end

function initUiControlPanel()

    createUiControl(
        'runChain',
        'Run Chain',
        'play',
        'toggleRunChain',
        'RUN_ITEM_CHAIN'
    )

    createUiControl(
        'camView',
        'Camera View',
        'eye_frame',
        'toggleViewCamera',
        'RUN_CAMERAS'
    )

    createUiControl(
        'restartChain',
        'Restart Chain',
        'restart',
        'initializeItemChain',
        ''
    )

    createUiControl(
        'prevEvent',
        'Prev Event',
        'prev',
        nil,
        ''
    )

    createUiControl(
        'nextEvent',
        'Next Event',
        'next',
        nil,
        ''
    )

    createUiControl(
        'detailedMode',
        'Detailed Mode',
        'info',
        'toggleDetails',
        'UI_SHOW_DETAILS'
    )

    createUiControl(
        'drawCameras',
        'Draw Cameras',
        'camera_classic',
        'toggleDrawCameras',
        'DRAW_CAMERAS'
    )

    createUiControl(
        'deleteAll',
        'Delete All',
        'deleteAll',
        'clearAllObjects',
        ''
    )

    createUiControl(
        'pinPanel',
        'Pin Panel',
        'pin',
        'togglePinControlPanel',
        'UI_PIN_CONTROL_PANEL'
    )

end
