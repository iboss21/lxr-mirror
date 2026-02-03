# 🐺 LXR-Mirror - Installation Guide

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

## 📥 Installation

Complete step-by-step installation guide for LXR-Mirror.

---

## 📋 Prerequisites

Before installing LXR-Mirror, ensure you have:

✅ RedM server installed and running  
✅ FXServer artifacts (latest recommended)  
✅ Server restart access  
✅ File system access to server resources folder

**Optional:**
- Supported framework (LXR-Core, RSG-Core, VORP, etc.)
- ox_lib for enhanced notifications
- Inventory system (if using item requirement)

---

## 🚀 Method 1: Git Clone (Recommended)

### Step 1: Navigate to Resources Folder
```bash
cd /path/to/your/server/resources
```

### Step 2: Clone Repository
```bash
git clone https://github.com/iBoss21/lxr-mirror.git
```

### Step 3: Verify Folder Name
Ensure the folder is named exactly `lxr-mirror`:
```bash
ls -la | grep lxr-mirror
# Should show: lxr-mirror/
```

### Step 4: Add to server.cfg
Edit your `server.cfg` and add:
```cfg
ensure lxr-mirror
```

### Step 5: Restart Server
```bash
# Linux
./run.sh

# Windows
run.bat

# Or use txAdmin restart
```

---

## 📦 Method 2: Manual Download

### Step 1: Download ZIP
1. Go to: https://github.com/iBoss21/lxr-mirror
2. Click **Code** → **Download ZIP**
3. Extract the ZIP file

### Step 2: Rename Folder
The extracted folder will be named `lxr-mirror-main` or similar.  
**You MUST rename it to exactly:** `lxr-mirror`

```bash
# Linux/Mac
mv lxr-mirror-main lxr-mirror

# Windows (Command Prompt)
ren lxr-mirror-main lxr-mirror
```

⚠️ **CRITICAL:** The folder name must be exactly `lxr-mirror` (lowercase, with hyphen). The resource has runtime name protection and will **NOT START** if named incorrectly.

### Step 3: Move to Resources
Move the `lxr-mirror` folder to your server's resources directory:
```
/path/to/your/server/resources/lxr-mirror/
```

### Step 4: Add to server.cfg
```cfg
ensure lxr-mirror
```

### Step 5: Restart Server

---

## 🔧 Configuration Setup

### Basic Configuration

After installation, edit `config.lua` for basic setup:

#### 1. Command Name (Optional)
```lua
Config.General.commandName = 'mirror'  -- Change if desired
```

#### 2. Item Requirement (Optional)
If you want to require a pocket mirror item:
```lua
Config.General.requireItem = true
Config.General.requiredItem = 'pocketmirror'  -- Your item name
```

#### 3. Framework (Usually Auto-Detected)
```lua
Config.Framework = 'auto'  -- Leave as 'auto' for auto-detection
-- Or manually set: 'lxr-core', 'rsg-core', 'vorp_core', etc.
```

#### 4. Language
```lua
Config.Lang = 'en'  -- 'en' for English, 'ge' for Georgian
```

### Advanced Configuration

For camera, animation, and security settings, see:
- [Configuration Documentation](configuration.md)

---

## ✅ Verification

### Check Resource Started

After server restart, check console for:
```
═══════════════════════════════════════════════════════════════════════════════
🐺 POCKET MIRROR SYSTEM - SUCCESSFULLY LOADED
═══════════════════════════════════════════════════════════════════════════════

Version:     1.0.0
Server:      The Land of Wolves 🐺

Framework:   Auto-detect enabled (or detected framework name)
Language:    en
Command:     /mirror
...
```

### Test In-Game

1. Connect to your server
2. Type `/mirror` in chat
3. You should see your character's face up close
4. Type `/mirror` again to close

### Check for Errors

If you see errors:
1. Verify folder name is exactly `lxr-mirror`
2. Check `fxmanifest.lua` is present and valid
3. Ensure all files are present (config.lua, client/mirror.lua, etc.)
4. Check server console for error messages

---

## 🎯 Framework-Specific Setup

### LXR-Core / RSG-Core

No additional setup needed. The resource will auto-detect.

**Optional:** If using item requirement, add mirror item to your items:
```lua
-- In your framework's items.lua
['pocketmirror'] = {
    label = 'Pocket Mirror',
    weight = 50,
    stack = false,
    close = true,
    description = 'A small handheld mirror'
}
```

### VORP Core

VORP will be auto-detected.

**Optional:** Add mirror item to VORP inventory:
```sql
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) 
VALUES ('pocketmirror', 'Pocket Mirror', 1, 1, 'item_standard', 0);
```

### RedEM:RP

RedEM will be auto-detected.

Configure items as per RedEM documentation if using item requirement.

### Standalone Mode

No framework needed! The resource works perfectly standalone.

Simply ensure the resource and disable item requirement:
```lua
Config.General.requireItem = false
```

---

## 📁 File Structure Check

Verify all files are present:

```
lxr-mirror/
├── fxmanifest.lua          ✅ Resource manifest
├── config.lua              ✅ Configuration
├── LICENSE                 ✅ License file
├── README.md               ✅ Main documentation
│
├── client/
│   └── mirror.lua          ✅ Client script
│
├── shared/
│   └── framework.lua       ✅ Framework adapter
│
├── nui/
│   ├── ui.html             ✅ NUI HTML
│   ├── ui.js               ✅ NUI JavaScript
│   └── image.png           ✅ Mirror frame image
│
└── docs/
    ├── overview.md         ✅ Overview
    ├── installation.md     ✅ This file
    ├── configuration.md    ✅ Config docs
    ├── frameworks.md       ✅ Framework docs
    ├── events.md           ✅ API docs
    ├── security.md         ✅ Security docs
    ├── performance.md      ✅ Performance docs
    └── screenshots.md      ✅ Screenshots
```

---

## 🔄 Updating

### Git Method
```bash
cd /path/to/resources/lxr-mirror
git pull origin main
```

### Manual Method
1. Download latest version
2. Backup your `config.lua` (if customized)
3. Replace all files except `config.lua`
4. Merge any new config options from the new `config.lua`
5. Restart server

---

## 🐛 Troubleshooting

### Issue: Resource Won't Start

**Error:** "Resource name mismatch"
- **Solution:** Rename folder to exactly `lxr-mirror`

**Error:** "Failed to load resource"
- **Solution:** Check `fxmanifest.lua` syntax and file permissions

### Issue: Command Not Working

**Check:**
1. Resource is started: `/refresh` then `/ensure lxr-mirror`
2. Command is enabled: `Config.General.enableCommand = true`
3. Correct command name: Check `Config.General.commandName`

### Issue: Black Screen / No Camera

**Check:**
1. Animation dictionary loaded (check console for errors)
2. Camera settings valid in config
3. No conflicts with other camera scripts

### Issue: Mirror Prop Not Showing

**Check:**
1. Prop spawning enabled: `Config.Prop.enabled = true`
2. Prop model valid: `p_pocketmirror01x` exists in game
3. No prop limit reached on server

### Issue: Framework Not Detected

**Check:**
1. Framework resource is started before lxr-mirror
2. Framework resource name matches config
3. Set manually if needed: `Config.Framework = 'your-framework'`

### Issue: Notifications Not Showing

**Check:**
1. Framework notifications working
2. ox_lib installed (if using LXR/RSG/QBR/QR)
3. Check framework settings in config

---

## 📞 Getting Help

### Support Channels

1. **Documentation:** Read the docs folder thoroughly
2. **Discord:** [Join wolves.land Discord](https://discord.gg/CrKcWdfd3A)
3. **GitHub Issues:** [Report bugs/issues](https://github.com/iBoss21/lxr-mirror/issues)
4. **Community:** Ask in RedM development communities

### Before Asking for Help

Please provide:
- Server artifact version
- Framework name and version
- Full error messages from console
- Steps to reproduce the issue
- Config.lua (without sensitive info)

---

## 🎓 Next Steps

After installation:
1. ✅ Configure settings to your preference → [configuration.md](configuration.md)
2. ✅ Understand framework integration → [frameworks.md](frameworks.md)
3. ✅ Learn about security features → [security.md](security.md)
4. ✅ Optimize performance if needed → [performance.md](performance.md)
5. ✅ Check API for custom integration → [events.md](events.md)

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
