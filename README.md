# 🐺 LXR-Mirror - Pocket Mirror System

```
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

**🐺 The Land of Wolves - Georgian RP 🇬🇪**

An immersive pocket mirror system for RedM that allows players to view their character's face up close with realistic camera positioning, animations, and prop attachments.

---

## 📋 Table of Contents

- [Features](#-features)
- [Framework Support](#-framework-support)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [Documentation](#-documentation)
- [Performance](#-performance)
- [Security](#-security)
- [Credits](#-credits)
- [Support](#-support)

---

## ✨ Features

### Core Functionality
- **Realistic Camera System** - Dynamic camera positioning based on player gender
- **Smooth Animations** - Authentic pocket mirror animation with proper prop attachment
- **NUI Overlay** - Customizable mirror frame overlay for enhanced immersion
- **Multi-Framework Support** - Works with LXR-Core, RSG-Core, VORP, and more
- **Standalone Compatible** - Functions without any framework dependency

### Advanced Features
- **Gender-Specific Settings** - Different camera FOV and positioning for male/female characters
- **Height Adjustment** - Automatic camera offset based on player model
- **Cooldown System** - Configurable cooldowns to prevent spam
- **Security Measures** - Built-in rate limiting and anti-abuse protection
- **Performance Optimized** - Minimal FPS impact with efficient camera updates

### Customization
- **Fully Configurable** - Every aspect adjustable through config.lua
- **Locale Support** - English and Georgian languages included
- **Branded UI** - wolves.land branding throughout
- **Command & Keybind** - Support for both /mirror command and keybind

---

## 🎯 Framework Support

### Primary Support (Tier 1)
- ✅ **LXR-Core** - Full integration with LXR ecosystem
- ✅ **RSG-Core** - Complete RSG-Core compatibility

### Supported Frameworks (Tier 2)
- ✅ **VORP Core** - Legacy support with full functionality
- ✅ **RedEM:RP** - Compatible with RedEM roleplay framework
- ✅ **QBR-Core** - QBCore RedM variant support
- ✅ **QR-Core** - QCore RedM variant support

### Fallback
- ✅ **Standalone** - Works without any framework

**Framework Auto-Detection:** The resource automatically detects your framework on startup. No manual configuration needed!

---

## 📦 Installation

### 1. Download & Extract
```bash
cd resources
git clone https://github.com/iBoss21/lxr-mirror.git
# or download and extract the ZIP
```

### 2. Rename Folder (IMPORTANT)
The resource folder **MUST** be named `lxr-mirror` (exact name, case-sensitive):
```bash
mv lxr-mirror-main lxr-mirror  # if downloaded as ZIP
```

> ⚠️ **Resource Name Protection:** The resource will not start if the folder is not named correctly. This prevents branding issues.

### 3. Add to server.cfg
```cfg
ensure lxr-mirror
```

### 4. Configure (Optional)
Edit `config.lua` to customize:
- Camera settings
- Animation preferences
- Cooldowns and security
- Localization
- Framework settings

### 5. Start Server
The resource will automatically detect your framework and display a startup banner showing the configuration.

---

## ⚙️ Configuration

### Quick Configuration
The most common settings to adjust:

```lua
-- Enable/disable command
Config.General.enableCommand = true
Config.General.commandName = 'mirror'

-- Require item in inventory
Config.General.requireItem = false
Config.General.requiredItem = 'pocketmirror'

-- Camera FOV settings
Config.Camera.male.fov = 10.0
Config.Camera.female.fov = 20.0

-- Cooldown duration (milliseconds)
Config.Cooldowns.duration = 2000
```

For complete configuration documentation, see [docs/configuration.md](docs/configuration.md)

---

## 🎮 Usage

### Player Commands
```
/mirror     - Toggle the pocket mirror on/off
/showimage  - Toggle just the UI overlay (legacy)
```

### For Developers

#### Exports
```lua
-- Toggle mirror programmatically
exports['lxr-mirror']:ToggleMirror()

-- Check if mirror is active
local isActive = exports['lxr-mirror']:IsMirrorActive()

-- Check if UI is open
local isUIOpen = exports['lxr-mirror']:IsUIOpen()

-- Get framework adapter
local Framework = exports['lxr-mirror']:GetFramework()
```

---

## 📚 Documentation

Comprehensive documentation is available in the `/docs` folder:

- **[Overview](docs/overview.md)** - Detailed feature overview and architecture
- **[Installation Guide](docs/installation.md)** - Step-by-step installation instructions
- **[Configuration](docs/configuration.md)** - Complete configuration reference
- **[Frameworks](docs/frameworks.md)** - Framework adapter and compatibility info
- **[Events & Exports](docs/events.md)** - API reference for developers
- **[Security](docs/security.md)** - Security features and best practices
- **[Performance](docs/performance.md)** - Optimization guide and benchmarks
- **[Screenshots](docs/screenshots.md)** - Visual examples and requirements

---

## ⚡ Performance

- **Client FPS Impact:** < 1 FPS on average hardware
- **Memory Footprint:** ~2-3 MB
- **Resmon:**
  - Idle: 0.00 ms
  - Active (mirror open): 0.01-0.02 ms
- **Network Traffic:** Minimal (client-side only)

### Optimization Features
- Efficient camera update loop
- Conditional prop spawning
- Smart animation dictionary caching
- Configurable update intervals
- Automatic cleanup on resource stop

---

## 🔒 Security

### Built-in Protection
- ✅ Resource name verification (prevents unauthorized rebranding)
- ✅ Rate limiting (max uses per minute configurable)
- ✅ Cooldown system (prevents spam)
- ✅ Usage monitoring (logs suspicious activity)
- ✅ Server-side validation ready (optional)

### Anti-Abuse Measures
```lua
Config.Security = {
    maxUsesPerMinute = 30,        -- Rate limit
    logSuspiciousActivity = true,  -- Log warnings
    rateLimitWarning = 20,         -- Warning threshold
    kickOnExploit = false          -- Auto-kick (optional)
}
```

For detailed security information, see [docs/security.md](docs/security.md)

---

## 🏆 Credits

**Script Author:** iBoss21 / The Lux Empire for The Land of Wolves  
**Original Concept:** Pocket mirror immersion mechanic  
**Framework:** wolves.land / LXR Framework ecosystem

### Special Thanks
- The RedM community for animation discoveries
- Framework developers (LXR, RSG, VORP teams)
- All contributors and testers

---

## 🐺 The Land of Wolves

### Server Information
**Name:** The Land of Wolves 🐺  
**Tagline:** Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!  
**Description:** ისტორია ცოცხლდება აქ! (History Lives Here!)  
**Type:** Serious Hardcore Roleplay  
**Access:** Discord & Whitelisted

### Links
- **Website:** [wolves.land](https://www.wolves.land)
- **Discord:** [Join Our Community](https://discord.gg/CrKcWdfd3A)
- **GitHub:** [@iBoss21](https://github.com/iBoss21)
- **Store:** [The Lux Empire](https://theluxempire.tebex.io)
- **Server Listing:** [RedM Servers](https://servers.redm.net/servers/detail/8gj7eb)

---

## 📞 Support

### Get Help
1. **Documentation First:** Check the [docs](docs/) folder
2. **Discord Support:** Join our [Discord](https://discord.gg/CrKcWdfd3A)
3. **GitHub Issues:** [Report bugs](https://github.com/iBoss21/lxr-mirror/issues)

### Contributing
We welcome contributions! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request
4. Follow our coding standards (wolves.land style guide)

---

## 📄 License

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

This resource is branded for The Land of Wolves and distributed under the included LICENSE file.

---

## 🔖 Version History

### v1.0.0 (Current)
- Initial release with wolves.land branding
- Multi-framework support (LXR, RSG, VORP, etc.)
- Complete framework adapter layer
- Comprehensive documentation
- Security and performance optimizations

---

<p align="center">
  <strong>🐺 Made with ❤️ for The Land of Wolves 🐺</strong><br>
  <em>ისტორია ცოცხლდება აქ! - History Lives Here!</em>
</p>
