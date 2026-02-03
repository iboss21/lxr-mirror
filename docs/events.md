# 🐺 LXR-Mirror - Events & Exports API

```
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

**🐺 wolves.land | The Land of Wolves**

---

## 📖 Events & Exports Overview

LXR-Mirror provides a clean API through **exports** for external resources to interact with the mirror system. This document covers all available exports, their usage, parameters, return values, and integration patterns.

---

## 🎯 Available Exports

### Quick Reference Table

| Export Name | Type | Description | Returns |
|-------------|------|-------------|---------|
| `ToggleMirror` | Function | Toggle mirror on/off | `void` |
| `IsMirrorActive` | Function | Check if mirror is active | `boolean` |
| `IsUIOpen` | Function | Check if UI overlay is open | `boolean` |
| `GetFramework` | Function | Get Framework adapter object | `table` |
| `GetActiveFramework` | Function | Get active framework name | `string` |

---

## 🔄 ToggleMirror Export

### Description

Toggles the pocket mirror on or off, managing camera, animation, prop, and UI.

### Syntax

```lua
exports['lxr-mirror']:ToggleMirror()
```

### Parameters

None

### Return Value

**Type:** `void` (no return value)

### Behavior

**When Mirror is Inactive:**
1. Checks cooldown status
2. Validates rate limiting
3. Checks required item (if enabled)
4. Starts camera system
5. Plays animation
6. Spawns mirror prop
7. Shows UI overlay (if configured)
8. Displays activation notification
9. Updates cooldown timer

**When Mirror is Active:**
1. Stops camera
2. Clears animation
3. Removes mirror prop
4. Hides UI overlay
5. Displays deactivation notification

### Usage Examples

#### Basic Usage

```lua
-- Toggle mirror from another resource
exports['lxr-mirror']:ToggleMirror()
```

#### Command Integration

```lua
-- Custom command to toggle mirror
RegisterCommand('lookatme', function()
    exports['lxr-mirror']:ToggleMirror()
end, false)
```

#### Keybind Integration

```lua
-- Custom keybind handler
RegisterKeyMapping('customMirror', 'Open Mirror', 'keyboard', 'F7')
RegisterCommand('customMirror', function()
    exports['lxr-mirror']:ToggleMirror()
end, false)
```

#### Inventory Item Integration

```lua
-- Using with inventory system (example with ox_inventory)
exports('pocketmirror', function(data, slot)
    exports['lxr-mirror']:ToggleMirror()
end)
```

#### Menu Integration

```lua
-- Integration with a menu system
local menuOptions = {
    {
        title = 'Use Pocket Mirror',
        icon = 'mirror',
        onSelect = function()
            exports['lxr-mirror']:ToggleMirror()
        end
    }
}
```

#### Distance Check Example

```lua
-- Only allow mirror use when not moving
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 0xC7B5340A) then -- 'M' key
            local playerPed = PlayerPedId()
            local speed = GetEntitySpeed(playerPed)
            
            if speed < 0.5 then
                exports['lxr-mirror']:ToggleMirror()
            else
                -- Notify: Stop moving first
            end
        end
    end
end)
```

#### Conditional Usage

```lua
-- Only allow in specific locations
local function IsInSafeZone()
    local playerCoords = GetEntityCoords(PlayerPedId())
    -- Check if in safe zone
    return true -- Example
end

RegisterCommand('mirror', function()
    if IsInSafeZone() then
        exports['lxr-mirror']:ToggleMirror()
    else
        -- Notify: Not in safe zone
    end
end, false)
```

### Cooldown & Rate Limiting

The export respects configuration settings:

- **Cooldown:** Prevents rapid toggling (configured in `Config.Cooldowns`)
- **Rate Limiting:** Anti-abuse protection (configured in `Config.Security`)
- **Item Check:** Validates inventory (if `Config.General.requireItem` is `true`)

### Error Handling

The export handles errors gracefully:

- Returns silently if on cooldown (with optional notification)
- Blocks if rate limit exceeded
- Prevents usage if required item missing
- Handles animation loading failures
- Manages prop spawning errors

---

## ✅ IsMirrorActive Export

### Description

Checks if the mirror camera is currently active.

### Syntax

```lua
local isActive = exports['lxr-mirror']:IsMirrorActive()
```

### Parameters

None

### Return Value

**Type:** `boolean`

- `true` - Mirror camera is active
- `false` - Mirror camera is not active

### Usage Examples

#### Basic Status Check

```lua
local isMirrorOn = exports['lxr-mirror']:IsMirrorActive()

if isMirrorOn then
    print('Mirror is currently active')
else
    print('Mirror is not active')
end
```

#### Conditional Command

```lua
RegisterCommand('checkmirror', function()
    if exports['lxr-mirror']:IsMirrorActive() then
        print('Mirror is currently open')
    else
        print('Mirror is closed')
    end
end, false)
```

#### Integration with Other Systems

```lua
-- Prevent certain actions while mirror is active
function CanPlayerPerformAction()
    if exports['lxr-mirror']:IsMirrorActive() then
        -- Notify: Close mirror first
        return false
    end
    return true
end
```

#### HUD Integration

```lua
-- Update HUD based on mirror status
CreateThread(function()
    while true do
        Wait(1000)
        
        local mirrorActive = exports['lxr-mirror']:IsMirrorActive()
        
        -- Update HUD element
        SendNUIMessage({
            type = 'updateMirrorStatus',
            active = mirrorActive
        })
    end
end)
```

#### Auto-Close on Event

```lua
-- Close mirror when entering vehicle
AddEventHandler('playerEnteredVehicle', function()
    if exports['lxr-mirror']:IsMirrorActive() then
        exports['lxr-mirror']:ToggleMirror() -- Close mirror
    end
end)
```

#### State-Based Logic

```lua
-- Different behavior based on mirror state
function HandlePlayerAction()
    if exports['lxr-mirror']:IsMirrorActive() then
        -- Mirror is open - limited actions
        return 'limited'
    else
        -- Mirror is closed - full actions
        return 'full'
    end
end
```

---

## 🎨 IsUIOpen Export

### Description

Checks if the mirror UI overlay is currently visible.

### Syntax

```lua
local isOpen = exports['lxr-mirror']:IsUIOpen()
```

### Parameters

None

### Return Value

**Type:** `boolean`

- `true` - UI overlay is visible
- `false` - UI overlay is not visible

### Usage Examples

#### Basic UI Check

```lua
local uiVisible = exports['lxr-mirror']:IsUIOpen()

if uiVisible then
    print('Mirror UI is visible')
else
    print('Mirror UI is hidden')
end
```

#### UI State Management

```lua
-- Check before opening another UI
function OpenCustomMenu()
    if exports['lxr-mirror']:IsUIOpen() then
        -- Close mirror UI first
        exports['lxr-mirror']:ToggleMirror()
    end
    
    -- Open your menu
    OpenMenu()
end
```

#### Conflict Prevention

```lua
-- Prevent UI conflicts
RegisterCommand('inventory', function()
    if exports['lxr-mirror']:IsUIOpen() then
        -- Notify: Close mirror first
        return
    end
    
    -- Open inventory
end, false)
```

#### UI Layering

```lua
-- Manage multiple UI layers
function GetActiveUILayers()
    local layers = {}
    
    if exports['lxr-mirror']:IsUIOpen() then
        table.insert(layers, 'mirror')
    end
    
    -- Check other UIs...
    
    return layers
end
```

---

## 🎮 GetFramework Export

### Description

Returns the Framework adapter object, providing access to framework-agnostic functions.

### Syntax

```lua
local framework = exports['lxr-mirror']:GetFramework()
```

### Parameters

None

### Return Value

**Type:** `table` (Framework adapter object)

**Structure:**
```lua
{
    Active = "lxr-core",           -- Current framework name
    Core = CoreObject,              -- Framework core object
    PlayerData = {},                -- Cached player data
    
    -- Functions
    Initialize = function(),
    Notify = function(message, type, duration),
    GetPlayerData = function(),
    IsPlayerLoaded = function(),
    HasItem = function(item, amount),
    TriggerCallback = function(name, cb, ...),
    GetLocale = function(key),
    Debug = function(message)
}
```

### Usage Examples

#### Accessing Framework Functions

```lua
local Framework = exports['lxr-mirror']:GetFramework()

-- Send notification using framework adapter
Framework:Notify('Custom message', 'info', 3000)
```

#### Check Player Data

```lua
local Framework = exports['lxr-mirror']:GetFramework()
local playerData = Framework:GetPlayerData()

if playerData.citizenid then
    print('Player ID: ' .. playerData.citizenid)
end
```

#### Inventory Check

```lua
local Framework = exports['lxr-mirror']:GetFramework()

if Framework:HasItem('pocketmirror', 1) then
    -- Player has mirror item
    exports['lxr-mirror']:ToggleMirror()
else
    Framework:Notify('You need a pocket mirror', 'error', 3000)
end
```

#### Localization

```lua
local Framework = exports['lxr-mirror']:GetFramework()

local activatedText = Framework:GetLocale('mirror_activated')
local deactivatedText = Framework:GetLocale('mirror_deactivated')

Framework:Notify(activatedText, 'success', 2000)
```

#### Debug Logging

```lua
local Framework = exports['lxr-mirror']:GetFramework()

Framework:Debug('Custom debug message from external resource')
```

---

## 📝 GetActiveFramework Export

### Description

Returns the name of the currently active framework.

### Syntax

```lua
local frameworkName = exports['lxr-mirror']:GetActiveFramework()
```

### Parameters

None

### Return Value

**Type:** `string`

**Possible Values:**
- `'lxr-core'`
- `'rsg-core'`
- `'vorp_core'`
- `'redem_roleplay'`
- `'qbr-core'`
- `'qr-core'`
- `'standalone'`

### Usage Examples

#### Framework Detection

```lua
local currentFramework = exports['lxr-mirror']:GetActiveFramework()
print('LXR-Mirror is using: ' .. currentFramework)
```

#### Conditional Logic

```lua
local framework = exports['lxr-mirror']:GetActiveFramework()

if framework == 'lxr-core' or framework == 'rsg-core' then
    -- Use LXR/RSG specific features
elseif framework == 'vorp_core' then
    -- Use VORP specific features
else
    -- Fallback behavior
end
```

#### Compatibility Check

```lua
function IsCompatibleFramework()
    local framework = exports['lxr-mirror']:GetActiveFramework()
    
    local compatibleFrameworks = {
        'lxr-core',
        'rsg-core',
        'vorp_core'
    }
    
    for _, fw in ipairs(compatibleFrameworks) do
        if framework == fw then
            return true
        end
    end
    
    return false
end
```

#### Integration Setup

```lua
-- Configure resource based on detected framework
local framework = exports['lxr-mirror']:GetActiveFramework()

if framework ~= 'standalone' then
    -- Enable advanced features
    SetupAdvancedIntegration()
else
    -- Use basic functionality
    SetupBasicMode()
end
```

---

## 🔗 Integration Patterns

### Pattern 1: Menu System Integration

```lua
-- Example with custom menu system
local function CreateMirrorMenuItem()
    return {
        label = 'Use Pocket Mirror',
        icon = 'fas fa-mirror',
        action = function()
            -- Check if player has item
            local Framework = exports['lxr-mirror']:GetFramework()
            
            if Framework:HasItem('pocketmirror', 1) then
                -- Toggle mirror
                exports['lxr-mirror']:ToggleMirror()
            else
                Framework:Notify('You need a pocket mirror', 'error', 3000)
            end
        end,
        canInteract = function()
            -- Only show if mirror not already active
            return not exports['lxr-mirror']:IsMirrorActive()
        end
    }
end
```

### Pattern 2: Inventory Item Usage

```lua
-- Example with ox_inventory
exports('pocketmirror', function(data, slot)
    local metadata = data.metadata
    
    -- Check if mirror is already active
    if exports['lxr-mirror']:IsMirrorActive() then
        exports['ox_lib']:notify({
            type = 'error',
            description = 'Mirror is already open'
        })
        return
    end
    
    -- Toggle mirror
    exports['lxr-mirror']:ToggleMirror()
end)
```

### Pattern 3: Target System Integration

```lua
-- Example with ox_target
exports['ox_target']:addGlobalPlayer({
    {
        name = 'use_mirror',
        label = 'Look in Mirror',
        icon = 'fa-solid fa-mirror',
        distance = 2.0,
        canInteract = function(entity)
            -- Check if player has mirror
            local Framework = exports['lxr-mirror']:GetFramework()
            return Framework:HasItem('pocketmirror', 1)
        end,
        onSelect = function()
            exports['lxr-mirror']:ToggleMirror()
        end
    }
})
```

### Pattern 4: Custom HUD Integration

```lua
-- Update HUD with mirror status
CreateThread(function()
    local lastState = false
    
    while true do
        Wait(500)
        
        local currentState = exports['lxr-mirror']:IsMirrorActive()
        
        if currentState ~= lastState then
            SendNUIMessage({
                type = 'updateMirrorIndicator',
                active = currentState
            })
            lastState = currentState
        end
    end
end)
```

### Pattern 5: Animation System Integration

```lua
-- Prevent other animations while mirror active
function CanPlayAnimation()
    if exports['lxr-mirror']:IsMirrorActive() then
        local Framework = exports['lxr-mirror']:GetFramework()
        Framework:Notify('Close the mirror first', 'error', 2000)
        return false
    end
    return true
end

RegisterCommand('dance', function()
    if CanPlayAnimation() then
        -- Play dance animation
    end
end, false)
```

### Pattern 6: Vehicle Entry Prevention

```lua
-- Prevent vehicle entry while mirror is active
CreateThread(function()
    while true do
        Wait(0)
        
        if exports['lxr-mirror']:IsMirrorActive() then
            local playerPed = PlayerPedId()
            
            -- Disable vehicle entry
            DisableControlAction(0, 0xD8F73058, true) -- INPUT_ENTER
            
            -- Check if trying to enter vehicle
            if IsPedTryingToEnterALockedVehicle(playerPed) then
                -- Close mirror
                exports['lxr-mirror']:ToggleMirror()
            end
        end
    end
end)
```

### Pattern 7: Character Creator Integration

```lua
-- Integration with character creation
function OnCharacterCustomizationComplete()
    -- Allow player to preview in mirror
    Wait(1000)
    
    local Framework = exports['lxr-mirror']:GetFramework()
    Framework:Notify('Press M to view your character', 'info', 5000)
    
    -- Auto-open mirror
    Wait(2000)
    exports['lxr-mirror']:ToggleMirror()
end
```

### Pattern 8: Photo Mode Integration

```lua
-- Photo mode with mirror
local photoMode = false

function TogglePhotoMode()
    photoMode = not photoMode
    
    if photoMode then
        -- Open mirror for photo
        if not exports['lxr-mirror']:IsMirrorActive() then
            exports['lxr-mirror']:ToggleMirror()
        end
        
        -- Hide UI
        DisplayRadar(false)
        -- Hide other HUD elements
    else
        -- Close mirror
        if exports['lxr-mirror']:IsMirrorActive() then
            exports['lxr-mirror']:ToggleMirror()
        end
        
        -- Show UI
        DisplayRadar(true)
    end
end
```

---

## 📊 Export Comparison

| Feature | ToggleMirror | IsMirrorActive | IsUIOpen | GetFramework | GetActiveFramework |
|---------|--------------|----------------|----------|--------------|-------------------|
| **Type** | Action | Query | Query | Object | Query |
| **Returns** | void | boolean | boolean | table | string |
| **Use Case** | Control | Status | Status | Integration | Detection |
| **Frequency** | On demand | Frequent | Frequent | Once | Once |

---

## 🎯 Best Practices

### For Resource Developers

1. **Check State Before Toggling**
   ```lua
   if not exports['lxr-mirror']:IsMirrorActive() then
       exports['lxr-mirror']:ToggleMirror()
   end
   ```

2. **Use Framework Adapter for Notifications**
   ```lua
   local Framework = exports['lxr-mirror']:GetFramework()
   Framework:Notify('Message', 'info', 3000)
   ```

3. **Handle Errors Gracefully**
   ```lua
   local success, result = pcall(function()
       return exports['lxr-mirror']:IsMirrorActive()
   end)
   
   if success then
       -- Use result
   else
       -- Handle error
   end
   ```

4. **Cache Framework Object**
   ```lua
   local Framework = exports['lxr-mirror']:GetFramework()
   -- Reuse Framework object instead of calling export repeatedly
   ```

5. **Respect Configuration**
   - Don't bypass cooldowns
   - Honor rate limiting
   - Check item requirements

---

## 🔍 Troubleshooting

### Export Not Working

**Problem:** Export returns nil or errors

**Solutions:**
1. Verify resource is started: `ensure lxr-mirror`
2. Check resource name is correct: `lxr-mirror`
3. Ensure proper syntax: `exports['lxr-mirror']:ExportName()`
4. Verify export exists in client/mirror.lua or shared/framework.lua

### State Desync

**Problem:** IsMirrorActive returns incorrect state

**Solutions:**
1. Restart lxr-mirror resource
2. Check for conflicting resources
3. Enable debug mode to trace state changes
4. Verify no other resources manipulating camera

### Framework Adapter Issues

**Problem:** GetFramework returns unexpected data

**Solutions:**
1. Check framework is properly detected
2. Enable debug: `Config.Debug = true`
3. Verify framework resource is started
4. Check console for framework initialization messages

---

## 📚 Related Documentation

- [Configuration Guide](configuration.md)
- [Framework Adapters](frameworks.md)
- [Security Features](security.md)
- [Installation Guide](installation.md)

---

## 💡 Example: Complete Integration

```lua
-- Complete example: Custom mirror system integration
local MirrorSystem = {}

-- Initialize
function MirrorSystem:Init()
    self.Framework = exports['lxr-mirror']:GetFramework()
    self.activeFramework = exports['lxr-mirror']:GetActiveFramework()
    
    print('Mirror system initialized with: ' .. self.activeFramework)
    
    -- Setup commands
    self:SetupCommands()
    
    -- Setup status checker
    self:SetupStatusChecker()
end

-- Setup custom commands
function MirrorSystem:SetupCommands()
    RegisterCommand('mymirror', function()
        self:ToggleMirrorSafe()
    end, false)
    
    RegisterCommand('mirrorstatus', function()
        self:PrintStatus()
    end, false)
end

-- Safe mirror toggle with checks
function MirrorSystem:ToggleMirrorSafe()
    -- Check if already active
    if exports['lxr-mirror']:IsMirrorActive() then
        exports['lxr-mirror']:ToggleMirror()
        return
    end
    
    -- Check player has item (if required)
    if not self.Framework:HasItem('pocketmirror', 1) then
        self.Framework:Notify('You need a pocket mirror', 'error', 3000)
        return
    end
    
    -- Toggle mirror
    exports['lxr-mirror']:ToggleMirror()
end

-- Print current status
function MirrorSystem:PrintStatus()
    local mirrorActive = exports['lxr-mirror']:IsMirrorActive()
    local uiOpen = exports['lxr-mirror']:IsUIOpen()
    
    print('Mirror Active: ' .. tostring(mirrorActive))
    print('UI Open: ' .. tostring(uiOpen))
    print('Framework: ' .. self.activeFramework)
end

-- Status checker thread
function MirrorSystem:SetupStatusChecker()
    CreateThread(function()
        while true do
            Wait(5000)
            
            if exports['lxr-mirror']:IsMirrorActive() then
                self.Framework:Debug('Mirror has been active for 5+ seconds')
            end
        end
    end)
end

-- Initialize system
CreateThread(function()
    Wait(2000)
    MirrorSystem:Init()
end)
```

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
