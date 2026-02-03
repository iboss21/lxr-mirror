# 🐺 LXR-Mirror - Security Features

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

## 📖 Security Overview

LXR-Mirror implements multiple layers of security protection to prevent abuse, exploits, and maintain server integrity. This document covers all security features, their implementation, configuration, and best practices.

---

## 🛡️ Security Layers

### Defense in Depth Strategy

```
┌─────────────────────────────────────────┐
│   Layer 1: Resource Name Protection     │  ← Brand Protection
├─────────────────────────────────────────┤
│   Layer 2: Rate Limiting System         │  ← Abuse Prevention
├─────────────────────────────────────────┤
│   Layer 3: Cooldown Mechanism           │  ← Usage Control
├─────────────────────────────────────────┤
│   Layer 4: Logging & Monitoring         │  ← Detection
├─────────────────────────────────────────┤
│   Layer 5: Resource Lifecycle Control   │  ← Cleanup
└─────────────────────────────────────────┘
```

---

## 🔐 Layer 1: Resource Name Protection

### Purpose

Enforces correct resource naming to maintain brand integrity and prevent conflicts.

### Implementation

**Location:** `config.lua` (lines 60-84)

```lua
local REQUIRED_RESOURCE_NAME = "lxr-mirror"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        ═══════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════
        
        Expected: %s
        Got: %s
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.
        
        🐺 wolves.land - The Land of Wolves
        ═══════════════════════════════════════════════════════════════
    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end
```

### Protection Level

**Type:** Critical Runtime Check  
**When:** Resource initialization  
**Action:** Prevents resource start if name is incorrect

### Security Benefits

1. **Brand Protection** - Maintains wolves.land branding
2. **Prevents Conflicts** - Ensures consistent naming across dependencies
3. **Attribution Enforcement** - Credits remain intact
4. **Version Control** - Easier to identify authentic versions

### Bypass Prevention

- Hard-coded in config.lua
- Executes before any other code
- Cannot be disabled via configuration
- Requires source code modification to bypass

### Error Message

Clear, informative error with exact resolution steps.

**Example Output:**

```
Error loading script config.lua in resource lxr-mirror-renamed: 
        ═══════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════
        
        Expected: lxr-mirror
        Got: lxr-mirror-renamed
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "lxr-mirror" to continue.
```

---

## ⏱️ Layer 2: Rate Limiting System

### Purpose

Prevents abuse by limiting how many times a player can toggle the mirror within a time window.

### Configuration

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

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enabled` | boolean | `true` | Enable security system |
| `maxUsesPerMinute` | integer | `30` | Maximum toggles per minute |
| `logSuspiciousActivity` | boolean | `true` | Log excessive usage |
| `rateLimitWarning` | integer | `20` | Warning threshold |
| `kickOnExploit` | boolean | `false` | Kick on exploit detection |
| `serverSideValidation` | boolean | `false` | Enable server checks |

### Implementation

**Location:** `client/mirror.lua` (lines 64-96)

```lua
local usageCounter = 0
local usageResetTime = 0

function CheckRateLimit()
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
            -- Trigger server-side kick
        end
        return false
    elseif usageCounter > Config.Security.rateLimitWarning then
        if Config.Security.logSuspiciousActivity then
            Framework:Debug('Approaching rate limit: ' .. usageCounter .. ' uses')
        end
    end
    
    return true
end
```

### How It Works

1. **Counter Initialization** - Starts at 0 on resource load
2. **Increment on Use** - Each toggle increments counter
3. **60-Second Window** - Counter resets after 60 seconds
4. **Warning Threshold** - Logs when approaching limit (20/30 by default)
5. **Hard Limit** - Blocks usage when exceeded (30/minute by default)
6. **Automatic Reset** - Counter resets every minute

### Thresholds

**Warning Phase (20-29 uses):**
- Logged to console
- Debug message printed
- Usage still allowed

**Block Phase (30+ uses):**
- Usage blocked
- Warning logged to console
- Optional kick (if enabled)
- Reset after 60 seconds

### Example Log Output

**Warning:**
```
[LXR-Mirror DEBUG] Approaching rate limit: 22 uses
```

**Exceeded:**
```
[LXR-Mirror WARNING] Rate limit exceeded: 31 uses per minute
```

### Security Profiles

**Strict (Competitive RP):**
```lua
Config.Security.maxUsesPerMinute = 15
Config.Security.rateLimitWarning = 10
Config.Security.kickOnExploit = true
Config.Security.logSuspiciousActivity = true
```

**Standard (Recommended):**
```lua
Config.Security.maxUsesPerMinute = 30
Config.Security.rateLimitWarning = 20
Config.Security.kickOnExploit = false
Config.Security.logSuspiciousActivity = true
```

**Relaxed (Casual Servers):**
```lua
Config.Security.maxUsesPerMinute = 60
Config.Security.rateLimitWarning = 45
Config.Security.kickOnExploit = false
Config.Security.logSuspiciousActivity = false
```

**Disabled:**
```lua
Config.Security.enabled = false
```

---

## 🕐 Layer 3: Cooldown Mechanism

### Purpose

Prevents rapid toggling of the mirror, improving user experience and reducing spam.

### Configuration

```lua
Config.Cooldowns = {
    enabled = true,
    duration = 2000,
    notifyOnCooldown = true
}
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enabled` | boolean | `true` | Enable cooldown system |
| `duration` | integer | `2000` | Cooldown duration (ms) |
| `notifyOnCooldown` | boolean | `true` | Notify when on cooldown |

### Implementation

**Location:** `client/mirror.lua` (lines 54-62)

```lua
local lastUseTime = 0

function IsOnCooldown()
    if not Config.Cooldowns.enabled then
        return false
    end
    
    local currentTime = GetGameTimer()
    return (currentTime - lastUseTime) < Config.Cooldowns.duration
end
```

### How It Works

1. **Timestamp Tracking** - Records last toggle time
2. **Time Comparison** - Compares current time to last use
3. **Cooldown Check** - Blocks if within cooldown period
4. **User Notification** - Informs user of cooldown (if enabled)
5. **Automatic Expiry** - Cooldown expires after configured duration

### Usage in ToggleMirror

```lua
function ToggleMirror()
    -- Check cooldown
    if IsOnCooldown() then
        if Config.Cooldowns.notifyOnCooldown then
            Framework:Notify(Framework:GetLocale('cooldown_active'), 'error', 3000)
        end
        return
    end
    
    -- ... mirror toggle logic ...
    
    -- Update cooldown timer
    lastUseTime = GetGameTimer()
end
```

### Cooldown Durations

**Very Short (Rapid Testing):**
```lua
Config.Cooldowns.duration = 500  -- 0.5 seconds
```

**Short (Quick Use):**
```lua
Config.Cooldowns.duration = 1000  -- 1 second
```

**Standard (Recommended):**
```lua
Config.Cooldowns.duration = 2000  -- 2 seconds
```

**Long (Restricted Use):**
```lua
Config.Cooldowns.duration = 5000  -- 5 seconds
```

**Very Long (RP Immersion):**
```lua
Config.Cooldowns.duration = 10000  -- 10 seconds
```

### Difference from Rate Limiting

| Feature | Cooldown | Rate Limiting |
|---------|----------|---------------|
| **Purpose** | Prevent rapid toggle | Prevent abuse |
| **Time Window** | Per use | Per minute |
| **Threshold** | Single use | Multiple uses |
| **Reset** | Automatic | After 60s |
| **Notification** | Optional | Warning only |
| **Severity** | Low | High |

---

## 📊 Layer 4: Logging & Monitoring

### Purpose

Track and record suspicious activity for server administrators.

### Logging Capabilities

#### 1. Security Warnings

```lua
if Config.Security.logSuspiciousActivity then
    print('^3[LXR-Mirror WARNING]^7 Rate limit exceeded: ' .. usageCounter .. ' uses per minute')
end
```

**When Logged:**
- Rate limit exceeded
- Approaching rate limit
- Unusual usage patterns

**Format:**
```
[LXR-Mirror WARNING] Rate limit exceeded: 31 uses per minute
```

#### 2. Debug Logging

```lua
Framework:Debug('Camera started - Gender: ' .. (isMale and 'Male' or 'Female') .. ', FOV: ' .. cameraFOV)
```

**Enable:**
```lua
Config.Debug = true
```

**What's Logged:**
- Framework detection
- Camera start/stop
- Animation loading
- Prop spawning
- UI toggling
- Rate limit warnings
- Cooldown activations

**Example Output:**
```
[LXR-Mirror DEBUG] Detected framework: lxr-core
[LXR-Mirror DEBUG] Camera started - Gender: Male, FOV: 10.0
[LXR-Mirror DEBUG] UI toggled: shown
[LXR-Mirror DEBUG] Approaching rate limit: 22 uses
[LXR-Mirror DEBUG] Camera stopped
```

#### 3. Startup Banner

```lua
[LXR-Mirror] Framework adapter initialized: lxr-core
```

**Information Shown:**
- Version number
- Server name
- Framework detected
- Language configured
- Command name
- Camera settings
- Security status
- Debug mode status

### Monitoring Best Practices

1. **Enable Logging Initially** - Help troubleshoot issues
2. **Monitor Console** - Watch for warnings
3. **Review Patterns** - Identify problem players
4. **Adjust Thresholds** - Based on usage data
5. **Disable When Stable** - Reduce console spam

### Log Analysis

**Normal Usage Pattern:**
```
[LXR-Mirror] Framework adapter initialized: lxr-core
[LXR-Mirror DEBUG] Camera started - Gender: Male, FOV: 10.0
[LXR-Mirror DEBUG] Camera stopped
[LXR-Mirror DEBUG] Camera started - Gender: Male, FOV: 10.0
[LXR-Mirror DEBUG] Camera stopped
```

**Suspicious Pattern:**
```
[LXR-Mirror DEBUG] Approaching rate limit: 21 uses
[LXR-Mirror DEBUG] Approaching rate limit: 23 uses
[LXR-Mirror DEBUG] Approaching rate limit: 26 uses
[LXR-Mirror WARNING] Rate limit exceeded: 31 uses per minute
[LXR-Mirror WARNING] Rate limit exceeded: 32 uses per minute
```

---

## 🧹 Layer 5: Resource Lifecycle Control

### Purpose

Properly clean up resources when mirror closes or resource stops.

### Cleanup on Resource Stop

**Location:** `client/mirror.lua` (lines 318-329)

```lua
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
```

### What Gets Cleaned Up

1. **Camera**
   - Destroyed and removed
   - Rendering disabled
   - Memory freed

2. **Prop**
   - Deleted from world
   - Handle freed

3. **Animation**
   - Cleared from ped
   - Dictionary unloaded (if configured)

4. **Player State**
   - Unfrozen
   - Controls re-enabled

5. **UI**
   - Hidden
   - NUI messages stopped

### Configuration

```lua
Config.Performance = {
    cleanupOnResourceStop = true
}
```

**Recommended:** Keep enabled to prevent:
- Memory leaks
- Camera stuck active
- Player frozen
- Prop persistence

---

## 🔒 Anti-Abuse Measures

### Combined Protection

Rate limiting + cooldown provides layered protection:

**Example Scenario:**
1. Player toggles mirror (✅ Allowed)
2. Tries again immediately (❌ Blocked by cooldown)
3. Waits 2 seconds, tries again (✅ Allowed)
4. Repeats rapidly for 1 minute (✅ Allowed up to limit)
5. Exceeds 30 uses in 1 minute (❌ Blocked by rate limit)
6. Must wait for counter reset (60 seconds)

### Exploit Prevention

**Prevents:**
- ❌ Rapid toggle spam
- ❌ Server performance degradation
- ❌ Client FPS abuse
- ❌ Macro exploitation
- ❌ Automation scripts

**Allows:**
- ✅ Normal usage
- ✅ Testing and customization
- ✅ Character preview
- ✅ Photography/content creation

### Kick on Exploit

**When to Enable:**
```lua
Config.Security.kickOnExploit = true
```

**Use Cases:**
- Competitive RP servers
- Strict rule enforcement
- Known abuse issues
- Zero-tolerance policy

**When to Disable:**
```lua
Config.Security.kickOnExploit = false
```

**Use Cases:**
- Development/testing
- Casual servers
- First offense warnings
- Lenient policies

---

## 🛠️ Server-Side Validation

### Current Status

**Available:** Configuration option  
**Status:** Not implemented (placeholder)

```lua
Config.Security.serverSideValidation = false
```

### Future Implementation

Server-side validation would add:

1. **Server Authority** - Server validates each toggle request
2. **Centralized Tracking** - Server maintains usage counters
3. **Cross-Client Protection** - Prevents client-side bypass
4. **Advanced Detection** - Pattern analysis
5. **Database Logging** - Persistent abuse records

### Implementation Outline

**Server File:** `server/security.lua` (future)

```lua
-- Future server-side validation
local playerUsage = {}

RegisterNetEvent('lxr-mirror:server:requestToggle', function()
    local src = source
    
    -- Validate request
    if ValidateToggleRequest(src) then
        -- Allow toggle
        TriggerClientEvent('lxr-mirror:client:toggleApproved', src)
    else
        -- Deny toggle
        TriggerClientEvent('lxr-mirror:client:toggleDenied', src)
    end
end)
```

---

## 📋 Security Checklist

### For Server Administrators

- [ ] Review security configuration
- [ ] Set appropriate rate limits
- [ ] Configure cooldown duration
- [ ] Enable logging initially
- [ ] Monitor console for warnings
- [ ] Test with various frameworks
- [ ] Verify cleanup on stop
- [ ] Document any custom changes
- [ ] Train moderation team
- [ ] Establish abuse policies

### For Developers

- [ ] Maintain resource name integrity
- [ ] Don't bypass security measures
- [ ] Respect rate limiting
- [ ] Test security features
- [ ] Log suspicious patterns
- [ ] Validate all inputs
- [ ] Clean up resources properly
- [ ] Document security changes
- [ ] Follow best practices
- [ ] Report vulnerabilities

---

## 🎯 Security Best Practices

### Configuration Recommendations

**High Security (Serious RP):**
```lua
Config.Security = {
    enabled = true,
    maxUsesPerMinute = 15,
    logSuspiciousActivity = true,
    rateLimitWarning = 10,
    kickOnExploit = true,
    serverSideValidation = true  -- When available
}

Config.Cooldowns = {
    enabled = true,
    duration = 5000,
    notifyOnCooldown = true
}
```

**Balanced (General Use):**
```lua
Config.Security = {
    enabled = true,
    maxUsesPerMinute = 30,
    logSuspiciousActivity = true,
    rateLimitWarning = 20,
    kickOnExploit = false,
    serverSideValidation = false
}

Config.Cooldowns = {
    enabled = true,
    duration = 2000,
    notifyOnCooldown = true
}
```

**Low Security (Testing):**
```lua
Config.Security = {
    enabled = false
}

Config.Cooldowns = {
    enabled = true,
    duration = 1000,
    notifyOnCooldown = false
}
```

### Monitoring Guidelines

1. **Initial Week** - Enable full logging, monitor closely
2. **Adjustment Period** - Tune thresholds based on data
3. **Steady State** - Reduce logging, maintain monitoring
4. **Incident Response** - Re-enable logging when issues occur

### Player Communication

**Clear Rules:**
- Explain mirror usage limits
- Document consequences
- Provide appeal process
- Update rules regularly

**Example Server Rules:**
```
Mirror Usage Policy:
- Maximum 30 uses per minute
- 2-second cooldown between uses
- Excessive use will be blocked automatically
- Intentional abuse may result in kick/ban
- Use for RP and character preview
```

---

## 🔍 Troubleshooting Security Issues

### Player Reporting Cooldown Issues

**Problem:** Cooldown seems too long

**Solution:**
```lua
Config.Cooldowns.duration = 1000  -- Reduce to 1 second
```

### High False Positive Rate

**Problem:** Legitimate users hitting rate limit

**Solution:**
```lua
Config.Security.maxUsesPerMinute = 45  -- Increase limit
Config.Security.rateLimitWarning = 35  -- Adjust warning
```

### Suspected Bypass Attempts

**Problem:** Player appears to bypass limits

**Investigation:**
1. Check console logs
2. Enable debug mode
3. Monitor player usage
4. Review server logs
5. Check for mod conflicts

**Solution:**
- Increase logging level
- Lower rate limits
- Enable kick on exploit
- Report to developer

### Resource Name Error

**Problem:** Resource won't start due to name mismatch

**Solution:**
1. Rename folder to exactly `lxr-mirror`
2. Verify no extra characters or spaces
3. Restart resource

---

## 📚 Related Documentation

- [Configuration Guide](configuration.md)
- [Performance Optimization](performance.md)
- [Installation Guide](installation.md)

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
