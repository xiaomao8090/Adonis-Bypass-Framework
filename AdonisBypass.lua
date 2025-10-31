-- Adonis Bypass Framework
-- Author: xiaomao
-- QQ: 1303323893
-- Version: v1.0.2

repeat
    task.wait()
until game:IsLoaded()

local player = game.Players.LocalPlayer

local CONFIG = {
    DELAY = 12,
    HIDE_CONSOLE = false,
    FAKE_LAG = true,
    BEHAVIOR_RANDOM = true,
    BLOCK_REMOTES = true,
}

print("Loading bypass framework...")

-- Layer 1: External bypass (DISABLED)
-- local bypassLoaded = false
-- pcall(function()
--     loadstring(game:HttpGet("https://raw.githubusercontent.com/Jko-Scripts/Adonis-AC-Bypass/main/Source.luau"))()
--     bypassLoaded = true
--     print("External bypass loaded")
-- end)
local bypassLoaded = false

task.wait(2)

-- Layer 2: Smart delay system
local function smartWait()
    local startTime = tick()
    local maxWait = CONFIG.DELAY + 5
    
    while tick() - startTime < CONFIG.DELAY do
        local adonisReady = false
        pcall(function()
            for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                if v.Name:lower():find("admin") then
                    adonisReady = true
                    break
                end
            end
        end)
        
        if adonisReady and tick() - startTime > 8 then
            task.wait(3)
            break
        end
        
        task.wait(1)
    end
end

smartWait()

-- Layer 3: Metatable protection
local oldMeta = {}
local metaProtected = false

pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    
    oldMeta.__index = mt.__index
    oldMeta.__newindex = mt.__newindex
    oldMeta.__namecall = mt.__namecall
    
    metaProtected = true
    setreadonly(mt, true)
    print("Metatable protection enabled")
end)

-- Layer 4: Remote interception and kick protection
if CONFIG.BLOCK_REMOTES then
    local blockedRemotes = {
        "Detected", "Kick", "Ban", "AdminDetection",
        "AntiCheat", "Security", "LogExploit",
        "StaminaChange", "AntiToolClone"
    }
    
    local suspiciousPatterns = {
        "detect", "kick", "ban", "log", "report",
        "exploit", "cheat", "hack", "inject", "security",
        "anticheat", "admin", "stamina", "antitool"
    }
    
    local function checkcaller()
        local callingScript = getcallingscript()
        if callingScript == nil then
            return true
        end
        return not pcall(function()
            game:IsDescendantOf(callingScript)
        end)
    end
    
    if not getgenv().namecallHooked then
        getgenv().namecallHooked = true
        pcall(function()
            local mt = getrawmetatable(game)
            if mt and mt.__namecall then
                local originalNamecall = mt.__namecall
                setreadonly(mt, false)
                
                mt.__namecall = newcclosure(function(self, ...)
                    local args = {...}
                    local method = getnamecallmethod()
                    
                    -- Block kick immediately
                    if method == "Kick" then
                        return nil
                    end
                    
                    -- Exclude common operations to avoid detection
                    if method == "GetPropertyChangedSignal" or 
                       method == "GetAttribute" or 
                       method == "SetAttribute" or
                       method == "FindFirstChild" or
                       method == "WaitForChild" or
                       method == "GetChildren" or
                       method == "GetDescendants" or
                       method == "Clone" or
                       method == "Destroy" or
                       method == "Remove" or
                       method == "GetService" then
                        return originalNamecall(self, table.unpack(args))
                    end
                    
                    -- Enhanced remote interception
                    if method == "FireServer" or method == "InvokeServer" then
                        local success2, remoteName = pcall(function() 
                            if self and typeof(self) == "Instance" then
                                return tostring(self.Name):lower()
                            end
                            return ""
                        end)
                        
                        if success2 and remoteName and remoteName ~= "" then
                            -- Check against blocked remotes
                            for _, blocked in ipairs(blockedRemotes) do
                                if remoteName:find(blocked:lower(), 1, true) then
                                    if method == "InvokeServer" then
                                        return nil
                                    end
                                    return
                                end
                            end
                            
                            -- Check against suspicious patterns
                            for _, pattern in ipairs(suspiciousPatterns) do
                                if remoteName:find(pattern, 1, true) then
                                    if method == "InvokeServer" then
                                        return nil
                                    end
                                    return
                                end
                            end
                            
                            -- Enhanced parameter modification
                            if #args >= 4 then
                                local success3, isExternal = pcall(checkcaller)
                                if success3 and isExternal then
                                    if args[1] == "FlllD" and args[4] == false then
                                        args[2] = 0
                                        args[3] = 0
                                    end
                                    
                                    -- Additional parameter modifications
                                    if remoteName:find("stamina") then
                                        if #args >= 1 then
                                            args[1] = math.max(0, math.min(100, args[1] or 100))
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    return originalNamecall(self, table.unpack(args))
                end)
                
                setreadonly(mt, true)
                print("Remote interception enabled")
            end
        end)
    end
    
    -- Enhanced multi-layer Kick protection
    if not getgenv().playerKickHooked then
        getgenv().playerKickHooked = true
        pcall(function()
            -- Method 1: Direct replacement
            if player then
                local kickMethod = player.Kick
                if kickMethod and typeof(kickMethod) == "function" then
                    player.Kick = newcclosure(function(...)
                        return nil
                    end)
                end
            end
            
            -- Method 2: Metatable protection
            local playerMeta = getrawmetatable(player)
            if playerMeta then
                setreadonly(playerMeta, false)
                local oldIndex = playerMeta.__index
                playerMeta.__index = newcclosure(function(self, key)
                    if key == "Kick" then
                        return function() end
                    end
                    return oldIndex(self, key)
                end)
                setreadonly(playerMeta, true)
            end
            
            -- Method 3: Protect through Players service
            local playersService = game:GetService("Players")
            local originalKick = playersService.Kick
            if originalKick then
                playersService.Kick = newcclosure(function(...)
                    local args = {...}
                    if args[1] == player then
                        return nil
                    end
                    return originalKick(table.unpack(args))
                end)
            end
        end)
    end
end

-- Layer 5: Behavior randomization
if CONFIG.BEHAVIOR_RANDOM then
    task.spawn(function()
        while task.wait(math.random(30, 60)) do
            pcall(function()
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and math.random(1, 5) == 1 then
                    local originalWS = humanoid.WalkSpeed
                    humanoid.WalkSpeed = originalWS * (math.random(98, 102) / 100)
                    task.wait(0.1)
                    humanoid.WalkSpeed = originalWS
                end
            end)
        end
    end)
end

-- Layer 6: Hide exploit traces
pcall(function()
    for _, name in ipairs({"syn", "KRNL_LOADED", "EXECUTOR_NAME", "getexecutorname"}) do
        pcall(function()
            if getfenv()[name] then
                getfenv()[name] = nil
            end
        end)
    end
end)


-- Layer 8: Fake lag system
if CONFIG.FAKE_LAG then
    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                if math.random(1, 50) == 1 then
                    task.wait(math.random(5, 20) / 1000)
                end
            end)
        end
    end)
end

-- Layer 9: Safe GetGC wrapper
if not getgenv().getgcWrapped then
    getgenv().getgcWrapped = true
    pcall(function()
        local realGetGC = getgc
        local lastGCCall = 0
        local callCount = 0
        local maxCallsPerSecond = 5
        
        getgc = function(...)
            local now = tick()
            callCount = callCount + 1
            
            if now - lastGCCall >= 1 then
                callCount = 0
                lastGCCall = now
            end
            
            if callCount > maxCallsPerSecond then
                task.wait(math.random(50, 150) / 1000)
            end
            
            lastGCCall = tick()
            return realGetGC(...)
        end
        
        print("GetGC wrapper enabled")
    end)
end

-- Layer 10: GUI detection blocking
task.spawn(function()
    pcall(function()
        local playerGui = player:WaitForChild("PlayerGui", 10)
        if playerGui then
            playerGui.DescendantAdded:Connect(function(gui)
                pcall(function()
                    if gui and gui.Parent and (gui:IsA("TextLabel") or gui:IsA("TextBox")) then
                        local success, text = pcall(function() return gui.Text:lower() end)
                        if success and text and (text:find("detect") or text:find("kick") or text:find("ban")) then
                            pcall(function()
                                gui.Text = ""
                                gui.Visible = false
                            end)
                        end
                    end
                end)
            end)
        end
    end)
end)

-- Layer 11: Call stack spoofing
if not getgenv().callStackSpoofed then
    getgenv().callStackSpoofed = true
    pcall(function()
        local originalGetCallingScript = getcallingscript
        
        getcallingscript = function()
            local calling = originalGetCallingScript()
            
            if calling == nil then
                local success, result = pcall(function()
                    return game:GetService("StarterPlayer").StarterPlayerScripts
                end)
                if success and result then
                    return result
                end
            end
            
            return calling
        end
        
        print("Call stack spoofing enabled")
    end)
end

-- Layer 13: Enhanced Detected function hook
if not getgenv().detectedHookAttempted then
    getgenv().detectedHookAttempted = true
    task.spawn(function()
        task.wait(5)
        
        local function safeGetGC()
            local success, result = pcall(function()
                return getgc(true)
            end)
            return success and result or {}
        end
        
        local objects = safeGetGC()
        local checked = 0
        local maxCheck = 80
        
        for _, v in next, objects do
            checked = checked + 1
            if checked > maxCheck then break end
            
            if typeof(v) == "table" then
                local detected = rawget(v, "Detected")
                local rlocked = rawget(v, "RLocked")
                
                if detected and typeof(detected) == "function" and rlocked then
                    local hookSuccess = pcall(function()
                        local oldDetected = detected
                        hookfunction(detected, function(action, info, crash)
                            if action == "_" and info == "_" and crash == false then
                                return oldDetected(action, info, crash)
                            end
                            return task.wait(9e9)
                        end)
                    end)
                    
                    if hookSuccess then
                        print("Detection hook installed successfully")
                    end
                    break
                end
            end
            
            if checked % 10 == 0 then
                task.wait(0.01)
            end
        end
    end)
end

local bypassSuccess = bypassLoaded or metaProtected

task.wait(0.5)

if bypassSuccess then
    print("|--FRAMEWORK LOADED--|")
    print("Anti-cheat bypass successful")
else
    print("Anti-cheat bypass failed")
end

return {
    loaded = true,
    bypassActive = bypassLoaded,
    metaProtected = metaProtected,
    
    safeGetGC = function()
        task.wait(math.random(100, 500) / 1000)
        return getgc(true)
    end,
    
    safeFireServer = function(remote, ...)
        if math.random(1, 3) == 1 then
            task.wait(math.random(10, 50) / 1000)
        end
        return remote:FireServer(...)
    end,
    
    safeConnect = function(signal, func)
        local connection
        task.spawn(function()
            connection = signal:Connect(function(...)
                task.spawn(func, ...)
            end)
        end)
        return connection
    end,
    
    isSafe = function()
        return bypassLoaded or (metaProtected and CONFIG.BLOCK_REMOTES)
    end,
}


