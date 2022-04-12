function debugMod()

    -- dbw('#ITEM_OBJECTS', #ITEM_OBJECTS)
    dbw('#CAMERA_OBJECTS', #CAMERA_OBJECTS)
    dbw('#EVENT_OBJECTS', #EVENT_OBJECTS)

    dbw('RUN_ITEM_CHAIN', RUN_ITEM_CHAIN)
    dbw('RUN_CAMERAS', RUN_CAMERAS)
    dbw('SELECTED_CAMERA', SELECTED_CAMERA)
    dbw('SELECTED_EVENT', SELECTED_EVENT)

    dbw('UI_SHOW_OPTIONS', UI_SHOW_OPTIONS)
    dbw('UI_SET_CAMERA', UI_SET_CAMERA)

end

function debugCameraLines()
    for key, camera in pairs(CAMERA_OBJECTS) do

        if camera == CAMERA_OBJECTS[SELECTED_CAMERA] then
            DrawDot(camera.tr.pos, 0.5,0.5, 0,1,1, 1)
            DrawDot(camera.tr.pos, 0.5,0.5, 1,1,1, 1)
        else
            DrawDot(camera.tr.pos, 0.5,0.5, 0,1,0, 1)
        end
        DebugCross(camera.tr.pos, 1,1,0, 1)

        local dist = 5
        DebugRay(camera.tr, dist, 1,1,1, 1)

        DrawDot(TransformToParentPoint(camera.tr, Vec(0,0,-dist)), 0.5,0.5, 1,0,0, 1)

    end
end

function manageDebugMode()

    db = not GetBool('savegame.mod.debugMode')
    if InputDown('ctrl') and InputPressed('d')  then
        SetBool('savegame.mod.debugMode', not GetBool('savegame.mod.debugMode'))
        db = GetBool('savegame.mod.debugMode')
        beep()
    end

end
function db_func(func) if db then func() end end -- debug function call

function dbw(str, value) if db then DebugWatch(str, value) end end -- debug watch
function dbp(str, newLine) if db then print(str .. '(' .. sfnTime() .. ')') end end -- debug print
function dbpc(str, newLine) if db then print(str .. ternary(newLine, '\n', '')) end end -- debug print

function dbl(p1, p2, c1, c2, c3, a) if db then DebugLine(p1, p2, c1, c2, c3, a) end end -- debug line
function dbdd(pos,w,l,r,g,b,a,dt) if db then DrawDot(pos,w,l,r,g,b,a,dt) end end -- debug draw dot
function dbray(tr, dist, c1, c2, c3, a) dbl(tr.pos, TransformToParentPoint(tr, Vec(0,0,-dist)), c1, c2, c3, a) end -- Debug ray from transform.
function dbcr(pos, r,g,b, a) if db then DebugCross(pos, r or 1, g or 1, b or 1, a or 1) end end -- debug cross

function DebugRay(tr, dist, c1, c2, c3, a) DebugLine(tr.pos, TransformToParentPoint(tr, Vec(0,0,-dist)), c1, c2, c3, a) end -- Debug ray from transform.