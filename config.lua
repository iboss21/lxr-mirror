--[[
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                                                                                    
    🐺 LXR-Mirror - Pocket Mirror System Configuration
    
    This configuration file controls the interactive pocket mirror system for RedM.
    Players can use a handheld mirror to view their character's face in detail.
    Features include camera positioning, animations, prop attachments, and UI overlay.
    
    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    
    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted
    
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    Version: 1.0.0
    Performance Target: Optimized for minimal client FPS impact with smooth camera transitions
    
    Tags: RedM, Georgian, SeriousRP, Whitelist, Mirror, Character, Immersion, Roleplay
    
    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Primary)
    - VORP Core (Supported)
    - RedEM:RP (Compatible)
    - QBR Core (Compatible)
    - QR Core (Compatible)
    - Standalone (Compatible)
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Script Author: iBoss21 / The Lux Empire for The Land of Wolves
    Original Concept: Pocket mirror immersion mechanic
    Inspired by: Character customization and self-inspection systems
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-mirror"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════
        
        Expected: %s
        Got: %s
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.
        
        🐺 wolves.land - The Land of Wolves
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    
    -- Contact & Links
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    
    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
    
    -- Tags
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Mirror', 'Character', 'Immersion'}
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core (Primary)
    2. RSG-Core (Primary)
    3. VORP Core (Supported)
    4. RedEM:RP (Optional - if detected)
    5. QBR-Core (Optional - if detected)
    6. QR-Core (Optional - if detected)
    7. Standalone (Fallback)
]]

Config.Framework = 'auto' -- 'auto' or manual: 'lxr-core', 'rsg-core', 'vorp_core', 'redem_roleplay', 'qbr-core', 'qr-core', 'standalone'

-- Framework-specific settings
Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource = 'lxr-core',
        notifications = 'ox_lib', -- notification system to use
        inventory = 'lxr-inventory',
        target = 'ox_target',
        -- Event naming convention
        events = {
            server = 'lxr-core:server:%s',
            client = 'lxr-core:client:%s',
            callback = 'lxr-core:callback:%s'
        }
    },
    ['rsg-core'] = {
        resource = 'rsg-core',
        notifications = 'ox_lib',
        inventory = 'rsg-inventory',
        target = 'ox_target',
        events = {
            server = 'RSGCore:Server:%s',
            client = 'RSGCore:Client:%s',
            callback = 'RSGCore:Callback:%s'
        }
    },
    ['vorp_core'] = {
        resource = 'vorp_core',
        notifications = 'vorp',
        inventory = 'vorp_inventory',
        target = 'vorp_core',
        events = {
            server = 'vorp:server:%s',
            client = 'vorp:client:%s'
        }
    },
    ['redem_roleplay'] = {
        resource = 'redem_roleplay',
        notifications = 'redem',
        inventory = 'redem_inventory',
        target = 'redem_target',
        events = {
            server = 'redem:%s:server',
            client = 'redem:%s:client'
        }
    },
    ['qbr-core'] = {
        resource = 'qbr-core',
        notifications = 'ox_lib',
        inventory = 'qbr-inventory',
        target = 'ox_target',
        events = {
            server = 'QBR:Server:%s',
            client = 'QBR:Client:%s'
        }
    },
    ['qr-core'] = {
        resource = 'qr-core',
        notifications = 'ox_lib',
        inventory = 'qr-inventory',
        target = 'ox_target',
        events = {
            server = 'QR:Server:%s',
            client = 'QR:Client:%s'
        }
    },
    ['standalone'] = {
        -- Minimal functionality without framework
        notifications = 'print',
        inventory = 'none',
        target = 'none'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en' -- Language for notifications (en, ge, etc.)

Config.Locale = {
    en = {
        mirror_activated = 'Mirror activated',
        mirror_deactivated = 'Mirror deactivated',
        mirror_use = 'Use Mirror',
        mirror_toggle = 'Toggle Mirror',
        mirror_close = 'Close Mirror',
        no_mirror = 'You need a pocket mirror',
        cooldown_active = 'You just used the mirror, wait a moment'
    },
    ge = {
        mirror_activated = 'სარკე გააქტიურდა',
        mirror_deactivated = 'სარკე გამოირთო',
        mirror_use = 'გამოიყენე სარკე',
        mirror_toggle = 'სარკის გადართვა',
        mirror_close = 'დახურე სარკე',
        no_mirror = 'გჭირდება ჯიბის სარკე',
        cooldown_active = 'ახლახან გამოიყენე სარკე, დაელოდე'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GENERAL SETTINGS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.General = {
    enableCommand = true,           -- Enable /mirror command
    commandName = 'mirror',         -- Command name to toggle mirror
    requireItem = false,            -- Require pocket mirror item in inventory
    requiredItem = 'pocketmirror',  -- Item name required (if requireItem is true)
    enableKeybind = false,          -- Enable keybind to toggle mirror
    keybindKey = 'M',              -- Key to toggle mirror (if enableKeybind is true)
    freezePlayer = true,            -- Freeze player position while using mirror
    disableControls = true          -- Disable movement controls while using mirror
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ CAMERA CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Camera settings by player gender
Config.Camera = {
    male = {
        offsetX = -0.04,        -- Horizontal offset
        offsetY = 0.6,          -- Forward offset
        offsetZ = 0.7,          -- Vertical offset (height)
        fov = 10.0,             -- Field of view (degrees)
        updateInterval = 0      -- Camera update interval (0 = every frame)
    },
    female = {
        offsetX = -0.03,        -- Horizontal offset
        offsetY = 0.3,          -- Forward offset
        offsetZ = 0.6,          -- Vertical offset (height)
        fov = 20.0,             -- Field of view (degrees)
        updateInterval = 0      -- Camera update interval (0 = every frame)
    },
    smoothTransition = true,    -- Smooth camera transitions
    transitionTime = 500        -- Transition time in milliseconds
}

-- Model dimensions for height adjustments
Config.ModelDimensions = {
    ['mp_male'] = vector3(0.0, 0.0, 1.0),      -- Default male height adjustment
    ['mp_female'] = vector3(0.0, 0.0, 0.9),    -- Default female height adjustment
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ANIMATION CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Animation settings
-- Find more animations here: https://github.com/femga/rdr3_discoveries/blob/master/animations/ingameanims/ingameanims_list.lua
Config.Animation = {
    dict = "amb_misc@world_human_pocket_mirror@female_a@base",
    anim = "base",
    flag = 1,  -- 1 = repeat/loop, 0 = normal
    loadTimeout = 5000  -- Animation dictionary load timeout (ms)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PROP CONFIGURATION ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Mirror prop settings
Config.Prop = {
    enabled = true,                         -- Enable prop spawning
    model = "p_pocketmirror01x",           -- Prop model name
    bone = "skel_l_hand",                  -- Bone to attach prop to
    offset = {
        x = 0.08,                          -- X position offset
        y = 0.01,                          -- Y position offset
        z = 0.05                           -- Z position offset
    },
    rotation = {
        x = -17.0,                         -- X rotation
        y = 173.0,                         -- Y rotation
        z = -62.0                          -- Z rotation
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ NUI / UI CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.UI = {
    enabled = true,                        -- Enable UI overlay
    imagePath = 'image.png',              -- Path to mirror frame image (in nui folder)
    showOnToggle = true,                  -- Show UI when mirror is toggled
    fadeInTime = 300,                     -- Fade in time (ms)
    fadeOutTime = 300                     -- Fade out time (ms)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ TIMING & COOLDOWNS ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Cooldowns = {
    enabled = true,                       -- Enable cooldown system
    duration = 2000,                      -- Cooldown duration in milliseconds
    notifyOnCooldown = true               -- Notify player when on cooldown
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SECURITY & ANTI-ABUSE █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Security = {
    enabled = true,                       -- Enable security checks
    maxUsesPerMinute = 30,               -- Max mirror toggles per minute per player
    logSuspiciousActivity = true,        -- Log excessive usage
    rateLimitWarning = 20,               -- Warn at this many uses per minute
    kickOnExploit = false,               -- Kick player if exploit detected
    serverSideValidation = false         -- Enable server-side validation (requires server file)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PERFORMANCE OPTIMIZATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Performance = {
    cameraUpdateRate = 0,                -- Camera update rate (0 = every frame, higher = less frequent)
    cleanupOnResourceStop = true,        -- Clean up camera/props on resource stop
    preloadAnimations = true,            -- Preload animation dictionaries
    optimizeForLowEnd = false            -- Reduce visual quality for better performance
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG SETTINGS ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Enable debug prints and extra logging

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ END OF CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Startup banner
CreateThread(function()
    Wait(1000)
    print([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        
            ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
            ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
            ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
            ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
            ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
            ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
        
        ═══════════════════════════════════════════════════════════════════════════════
        🐺 POCKET MIRROR SYSTEM - SUCCESSFULLY LOADED
        ═══════════════════════════════════════════════════════════════════════════════
        
        Version:     1.0.0
        Server:      ]] .. Config.ServerInfo.name .. [[
        
        Framework:   ]] .. (Config.Framework == 'auto' and 'Auto-detect enabled' or Config.Framework) .. [[
        Language:    ]] .. Config.Lang .. [[
        Command:     /]] .. (Config.General.commandName or 'mirror') .. [[
        
        Camera:      Male FOV: ]] .. Config.Camera.male.fov .. [[° | Female FOV: ]] .. Config.Camera.female.fov .. [[°
        Animation:   ]] .. Config.Animation.dict .. [[
        Prop:        ]] .. (Config.Prop.enabled and Config.Prop.model or 'Disabled') .. [[
        UI:          ]] .. (Config.UI.enabled and 'Enabled' or 'Disabled') .. [[
        
        Security:    ]] .. (Config.Security.enabled and 'ENABLED ✓' or 'DISABLED ✗') .. [[
        Debug:       ]] .. (Config.Debug and 'ENABLED' or 'DISABLED') .. [[
        
        ═══════════════════════════════════════════════════════════════════════════════
        
        Developer:   iBoss21 / The Lux Empire
        Website:     https://www.wolves.land
        Discord:     https://discord.gg/CrKcWdfd3A
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]])
end)
