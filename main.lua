-- ====================================================================
--  ____   ___ _____ _____ 
-- |  _ \ / _ \_   _|_   _|
-- | | | | | | || |   | |  
-- | |_| | |_| || |   | |  
-- |____/ \___/ |_|   |_|  UNIVERSAL
--
-- Created by You • 2026 Visual Suite
-- ====================================================================

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Setup Core Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create the Main Window
local Window = Rayfield:CreateWindow({
   Name = "Dott Universal 🔴",
   LoadingTitle = "Dott Suite Loading...",
   LoadingSubtitle = "by You",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DottUniversal", -- Creates a folder in your executor's workspace
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "", -- Your discord invite link if you make one later
      RememberWithKey = false
   },
   KeySystem = false -- We don't need a key system since it's private to you!
})

-- ==========================================
-- TAB 1: PLAYER MODIFICATIONS
-- ==========================================
local PlayerTab = Window:CreateTab("Player", 4483345998) -- Creates a tab with an icon

-- WalkSpeed Slider
local SpeedSlider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Info = "Changes how fast your character moves.",
   Increment = 1,
   Min = 16,
   Max = 250,
   CurrentValue = 16,
   Flag = "SpeedSlider", -- Identifier for config saves
   Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
   end,
})

-- JumpPower Slider
local JumpSlider = PlayerTab:CreateSlider({
   Name = "JumpPower",
   Info = "Changes how high you jump.",
   Increment = 1,
   Min = 50,
   Max = 350,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = Value
            humanoid.UseJumpPower = true -- Force modern game compatibility
        end
   end,
})

-- Infinite Jump Toggle
local InfiniteJumpEnabled = false
local InfJumpToggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
        InfiniteJumpEnabled = Value
   end,
})

-- Connect Infinite Jump to Roblox's input service
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
end)


-- ==========================================
-- TAB 2: TELEPORTATION
-- ==========================================
local TeleportTab = Window:CreateTab("Teleport", 4483345998)

-- Teleport to Player Textbox
local TPInput = TeleportTab:CreateInput({
   Name = "Teleport to Player",
   PlaceholderText = "Type username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        local targetName = string.lower(Text)
        if targetName == "" then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            -- Checks if the name you typed matches the beginning of a player's name
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

-- Notify that it has successfully loaded
Rayfield:Notify({
   Title = "Dott Universal",
   Content = "Enjoy using your custom suite!",
   Duration = 5,
   Image = 4483345998,
})
