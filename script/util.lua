--[[
STEADY_CAMERAS = false

function stuff()
	lookcamenabled = false
	cameraenabled = false

	lockCam = false
	zoomlevel = 6
	maxzoom = 12
	minzoom = 0.5

	camera = {}
	camera.barrel = {}
	camera.barrel.rot = Quat()
end

function clamp(value, mi, ma)
	if value < mi then value = mi end
	if value > ma then value = ma end
	return value
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function rnd(mi, ma)
	return math.random(0, 1000)/1000*(ma-mi)+mi
end

function GetAimPos()
	local ct = GetCameraTransform()
	local forwardPos = TransformToParentPoint(ct, Vec(0, 0, -150))
    local direction = VecSub(forwardPos, ct.pos)
    local distance = VecLength(direction)
	local direction = VecNormalize(direction)
	local hit, hitDistance = QueryRaycast(ct.pos, direction, distance)
	if hit then
		forwardPos = TransformToParentPoint(ct, Vec(0, 0, -hitDistance))
		distance = hitDistance
	end
	return forwardPos, hit, distance
end

function GetCamLookPos()
	local forwardPos = TransformToParentPoint(camera.barrel, Vec(0, 0, -150))
    local direction = VecSub(forwardPos, camera.barrel.pos)
    local distance = VecLength(direction)
	local direction = VecNormalize(direction)
	local hit, hitDistance = QueryRaycast(camera.barrel.pos, direction, distance)
	if hit then
		forwardPos = TransformToParentPoint(camera.barrel, Vec(0, 0, -hitDistance))
		distance = hitDistance
	end
	return forwardPos, hit, distance
end

function FlyCam()
	local mousewheel = InputValue("mousewheel")
	if mousewheel ~= 0 then
		zoomlevel = clamp(zoomlevel - mousewheel/2, minzoom, maxzoom)
	end

	local mx, my = InputValue("mousedx"), InputValue("mousedy")

	local rotdiv = 200/zoomlevel

	local CameraRot = QuatLookAt(camera.barrel.pos, aimpos)
	CameraRot = QuatRotateQuat(CameraRot, QuatEuler(-my/rotdiv, -mx/rotdiv, 0))
	camera.barrel.rot = CameraRot
end

function GetShapeInFront(distance)
	local fwd = TransformToParentVec(GetCameraTransform(),Vec(0,0,-1))
	local hit, d, normal, shape = QueryRaycast(GetCameraTransform().pos, fwd, distance,0,false)
	if hit then
		return shape, GetForwardPoint(d), d
	end
	return nil, nil, nil
end

function tik(dt)
	if GetString('game.player.tool') == 'advancedCamera' and GetPlayerVehicle() == 0 then
		SetBool('game.input.locktool', lookcamenabled)
		firing = InputDown("usetool")
		cameraenabled = true
		if equipTimer < 1 then
			equipTimer = equipTimer + dt * 2
		end

		aimpos = lookcamenabled and GetCamLookPos() or GetAimPos()

		local b = GetToolBody()
		if b ~= 0 then
			SetShapeLocalTransform(camerashape, TransformToLocalTransform(GetBodyTransform(GetToolBody()), camera))
		end

		camerafwdpos = TransformToParentPoint(camera, Vec(-0.15, 0, 0))
		camerarotation = QuatRotateQuat(camera.rot, QuatEuler(0, 0, 0.1))
		camera.pos = camerafwdpos
		camera.rot = camerarotation
		camera.barrel.pos = TransformToParentPoint(camera, Vec(2.5, 4.5, 0))
	end
end
]]

cameraX = 0
cameraY = 0
zoom = 2

function manageCamera(body)
	local height = 0
    local mx = InputValue("mousedx")
	local my = InputValue("mousedy")
    cameraX = cameraX - mx / 10
    cameraY = cameraY - my / 10
    cameraY = clamp(cameraY, -75, 75)
    local cameraRot = QuatEuler(cameraY, cameraX, 0)
    local cameraT = Transform(VecAdd(GetBodyTransform(body).pos, 5), cameraRot)
    zoom = zoom - InputValue("mousewheel") * 2.5
    zoom = clamp(zoom, 2, 20)
    local cameraPos = TransformToParentPoint(cameraT, Vec(0, height + zoom/10, zoom))
    local camera = Transform(VecLerp(cameraPos, GetCameraTransform().pos, 0.5), cameraRot)
    SetCameraTransform(camera)
end

function GetShapeInFront(distance)
	local fwd = TransformToParentVec(GetCameraTransform(),Vec(0,0,-1))
	local hit, d, normal, shape = QueryRaycast(GetCameraTransform().pos, fwd, distance,0,false)
	if hit then
		return shape, GetForwardPoint(d), d
	end
	return nil, nil, nil
end

function GetPointInsideShape(shape, point)
	return TransformToLocalPoint(GetShapeWorldTransform(shape), point)
end

function GetPointOutOfShape(shape, point)
	return TransformToParentPoint(GetShapeWorldTransform(shape), point)
end

function GetForwardPoint(distance)
	local fwd = TransformToParentVec(GetCameraTransform(),Vec(0,0,-1))
	return VecAdd(GetCameraTransform().pos,VecScale(fwd, distance))
end

function GetForwardVector(vec)
	local fwd = TransformToParentVec(GetCameraTransform(),VecAdd(Vec(0,0,1)))
	local up = TransformToParentVec(GetCameraTransform(),VecAdd(Vec(0,1,0)))
	local left = TransformToParentVec(GetCameraTransform(),VecAdd(Vec(1,0,0)))

	return VecAdd(GetCameraTransform().pos, VecAdd(VecScale(left,vec[1]),VecAdd(VecScale(fwd,vec[3]),VecScale(up,vec[2]))))
end

function DebugVec(v)
	DebugPrint(v[1] .. " " .. v[2] .. " " .. v[3])
end