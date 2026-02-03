# 🐺 LXR-Mirror - Configuration Reference

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

## 📖 Configuration Overview

This document provides a complete reference for all configuration options available in `config.lua`. The LXR-Mirror system is highly customizable and can be tailored to match your server's specific requirements.

---

## 📁 Configuration File Location

- **Path:** `/lxr-mirror/config.lua`
- **Format:** Lua table structure
- **Reload:** Restart the resource after making changes

---

## 🔒 Resource Name Protection

The resource enforces its branded name at runtime.

```lua
local REQUIRED_RESOURCE_NAME = "lxr-mirror"
```

**Purpose:** Ensures brand integrity and prevents naming conflicts.

**Behavior:**
- Resource will not start if folder name is incorrect
- Displays clear error message with expected name
- Cannot be bypassed without modifying source code

**Error Message Example:**
```
❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
Expected: lxr-mirror
Got: mirror-system
```

---

## 🏢 Server Information Section

```lua
Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!',
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    developer = 'iBoss21 / The Lux Empire',
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Mirror', 'Character', 'Immersion'}
}
```

**Purpose:** Branding and attribution metadata.

**Customization:** Update these values to reflect your server information while maintaining attribution to the original developer.

---

## 🎮 Framework Configuration

### Framework Detection

```lua
Config.Framework = 'auto'
```

**Options:**
- `'auto'` - Automatic detection (recommended)
- `'lxr-core'` - Force LXR-Core
- `'rsg-core'` - Force RSG-Core
- `'vorp_core'` - Force VORP Core
- `'redem_roleplay'` - Force RedEM:RP
- `'qbr-core'` - Force QBR-Core
- `'qr-core'` - Force QR-Core
- `'standalone'` - No framework mode

**Detection Priority (when auto):**
1. LXR-Core
2. RSG-Core
3. VORP Core
4. RedEM:RP
5. QBR-Core
6. QR-Core
7. Standalone (fallback)

### Framework-Specific Settings

```lua
Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource = 'lxr-core',
        notifications = 'ox_lib',
        inventory = 'lxr-inventory',
        target = 'ox_target',
        events = {
            server = 'lxr-core:server:%s',
            client = 'lxr-core:client:%s',
            callback = 'lxr-core:callback:%s'
        }
    },
    -- Additional frameworks...
}
```

**Per-Framework Options:**
- `resource` - Resource name to check for detection
- `notifications` - Notification system to use
- `inventory` - Inventory system name
- `target` - Targeting system name
- `events` - Event naming convention patterns

---

## 🌍 Language Configuration

### Language Selection

```lua
Config.Lang = 'en'
```

**Available Languages:**
- `'en'` - English
- `'ge'` - Georgian (ქართული)

### Locale Strings

```lua
Config.Locale = {
    en = {
        mirror_activated = 'Mirror activated',
        mirror_deactivated = 'Mirror deactivated',
        mirror_use = 'Use Mirror',
        mirror_toggle = 'Toggle Mirror',
        mirror_close = 'Close Mirror',
        no_mirror = 'You need a pocket mirror',
        cooldown_active = 'You just used the mirror, wait a moment'
    }
}
```

**Adding Custom Languages:**

1. Add new language key to `Config.Lang`
2. Create locale table in `Config.Locale`
3. Translate all strings maintaining same keys

**Example: Adding Spanish**

```lua
Config.Lang = 'es'

Config.Locale.es = {
    mirror_activated = 'Espejo activado',
    mirror_deactivated = 'Espejo desactivado',
    mirror_use = 'Usar espejo',
    mirror_toggle = 'Alternar espejo',
    mirror_close = 'Cerrar espejo',
    no_mirror = 'Necesitas un espejo de bolsillo',
    cooldown_active = 'Acabas de usar el espejo, espera un momento'
}
```

---

## ⚙️ General Settings

```lua
Config.General = {
    enableCommand = true,
    commandName = 'mirror',
    requireItem = false,
    requiredItem = 'pocketmirror',
    enableKeybind = false,
    keybindKey = 'M',
    freezePlayer = true,
    disableControls = true
}
```

### Option Details

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enableCommand` | boolean | `true` | Enable /mirror command |
| `commandName` | string | `'mirror'` | Command name to use |
| `requireItem` | boolean | `false` | Require item in inventory |
| `requiredItem` | string | `'pocketmirror'` | Item name required (if enabled) |
| `enableKeybind` | boolean | `false` | Enable keyboard shortcut |
| `keybindKey` | string | `'M'` | Key for keybind (if enabled) |
| `freezePlayer` | boolean | `true` | Freeze player while using mirror |
| `disableControls` | boolean | `true` | Disable movement controls |

**Common Use Cases:**

**Item-Based Mirror:**
```lua
Config.General.requireItem = true
Config.General.requiredItem = 'pocketmirror'
```

**Keybind Only (No Command):**
```lua
Config.General.enableCommand = false
Config.General.enableKeybind = true
Config.General.keybindKey = 'M'
```

**Free Movement Mirror:**
```lua
Config.General.freezePlayer = false
Config.General.disableControls = false
```

---

## 📷 Camera Configuration

### Gender-Specific Settings

```lua
Config.Camera = {
    male = {
        offsetX = -0.04,
        offsetY = 0.6,
        offsetZ = 0.7,
        fov = 10.0,
        updateInterval = 0
    },
    female = {
        offsetX = -0.03,
        offsetY = 0.3,
        offsetZ = 0.6,
        fov = 20.0,
        updateInterval = 0
    },
    smoothTransition = true,
    transitionTime = 500
}
```

### Camera Parameters

| Parameter | Type | Description | Range |
|-----------|------|-------------|-------|
| `offsetX` | float | Horizontal offset from ped | -1.0 to 1.0 |
| `offsetY` | float | Forward/backward offset | 0.0 to 2.0 |
| `offsetZ` | float | Vertical offset (height) | 0.0 to 2.0 |
| `fov` | float | Field of view (degrees) | 1.0 to 130.0 |
| `updateInterval` | integer | Update rate (ms, 0=every frame) | 0 to 100 |
| `smoothTransition` | boolean | Enable smooth camera transitions | true/false |
| `transitionTime` | integer | Transition duration (ms) | 100 to 2000 |

### Model Height Adjustments

```lua
Config.ModelDimensions = {
    ['mp_male'] = vector3(0.0, 0.0, 1.0),
    ['mp_female'] = vector3(0.0, 0.0, 0.9),
}
```

**Purpose:** Fine-tune camera positioning for different character models.

**Adding Custom Models:**
```lua
Config.ModelDimensions['custom_model'] = vector3(0.0, 0.0, 0.95)
```

### Camera Tuning Guide

**For Closer Face View:**
- Decrease `offsetY` (move camera forward)
- Decrease `fov` (narrow field of view)

**For Wider View:**
- Increase `offsetY` (move camera back)
- Increase `fov` (wider field of view)

**For Height Adjustment:**
- Increase `offsetZ` for higher position
- Decrease `offsetZ` for lower position

**Example: Cinematic Close-up**
```lua
Config.Camera.male.offsetY = 0.4
Config.Camera.male.fov = 15.0
```

---

## 🎬 Animation Configuration

```lua
Config.Animation = {
    dict = "amb_misc@world_human_pocket_mirror@female_a@base",
    anim = "base",
    flag = 1,
    loadTimeout = 5000
}
```

### Animation Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `dict` | string | Animation dictionary name |
| `anim` | string | Animation name within dictionary |
| `flag` | integer | Animation flag (0=normal, 1=loop) |
| `loadTimeout` | integer | Max wait time for animation load (ms) |

### Animation Flags

- `0` - Play once
- `1` - Repeat/loop continuously
- `2` - Stop on last frame
- `16` - Cancellable
- `32` - Upper body only

**Common Animation Alternatives:**

```lua
-- Male mirror animation
Config.Animation.dict = "amb_misc@world_human_pocket_mirror@male_a@base"

-- Sitting mirror animation
Config.Animation.dict = "amb_misc@world_human_pocket_mirror@female_a@idle_a"
```

**Find More Animations:**
https://github.com/femga/rdr3_discoveries/blob/master/animations/ingameanims/ingameanims_list.lua

---

## 🪞 Prop Configuration

```lua
Config.Prop = {
    enabled = true,
    model = "p_pocketmirror01x",
    bone = "skel_l_hand",
    offset = {
        x = 0.08,
        y = 0.01,
        z = 0.05
    },
    rotation = {
        x = -17.0,
        y = 173.0,
        z = -62.0
    }
}
```

### Prop Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `enabled` | boolean | Enable prop spawning |
| `model` | string | Prop model name |
| `bone` | string | Bone to attach prop to |
| `offset.x/y/z` | float | Position offset from bone |
| `rotation.x/y/z` | float | Rotation angles (degrees) |

### Common Bones

- `skel_l_hand` - Left hand
- `skel_r_hand` - Right hand
- `skel_spine3` - Upper chest

### Prop Adjustment Tips

**Position Tuning:**
- `offset.x` - Left/right (negative = left)
- `offset.y` - Forward/back (positive = forward)
- `offset.z` - Up/down (positive = up)

**Rotation Tuning:**
- Adjust in small increments (5-10 degrees)
- Test with both male and female models
- Use in-game to verify positioning

**Disable Prop:**
```lua
Config.Prop.enabled = false
```

---

## 🎨 NUI / UI Configuration

```lua
Config.UI = {
    enabled = true,
    imagePath = 'image.png',
    showOnToggle = true,
    fadeInTime = 300,
    fadeOutTime = 300
}
```

### UI Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `enabled` | boolean | Enable UI overlay |
| `imagePath` | string | Image file path (in nui folder) |
| `showOnToggle` | true | Show UI when mirror toggles |
| `fadeInTime` | integer | Fade in duration (ms) |
| `fadeOutTime` | integer | Fade out duration (ms) |

**Custom UI Image:**
1. Place image in `/lxr-mirror/nui/` folder
2. Update `imagePath` to filename
3. Supported formats: PNG, JPG, GIF

**Example:**
```lua
Config.UI.imagePath = 'custom_frame.png'
```

**Disable UI Overlay:**
```lua
Config.UI.enabled = false
```

---

## ⏱️ Cooldowns Configuration

```lua
Config.Cooldowns = {
    enabled = true,
    duration = 2000,
    notifyOnCooldown = true
}
```

### Cooldown Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `enabled` | boolean | Enable cooldown system |
| `duration` | integer | Cooldown duration (ms) |
| `notifyOnCooldown` | boolean | Show notification when on cooldown |

**Use Cases:**

**Short Cooldown (Rapid Use):**
```lua
Config.Cooldowns.duration = 1000  -- 1 second
```

**Long Cooldown (Restricted Use):**
```lua
Config.Cooldowns.duration = 10000  -- 10 seconds
```

**No Cooldown:**
```lua
Config.Cooldowns.enabled = false
```

---

## 🔐 Security Configuration

```lua
Config.Security = {
    enabled = true,
    maxUsesPerMinute = 30,
    logSuspiciousActivity = true,
    rateLimitWarning = 20,
    kickOnExploit = false,
    serverSideValidation = false
}
```

### Security Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `enabled` | boolean | Enable security system |
| `maxUsesPerMinute` | integer | Max toggles per minute per player |
| `logSuspiciousActivity` | boolean | Log excessive usage to console |
| `rateLimitWarning` | integer | Warn threshold for usage |
| `kickOnExploit` | boolean | Kick player on exploit detection |
| `serverSideValidation` | boolean | Enable server-side checks |

**Security Levels:**

**Strict:**
```lua
Config.Security.maxUsesPerMinute = 15
Config.Security.kickOnExploit = true
Config.Security.serverSideValidation = true
```

**Moderate (Default):**
```lua
Config.Security.maxUsesPerMinute = 30
Config.Security.logSuspiciousActivity = true
```

**Relaxed:**
```lua
Config.Security.enabled = false
```

---

## ⚡ Performance Configuration

```lua
Config.Performance = {
    cameraUpdateRate = 0,
    cleanupOnResourceStop = true,
    preloadAnimations = true,
    optimizeForLowEnd = false
}
```

### Performance Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `cameraUpdateRate` | integer | Camera update interval (0=every frame) |
| `cleanupOnResourceStop` | boolean | Clean up on resource stop |
| `preloadAnimations` | true | Preload animation dictionaries |
| `optimizeForLowEnd` | boolean | Enable low-end optimizations |

**Performance Modes:**

**Maximum Quality (High-End PCs):**
```lua
Config.Performance.cameraUpdateRate = 0
Config.Performance.optimizeForLowEnd = false
```

**Balanced:**
```lua
Config.Performance.cameraUpdateRate = 16  -- ~60 FPS update
Config.Performance.optimizeForLowEnd = false
```

**Low-End Optimized:**
```lua
Config.Performance.cameraUpdateRate = 33  -- ~30 FPS update
Config.Performance.optimizeForLowEnd = true
Config.Camera.smoothTransition = false
```

---

## 🐛 Debug Settings

```lua
Config.Debug = false
```

**Enable Debug Mode:**
```lua
Config.Debug = true
```

**Debug Output Includes:**
- Framework detection results
- Camera start/stop events
- Animation loading status
- Rate limiting warnings
- UI toggle events
- Prop spawning information

**Usage:** Enable when troubleshooting issues or testing configuration changes.

---

## 📝 Configuration Examples

### Example 1: Roleplay Immersive Mode

```lua
Config.General = {
    enableCommand = true,
    commandName = 'mirror',
    requireItem = true,
    requiredItem = 'pocketmirror',
    enableKeybind = false,
    freezePlayer = true,
    disableControls = true
}

Config.Cooldowns = {
    enabled = true,
    duration = 3000,
    notifyOnCooldown = true
}

Config.Security = {
    enabled = true,
    maxUsesPerMinute = 20,
    logSuspiciousActivity = true,
    kickOnExploit = false
}
```

### Example 2: Quick Access Mode

```lua
Config.General = {
    enableCommand = true,
    commandName = 'mirror',
    requireItem = false,
    enableKeybind = true,
    keybindKey = 'M',
    freezePlayer = false,
    disableControls = false
}

Config.Cooldowns = {
    enabled = true,
    duration = 1000,
    notifyOnCooldown = false
}
```

### Example 3: Photography/Content Creation Mode

```lua
Config.Camera = {
    male = {
        offsetY = 0.5,
        fov = 20.0,
        updateInterval = 0
    },
    smoothTransition = true,
    transitionTime = 1000
}

Config.General.freezePlayer = true
Config.Cooldowns.enabled = false
Config.UI.enabled = false
```

---

## 🔧 Troubleshooting Configuration

### Camera Position Issues

**Problem:** Camera too close/far
- Adjust `Config.Camera.[gender].offsetY`
- Decrease for closer, increase for farther

**Problem:** Camera off-center
- Adjust `Config.Camera.[gender].offsetX`
- Negative values move left, positive right

### Animation Issues

**Problem:** Animation not playing
- Verify animation dictionary name
- Increase `loadTimeout` to 10000
- Check console for loading errors

### Performance Issues

**Problem:** FPS drops when using mirror
- Increase `cameraUpdateRate` to 33 or 50
- Enable `optimizeForLowEnd`
- Disable `smoothTransition`

### Prop Issues

**Problem:** Prop not appearing
- Verify prop model name is correct
- Check if model exists in game files
- Try different bone attachment

**Problem:** Prop position incorrect
- Adjust `offset` values in small increments
- Test with both male/female characters
- Check `rotation` values

---

## 📚 Related Documentation

- [Installation Guide](installation.md)
- [Framework Adapters](frameworks.md)
- [Events & Exports](events.md)
- [Security Features](security.md)
- [Performance Guide](performance.md)

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
