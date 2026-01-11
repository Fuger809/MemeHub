local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cityrage/goldfarm_boogabooga/refs/heads/main/rayfield'))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local HWIDtable = loadstring(game:HttpGet("https://raw.githubusercontent.com/Fuger809/Script545/refs/heads/main/Solo.lua"))()




local Window = Rayfield:CreateWindow({
   Name = "Whitelist",
   Icon = "baseline", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "BloomHub",
   LoadingSubtitle = "Loading...",
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

})


local Tab = Window:CreateTab("Whitelist", "cable") -- Title, Image


local Button = Tab:CreateButton({
   Name = "Get HWID",
   Callback = function()
       Rayfield:Notify({
          Title = "Your HWID is",
          Content = ""..HWID.."",
          Duration = 6.5,
          Image = "bookmark-check",
        })
     wait(0.3)
     Rayfield:Notify({
          Title = "Hwid",
          Content = "Copied to clipboard",
          Duration = 3,
          Image = "bookmark-check",
        })
     setclipboard(HWID)
   end,
})


local Button = Tab:CreateButton({
   Name = "Load script",
   Callback = function()
        for i,v in pairs(HWIDtable) do
          if v == HWID then
            Rayfield:Destroy()



local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- ===================== SETTINGS & CACHE =====================
local Settings = {
    TPToggle = true,
    TPDistance = 50000,
    TargetType = "Egg Dog",
    AutoTPEnabled = false,
    AutoTPHeight = 7.9,
    AutoAttackEnabled = false,
    AttackCooldown = 0.05,
    AttackRange = 25,
    FlyEnabled = false,
    FlySpeed = 100,
    SpeedEnabled = false,
    SpeedValue = 50,
    AutoQuestEnabled = false
}

local targetCache = {}
local lastCacheUpdate = 0
local lastTargetSearchTime = 0

local currentTargetModel = nil
local currentTargetRoot = nil

-- Movement
local flyBodyVelocity = nil
local originalWalkSpeed = 16

-- Quests
local currentQuest = nil
local lastQuestCheck = 0
local questTaken = false
local lastQuestTakeTime = 0

-- ===================== ФУНКЦИИ =====================
-- Функция имитирует нажатие клавиши "1"
local function pressOne()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
end

-- Функция имитирует нажатие клавиши "E"
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.spawn(function()
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

-- ===================== ПОИСК ЦЕЛЕЙ =====================
local function updateTargetCache()
    table.clear(targetCache)
    local targetType = tostring(Settings.TargetType)
    
    pcall(function()
        local targetPath = nil
        
        if targetType == "Egg Dog" then
            targetPath = workspace.Monster["Egg Dog"]
        elseif targetType == "PopCat" then
            targetPath = workspace.Monster.Popcat
        elseif targetType == "Gorilla King" then
            targetPath = workspace.Monster["Gorilla King"]
        elseif targetType == "Floppa" then
            targetPath = workspace.Monster.Floppa
        end
        
        if targetPath and targetPath:IsA("Model") then
            local root = targetPath:FindFirstChild("HumanoidRootPart") or targetPath:FindFirstChild("PrimaryPart") or targetPath:FindFirstChild("RootPart")
            if root then
                table.insert(targetCache, {model = targetPath, root = root})
            end
        elseif targetPath and targetPath:IsA("Folder") then
            -- Если это папка, ищем все модели внутри
            for _, v in pairs(targetPath:GetDescendants()) do
                if v:IsA("Model") then
                    local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("PrimaryPart") or v:FindFirstChild("RootPart")
                    if root then
                        table.insert(targetCache, {model = v, root = root})
                    end
                end
            end
        end
    end)
end

local function findNearest()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local pRoot = char.HumanoidRootPart
    local closestM, closestR = nil, nil
    local dist = Settings.TPDistance

    -- Обновляем кеш если он пуст или слишком старый
    if #targetCache == 0 or tick() - lastCacheUpdate > 0.5 then
        updateTargetCache()
        lastCacheUpdate = tick()
    end

    for _, data in pairs(targetCache) do
        if data.model and data.model.Parent and data.root and data.root.Parent then
            local d = (pRoot.Position - data.root.Position).Magnitude
            if d < dist then
                dist = d
                closestM = data.model
                closestR = data.root
            end
        end
    end
    
    -- Если ничего не найдено, обновляем кеш и ищем снова
    if not closestM then
        updateTargetCache()
        lastCacheUpdate = tick()
        for _, data in pairs(targetCache) do
            if data.model and data.model.Parent and data.root and data.root.Parent then
                local d = (pRoot.Position - data.root.Position).Magnitude
                if d < dist then
                    dist = d
                    closestM = data.model
                    closestR = data.root
                end
            end
        end
    end
    
    return closestR, closestM
end

-- ===================== UI =====================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "MemeHub",
    Icon = 6031075938,
    LoadingTitle = "MemeHub",
    LoadingSubtitle = "Loading...",
    Theme = "Dark",
    ConfigurationSaving = {Enabled = false}
})

local MainTab = Window:CreateTab("Main", 6031302954)

-- ===================== QUEST FUNCTIONS =====================
local function findQuest()
    local questLocation = nil
    local questPosition = nil
    
    pcall(function()
        -- Определяем название квеста в зависимости от выбранной цели
        local questName = nil
        local targetType = tostring(Settings.TargetType)
        
        if targetType == "Egg Dog" then
            questName = "Floppa Quest 13"
        elseif targetType == "PopCat" then
            questName = "Floppa Quest 14"
        elseif targetType == "Gorilla King" then
            questName = "Floppa Quest 15"
        elseif targetType == "Floppa" then
            questName = "Floppa Quest 1" -- По умолчанию для Floppa
        end
        
        if questName then
            -- Пробуем прямой путь
            questLocation = workspace.Location.QuestLocaion[questName]
            
            -- Если не нашли, пробуем через FindFirstChild
            if not questLocation then
                local questFolder = workspace:FindFirstChild("Location")
                if questFolder then
                    local questLocaion = questFolder:FindFirstChild("QuestLocaion")
                    if questLocaion then
                        questLocation = questLocaion:FindFirstChild(questName)
                    end
                end
            end
            
            if questLocation then
                -- Пробуем получить позицию через PrimaryPart
                if questLocation:IsA("Model") and questLocation.PrimaryPart then
                    questPosition = questLocation.PrimaryPart.Position
                elseif questLocation:IsA("Model") then
                    -- Используем GetModelCFrame если PrimaryPart нет
                    local success, cframe = pcall(function() return questLocation:GetModelCFrame() end)
                    if success and cframe then
                        questPosition = cframe.Position
                    else
                        -- Ищем любую часть для позиции
                        local questPart = questLocation:FindFirstChild("HumanoidRootPart") 
                            or questLocation:FindFirstChild("RootPart")
                            or questLocation:FindFirstChildOfClass("BasePart")
                        
                        if questPart and questPart:IsA("BasePart") then
                            questPosition = questPart.Position
                        else
                            -- Если не нашли, ищем в дочерних элементах
                            for _, child in pairs(questLocation:GetDescendants()) do
                                if child:IsA("BasePart") then
                                    questPosition = child.Position
                                    break
                                end
                            end
                        end
                    end
                elseif questLocation:IsA("BasePart") then
                    questPosition = questLocation.Position
                else
                    -- Ищем любую часть для позиции
                    local questPart = questLocation:FindFirstChild("HumanoidRootPart") 
                        or questLocation:FindFirstChild("RootPart")
                        or questLocation:FindFirstChildOfClass("BasePart")
                    
                    if questPart and questPart:IsA("BasePart") then
                        questPosition = questPart.Position
                    else
                        -- Если не нашли, ищем в дочерних элементах
                        for _, child in pairs(questLocation:GetDescendants()) do
                            if child:IsA("BasePart") then
                                questPosition = child.Position
                                break
                            end
                        end
                    end
                end
            end
        end
    end)
    
    return questLocation, questPosition
end

-- Функция для автоматической установки высоты в зависимости от типа цели
local function updateHeightForTarget(targetType)
    if targetType == "PopCat" then
        Settings.AutoTPHeight = 6
    elseif targetType == "Egg Dog" then
        Settings.AutoTPHeight = 7.9
    elseif targetType == "Gorilla King" then
        Settings.AutoTPHeight = 6.5
    elseif targetType == "Floppa" then
        Settings.AutoTPHeight = 5
    end
end

-- ИСПРАВЛЕННЫЙ DROPDOWN (Фикс ошибки 'lower' of table)
MainTab:CreateDropdown({
    Name = "Select Target",
    Options = {"Egg Dog", "PopCat", "Gorilla King", "Floppa"},
    CurrentOption = Settings.TargetType,
    Callback = function(Value)
        -- ФИКС: Rayfield может возвращать таблицу {"Egg Dog"}. Извлекаем строку.
        local selectedValue = Value
        if type(Value) == "table" then
            selectedValue = Value[1] or Value.CurrentOption
        end
        
        Settings.TargetType = tostring(selectedValue)
        
        -- АВТОМАТИЧЕСКАЯ УСТАНОВКА ВЫСОТЫ
        updateHeightForTarget(Settings.TargetType)
        
        -- ПОЛНЫЙ СБРОС ДЛЯ ПЕРЕКЛЮЧЕНИЯ
        currentTargetModel = nil
        currentTargetRoot = nil
        table.clear(targetCache)
        lastCacheUpdate = 0
        lastTargetSearchTime = 0
        
        updateTargetCache()
        
        Rayfield:Notify({Title = "Target Changed", Content = "Target set to: " .. Settings.TargetType .. " | Height: " .. Settings.AutoTPHeight})
    end
})

MainTab:CreateToggle({
    Name = "Auto TP (Stay Above)",
    CurrentValue = Settings.AutoTPEnabled,
    Callback = function(V) Settings.AutoTPEnabled = V end
})

MainTab:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = Settings.AutoAttackEnabled,
    Callback = function(V) 
        Settings.AutoAttackEnabled = V
        if V then
            -- Нажимаем клавишу "1" при включении Auto Attack
            task.spawn(function()
                pressOne()
            end)
        end
    end
})

MainTab:CreateSlider({
    Name = "TP Height",
    Range = {5, 15},
    Increment = 0.5,
    CurrentValue = Settings.AutoTPHeight,
    Callback = function(V) Settings.AutoTPHeight = V end
})

MainTab:CreateToggle({
    Name = "Auto Quest",
    CurrentValue = Settings.AutoQuestEnabled,
    Callback = function(V) 
        Settings.AutoQuestEnabled = V
        currentQuest = nil
        lastQuestCheck = 0
        questTaken = false
        lastQuestTakeTime = 0
    end
})

-- ===================== MOVEMENT TAB =====================
local MovementTab = Window:CreateTab("Movement", 6031075938)

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = Settings.FlyEnabled,
    Callback = function(V) 
        Settings.FlyEnabled = V
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        if V then
            -- Включаем fly
            local hrp = char.HumanoidRootPart
            if not flyBodyVelocity then
                flyBodyVelocity = Instance.new("BodyVelocity")
                flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                flyBodyVelocity.Parent = hrp
            end
        else
            -- Выключаем fly
            if flyBodyVelocity then
                flyBodyVelocity:Destroy()
                flyBodyVelocity = nil
            end
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 0, char.HumanoidRootPart.Velocity.Z)
            end
        end
    end
})

MovementTab:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 500},
    Increment = 1,
    CurrentValue = Settings.FlySpeed,
    Callback = function(V) Settings.FlySpeed = V end
})

MovementTab:CreateToggle({
    Name = "Speed",
    CurrentValue = Settings.SpeedEnabled,
    Callback = function(V) 
        Settings.SpeedEnabled = V
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            if V then
                originalWalkSpeed = char.Humanoid.WalkSpeed
                char.Humanoid.WalkSpeed = Settings.SpeedValue
            else
                char.Humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end
})

MovementTab:CreateSlider({
    Name = "Speed Value",
    Range = {1, 200},
    Increment = 1,
    CurrentValue = Settings.SpeedValue,
    Callback = function(V) 
        Settings.SpeedValue = V
        local char = player.Character
        if Settings.SpeedEnabled and char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = V
        end
    end
})

-- ===================== ОСНОВНОЙ ЦИКЛ =====================
runService.Heartbeat:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- Проверяем, существует ли текущая цель
    local targetExists = currentTargetModel and currentTargetModel.Parent and currentTargetRoot and currentTargetRoot.Parent
    
    -- Поиск цели раз в 0.3 сек или если цель исчезла
    if tick() - lastTargetSearchTime > 0.3 or not targetExists then
        currentTargetRoot, currentTargetModel = findNearest()
        lastTargetSearchTime = tick()
    end

    if currentTargetRoot and currentTargetModel and currentTargetRoot.Parent and currentTargetModel.Parent then
        -- Телепортация (только если квест взят, чтобы не мешать взятию квеста)
        if Settings.AutoTPEnabled and (questTaken or not Settings.AutoQuestEnabled) then
            char.HumanoidRootPart.CFrame = currentTargetRoot.CFrame * CFrame.new(0, Settings.AutoTPHeight, 0)
            char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end

        -- Атака (только если квест взят, чтобы не мешать взятию квеста)
        if Settings.AutoAttackEnabled and (questTaken or not Settings.AutoQuestEnabled) then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end
    
    -- Fly
    if Settings.FlyEnabled then
        local hrp = char.HumanoidRootPart
        if not flyBodyVelocity or flyBodyVelocity.Parent ~= hrp then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            flyBodyVelocity.Parent = hrp
        end
        
        local cam = workspace.CurrentCamera
        local moveVector = Vector3.new(0, 0, 0)
        
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + (cam.CFrame.LookVector * Settings.FlySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - (cam.CFrame.LookVector * Settings.FlySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - (cam.CFrame.RightVector * Settings.FlySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + (cam.CFrame.RightVector * Settings.FlySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, Settings.FlySpeed, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector = moveVector - Vector3.new(0, Settings.FlySpeed, 0)
        end
        
        flyBodyVelocity.Velocity = moveVector
    end
    
    -- Speed
    if Settings.SpeedEnabled and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Settings.SpeedValue
    end
    
    -- Auto Quest
    if Settings.AutoQuestEnabled then
        -- Сбрасываем флаг через 5 секунд после взятия, чтобы можно было взять новый квест
        if questTaken and tick() - lastQuestTakeTime > 5 then
            questTaken = false
        end
        
        if tick() - lastQuestCheck > 0.2 then -- Проверяем каждые 0.2 сек
            local quest, questPosition = findQuest()
            
            if quest and questPosition and not questTaken then
                local hrp = char.HumanoidRootPart
                local distance = (hrp.Position - questPosition).Magnitude
                
                -- Телепортируемся к квесту если далеко
                if distance > 10 then
                    local offset = Vector3.new(0, 5, 0)
                    hrp.CFrame = CFrame.new(questPosition + offset)
                    hrp.Velocity = Vector3.new(0, 0, 0)
                else
                    -- Если близко к квесту, нажимаем E для взятия
                    task.spawn(function()
                        pressE()
                    end)
                    questTaken = true
                    lastQuestTakeTime = tick()
                end
            end
            lastQuestCheck = tick()
        end
    end
end)

-- Обработчик respawn (после смерти)
player.CharacterAdded:Connect(function(newChar)
    task.spawn(function()
        -- Ждем загрузки персонажа
        if newChar and newChar:FindFirstChild("HumanoidRootPart") then
            task.wait(0.5)
        else
            newChar:WaitForChild("HumanoidRootPart")
            task.wait(0.5)
        end
        
        -- Восстанавливаем fly если был включен
        if Settings.FlyEnabled then
            flyBodyVelocity = nil
            if newChar and newChar:FindFirstChild("HumanoidRootPart") then
                flyBodyVelocity = Instance.new("BodyVelocity")
                flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                flyBodyVelocity.Parent = newChar.HumanoidRootPart
            end
        end
        
        -- Восстанавливаем speed если был включен
        if Settings.SpeedEnabled and newChar:FindFirstChild("Humanoid") then
            newChar.Humanoid.WalkSpeed = Settings.SpeedValue
        end
        
        -- Нажимаем клавишу "1" после respawn
        pressOne()
    end)
end)

-- Устанавливаем начальную высоту для текущего типа цели
updateHeightForTarget(Settings.TargetType)

Rayfield:Notify({
    Title = "MemeHub",
    Content = "Скрипт загружен успешно!",
    Duration = 5
})







            print("script loaded succesfull")
          else
          Rayfield:Notify({
                  Title = "Error",
                  Content = "You are not whitelisted",
                  Image = "badge-alert",
                  Duration = 6.5,
                })
      end
    end    
  end,
})
