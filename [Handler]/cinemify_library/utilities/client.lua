----------------------------------------------------------------
--[[ Resource: Cinematic Camera Handler
     Script: settings: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 13/10/2019 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

loadstring(exports.beautify_library:fetchImports())()


---------------------------------------------
--[[ Function: Reverses Cinemation Point ]]--
---------------------------------------------

function reverseCinemPoint(cinemPoint)
    if not cinemPoint then return false end
    return {
        initial = cinemPoint.final,
        final = cinemPoint.initial,
        duration = cinemPoint.duration
    }
end