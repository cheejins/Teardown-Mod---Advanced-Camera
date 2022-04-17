UiControls = {}

function getImgPath(str)
    return 'MOD/img/icon_' .. str .. '.png'
end

function createUiControl(name, keybind, title, icon, func)

    local co = {
        name = name,
        keybind = keybind,
        title = title,
        icon = getImgPath(icon),
        func = func
    }

    table.insert(UiControls, co)

end

function initUiControlPanel()

    createUiControl(
        '',
        'G',
        'Run Chain',
        'play',
        toggleRunChain
    )

    createUiControl(
        '',
        'B',
        'Prev Event',
        'prev',
        nil
    )

    createUiControl(
        '',
        'N',
        'Next Event',
        'next',
        nil
    )

    createUiControl(
        '',
        'T',
        'Restart Chain',
        'restart',
        initializeItemChain
    )

    createUiControl(
        '',
        'I',
        'Detailed Mode',
        'info',
        nil
    )

    createUiControl(
        '',
        'O',
        'Draw Cameras',
        'camera_classic',
        toggleDrawCameras
    )

    createUiControl(
        '',
        'R',
        'Delete All',
        'deleteAll',
        clearAllObjects
    )

    createUiControl(
        '',
        'P',
        'Pin Panel',
        'pin',
        nil
    )

end
