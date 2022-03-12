function drawControls()

    do UiPush()

        local yMargin = 30

        UiTranslate(UiWidth() - 270, yMargin)
        UiAlign('left top')
        UiText('CAMERA CONTROLS')

        for key, k in pairs(KEYS) do
            UiTranslate(0, yMargin)
            UiText(k.key .. ' = ' .. k.desc)
        end

    UiPop() end

    do UiPush()

        UiTranslate(UiCenter(), UiHeight() - 50)
        UiText('Press ctrl+d to enable/disable adv cam debug mode')

    UiPop() end

end

function drawCameraNumbers()
    for key, camera in pairs(CAMERA_OBJECTS) do -- Draw camera numbers

        if TransformToLocalPoint(GetCameraTransform(), camera.def.tr.pos)[3] < 0 then

            local x,y = UiWorldToPixel(camera.def.tr.pos)

            do UiPush()
                UiTranslate(x,y)
                UiText(camera.id)
            UiPop() end

        end

    end
end


-- function drawCameraToolGrid()
    -- do UiPush()

    --     local h = UiHeight()/10
    --     local w = UiWidth()/10

    --     local x = UiCenter()/2
    --     local y = UiMiddle()/2

    --     UiTranslate(x, y)
    --     UiAlign('center middle')
    --     UiColor(1,1,1, 1)

    --     for i = 1, 3 do
    --         -- for j = 1, 3 do

    --             UiTranslate(h*i, y)
    --             UiRect()

    --         -- end
    --     end

    -- UiPop() end
-- end