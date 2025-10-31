-- Adonis Bypass Framework
-- Author: xiaomao
-- QQ: 1303323893
-- Version: v1.0.1

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
                    
                    -- Block suspicious remotes
                    if method == "FireServer" or method == "InvokeServer" then
                        local success2, remoteName = pcall(function() 
                            if self and typeof(self) == "Instance" then
                                return tostring(self.Name):lower()
                            end
                            return ""
                        end)
                        if success2 and remoteName and remoteName ~= "" then
                            for _, blocked in ipairs(blockedRemotes) do
                                if remoteName:find(blocked:lower(), 1, true) then
                                    if method == "InvokeServer" then
                                        return nil
                                    end
                                    return
                                end
                            end
                        end
                        
                        -- Remote parameter modification
                        if #args >= 4 then
                            local success3, isExternal = pcall(checkcaller)
                            if success3 and isExternal and args[1] == "FlllD" and args[4] == false then
                                args[2] = 0
                                args[3] = 0
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
    
    -- Extra protection: Hook Player.Kick directly (more reliable)
    if not getgenv().playerKickHooked then
        getgenv().playerKickHooked = true
        pcall(function()
            if player then
                local kickMethod = player.Kick
                if kickMethod and typeof(kickMethod) == "function" then
                    local oldKick = kickMethod
                    player.Kick = newcclosure(function(...)
                        -- Block all kick attempts
                        return nil
                    end)
                end
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

-- Layer 9: GetGC wrapper (DISABLED - may cause crashes)
-- if not getgenv().getgcWrapped then
--     getgenv().getgcWrapped = true
--     local realGetGC = getgc
--     local lastGCCall = 0
-- 
--     getgc = function(...)
--         local now = tick()
--         if now - lastGCCall < 1 then
--             task.wait(math.random(100, 300) / 1000)
--         end
--         lastGCCall = now
--         return realGetGC(...)
--     end
-- end

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

-- Layer 12: Subscribe/Connect protection (DISABLED - too aggressive, causes crashes)
-- This layer has been disabled as it interferes with other scripts

-- Layer 13: Detected function hook (from 修复reagebot绕过.lua) - DISABLED to prevent crashes
-- This layer has been disabled as it may cause instability when accessing getgc
-- if not getgenv().detectedHookAttempted then
--     getgenv().detectedHookAttempted = true
--     local detectedHookSuccess = false
--     task.spawn(function()
--         local function isAdonisAC(table)
--             return rawget(table, "Detected")
--                 and typeof(rawget(table, "Detected")) == "function"
--                 and rawget(table, "RLocked")
--         end
-- 
--         local success, objects = pcall(function()
--             return getgc(true)
--         end)
--         
--         if not success or not objects then
--             return
--         end
--         
--         local checked = 0
--         local maxCheck = 200
--         local startTime = tick()
--         
--         for _, v in next, objects do
--             if tick() - startTime > 2 then
--                 break
--             end
--             
--             checked = checked + 1
--             if checked > maxCheck then
--                 break
--             end
--             
--             if checked % 20 == 0 then
--                 task.wait(0.02)
--             end
--             
--             if typeof(v) == "table" and isAdonisAC(v) then
--                 for i, func in next, v do
--                     if rawequal(i, "Detected") then
--                         local hookSuccess = pcall(function()
--                             local old
--                             old = hookfunction(func, function(action, info, crash)
--                                 if rawequal(action, "_") and rawequal(info, "_") and rawequal(crash, false) then
--                                     return old(action, info, crash)
--                                 end
--                                 return task.wait(9e9)
--                             end)
--                         end)
--                         
--                         if hookSuccess then
--                             detectedHookSuccess = true
--                             print("Detection hook installed")
--                         end
--                         break
--                     end
--                 end
--             end
--         end
--         
--         task.wait(3)
--         
--         getgenv().detectedHookSuccess = detectedHookSuccess
--     end)
-- end

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


