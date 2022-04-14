function drawSquare()
    do UiPush()
        UiAlign('center middle')
        UiColor(1,0.5,1, 1)
        UiRect(5,5)
    UiPop() end
end

function margin(x,y) UiTranslate(x,y) end

function createSlider(title, tb, key, valueText, min, max, w, h, round)

    do UiPush()

        local v = tb[key]

        min = min or 0
        max = max or 300

        UiAlign('left middle')

        -- Text header
        UiColor(1,1,1, 1)
        UiFont('regular.ttf', 24)
        UiText(title)
        UiTranslate(0, 24)

        -- Slider BG
        UiColor(0.4,0.4,0.4, 1)
        local slW = w or 400
        UiRect(slW, h or 10)

        -- Convert to slider scale.
        v = ((v-min) / (max-min)) * slW

        -- Slider dot
        UiColor(1,1,1, 1)
        UiAlign('center middle')
        -- v, done = UiSlider("ui/common/dot.png", "x", math.floor(v), 0, slW)
        v, done = UiSlider("ui/common/dot.png", "x", v, 0, slW)

        local val = (v/slW) * (max-min) + min -- Convert to true scale.
        tb[key] = val

        -- Slider value
        do UiPush()
            UiAlign('left middle')
            UiTranslate(slW + 20, 0)
            local decimals = ternary((v/slW) * (max-min) + min < 10, 3, 1)
            UiText(sfn((v/slW) * (max-min) + min, decimals) .. ' ' .. (valueText or ''))
        UiPop() end

    UiPop() end

    if done then
        return true
    end

end

function uiSetFont(fs)
    UiFont('regular.ttf', fs or 32)
    UiTextShadow(0,0,0,1, 0.5,0.5)
    UiColor(1,1,1, 1)
end

function uiShowMessage(stringsTable)
    do UiPush()

        margin(UiCenter(), UiMiddle() + 200)

        for index, str in ipairs(stringsTable) do
            UiText(str)
            margin(0,50)
        end

    UiPop() end
end

function UiSetColor(c, a)
    UiColor(c[1], c[2], c[3], a or 1)
end
