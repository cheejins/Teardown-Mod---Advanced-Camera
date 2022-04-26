keyTitles = {
    leftarrow = 'left',
    rightarrow = 'right',
    uparrow = 'up',
    downarrow = 'down',
}

validKeys = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12',
    'tab', 'uparrow', 'downarrow', 'leftarrow', 'rightarrow',
    'backspace', 'alt', 'delete', 'home', 'end',
    'pgup', 'pgdown', 'insert', 'space', 'shift', 'ctrl', 'return',
}

validChars = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'space',
}

comboKeys = {'-', 'ctrl', 'shift', 'alt'}


--- Convert a input string to the appropriate display string.
function convertKeyTitle(str)
    for key, value in pairs(keyTitles) do
        if key == str then
            return value
        end
    end
    return str
end


--- Check if a string is a valid keyboard input.
function isKeyValid(str)
    for index, value in ipairs(validKeys) do
        if str == value then
            return true
        end
    end
    return false
end


--- Check if a string is a valid text input.
function isCharValid(str)
    for index, value in ipairs(validChars) do
        if str == value then
            return true
        end
    end
    return false
end
