# 🐺 LXR-Mirror - Framework Adapters

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

## 📖 Framework Adapter Overview

LXR-Mirror implements a **unified adapter layer** that provides framework-agnostic functionality. This design pattern decouples the core mirror logic from framework-specific implementations, enabling seamless multi-framework compatibility.

---

## 🎯 Design Philosophy

### Adapter Pattern Benefits

1. **Single Codebase** - One implementation works across all frameworks
2. **Easy Maintenance** - Framework changes don't affect core logic
3. **Extensible** - Add new frameworks without modifying existing code
4. **Fallback Support** - Graceful degradation for unsupported features
5. **Developer Friendly** - Simple API regardless of underlying framework

### Architecture

```
┌─────────────────────────────────────┐
│     Mirror Core Logic               │
│  (Camera, Animation, Props, UI)     │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│     Unified Adapter API             │
│  (Framework Bridge Layer)           │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│  Framework-Specific Implementations │
│  LXR │ RSG │ VORP │ RedEM │ QB │ QR │
└─────────────────────────────────────┘
```

---

## 🔍 Auto-Detection System

### How Auto-Detection Works

The framework adapter automatically detects your active framework on resource start using a priority-based system.

**Detection Logic:**

```lua
function DetectFramework()
    if Config.Framework ~= 'auto' then
        return Config.Framework  -- Manual override
    end
    
    -- Check each framework in priority order
    local frameworks = {
        'lxr-core',           -- Priority 1
        'rsg-core',           -- Priority 2
        'vorp_core',          -- Priority 3
        'redem_roleplay',     -- Priority 4
        'qbr-core',           -- Priority 5
        'qr-core'             -- Priority 6
    }
    
    for _, fw in ipairs(frameworks) do
        local settings = Config.FrameworkSettings[fw]
        if settings and GetResourceState(settings.resource) == 'started' then
            return fw  -- Found running framework
        end
    end
    
    return 'standalone'  -- Fallback mode
end
```

**Detection Process:**

1. Check if manual framework specified in config
2. Iterate through frameworks in priority order
3. Check if framework resource is started
4. Return first detected framework
5. Fall back to standalone mode if none found

**Console Output:**

```
[LXR-Mirror] Detected framework: lxr-core
[LXR-Mirror] Framework adapter initialized: lxr-core
```

---

## 📊 Framework Priority Order

The detection system uses a specific priority order designed for compatibility and optimal performance:

| Priority | Framework | Resource Name | Status |
|----------|-----------|---------------|--------|
| **1** | **LXR-Core** | `lxr-core` | Primary (Optimized) |
| **2** | **RSG-Core** | `rsg-core` | Primary (Optimized) |
| **3** | **VORP Core** | `vorp_core` | Fully Supported |
| **4** | **RedEM:RP** | `redem_roleplay` | Compatible |
| **5** | **QBR-Core** | `qbr-core` | Compatible |
| **6** | **QR-Core** | `qr-core` | Compatible |
| **7** | **Standalone** | - | Fallback Mode |

### Why This Priority Order?

- **LXR-Core & RSG-Core** listed first as they are the primary target frameworks with full feature support
- **VORP** prioritized for widespread RedM adoption
- **RedEM, QBR, QR** follow as additional supported frameworks
- **Standalone** ensures resource works without any framework

---

## 🔧 Framework-Specific Configuration

Each framework has its own configuration section defining integration points:

```lua
Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource = 'lxr-core',              -- Resource name for detection
        notifications = 'ox_lib',            -- Notification system
        inventory = 'lxr-inventory',         -- Inventory system
        target = 'ox_target',                -- Targeting system
        events = {
            server = 'lxr-core:server:%s',   -- Server event pattern
            client = 'lxr-core:client:%s',   -- Client event pattern
            callback = 'lxr-core:callback:%s' -- Callback pattern
        }
    }
}
```

### Configuration Parameters

| Parameter | Type | Purpose |
|-----------|------|---------|
| `resource` | string | Framework resource name for detection |
| `notifications` | string | Notification system identifier |
| `inventory` | string | Inventory system name |
| `target` | string | Targeting system name |
| `events` | table | Event naming convention patterns |

---

## 🔌 Unified Adapter API

The adapter provides a consistent API that works identically across all frameworks.

### Available Functions

#### 🔔 Notification System

```lua
Framework:Notify(message, type, duration)
```

**Parameters:**
- `message` (string) - Notification text
- `type` (string) - Notification type: 'info', 'success', 'error', 'warning'
- `duration` (integer) - Display duration in milliseconds

**Example:**
```lua
Framework:Notify('Mirror activated', 'success', 2000)
```

**Framework Implementations:**
- **LXR/RSG/QBR/QR:** Uses ox_lib notifications (if available) or framework native
- **VORP:** Uses `Core.NotifyRightTip()`
- **RedEM:** Uses framework notification system
- **Standalone:** Console print fallback

---

#### 👤 Player Data System

```lua
Framework:GetPlayerData()
```

**Returns:** Player data table (structure varies by framework)

**Example:**
```lua
local playerData = Framework:GetPlayerData()
if playerData.citizenid then
    print("Player ID: " .. playerData.citizenid)
end
```

---

```lua
Framework:IsPlayerLoaded()
```

**Returns:** `true` if player is fully loaded, `false` otherwise

**Example:**
```lua
CreateThread(function()
    while not Framework:IsPlayerLoaded() do
        Wait(1000)
    end
    -- Player is now loaded
end)
```

---

#### 🎒 Inventory System

```lua
Framework:HasItem(item, amount)
```

**Parameters:**
- `item` (string) - Item name
- `amount` (integer) - Required quantity (default: 1)

**Returns:** `true` if player has item, `false` otherwise

**Example:**
```lua
if Framework:HasItem('pocketmirror', 1) then
    -- Allow mirror usage
end
```

**Note:** Some frameworks require server callbacks for accurate inventory checks. Current implementation provides simplified client-side checks.

---

#### 📞 Callback System

```lua
Framework:TriggerCallback(name, callback, ...)
```

**Parameters:**
- `name` (string) - Callback name
- `callback` (function) - Callback function
- `...` - Additional arguments

**Example:**
```lua
Framework:TriggerCallback('lxr-mirror:server:checkItem', function(hasItem)
    if hasItem then
        ToggleMirror()
    end
end, 'pocketmirror')
```

---

#### 🌍 Utility Functions

```lua
Framework:GetLocale(key)
```

**Parameters:**
- `key` (string) - Locale key

**Returns:** Localized string for configured language

**Example:**
```lua
local message = Framework:GetLocale('mirror_activated')
Framework:Notify(message, 'success', 2000)
```

---

```lua
Framework:Debug(message)
```

**Parameters:**
- `message` (string) - Debug message

**Purpose:** Print debug message if `Config.Debug` is enabled

**Example:**
```lua
Framework:Debug('Camera FOV set to ' .. cameraFOV)
```

---

## 🎮 Per-Framework Implementation Details

### LXR-Core

**Primary Framework** - Fully optimized integration

**Core Object:**
```lua
Framework.Core = exports['lxr-core']:GetCoreObject()
```

**Features:**
- ✅ Full notification support (ox_lib)
- ✅ Inventory integration
- ✅ Player data access
- ✅ Callback system
- ✅ Event system

**Notification Example:**
```lua
exports.ox_lib:notify({
    title = 'Mirror',
    description = message,
    type = type,
    duration = duration
})
```

---

### RSG-Core

**Primary Framework** - Fully optimized integration

**Core Object:**
```lua
Framework.Core = exports['rsg-core']:GetCoreObject()
```

**Features:**
- ✅ Full notification support (ox_lib)
- ✅ Inventory integration
- ✅ Player data access
- ✅ Callback system
- ✅ Event system

**Player Data Example:**
```lua
local playerData = Framework.Core.Functions.GetPlayerData()
```

---

### VORP Core

**Fully Supported** - Complete feature implementation

**Core Object:**
```lua
Framework.Core = exports.vorp_core:GetCore()
```

**Features:**
- ✅ Native notification system
- ⚠️ Simplified inventory checks
- ✅ Player data access
- ✅ Async callback system
- ✅ Event system

**Notification Example:**
```lua
Framework.Core.NotifyRightTip(message, duration)
```

**Callback System:**
```lua
Framework.Core.Callback.TriggerAsync(name, callback, ...)
```

---

### RedEM:RP

**Compatible** - Core features supported

**Core Object:**
```lua
Framework.Core = exports['redem_roleplay']:GetCoreObject()
```

**Features:**
- ✅ Framework notifications
- ⚠️ Simplified inventory checks
- ✅ Player data access
- ✅ Callback system
- ✅ Event system

---

### QBR-Core & QR-Core

**Compatible** - QB-style framework support

**Core Objects:**
```lua
-- QBR
Framework.Core = exports['qbr-core']:GetCoreObject()

-- QR
Framework.Core = exports['qr-core']:GetCoreObject()
```

**Features:**
- ✅ Full notification support (ox_lib fallback)
- ✅ Inventory integration
- ✅ Player data access
- ✅ Callback system
- ✅ Event system

---

### Standalone Mode

**Fallback Mode** - No framework required

**Core Object:**
```lua
Framework.Core = nil
```

**Features:**
- ⚠️ Console print notifications
- ✅ No inventory requirements
- ✅ Basic functionality
- ⚠️ No player data
- ⚠️ No callback system

**Limitations:**
- No server integration
- No player authentication
- No inventory checks
- Print-only notifications

**Use Cases:**
- Testing and development
- Single-player environments
- Minimal setups without framework

---

## 🛠️ Adding New Frameworks

### Step-by-Step Guide

#### 1. Add Framework Configuration

Add your framework to `Config.FrameworkSettings` in `config.lua`:

```lua
Config.FrameworkSettings['my-framework'] = {
    resource = 'my-framework',
    notifications = 'my_notify',
    inventory = 'my_inventory',
    target = 'my_target',
    events = {
        server = 'myfw:server:%s',
        client = 'myfw:client:%s',
        callback = 'myfw:callback:%s'
    }
}
```

#### 2. Add to Priority List

Add framework to detection priority list in `shared/framework.lua`:

```lua
local frameworks = {
    'lxr-core',
    'rsg-core',
    'vorp_core',
    'redem_roleplay',
    'qbr-core',
    'qr-core',
    'my-framework',  -- Add here
}
```

#### 3. Create Initialization Function

Add initialization function in `shared/framework.lua`:

```lua
function Framework:InitializeMyFramework()
    if IsDuplicityVersion() then
        -- Server-side initialization
        self.Core = exports['my-framework']:GetCoreObject()
    else
        -- Client-side initialization
        self.Core = exports['my-framework']:GetCoreObject()
    end
end
```

#### 4. Add to Initialization Switch

Add case to initialization switch in `Framework:Initialize()`:

```lua
function Framework:Initialize()
    self.Active = DetectFramework()
    
    if self.Active == 'lxr-core' then
        self:InitializeLXRCore()
    elseif self.Active == 'rsg-core' then
        self:InitializeRSGCore()
    -- ... other frameworks ...
    elseif self.Active == 'my-framework' then
        self:InitializeMyFramework()  -- Add here
    else
        self:InitializeStandalone()
    end
    
    print('^2[LXR-Mirror]^7 Framework adapter initialized: ^3' .. self.Active .. '^7')
end
```

#### 5. Implement Adapter Functions

Update adapter functions to support your framework:

```lua
function Framework:Notify(message, type, duration)
    type = type or 'info'
    duration = duration or 5000
    
    if self.Active == 'my-framework' then
        -- Implement notification for your framework
        if self.Core then
            self.Core.Notify(message, type, duration)
        else
            print(message)
        end
    elseif self.Active == 'lxr-core' or self.Active == 'rsg-core' then
        -- ... existing code ...
    end
end
```

#### 6. Test Integration

Test all adapter functions:

- ✅ Notifications display correctly
- ✅ Player data retrieves properly
- ✅ Inventory checks work
- ✅ Callbacks function
- ✅ Events trigger properly

---

## 🔄 Manual Framework Selection

Override auto-detection by setting specific framework:

```lua
Config.Framework = 'lxr-core'  -- Force LXR-Core
```

**Use Cases:**
- Multiple frameworks installed
- Testing specific framework integration
- Forcing specific behavior
- Development and debugging

---

## 🧪 Testing Framework Integration

### Test Checklist

- [ ] Framework detection works correctly
- [ ] Notifications display in-game
- [ ] Player data retrieves successfully
- [ ] Inventory checks function (if applicable)
- [ ] Callbacks execute properly
- [ ] Events trigger correctly
- [ ] Locale strings load
- [ ] Debug messages appear (if enabled)

### Debug Output

Enable debug mode to verify framework operation:

```lua
Config.Debug = true
```

**Expected Console Output:**

```
[LXR-Mirror DEBUG] Detected framework: lxr-core
[LXR-Mirror] Framework adapter initialized: lxr-core
[LXR-Mirror DEBUG] Camera started - Gender: Male, FOV: 10.0
[LXR-Mirror DEBUG] UI toggled: shown
```

---

## 📝 Framework Comparison

| Feature | LXR | RSG | VORP | RedEM | QBR | QR | Standalone |
|---------|-----|-----|------|-------|-----|----|-----------| 
| Auto-Detect | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Notifications | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| Player Data | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Inventory | ✅ | ✅ | ⚠️ | ⚠️ | ✅ | ✅ | ❌ |
| Callbacks | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Events | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Optimization | 🔥 | 🔥 | ✅ | ✅ | ✅ | ✅ | ✅ |

**Legend:**
- ✅ Fully Supported
- ⚠️ Simplified/Limited
- ❌ Not Available
- 🔥 Optimized

---

## 🎯 Best Practices

### For Server Owners

1. **Use Auto-Detection** - Let the system detect your framework
2. **Configure Framework Settings** - Customize for your specific setup
3. **Test Notifications** - Verify notification system works
4. **Enable Debug Initially** - Helps troubleshoot integration issues
5. **Monitor Console** - Check for framework initialization messages

### For Developers

1. **Use Unified API** - Always use adapter functions, not direct framework calls
2. **Handle Nil Cases** - Check if `Framework.Core` exists before using
3. **Provide Fallbacks** - Ensure functionality degrades gracefully
4. **Test All Frameworks** - Verify compatibility across supported frameworks
5. **Document Changes** - Update docs when adding framework support

---

## 🔗 Framework-Specific Resources

### Official Framework Links

- **LXR-Core:** Contact iBoss21 / The Lux Empire
- **RSG-Core:** https://github.com/Rexshack-RedM/rsg-core
- **VORP Core:** https://github.com/VORPCORE/vorp-core-lua
- **RedEM:RP:** https://github.com/RedEM-RP/redem_roleplay
- **QBR-Core:** Search RedM adaptations
- **QR-Core:** Search RedM adaptations

---

## 📚 Related Documentation

- [Configuration Guide](configuration.md)
- [Events & Exports](events.md)
- [Installation Guide](installation.md)

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
