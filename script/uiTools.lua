function drawSquare()
    do UiPush()
        UiAlign('center middle')
        UiColor(1,0.5,1, 1)
        UiRect(5,5)
    UiPop() end
end

function margin(x,y) UiTranslate(x,y) end
