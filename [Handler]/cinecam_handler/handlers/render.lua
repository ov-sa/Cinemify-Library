----------------------------------------------------------------
--[[ Resource: Cinematic Camera Handler
     Script: handlers: render.lua
     Server: -
     Author: Tron
     Developer: -
     DOC: 13/10/2019 (Tron)
     Desc: Cinematic Camera Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local interpolationStatus = false
local interpolationObjects = {nil, nil}
local interpolationDuration = 0
local interpolationFOV = 70
local interpolationTicker = getTickCount()


-------------------------------------
--[[ Event: On Client Pre Render ]]--
-------------------------------------

addEventHandler("onClientPreRender", root, function()

    if interpolationStatus then
        if (getTickCount() - interpolationTicker) >= interpolationDuration then
            stopCameraMovement()
            return false
        end
        local posVector_1 = interpolationObjects[1]:getPosition()
        local posVector_2 = interpolationObjects[2]:getPosition()
        setCameraMatrix(posVector_1.x, posVector_1.y, posVector_1.z, posVector_2.x, posVector_2.y, posVector_2.z, 0, interpolationFOV)
    end

end)
 

-----------------------------------------
--[[ Function: Stops Camera Movement ]]--
-----------------------------------------

function stopCameraMovement()

    if not interpolationStatus then return false end

    interpolationStatus = false
    for i, j in ipairs(interpolationObjects) do
        if j and isElement(j) then
            j:destroy()
        end
    end
    return true
    
end


------------------------------------------
--[[ Function: Starts Camera Movement ]]--
------------------------------------------

function startCameraMovement(cinemationPoint, cinemationFOV)

    if interpolationStatus then return false end
    if not cinemationPoint or type(cinemationPoint) ~= "table" then return false end
    if not cinemationPoint.cameraStart or type(cinemationPoint.cameraStart) ~= "table" or not cinemationPoint.cameraStartLook or type(cinemationPoint.cameraStartLook) ~= "table" or not cinemationPoint.cameraEnd or type(cinemationPoint.cameraEnd) ~= "table" or not cinemationPoint.cameraEndLook or type(cinemationPoint.cameraEndLook) ~= "table" or not cinemationPoint.cinemationDuration then return false end
    cameraStartX = tonumber(cinemationPoint.cameraStart.x); cameraStartY = tonumber(cinemationPoint.cameraStart.y); cameraStartZ = tonumber(cinemationPoint.cameraStart.z);
    cameraStartLookX = tonumber(cinemationPoint.cameraStartLook.x); cameraStartLookY = tonumber(cinemationPoint.cameraStartLook.y); cameraStartLookZ = tonumber(cinemationPoint.cameraStartLook.z);
    cameraEndX = tonumber(cinemationPoint.cameraEnd.x); cameraEndY = tonumber(cinemationPoint.cameraEnd.y); cameraEndZ = tonumber(cinemationPoint.cameraEnd.z);
    cameraEndLookX = tonumber(cinemationPoint.cameraEndLook.x); cameraEndLookY = tonumber(cinemationPoint.cameraEndLook.y); cameraEndLookZ = tonumber(cinemationPoint.cameraEndLook.z);
    cameraDuration = tonumber(cinemationPoint.cinemationDuration);
    if not cameraStartX or not cameraStartY or not cameraStartZ or not cameraStartLookX or not cameraStartLookY or not cameraStartLookZ or not cameraEndX or not cameraEndY or not cameraEndZ or not cameraEndLookX or not cameraEndLookY or not cameraEndLookZ or not cameraDuration then return false end
    interpolationFOV = tonumber(cinemationFOV) or 70

    interpolationObjects[1] = Object(1337, cameraStartX, cameraStartY, cameraStartZ)
    interpolationObjects[2] = Object(1337, cameraStartLookX, cameraStartLookY, cameraStartLookZ)
    for i, j in ipairs(interpolationObjects) do
        j:setAlpha(0)
        j:setScale(0.01)
        j:setCollisionsEnabled(false)
    end
    interpolationObjects[1]:move(cameraDuration, cameraEndX, cameraEndY, cameraEndZ, 0, 0, 0, "InOutQuad")
    interpolationObjects[2]:move(cameraDuration, cameraEndLookX, cameraEndLookY, cameraEndLookZ, 0, 0, 0, "InOutQuad")
    interpolationDuration = cameraDuration
    interpolationTicker = getTickCount()
    interpolationStatus = true
    return true

end


--------------------------------------------------
--[[ Function: Retrieves Interpolation Status ]]--
--------------------------------------------------

function getInterpolationStatus()

    return interpolationStatus

end