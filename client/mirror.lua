--[[
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                                                                                    
    🐺 LXR-Mirror - Client Script
    
    Handles all client-side mirror functionality including:
    - Camera creation and positioning
    - Animation playback
    - Prop attachment
    - NUI overlay management
    - Player input handling
    - Cooldown tracking
    
    ═══════════════════════════════════════════════════════════════════════════════
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 STATE MANAGEMENT
-- ═══════════════════════════════════════════════════════════════════════════════

local cameraActive = false
local cameraEntity = nil
local mirrorOpen = false
local spawnedObject = nil
local lastUseTime = 0
local usageCounter = 0
local usageResetTime = 0

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Function to get the player's height based on their model
local function GetPlayerHeight(playerPed)
    local modelHash = GetEntityModel(playerPed)
    
    -- Check if we have a specific height for this model
    for modelName, dimensions in pairs(Config.ModelDimensions) do
        if GetHashKey(modelName) == modelHash then
            return dimensions
        end
    end
    
    -- Default height if model not found
    return vector3(0.0, 0.0, 1.0)
end

-- Function to check if player is on cooldown
local function IsOnCooldown()
    if not Config.Cooldowns.enabled then
        return false
    end
    
    local currentTime = GetGameTimer()
    return (currentTime - lastUseTime) < Config.Cooldowns.duration
end

-- Function to check usage rate limits
local function CheckRateLimit()
    if not Config.Security.enabled then
        return true
    end
    
    local currentTime = GetGameTimer()
    
    -- Reset counter every minute
    if currentTime - usageResetTime > 60000 then
        usageCounter = 0
        usageResetTime = currentTime
    end
    
    usageCounter = usageCounter + 1
    
    -- Check if exceeding limits
    if usageCounter > Config.Security.maxUsesPerMinute then
        if Config.Security.logSuspiciousActivity then
            print('^3[LXR-Mirror WARNING]^7 Rate limit exceeded: ' .. usageCounter .. ' uses per minute')
        end
        if Config.Security.kickOnExploit then
            -- Could trigger server-side kick here
        end
        return false
    elseif usageCounter > Config.Security.rateLimitWarning then
        if Config.Security.logSuspiciousActivity then
            Framework:Debug('Approaching rate limit: ' .. usageCounter .. ' uses')
        end
    end
    
    return true
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 CAMERA SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

-- Function to update camera properties
local function UpdateCameraProperties(playerPed, adjustedCameraOffset, cameraFOV)
    local playerCoords = GetEntityCoords(playerPed)
    local updatedCameraPosition = playerCoords + adjustedCameraOffset
    
    SetCamCoord(cameraEntity, updatedCameraPosition.x, updatedCameraPosition.y, updatedCameraPosition.z)
    
    local playerHeading = GetEntityHeading(playerPed)
    local cameraYaw = playerHeading + 180.0
    SetCamRot(cameraEntity, 0.0, 0.0, cameraYaw, 2)
    
    -- Update camera FOV
    local currentFOV = GetCamFov(cameraEntity)
    if currentFOV ~= cameraFOV then
        SetCamFov(cameraEntity, cameraFOV)
    end
end

-- Function to start the camera
local function StartCamera()
    if cameraActive then
        return
    end
    
    local playerPed = PlayerPedId()
    local playerHeight = GetPlayerHeight(playerPed)
    local isMale = IsPedMale(playerPed)
    
    -- Get camera settings based on gender
    local cameraSettings = isMale and Config.Camera.male or Config.Camera.female
    
    -- Adjust camera offset based on player height
    local adjustedCameraOffset = vector3(
        cameraSettings.offsetX,
        cameraSettings.offsetY + playerHeight.z,
        cameraSettings.offsetZ
    )
    
    -- Create the camera and set its properties
    cameraEntity = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamFov(cameraEntity, cameraSettings.fov)
    
    -- Attach the camera to the player with the adjusted camera offset
    AttachCamToEntity(cameraEntity, playerPed, adjustedCameraOffset.x, adjustedCameraOffset.y, adjustedCameraOffset.z, true)
    
    -- Activate the camera
    RenderScriptCams(true, Config.Camera.smoothTransition, Config.Camera.transitionTime, true, true)
    SetCamActive(cameraEntity, true)
    cameraActive = true
    
    -- Freeze the player's position if configured
    if Config.General.freezePlayer then
        FreezeEntityPosition(playerPed, true)
    end
    
    -- Load and play animation
    RequestAnimDict(Config.Animation.dict)
    local timeout = GetGameTimer() + Config.Animation.loadTimeout
    while not HasAnimDictLoaded(Config.Animation.dict) and GetGameTimer() < timeout do
        Wait(100)
    end
    
    if HasAnimDictLoaded(Config.Animation.dict) then
        TaskPlayAnim(playerPed, Config.Animation.dict, Config.Animation.anim, 8.0, -8.0, -1, Config.Animation.flag, 0, false, false, false)
    else
        Framework:Debug('Failed to load animation dictionary: ' .. Config.Animation.dict)
    end
    
    -- Spawn the mirror prop if enabled
    if Config.Prop.enabled then
        local boneIndex = GetEntityBoneIndexByName(playerPed, Config.Prop.bone)
        if boneIndex ~= -1 then
            local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
            spawnedObject = CreateObject(GetHashKey(Config.Prop.model), boneCoords, true, false, false)
            if DoesEntityExist(spawnedObject) then
                AttachEntityToEntity(
                    spawnedObject, playerPed, boneIndex,
                    Config.Prop.offset.x, Config.Prop.offset.y, Config.Prop.offset.z,
                    Config.Prop.rotation.x, Config.Prop.rotation.y, Config.Prop.rotation.z,
                    true, true, false, true, 1, true
                )
            end
        end
    end
    
    -- Continuously update the camera position, rotation, and FOV
    CreateThread(function()
        while cameraActive do
            UpdateCameraProperties(playerPed, adjustedCameraOffset, cameraSettings.fov)
            Wait(Config.Performance.cameraUpdateRate or 0)
        end
    end)
    
    Framework:Debug('Camera started - Gender: ' .. (isMale and 'Male' or 'Female') .. ', FOV: ' .. cameraSettings.fov)
end

-- Function to stop the camera and animation
local function StopCamera()
    if not cameraActive then
        return
    end
    
    -- Despawn the object if it exists
    if spawnedObject and DoesEntityExist(spawnedObject) then
        DeleteEntity(spawnedObject)
        spawnedObject = nil
    end
    
    -- Deactivate the camera, destroy it, and reset its properties
    RenderScriptCams(false, Config.Camera.smoothTransition, Config.Camera.transitionTime, true, true)
    DestroyCam(cameraEntity, false)
    cameraEntity = nil
    cameraActive = false
    
    -- Unfreeze the player's position and clear their animation task
    local playerPed = PlayerPedId()
    if Config.General.freezePlayer then
        FreezeEntityPosition(playerPed, false)
    end
    ClearPedTasks(playerPed)
    
    Framework:Debug('Camera stopped')
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 NUI / UI SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

-- Function to open/close fullscreen image using NUI
local function ToggleUI()
    if not Config.UI.enabled then
        return
    end
    
    mirrorOpen = not mirrorOpen
    
    SendNUIMessage({
        type = mirrorOpen and 'show' or 'hide',
        image = Config.UI.imagePath
    })
    
    Framework:Debug('UI toggled: ' .. (mirrorOpen and 'shown' or 'hidden'))
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 MAIN TOGGLE FUNCTION
-- ═══════════════════════════════════════════════════════════════════════════════

local function ToggleMirror()
    -- Check cooldown
    if IsOnCooldown() then
        if Config.Cooldowns.notifyOnCooldown then
            Framework:Notify(Framework:GetLocale('cooldown_active'), 'error', 3000)
        end
        return
    end
    
    -- Check rate limiting
    if not CheckRateLimit() then
        Framework:Notify('You are using the mirror too frequently', 'error', 3000)
        return
    end
    
    -- Check if item is required
    if Config.General.requireItem then
        if not Framework:HasItem(Config.General.requiredItem, 1) then
            Framework:Notify(Framework:GetLocale('no_mirror'), 'error', 3000)
            return
        end
    end
    
    -- Toggle camera
    if cameraActive then
        StopCamera()
        Framework:Notify(Framework:GetLocale('mirror_deactivated'), 'success', 2000)
    else
        StartCamera()
        Framework:Notify(Framework:GetLocale('mirror_activated'), 'success', 2000)
    end
    
    -- Toggle UI
    if Config.UI.showOnToggle then
        ToggleUI()
    end
    
    -- Update cooldown timer
    lastUseTime = GetGameTimer()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 COMMANDS & KEYBINDS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Register mirror command
if Config.General.enableCommand then
    RegisterCommand(Config.General.commandName, function()
        ToggleMirror()
    end, false)
    
    -- Register alternate command for showing just the image (legacy support)
    RegisterCommand("showimage", function()
        if Config.UI.enabled then
            ToggleUI()
        end
    end, false)
end

-- Register keybind if enabled
if Config.General.enableKeybind then
    RegisterKeyMapping(Config.General.commandName, 'Toggle Mirror', 'keyboard', Config.General.keybindKey)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE LIFECYCLE EVENTS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Clean up when resource stops
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if Config.Performance.cleanupOnResourceStop then
            StopCamera()
            if mirrorOpen then
                ToggleUI()
            end
        end
        Framework:Debug('Resource stopped - cleaned up camera and UI')
    end
end)

-- Preload animations on resource start if configured
if Config.Performance.preloadAnimations then
    CreateThread(function()
        Wait(2000)
        RequestAnimDict(Config.Animation.dict)
        Framework:Debug('Preloaded animation dictionary')
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 EXPORTS
-- ═══════════════════════════════════════════════════════════════════════════════

exports('ToggleMirror', ToggleMirror)
exports('IsMirrorActive', function() return cameraActive end)
exports('IsUIOpen', function() return mirrorOpen end)
