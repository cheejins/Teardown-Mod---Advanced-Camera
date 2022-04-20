#include "main.lua"


local activeAssignment = false
local activeTable = {tb = '', key = ''}
local lastKeyPressed = ''
local font_size = 28


local validKeys = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12',
    'esc', 'tab', 'uparrow', 'downarrow', 'leftarrow', 'rightarrow',
    'backspace', 'alt', 'delete', 'home', 'end',
    'pgup', 'pgdown', 'insert', 'space', 'shift', 'ctrl', 'return',
}
local comboKeys = {'-', 'ctrl', 'shift', 'alt'}


function init()

    OPTIONS = true

    InitKeys()
    initUiControlPanel()

end

function tick()

    DebugWatch('activeAssignment', activeAssignment)
    DebugWatch('activeTable', activeTable)
    DebugWatch('lastKeyPressed', lastKeyPressed)
    DebugWatch('font_size', font_size)

    lastKeyPressed = string.lower(InputLastPressedKey())
    if activeAssignment and isKeyValid(lastKeyPressed) then

        lastKeyPressed = lastKeyPressed
        activeTable.tb[activeTable.key] = lastKeyPressed

        resetActiveTable()
        activeAssignment = false

    end

end

function draw()

    local itemH = 40
    local col = {
        {'', itemH + 20},
        {'', 180},
        {'Combo Key', 180},
        {'Main Key', 180},
    }
    local function colVal(index)
        return col[index][2]
    end


    -- Title.
    UiAlign('left top')
    uiSetFont(50)
    UiText('Control Panel Keybinds')


    -- Table headers.
    margin(0, 100)
    uiSetFont(24)
    do UiPush()
        for index, value in ipairs(col) do
            UiText(string.upper(value[1]))
            margin(value[2], 0)
        end
    UiPop() end


    -- Draw keybind list.
    margin(0, 50)
    uiSetFont(24)
    for index, value in ipairs(UiControls) do

        local key = UiControls[index].name

        for k, v in pairs(KEYS) do
            if k == key then
                do UiPush()

                    UiImageBox(UiControls[index].icon, itemH, itemH, 0,0) -- Icon
                    margin(colVal(1), 0)

                    UiText(v.title)
                    margin(colVal(2), 0)

                    Ui_Option_Keybind_Combo(180, itemH, 200, v.title, v.key, v, 'key') -- Combo key
                    margin(colVal(3), 0)

                    Ui_Option_Keybind(180, itemH, 200, ' ', v.key2, v, 'key2') -- Key
                    margin(colVal(4), 0)

                UiPop() end

                margin(0, 70)
            end
        end

    end

end


function Ui_Option_Keybind(w, h, marginX, title, label, tb, key)
    do UiPush()

        local w_key = w - h

        -- Label.
        UiFont('regular.ttf', font_size)
        UiAlign('left top')
        -- UiText(title)

        -- Bind button.
        -- UiTranslate(marginX + font_size, 0)
        UiButtonImageBox("ui/common/box-outline-6.png", 10,10)
        UiButtonHoverColor(0.5,0.5,1,1)

        local lab = ternary(isActiveTableKey(tb, key), 'Press key...', label) -- If active assignment key, then show "Press key" label

        if UiTextButton(string.upper(lab), w_key,h) then
            if not activeAssignment then
                activeAssignment = true
                activeTable = { tb = tb, key = key }
            end
        end

        if activeAssignment and activeTable.tb == tb and activeTable.key == key then

            margin(w_key + 10, 0)

            UiButtonImageBox("MOD/img/icon_deleteAll.png")
            UiButtonHoverColor(0.5,0.5,1,1)
            if UiTextButton(' ', h,h) then
                activeAssignment = false
                resetActiveTable()
            end

        end

    UiPop() end
end


function Ui_Option_Keybind_Combo(w, h, marginX, title, label, tb, key)
    do UiPush()

        local w_key = w - h

        -- Label.
        UiFont('regular.ttf', font_size)
        UiAlign('left top')
        -- UiText(title)

        -- Bind button.
        UiButtonImageBox("ui/common/box-outline-6.png", 10,10)
        UiButtonHoverColor(0.5,0.5,1, 1)

        local comboValid = tb[key] ~= '-'
        local lab = tb[key]

        if UiTextButton(string.upper(lab), w_key,h) then

            for index, value in ipairs(comboKeys) do
                if tb[key] == value then
                    tb[key] = comboKeys[GetTableNextIndex(comboKeys, index)] -- Set the combo key to the next item in the comboKeys table.
                    break
                end
            end

        end

        if comboValid then
            margin(w_key + h/4, h/4)
            UiColor(0.5,0.5,0.5, 1)
            UiImageBox('MOD/img/icon_plus.png', h/2, h/2)
        end


    UiPop() end
end


function isKeyValid(str)
    for index, value in ipairs(validKeys) do
        if str == value then
            return true
        end
    end
    return false
end


function isActiveTableKey(tb, key)
    return tb == activeTable.tb and activeTable.key == key
end
function resetActiveTable()
    activeTable = {tb = '', key = ''}
end
