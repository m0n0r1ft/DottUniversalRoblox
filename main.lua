-- ====================================================================
--  ____   ___ _____ _____ 
-- |  _ \ / _ \_   _|_   _|
-- | | | | | | || |   | |  
-- | |_| | |_| || |   | |  
-- |____/ \___/ |_|   |_|  UNIVERSAL
--
-- Created by You • 2026 Visual Suite (Sirius Rayfield)
-- ====================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Global variables to store our modifications
local DesiredSpeed = 16
local DesiredJump = 50
local InfiniteJumpEnabled = false

local Window = Rayfield:CreateWindow({
   Name = "Dott Universal 🔴",
   LoadingTitle = "Dott Suite Loading...",
   LoadingSubtitle = "by You",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DottUniversal",
      FileName = "Config"
   },
   Discord = { Enabled = false },
   KeySystem = false
})

-- TAB 1: PLAYER
local PlayerTab = Window:CreateTab("Player", 4483345998)

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Info = "Forces your character's speed.",
   Increment = 1,
   Min = 16,
   Max = 250,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
        DesiredSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "JumpPower",
   Info = "Forces your jump height.",
   Increment = 1,
   Min = 50,
   Max = 350,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
        DesiredJump = Value
   end,
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
        InfiniteJumpEnabled = Value
   end,
})

-- ==========================================
-- THE FORCE LOOP (Fixes the game resetting your values)
-- ==========================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Only override if the user actually changed the slider from default
                if DesiredSpeed ~= 16 then
                    humanoid.WalkSpeed = DesiredSpeed
                end
                
                if DesiredJump ~= 50 then
                    humanoid.UseJumpPower = true
                    humanoid.JumpPower = DesiredJump
                end
            end
        end
    end)
end)

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        pcall(function()
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end)

-- TAB 2: TELEPORT
local TeleportTab = Window:CreateTab("Teleport", 4483345998)

TeleportTab:CreateInput({
   Name = "Teleport to Player",
   PlaceholderText = "Type username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        local targetName = string.lower(Text)
        if targetName == "" then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            if string.sub(string.lower(player.Name), 1, #targetName) == targetName then
                if LocalPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
                    Rayfield:Notify({
                        Title = "Dott Teleport",
                        Content = "Successfully teleported to " .. player.Name,
                        Duration = 3,
                        Image = 4483345998,
                    })
                    break
                end
            end
        end
   end,
})

Rayfield:Notify({
   Title = "Dott Universal",
   Content = "Enjoy using your custom suite!",
   Duration = 5,
   Image = 4483345998,
})
