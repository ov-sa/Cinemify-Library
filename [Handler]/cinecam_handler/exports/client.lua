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
local _blurShader = nil
local _screenSource = DxScreenSource(sX*1366, sY*768)


---------------------------------------
--[[ Function: Previews Cinemation ]]--
---------------------------------------

local function previewCinemation()

    local interpolationStatus = getInterpolationStatus()
    if not interpolationStatus then
        Camera.fade(true)
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
            startCameraMovement(_customCinemationPoint, _customCinemationFOV)
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

function startCinemation(customCinemationPoint, customCinemationLoop, skipCinemationBlur, customCinemationFOV, reverseCinemationLoop)

    if cinemationStatus then return false end
    if customCinemationPoint and type(customCinemationPoint) ~= "table" then return false end

    _customCinemationPoint = customCinemationPoint
    _customCinemationLoop = customCinemationLoop
    if skipCinemationBlur then
        if _blurShader and isElement(_blurShader) then
            _blurShader:destroy()
            _blurShader = nil
        end
        _cinemationBlur = false
    else
        _cinemationBlur = true
        if not _blurShader or not isElement(_blurShader) then
            _blurShader = DxShader("files/shaders/blur.fx")
        end
    end
    _customCinemationFOV = customCinemationFOV
    if _customCinemationLoop then
        _reverseCinemationLoop = reverseCinemationLoop
        if _customCinemationPoint and _reverseCinemationLoop then
            _customCinemationPoint = reverseCinemationPoint(_customCinemationPoint)
        end
    end
    cinemationStatus = true
    addEventHandler("onClientRender", root, previewCinemation)
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
    setCameraTarget(localPlayer)
    return true
    
end