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
        cameraStart = {x = 2551.50146484375, y = -1667.528686523438, z = 48.12009811401367},
        cameraStartLook = {x = 2550.865234375, y = -1667.528564453125, z = 47.34856414794922},
        cameraEnd = {x = 2397.070556640625, y = -1660.260009765625, z = 14.6624002456665},
        cameraEndLook = {x = 2398.056884765625, y = -1660.214111328125, z = 14.50369930267334},
        cinemationDuration = 8500
      }
      customCinemationLoop: bool
      skipCinemationBlur: bool
      customCinemationFOV; int
      reverseCinemationLoop: bool
      forceStart: bool
      animateFOV: bool
      freezeLastFrame: bool
      ```

  - **Function:** _stopCinemation()_ **| Type:** _client_ **| Returns:** _bool_
  
  - **Function:** _getCinemationData()_ **| Type:** _client_ **| Returns:** _data; else false bool_
  ```lua
@Parameters

customCinemationPoint: {
  cameraStart = {x = 2551.50146484375, y = -1667.528686523438, z = 48.12009811401367},
  cameraStartLook = {x = 2550.865234375, y = -1667.528564453125, z = 47.34856414794922},
  cameraEnd = {x = 2397.070556640625, y = -1660.260009765625, z = 14.6624002456665},
  cameraEndLook = {x = 2398.056884765625, y = -1660.214111328125, z = 14.50369930267334},
  cinemationDuration = 8500
}
customCinemationLoop: bool
skipCinemationBlur: bool
customCinemationFOV; int
reverseCinemationLoop: bool
forceStart: bool
animateFOV: bool
freezeLastFrame: bool
```
