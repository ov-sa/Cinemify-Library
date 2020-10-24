***
## Resource: Cinematic Camera Handler
## Developer(s): OvileAmriam
***

### Keypoints:
  :heavy_check_mark: **Eases out ingame cinemations.**

  :heavy_check_mark: **Easy to understand & integrate APIs.**

  :heavy_check_mark: **Supports custom cinemation point.**

  :heavy_check_mark: **Supports FOV animation.**

  :heavy_check_mark: **Supports normal/reverse cinemation looping.**

  :heavy_check_mark: **Supports cinemation blurring.**

  :heavy_check_mark: **Supports freezing of last frame.**

### Exports:
  - **Function:** _startCinemation(customCinemationPoint, customCinemationLoop, skipCinemationBlur, customCinemationFOV, reverseCinemationLoop, forceStart, animateFOV, freezeLastFrame)_ **| Type:** _client_ **| Returns:** _bool_
      ```lua
      @Parameters

      customCinemationPoint: {
        cameraStart = {x = float, y = float, z = float},
        cameraStartLook = {x = float, y = float, z = float},
        cameraEnd = {x = float, y = float, z = float},
        cameraEndLook = {x = float, y = float, z = float},
        cinemationDuration = float --In milliseconds
      }
      customCinemationLoop: bool
      skipCinemationBlur: bool
      customCinemationFOV: int
      reverseCinemationLoop: bool
      forceStart: bool
      animateFOV: bool
      freezeLastFrame: bool
      ```

  - **Function:** _stopCinemation()_ **| Type:** _client_ **| Returns:** _bool_
  
  - **Function:** _getCinemationData()_ **| Type:** _client_ **| Returns:** _data; else false bool_
      ```lua
      @Returns

      data: {
        cameraPosition = {x = float, y = float, z = float},
        cameraLookPosition = {x = float, y = float, z = float},
        cameraFOV = int,
        cameraLooping = bool,
        cameraFrozen = bool
      }
      ```
