function debugMod()

    if #CAMERA_OBJECTS >= 1 then
        local cam = CAMERA_OBJECTS[SELECTED_CAMERA]
        dbw('CAM ID', cam.id)
        dbw('CAM TIME', cam.time)
    end

    dbw('SELECTED_CAMERA', SELECTED_CAMERA or '(No cameras exist...)')
    dbw('NEXT CAMERA', getNextCamera() or '(No cameras exist...)')
    dbw('CAMERA_IDS', CAMERA_IDS)
    dbw('CAMERAS', #CAMERA_OBJECTS or '(No cameras exist...)')
    dbw('CAMERAS RUNNING', RUN_CAMERAS)

    for key, camera in pairs(CAMERA_OBJECTS) do

        if camera == CAMERA_OBJECTS[SELECTED_CAMERA] then
            dbdd(camera.tr.pos, 0.5,0.5, 0,1,1, 1)
            dbdd(camera.trStart.pos, 0.5,0.5, 1,1,1, 1)
        else
            dbdd(camera.tr.pos, 0.5,0.5, 0,1,0, 1)
        end
        dbcr(camera.trStart.pos, 1,1,0, 1)

        local dist = 5
        dbray(camera.tr, dist, 1,1,1, 1)
        dbdd(TransformToParentPoint(camera.tr, Vec(0,0,-dist)), 0.5,0.5, 1,0,0, 1)

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
