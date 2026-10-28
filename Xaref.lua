-- ==========================================
-- Script Name: dacscrip vx
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration Variables (ค่าเริ่มต้น)
local Config = {
    AimbotEnabled = false,
    FOVRadius = 100,          -- ขนาดวงกลม FOV (ปรับได้)
    WalkSpeed = 16,           -- ความเร็วการวิ่ง (ปกติคือ 16)
    JumpPower = 50,           -- ความสูงการกระโดด (ปกติคือ 50)
    ESPEnabled = false        -- มองเห็นศัตรูไม่จำกัดระยะ
}

-- Create GUI Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "dacscrip_vx_UI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- FOV Circle (วงกลมตรงกลางหน้าจอ)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.NumSides = 64

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "dacscrip vx"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Helper UI Function (สร้างปุ่มกด)
local function CreateButton(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- ------------------------------------------
-- 1. ฟังก์ชั่น: เล็งหัวอัตโนมัติ (Aimbot & FOV)
-- ------------------------------------------
CreateButton("Aimbot (เล็งหัว): OFF", UDim2.new(0.05, 0, 0.15, 0), function(btn)
    Config.AimbotEnabled = not Config.AimbotEnabled
    FOVCircle.Visible = Config.AimbotEnabled
    btn.Text = "Aimbot (เล็งหัว): " .. (Config.AimbotEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = Config.AimbotEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

-- ปุ่มปรับขนาด FOV Circle
CreateButton("ขนาดวงกลม FOV: " .. Config.FOVRadius, UDim2.new(0.05, 0, 0.27, 0), function(btn)
    Config.FOVRadius = Config.FOVRadius + 50
    if Config.FOVRadius > 300 then Config.FOVRadius = 50 end
    btn.Text = "ขนาดวงกลม FOV: " .. Config.FOVRadius
end)

-- ------------------------------------------
-- 2. ฟังก์ชั่น: วิ่งไว (WalkSpeed)
-- ------------------------------------------
CreateButton("ความเร็ววิ่ง (Speed): " .. Config.WalkSpeed, UDim2.new(0.05, 0, 0.40, 0), function(btn)
    if Config.WalkSpeed == 16 then Config.WalkSpeed = 50
    elseif Config.WalkSpeed == 50 then Config.WalkSpeed = 100
    elseif Config.WalkSpeed == 100 then Config.WalkSpeed = 150
    else Config.WalkSpeed = 16 end
    btn.Text = "ความเร็ววิ่ง (Speed): " .. Config.WalkSpeed
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
end)

-- ------------------------------------------
-- 3. ฟังก์ชั่น: กระโดดสูง (JumpPower)
-- ------------------------------------------
CreateButton("ความสูงกระโดด (Jump): " .. Config.JumpPower, UDim2.new(0.05, 0, 0.53, 0), function(btn)
    if Config.JumpPower == 50 then Config.JumpPower = 100
    elseif Config.JumpPower == 100 then Config.JumpPower = 200
    elseif Config.JumpPower == 200 then Config.JumpPower = 300
    else Config.JumpPower = 50 end
    btn.Text = "ความสูงกระโดด (Jump): " .. Config.JumpPower
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = Config.JumpPower
    end
