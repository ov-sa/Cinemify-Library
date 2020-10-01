----------------------------------------------------------------
--[[ Resource: Cinematic Camera Handler
     Script: exports: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 13/10/2019 (OvileAmriam)
     Desc: Client Sided Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local cinemationStatus = false
local _customCinemationPoint = false
local _customCinemationLoop = false
local _cinemationBlur = true
local _customCinemationFOV = false
local _reverseCinemationLoop = false
local _animateCinemationFOV = false
local _blurShader = nil
local _screenSource = DxScreenSource(sX*1366, sY*768)


---------------------------------------
--[[ Function: Previews Cinemation ]]--
---------------------------------------

local function previewCinemation()

    local interpolationStatus = getInterpolationStatus()
    if not interpolationStatus then
        if not _customCinemationPoint then
            if (#availableCinemationPoints) > 0 then
                startCameraMovement(availableCinemationPoints[math.random(#availableCinemationPoints)], _customCinemationFOV)
            end
        else
            if _customCinemationLoop then
                if _reverseCinemationLoop then
                    _customCinemationPoint = reverseCinemationPoint(_customCinemationPoint)
                end
            elseif not _customCinemationLoop then
                _customCinemationLoop = -1
            elseif _customCinemationLoop == -1 then
                stopCinemation()
                return false
            end
            startCameraMovement(_customCinemationPoint, _customCinemationFOV, _animateCinemationFOV)
        end
    end

    dxUpdateScreenSource(_screenSource)
    if _cinemationBlur and _blurShader and isElement(_blurShader) then
        dxSetShaderValue(_blurShader, "ScreenSource", _screenSource)
        dxSetShaderValue(_blurShader, "BlurStrength", blurStrength)
        dxSetShaderValue(_blurShader, "UVSize", sX*1366, sY*768)
        dxDrawImage(0, 0, sX*1366, sY*768, _blurShader)
    else
        dxDrawImage(0, 0, sX*1366, sY*768, _screenSource)
    end

end


-------------------------------------
--[[ Function: Starts Cinemation ]]--
-------------------------------------

function startCinemation(customCinemationPoint, customCinemationLoop, skipCinemationBlur, customCinemationFOV, reverseCinemationLoop, forceStart, animateCinemationFOV)

    if cinemationStatus and not forceStart then return false end
    if customCinemationPoint and type(customCinemationPoint) ~= "table" then return false end

    _customCinemationPoint = customCinemationPoint
    _customCinemationLoop = customCinemationLoop
    if skipCinemationBlur then
        _cinemationBlur = false
        if _blurShader and isElement(_blurShader) then
            _blurShader:destroy()
            _blurShader = nil
        end
    else
        _cinemationBlur = true
        if not _blurShader or not isElement(_blurShader) then
            _blurShader = DxShader("files/shaders/blur.fx")
        end
    end
    _customCinemationFOV = customCinemationFOV
    _reverseCinemationLoop = reverseCinemationLoop
    _animateCinemationFOV = animateCinemationFOV
    if _customCinemationPoint and _customCinemationLoop and _reverseCinemationLoop then
        _customCinemationPoint = reverseCinemationPoint(_customCinemationPoint)
    end
    if not cinemationStatus then
        cinemationStatus = true
        addEventHandler("onClientRender", root, previewCinemation)
    else
        stopCameraMovement()
    end
    return true

end


------------------------------------
--[[ Function: Stops Cinemation ]]--
------------------------------------

function stopCinemation()

    if not cinemationStatus then return false end

    removeEventHandler("onClientRender", root, previewCinemation)
    stopCameraMovement()
    if _blurShader and isElement(_blurShader) then
        _blurShader:destroy()
        _blurShader = nil
    end
    cinemationStatus = false
    _customCinemationPoint = false
    _customCinemationLoop = false
    _cinemationBlur = true
    _customCinemationFOV = false
    _reverseCinemationLoop = false
    _animateCinemationFOV = false
    setCameraTarget(localPlayer)
    return true
    
end


-----------------------------------------------
--[[ Function: Retrieves Cinemation Matrix ]]--
-----------------------------------------------

function getCinemationMatrix()

    if not cinemationStatus then return false end

    local cameraMatrix = {getCameraMatrix()}
    local cinemationMarix = {
        cameraPosition = {x = cameraMatrix[1], y = cameraMatrix[2], z = cameraMatrix[3]},
        cameraLookPosition = {x = cameraMatrix[4], y = cameraMatrix[5], z = cameraMatrix[6]},
        cameraFOV = cameraMatrix[8]
    }
    return cinemationMarix

end



--TODO: HOLY DAMN SHIT MANY BUGS :()
cinemationPoint = {
    cameraStart = {x = -2003.1206054688, y = 2712.8400878906, z = 133.61430358887},
    cameraStartLook = {x = -2002.2531738281, y = 2712.3503417969, z = 133.70231628418},
    cameraEnd = {x = -2003.1206054688, y = 2713.2400878906, z = 133.51430358887},
    cameraEndLook = {x = -2002.2531738281, y = 2712.3503417969, z = 133.70231628418},
    cinemationDuration = 3000 
}
startCinemation(cinemationPoint, true, true, 95, true, true)

bindKey("2", "down", function()

    local cinemationMarix = getCinemationMatrix()
    if not cinemationMarix then return false end

    local newPoint = {
        cameraStart = {x = cinemationMarix.cameraPosition.x, y = cinemationMarix.cameraPosition.y, z = cinemationMarix.cameraPosition.z},
        cameraStartLook = {x = cinemationMarix.cameraLookPosition.x, y = cinemationMarix.cameraLookPosition.y, z = cinemationMarix.cameraLookPosition.z},
        cameraEnd = {x = -2003.1206054688, y = 2713.2400878906, z = 133.51430358887},
        cameraEndLook = {x = -2002.2531738281, y = 2712.3503417969, z = 133.70231628418},
        cinemationDuration = 2500
    }
    startCinemation(newPoint, true, true, 85, true, true, true) --ADDED LAST PARAM TO ANIMATE FOV LOL.-. XD

end)