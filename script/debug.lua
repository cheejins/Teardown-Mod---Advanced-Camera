function debugMod()

    dbw('#CAMERA_OBJECTS', #CAMERA_OBJECTS)
    dbw('#EVENT_OBJECTS', #EVENT_OBJECTS)

    dbw('RUN_ITEM_CHAIN', RUN_ITEM_CHAIN)
    dbw('RUN_CAMERAS', RUN_CAMERAS)
    dbw('SELECTED_CAMERA', SELECTED_CAMERA)
    dbw('SELECTED_EVENT', SELECTED_EVENT)

    dbw('UI_SHOW_OPTIONS', UI_SHOW_OPTIONS)
    dbw('UI_SET_CAMERA', UI_SET_CAMERA)

end

function manageDebugMode(override)
    db = not GetBool('savegame.mod.debugMode') or override
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