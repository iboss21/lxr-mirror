# 🐺 LXR-Mirror - Overview

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

## 📖 System Overview

LXR-Mirror is a production-grade pocket mirror system for RedM, designed for The Land of Wolves server. It provides an immersive first-person view of the player's character face using a realistic camera system with proper animations and prop attachments.

---

## 🎯 Core Purpose

The mirror system allows players to:
- Inspect their character's face and appearance in detail
- View character customization changes in real-time
- Enhance roleplay immersion with realistic mirror interaction
- Use a simple command or keybind to toggle the mirror

---

## 🏗️ Architecture

### Component Structure

```
lxr-mirror/
├── config.lua              # Main configuration with branding
├── fxmanifest.lua          # Resource manifest
│
├── shared/
│   └── framework.lua       # Multi-framework adapter/bridge
│
├── client/
│   └── mirror.lua          # Camera, animation, and UI logic
│
├── nui/
│   ├── ui.html             # Mirror frame overlay
│   ├── ui.js               # NUI message handling
│   └── image.png           # Mirror frame image
│
└── docs/
    ├── overview.md         # This file
    ├── installation.md     # Installation guide
    ├── configuration.md    # Config reference
    ├── frameworks.md       # Framework integration
    ├── events.md           # API reference
    ├── security.md         # Security features
    ├── performance.md      # Performance guide
    └── screenshots.md      # Visual documentation
```

### Data Flow

1. **Player Action** → Command `/mirror` or keybind
2. **Validation** → Cooldown check, item check (if required), rate limit
3. **Camera System** → Create camera, position based on gender/height
4. **Animation** → Load and play pocket mirror animation
5. **Prop Attachment** → Spawn mirror prop and attach to hand
6. **UI Overlay** → Display mirror frame via NUI
7. **Update Loop** → Continuously update camera position/rotation
8. **Cleanup** → Remove camera, prop, animation when toggled off

---

## 🎨 Key Features Explained

### 1. Gender-Specific Camera System

The system automatically detects player gender and applies appropriate camera settings:

**Male Characters:**
- Closer camera position (offsetY: 0.6)
- Tighter FOV (10°) for detailed face view
- Optimized vertical offset (0.7)

**Female Characters:**
- Slightly further camera (offsetY: 0.3)
- Wider FOV (20°) for fuller face view
- Adjusted vertical offset (0.6)

### 2. Model Height Adjustment

The system includes a height compensation system:
- Detects player model (mp_male, mp_female, custom models)
- Applies height offset to camera Y position
- Ensures consistent camera framing across different character models
- Extensible model dimensions table in config

### 3. Animation & Prop System

**Animation:**
- Uses authentic RedM animation dictionary
- Loops continuously while mirror is active
- Freezes player position for stable viewing
- Cleans up properly when deactivated

**Prop Attachment:**
- Spawns pocket mirror prop (p_pocketmirror01x)
- Attaches to left hand bone (skel_l_hand)
- Precise positioning and rotation
- Automatic cleanup when mirror closes

### 4. NUI Overlay System

- Displays a mirror frame/border image
- Full-screen overlay for immersion
- Toggles synchronously with camera
- Configurable image path
- Lightweight (only shows image, no heavy HTML/CSS)

### 5. Multi-Framework Bridge

The framework adapter provides:
- **Auto-Detection:** Finds active framework on startup
- **Unified API:** Same functions work across all frameworks
- **Notification System:** Framework-agnostic notifications
- **Inventory Integration:** Check for mirror item (if required)
- **Locale Support:** Multi-language notifications

Supported frameworks in priority order:
1. LXR-Core
2. RSG-Core
3. VORP Core
4. RedEM:RP
5. QBR-Core
6. QR-Core
7. Standalone (fallback)

---

## 🔐 Security Design

### Client-Side Protection
- **Cooldown System:** Prevents rapid toggling
- **Rate Limiting:** Max uses per minute tracking
- **Usage Monitoring:** Logs suspicious activity
- **Resource Name Guard:** Prevents unauthorized rebranding

### Server-Side Ready
While currently client-only, the architecture supports:
- Server-side validation hooks
- Event-based state verification
- Admin logging integration
- Discord webhook alerts

---

## ⚡ Performance Characteristics

### Resource Usage
- **Memory:** 2-3 MB (client)
- **CPU:** < 0.02ms when active, 0.00ms idle
- **FPS Impact:** < 1 FPS on average hardware
- **Network:** None (fully client-side)

### Optimization Strategies
1. **Lazy Loading:** Animations loaded only when needed
2. **Conditional Updates:** Camera updates at configurable rate
3. **Efficient Cleanup:** Proper entity deletion on stop
4. **Smart Caching:** Animation dictionaries cached after first load
5. **Minimal NUI:** Simple image overlay, no complex rendering

---

## 🎭 Use Cases

### 1. Character Customization
Players can use the mirror to:
- Check appearance after barber/cosmetics
- Verify character creation choices
- Inspect facial features in detail

### 2. Roleplay Scenarios
- "Looking in a mirror" RP action
- Character grooming scenes
- Social interaction prop
- Immersive character moments

### 3. Photography
- Close-up selfie angles
- Character showcase screenshots
- Promotional content creation

---

## 🔄 State Management

The system tracks several states:

```lua
cameraActive    -- Is camera currently rendering
cameraEntity    -- Camera entity reference
mirrorOpen      -- Is UI overlay displayed
spawnedObject   -- Mirror prop entity
lastUseTime     -- Timestamp of last use (cooldown)
usageCounter    -- Uses in current minute (rate limit)
usageResetTime  -- When to reset usage counter
```

All states are properly cleaned up on:
- Mirror toggle off
- Resource stop
- Player disconnect (automatic Lua GC)

---

## 🌐 Localization

Built-in locale support for:
- **English (en)** - Default
- **Georgian (ge)** - Native language for The Land of Wolves

Locale keys:
- mirror_activated
- mirror_deactivated
- mirror_use
- mirror_toggle
- mirror_close
- no_mirror
- cooldown_active

Easy to extend by adding new language tables to Config.Locale.

---

## 🔧 Extensibility

The system is designed for easy extension:

### Custom Camera Positions
Add new gender/model-specific settings in config:
```lua
Config.Camera.custom_model = {
    offsetX = 0.0,
    offsetY = 0.5,
    offsetZ = 0.8,
    fov = 15.0
}
```

### Additional Animations
Change animation dictionary/name in config:
```lua
Config.Animation = {
    dict = "your_custom_dict",
    anim = "your_custom_anim",
    flag = 1
}
```

### Custom Props
Modify prop model and positioning:
```lua
Config.Prop = {
    model = "your_prop_model",
    bone = "your_bone_name",
    -- etc.
}
```

### Framework Integration
Add new framework support in shared/framework.lua:
1. Add detection logic
2. Implement initialization function
3. Map to unified API functions

---

## 📊 System Requirements

### Server
- RedM server (latest recommended)
- Any supported framework (or none for standalone)
- Lua 5.4 enabled

### Client
- RedM client (latest)
- Average gaming hardware (30+ FPS baseline)
- ~5 MB free memory

### Optional
- ox_lib (for enhanced notifications)
- Inventory system (if requireItem enabled)

---

## 🎯 Design Philosophy

### wolves.land Standards
This resource adheres to The Land of Wolves development standards:
- ✅ Heavy branding and visual identity
- ✅ Production-grade code quality
- ✅ Multi-framework compatibility
- ✅ Comprehensive documentation
- ✅ Security-first approach
- ✅ Performance optimization
- ✅ Immersive gameplay focus

### Code Quality
- Consistent naming conventions
- Extensive comments and documentation
- Modular architecture
- Error handling and edge cases
- Clean separation of concerns

---

## 🔮 Future Enhancements

Potential future additions:
- Server-side state synchronization
- Mirror item requirement with actual item system
- Multiple mirror types (hand, wall-mounted, etc.)
- Customizable mirror frame overlays
- Distance check from actual mirror props in world
- Integration with clothing/barber scripts
- Multiplayer mirror viewing (others can see you using mirror)

---

## 📞 Support & Feedback

For questions, bug reports, or suggestions:
- Discord: [Join wolves.land](https://discord.gg/CrKcWdfd3A)
- GitHub Issues: [Report Here](https://github.com/iBoss21/lxr-mirror/issues)
- Documentation: [Read Full Docs](../README.md)

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
