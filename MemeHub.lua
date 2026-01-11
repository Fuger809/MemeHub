--[[ 
    BloomHub & MemeHub Premium Protection v5.0
    [FIXED] Quest Logic & Movement Tab
--]]

local _0xR = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cityrage/goldfarm_boogabooga/refs/heads/main/rayfield'))()
local _0xH = game:GetService("RbxAnalyticsService"):GetClientId()
local _0xW = loadstring(game:HttpGet("https://raw.githubusercontent.com/Fuger809/Script545/refs/heads/main/Solo.lua"))()

local _0xWin = _0xR:CreateWindow({
    Name = "Whitelist System",
    LoadingTitle = "BloomHub",
    Theme = "Amethyst"
})

local _0xT1 = _0xWin:CreateTab("Whitelist", "shield")

_0xT1:CreateButton({
    Name = "Copy HWID",
    Callback = function()
        setclipboard(_0xH)
        _0xR:Notify({Title = "HWID", Content = "Copied to clipboard!", Duration = 5})
    end
})

_0xT1:CreateButton({
    Name = "Load Script",
    Callback = function()
        local _0xAuth = false
        for _, v in pairs(_0xW) do if v == _0xH then _0xAuth = true break end end

        if _0xAuth then
            _0xR:Destroy()
            
            -- [[ START CORE ]]
            local function _0xINIT()
                local p = game.Players.LocalPlayer
                local rs = game:GetService("RunService")
                local uis = game:GetService("UserInputService")
                local vim = game:GetService("VirtualInputManager")

                local cfg = {
                    tt = "Egg Dog", tpe = false, th = 7.9, atke = false, 
                    fly = false, fs = 100, se = false, sv = 50, qe = false
                }
                
                local tc, lc, lts = {}, 0, 0
                local ctm, ctr, fbv = nil, nil, nil
                local qt, lqt, lqc = false, 0, 0

                local function _0xP1() vim:SendKeyEvent(true, Enum.KeyCode.One, false, game) task.wait(0.05) vim:SendKeyEvent(false, Enum.KeyCode.One, false, game) end
                local function _0xPE() vim:SendKeyEvent(true, Enum.KeyCode.E, false, game) task.wait(0.1) vim:SendKeyEvent(false, Enum.KeyCode.E, false, game) end

                local function _0xUTC()
                    table.clear(tc)
                    pcall(function()
                        local path = (cfg.tt == "Egg Dog" and workspace.Monster["Egg Dog"]) or 
                                     (cfg.tt == "PopCat" and workspace.Monster.Popcat) or 
                                     (cfg.tt == "Gorilla King" and workspace.Monster["Gorilla King"]) or 
                                     (cfg.tt == "Floppa" and workspace.Monster.Floppa)
                        if path then
                            if path:IsA("Model") then table.insert(tc, {m = path, r = path:FindFirstChild("HumanoidRootPart") or path.PrimaryPart})
                            else for _, v in pairs(path:GetChildren()) do if v:IsA("Model") then table.insert(tc, {m = v, r = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart}) end end end
                        end
                    end)
                end

                local _0xRF = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
                local _0xMWin = _0xRF:CreateWindow({Name = "MemeHub | Fixed", Theme = "Dark"})
                
                -- MAIN TAB
                local _0xMT = _0xMWin:CreateTab("Main", 6031302954)
                _0xMT:CreateDropdown({
                    Name = "Select Target", Options = {"Egg Dog", "PopCat", "Gorilla King", "Floppa"}, CurrentOption = cfg.tt,
                    Callback = function(v)
                        cfg.tt = type(v) == "table" and v[1] or v
                        cfg.th = (cfg.tt == "PopCat" and 6) or (cfg.tt == "Egg Dog" and 7.9) or (cfg.tt == "Gorilla King" and 6.5) or 5
                        ctm = nil; _0xUTC()
                    end
                })
                _0xMT:CreateToggle({Name = "Auto TP", CurrentValue = false, Callback = function(v) cfg.tpe = v end})
                _0xMT:CreateToggle({Name = "Auto Attack", CurrentValue = false, Callback = function(v) cfg.atke = v if v then _0xP1() end end})
                _0xMT:CreateToggle({Name = "Auto Quest", CurrentValue = false, Callback = function(v) cfg.qe = v; qt = false end})

                -- MOVEMENT TAB (Вернул!)
                local _0xMV = _0xMWin:CreateTab("Movement", 6031075938)
                _0xMV:CreateToggle({Name = "Fly", CurrentValue = false, Callback = function(v) cfg.fly = v end})
                _0xMV:CreateSlider({Name = "Fly Speed", Range = {1, 500}, Increment = 1, CurrentValue = 100, Callback = function(v) cfg.fs = v end})
                _0xMV:CreateToggle({Name = "Speed", CurrentValue = false, Callback = function(v) cfg.se = v end})
                _0xMV:CreateSlider({Name = "WalkSpeed", Range = {16, 200}, Increment = 1, CurrentValue = 50, Callback = function(v) cfg.sv = v end})

                -- LOOP
                rs.Heartbeat:Connect(function()
                    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = p.Character.HumanoidRootPart
                    local hum = p.Character:FindFirstChild("Humanoid")

                    -- Target Find
                    if tick() - lts > 0.4 or not ctm or not ctm.Parent then
                        _0xUTC(); local d = 50000
                        for _, obj in pairs(tc) do
                            if obj.m.Parent and obj.r then
                                local dist = (hrp.Position - obj.r.Position).Magnitude
                                if dist < d then d = dist; ctr = obj.r; ctm = obj.m end
                            end
                        end
                        lts = tick()
                    end

                    -- Auto Farm
                    if ctr and ctm and ctm.Parent then
                        if cfg.tpe and (qt or not cfg.qe) then
                            hrp.CFrame = ctr.CFrame * CFrame.new(0, cfg.th, 0)
                            hrp.Velocity = Vector3.zero
                        end
                        if cfg.atke and (qt or not cfg.qe) then
                            local t = p.Character:FindFirstChildOfClass("Tool")
                            if t then t:Activate() end
                        end
                    end

                    -- [FIXED] Quest System
                    if cfg.qe then
                        if qt and tick() - lqt > 8 then qt = false end -- Сброс квеста
                        if not qt and tick() - lqc > 0.5 then
                            pcall(function()
                                local name = (cfg.tt == "Egg Dog" and "Floppa Quest 13") or (cfg.tt == "PopCat" and "Floppa Quest 14") or (cfg.tt == "Gorilla King" and "Floppa Quest 15") or "Floppa Quest 1"
                                local loc = workspace.Location.QuestLocaion:FindFirstChild(name)
                                if loc then
                                    local pos = loc:IsA("Model") and (loc.PrimaryPart and loc.PrimaryPart.Position or loc:GetModelCFrame().Position) or loc.Position
                                    if (hrp.Position - pos).Magnitude > 12 then
                                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
                                    else
                                        _0xPE(); qt = true; lqt = tick()
                                    end
                                end
                            end)
                            lqc = tick()
                        end
                    end

                    -- Movement Logic
                    if cfg.fly then
                        if not fbv or fbv.Parent ~= hrp then
                            if fbv then fbv:Destroy() end
                            fbv = Instance.new("BodyVelocity", hrp)
                            fbv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                        end
                        local c = workspace.CurrentCamera.CFrame
                        local m = Vector3.zero
                        if uis:IsKeyDown("W") then m = m + c.LookVector end
                        if uis:IsKeyDown("S") then m = m - c.LookVector end
                        if uis:IsKeyDown("A") then m = m - c.RightVector end
                        if uis:IsKeyDown("D") then m = m + c.RightVector end
                        fbv.Velocity = m * cfg.fs
                    elseif fbv then
                        fbv:Destroy(); fbv = nil
                    end

                    if cfg.se and hum then hum.WalkSpeed = cfg.sv end
                end)

                _0xRF:Notify({Title = "MemeHub", Content = "Loaded Successfully!", Duration = 5})
            end
            _0xINIT()

        else
            _0xR:Notify({Title = "Error", Content = "HWID not whitelisted!", Duration = 10})
        end
    end
})
