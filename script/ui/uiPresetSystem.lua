Presets = {}
PRESET_ID = 0


function initPresets()
    -- Presets = util.structured_table("savegame.mod.presets", {})
end

function drawPresetCanvas(w,h, listItemH)

    UiWindow(w, h)
    UiAlign('left top')

    local contH = UiHeight() * 0.9
    local buttonsH = UiHeight() * 0.1

    -- List
    do UiPush()

        UiWindow(w, contH)
        UiImageBox('ui/common/box-outline-6.png', UiWidth(), UiHeight(), 10,10)

        for index, preset in ipairs(Presets) do
            UiText(preset.id)
        end

    UiPop() end

    -- Button panel.
    do UiPush()

        margin(0, contH)
        UiWindow(w, buttonsH)
        drawPresetButtons(w, buttonsH)

    UiPop() end

end

function drawPresetButtons(w, h)

    local btnTexts = {'Delete', 'Save', 'Load'}

    do UiPush()

        UiWindow(w, h)

        local btnW = w/3

        for i = 0, 2 do

            do UiPush()

                margin(i * btnW, 0)
                UiWindow(btnW, h)

                UiButtonImageBox('ui/common/box-outline-6.png', 10,10, 1,1,1, 1)
                if UiTextButton(btnTexts[i+1], w/3, UiHeight()) then

                    local globalKey = 'preset_'..btnTexts[i+1]
                    _G[globalKey](ITEM_CHAIN)
                    print(globalKey)

                end

            UiPop() end

        end

    UiPop() end

end



function preset_Load(preset)

    ITEM_CHAIN = preset

    PrintTable(ITEM_CHAIN)
end

function preset_Save(name, tb)

    local preset = createPreset(name, tb)
    table.insert(Presets, preset)

    PrintTable(Presets, 2)
end

function preset_Delete(preset_id)

    local p, i = FindPresetById(preset_id)
    table.remove(Presets, i)

    PrintTable(Presets)
end




function createPreset(name, tb)

    PRESET_ID = PRESET_ID + 1

    local preset = {
        id = PRESET_ID,
        name = name,
        table = DeepCopy(tb),
    }

    return preset

end

function FindPresetByName(name)
    for index, preset in ipairs(Presets) do
        if preset.name == name then
            return preset, index
        end
    end
end

function FindPresetById(id)
    for index, preset in ipairs(Presets) do
        if preset.id == id then
            return preset, index
        end
    end
end
