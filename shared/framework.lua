--[[
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                                                                                    
    🐺 LXR-Mirror - Framework Bridge / Adapter Layer
    
    This file provides a unified API layer for multi-framework compatibility.
    It automatically detects the active framework and provides standardized
    functions that work across all supported frameworks.
    
    Purpose: Decouple core gameplay logic from framework-specific implementations
    
    ═══════════════════════════════════════════════════════════════════════════════
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION
-- ═══════════════════════════════════════════════════════════════════════════════

Framework = {}
Framework.Active = nil
Framework.PlayerData = {}

-- Framework detection function
function DetectFramework()
    if Config.Framework ~= 'auto' then
        return Config.Framework
    end
    
    -- Priority order: LXR > RSG > VORP > RedEM > QBR > QR > Standalone
    local frameworks = {
        'lxr-core',
        'rsg-core',
        'vorp_core',
        'redem_roleplay',
        'qbr-core',
        'qr-core'
    }
    
    for _, fw in ipairs(frameworks) do
        local settings = Config.FrameworkSettings[fw]
        if settings and GetResourceState(settings.resource) == 'started' then
            return fw
        end
    end
    
    return 'standalone'
end

-- Initialize framework
function Framework:Initialize()
    self.Active = DetectFramework()
    
    if Config.Debug then
        print('^3[LXR-Mirror]^7 Detected framework: ^2' .. self.Active .. '^7')
    end
    
    -- Framework-specific initialization
    if self.Active == 'lxr-core' then
        self:InitializeLXRCore()
    elseif self.Active == 'rsg-core' then
        self:InitializeRSGCore()
    elseif self.Active == 'vorp_core' then
        self:InitializeVORP()
    elseif self.Active == 'redem_roleplay' then
        self:InitializeRedEM()
    elseif self.Active == 'qbr-core' then
        self:InitializeQBR()
    elseif self.Active == 'qr-core' then
        self:InitializeQR()
    else
        self:InitializeStandalone()
    end
    
    print('^2[LXR-Mirror]^7 Framework adapter initialized: ^3' .. self.Active .. '^7')
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK-SPECIFIC INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

function Framework:InitializeLXRCore()
    -- LXR-Core specific initialization
    if IsDuplicityVersion() then
        -- Server-side
        self.Core = exports['lxr-core']:GetCoreObject()
    else
        -- Client-side
        self.Core = exports['lxr-core']:GetCoreObject()
    end
end

function Framework:InitializeRSGCore()
    -- RSG-Core specific initialization
    if IsDuplicityVersion() then
        self.Core = exports['rsg-core']:GetCoreObject()
    else
        self.Core = exports['rsg-core']:GetCoreObject()
    end
end

function Framework:InitializeVORP()
    -- VORP Core specific initialization
    if IsDuplicityVersion() then
        self.Core = exports.vorp_core:GetCore()
    else
        self.Core = exports.vorp_core:GetCore()
    end
end

function Framework:InitializeRedEM()
    -- RedEM:RP specific initialization
    if IsDuplicityVersion() then
        self.Core = exports['redem_roleplay']:GetCoreObject()
    else
        self.Core = exports['redem_roleplay']:GetCoreObject()
    end
end

function Framework:InitializeQBR()
    -- QBR-Core specific initialization
    if IsDuplicityVersion() then
        self.Core = exports['qbr-core']:GetCoreObject()
    else
        self.Core = exports['qbr-core']:GetCoreObject()
    end
end

function Framework:InitializeQR()
    -- QR-Core specific initialization
    if IsDuplicityVersion() then
        self.Core = exports['qr-core']:GetCoreObject()
    else
        self.Core = exports['qr-core']:GetCoreObject()
    end
end

function Framework:InitializeStandalone()
    -- Standalone mode (no framework)
    self.Core = nil
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- UNIFIED ADAPTER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- ███████ NOTIFICATION SYSTEM ███████

function Framework:Notify(message, type, duration)
    type = type or 'info'
    duration = duration or 5000
    
    if self.Active == 'lxr-core' or self.Active == 'rsg-core' or self.Active == 'qbr-core' or self.Active == 'qr-core' then
        -- Using ox_lib for notifications
        if GetResourceState('ox_lib') == 'started' then
            exports.ox_lib:notify({
                title = 'Mirror',
                description = message,
                type = type,
                duration = duration
            })
        else
            -- Fallback to framework notification
            if self.Core then
                self.Core.Functions.Notify(message, type, duration)
            else
                print(message)
            end
        end
    elseif self.Active == 'vorp_core' then
        if self.Core then
            self.Core.NotifyRightTip(message, duration)
        else
            print(message)
        end
    elseif self.Active == 'redem_roleplay' then
        if self.Core then
            self.Core.Functions.Notify(message, type, duration)
        else
            print(message)
        end
    else
        -- Standalone fallback
        print('[Mirror] ' .. message)
    end
end

-- ███████ PLAYER DATA SYSTEM ███████

function Framework:GetPlayerData()
    if self.Active == 'lxr-core' or self.Active == 'rsg-core' or self.Active == 'qbr-core' or self.Active == 'qr-core' then
        if self.Core then
            return self.Core.Functions.GetPlayerData()
        end
    elseif self.Active == 'vorp_core' then
        if self.Core then
            return self.Core.getUser(GetPlayerServerId(PlayerId())).getUsedCharacter
        end
    elseif self.Active == 'redem_roleplay' then
        if self.Core then
            return self.Core.Functions.GetPlayerData()
        end
    end
    
    return {}
end

function Framework:IsPlayerLoaded()
    if self.Active == 'lxr-core' or self.Active == 'rsg-core' or self.Active == 'qbr-core' or self.Active == 'qr-core' then
        if self.Core then
            local playerData = self.Core.Functions.GetPlayerData()
            return playerData and playerData.citizenid ~= nil
        end
    elseif self.Active == 'vorp_core' then
        -- VORP uses different player load system
        return true -- Simplified for this resource
    elseif self.Active == 'redem_roleplay' then
        if self.Core then
            local playerData = self.Core.Functions.GetPlayerData()
            return playerData and playerData.identifier ~= nil
        end
    end
    
    return true -- Standalone always returns true
end

-- ███████ INVENTORY SYSTEM ███████

function Framework:HasItem(item, amount)
    amount = amount or 1
    
    if self.Active == 'lxr-core' or self.Active == 'rsg-core' then
        if self.Core then
            local hasItem = self.Core.Functions.HasItem(item, amount)
            return hasItem
        end
    elseif self.Active == 'vorp_core' then
        -- VORP inventory check would require callback
        return true -- Simplified for mirror resource
    elseif self.Active == 'qbr-core' or self.Active == 'qr-core' then
        if self.Core then
            return self.Core.Functions.HasItem(item, amount)
        end
    elseif self.Active == 'redem_roleplay' then
        -- RedEM inventory check
        return true -- Simplified
    end
    
    return true -- Standalone always returns true
end

-- ███████ CALLBACK SYSTEM ███████

function Framework:TriggerCallback(name, cb, ...)
    if self.Active == 'lxr-core' or self.Active == 'rsg-core' then
        if self.Core then
            self.Core.Functions.TriggerCallback(name, cb, ...)
        end
    elseif self.Active == 'vorp_core' then
        if self.Core then
            self.Core.Callback.TriggerAsync(name, cb, ...)
        end
    elseif self.Active == 'qbr-core' or self.Active == 'qr-core' then
        if self.Core then
            self.Core.Functions.TriggerCallback(name, cb, ...)
        end
    elseif self.Active == 'redem_roleplay' then
        if self.Core then
            self.Core.Functions.TriggerCallback(name, cb, ...)
        end
    else
        -- Standalone fallback
        if cb then cb(false) end
    end
end

-- ███████ UTILITY FUNCTIONS ███████

function Framework:GetLocale(key)
    local lang = Config.Lang or 'en'
    if Config.Locale[lang] and Config.Locale[lang][key] then
        return Config.Locale[lang][key]
    end
    return key
end

function Framework:Debug(message)
    if Config.Debug then
        print('^3[LXR-Mirror DEBUG]^7 ' .. message)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- EXPORTS
-- ═══════════════════════════════════════════════════════════════════════════════

exports('GetFramework', function()
    return Framework
end)

exports('GetActiveFramework', function()
    return Framework.Active
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- AUTO-INITIALIZE ON LOAD
-- ═══════════════════════════════════════════════════════════════════════════════

if not IsDuplicityVersion() then
    -- Client-side auto-initialization
    CreateThread(function()
        Wait(1000) -- Wait for config to load
        Framework:Initialize()
    end)
end
