local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local lp = Players.LocalPlayer

--// COLORS (MORE LEGIBLE)
local BG_MAIN = Color3.fromRGB(8, 8, 20)
local BG_TOP = Color3.fromRGB(18, 18, 40)

local ACCENT = Color3.fromRGB(190, 0, 255)
local ACCENT2 = Color3.fromRGB(0, 220, 255)

local TEXT = Color3.fromRGB(255,255,255)
local TEXT_SOFT = Color3.fromRGB(220,220,255)

getgenv().AbuseActive = false
getgenv().SelectedSlot = Enum.KeyCode.Three

--// REMOVE OLD GUI
if game.CoreGui:FindFirstChild("KoiBountyGui") then
    game.CoreGui:FindFirstChild("KoiBountyGui"):Destroy()
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoiBountyGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// MAIN
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
MainFrame.BackgroundColor3 = BG_MAIN
MainFrame.BorderSizePixel = 0

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,18)

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = ACCENT
MainStroke.Thickness = 2

local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = MainFrame
MainGradient.Rotation = 45
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15,0,40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,20,45))
}

--// LIGHTNING EFFECT
for i = 1, 10 do

    local line = Instance.new("Frame")
    line.Parent = MainFrame
    line.BorderSizePixel = 0
    line.BackgroundColor3 = i % 2 == 0 and ACCENT or ACCENT2
    line.Size = UDim2.new(0, math.random(25,70), 0, 2)

    line.Position = UDim2.new(
        math.random(),
        0,
        math.random(),
        0
    )

    line.Rotation = math.random(-70,70)

    local glow = Instance.new("UIStroke")
    glow.Parent = line
    glow.Color = line.BackgroundColor3
    glow.Thickness = 1.3
end

--// TOP BAR
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1,0,0,40)
TitleBar.BackgroundColor3 = BG_TOP
TitleBar.BorderSizePixel = 0

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,18)

local FixCorner = Instance.new("Frame")
FixCorner.Parent = TitleBar
FixCorner.Size = UDim2.new(1,0,0.5,0)
FixCorner.Position = UDim2.new(0,0,0.5,0)
FixCorner.BackgroundColor3 = BG_TOP
FixCorner.BorderSizePixel = 0

--// TITLE
local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,12,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KOI BOUNTY"
Title.TextColor3 = TEXT
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, ACCENT),
    ColorSequenceKeypoint.new(1, ACCENT2)
}

--// SUBTITLE
local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = MainFrame
Subtitle.Size = UDim2.new(1,0,0,22)
Subtitle.Position = UDim2.new(0,0,0,42)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "[KOI ON TOP]"
Subtitle.TextColor3 = TEXT_SOFT
Subtitle.Font = Enum.Font.GothamBold
Subtitle.TextSize = 12
Subtitle.TextStrokeTransparency = 0.5

--// MIN BUTTON
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.Size = UDim2.new(0,24,0,24)
MinBtn.Position = UDim2.new(1,-30,0,8)
MinBtn.BackgroundColor3 = Color3.fromRGB(30,30,50)
MinBtn.Text = "-"
MinBtn.TextColor3 = TEXT
MinBtn.Font = Enum.Font.GothamBlack
MinBtn.TextSize = 20
MinBtn.BorderSizePixel = 0

Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1,0)

local MinStroke = Instance.new("UIStroke")
MinStroke.Parent = MinBtn
MinStroke.Color = ACCENT2
MinStroke.Thickness = 1.5

--// CONTENT
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1,0,1,-60)
ContentFrame.Position = UDim2.new(0,0,0,60)
ContentFrame.BackgroundTransparency = 1

--// FLOAT BUTTON
local FloatButton = Instance.new("TextButton")
FloatButton.Parent = ScreenGui
FloatButton.Size = UDim2.new(0,58,0,58)
FloatButton.Position = UDim2.new(0,20,0.5,-29)
FloatButton.BackgroundColor3 = BG_TOP
FloatButton.Text = "K"
FloatButton.TextColor3 = TEXT
FloatButton.Font = Enum.Font.GothamBlack
FloatButton.TextSize = 25
FloatButton.Visible = false
FloatButton.BorderSizePixel = 0

Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(1,0)

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Parent = FloatButton
FloatStroke.Color = ACCENT
FloatStroke.Thickness = 2

--// INFO BUTTON
local InfoBtn = Instance.new("TextButton")
InfoBtn.Parent = MainFrame
InfoBtn.Size = UDim2.new(0.86,0,0,36)
InfoBtn.Position = UDim2.new(0.07,0,1,-45)

InfoBtn.BackgroundColor3 = Color3.fromRGB(20,20,45)
InfoBtn.Text = "INFO"
InfoBtn.TextColor3 = TEXT

InfoBtn.Font = Enum.Font.GothamBlack
InfoBtn.TextSize = 14
InfoBtn.BorderSizePixel = 0

Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0,12)

local infoStroke = Instance.new("UIStroke")
infoStroke.Parent = InfoBtn
infoStroke.Color = ACCENT2
infoStroke.Thickness = 1.5

--// INFO PANEL
local InfoFrame = Instance.new("Frame")
InfoFrame.Parent = ScreenGui
InfoFrame.Size = UDim2.new(0, 180, 0, 95)
InfoFrame.Position = UDim2.new(1, -190, 0, 20)

InfoFrame.BackgroundColor3 = BG_MAIN
InfoFrame.Visible = false
InfoFrame.BorderSizePixel = 0

Instance.new("UICorner", InfoFrame).CornerRadius = UDim.new(0,16)

local infoMainStroke = Instance.new("UIStroke")
infoMainStroke.Parent = InfoFrame
infoMainStroke.Color = ACCENT
infoMainStroke.Thickness = 2

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoFrame
InfoTitle.Size = UDim2.new(1,0,0,26)
InfoTitle.BackgroundTransparency = 1

InfoTitle.Text = "PLAYER INFO"
InfoTitle.Font = Enum.Font.GothamBlack
InfoTitle.TextSize = 14
InfoTitle.TextColor3 = TEXT
InfoTitle.TextStrokeTransparency = 0

local BountyLabel = Instance.new("TextLabel")
BountyLabel.Parent = InfoFrame
BountyLabel.Size = UDim2.new(1,-12,0,20)
BountyLabel.Position = UDim2.new(0,12,0,30)
BountyLabel.BackgroundTransparency = 1

BountyLabel.Text = "BOUNTY : 0"
BountyLabel.TextColor3 = TEXT
BountyLabel.Font = Enum.Font.GothamBold
BountyLabel.TextSize = 13
BountyLabel.TextStrokeTransparency = 0.4
BountyLabel.TextXAlignment = Enum.TextXAlignment.Left

local PingLabel = Instance.new("TextLabel")
PingLabel.Parent = InfoFrame
PingLabel.Size = UDim2.new(1,-12,0,20)
PingLabel.Position = UDim2.new(0,12,0,50)
PingLabel.BackgroundTransparency = 1

PingLabel.Text = "PING : 0"
PingLabel.TextColor3 = TEXT
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 13
PingLabel.TextStrokeTransparency = 0.4
PingLabel.TextXAlignment = Enum.TextXAlignment.Left

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Parent = InfoFrame
FPSLabel.Size = UDim2.new(1,-12,0,20)
FPSLabel.Position = UDim2.new(0,12,0,70)
FPSLabel.BackgroundTransparency = 1

FPSLabel.Text = "FPS : 0"
FPSLabel.TextColor3 = TEXT
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 13
FPSLabel.TextStrokeTransparency = 0.4
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left

--// INFO TOGGLE
InfoBtn.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
end)

--// UPDATE INFO
task.spawn(function()

    local frames = 0
    local last = tick()

    while true do

        frames += 1

        if tick() - last >= 1 then

            FPSLabel.Text = "FPS : "..frames
            frames = 0
            last = tick()
        end

        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        PingLabel.Text = "PING : "..ping.." ms"

        local bounty = 0

        pcall(function()

            local data = lp:FindFirstChild("leaderstats")

            if data then

                local val =
                    data:FindFirstChild("Bounty")
                    or data:FindFirstChild("Honor")

                if val then
                    bounty = val.Value
                end
            end
        end)

        BountyLabel.Text = "BOUNTY : "..tostring(bounty)

        RunService.RenderStepped:Wait()
    end
end)

--// MINIMIZE SYSTEM
local minimized = false
local oldPos = MainFrame.Position
local oldSize = MainFrame.Size

MinBtn.MouseButton1Click:Connect(function()

    minimized = true

    oldPos = MainFrame.Position
    oldSize = MainFrame.Size

    MainFrame.Visible = false
    FloatButton.Visible = true
end)

FloatButton.MouseButton1Click:Connect(function()

    minimized = false

    MainFrame.Visible = true
    MainFrame.Position = oldPos
    MainFrame.Size = oldSize

    FloatButton.Visible = false
end)

--// KEY PRESS
local function Press(key)

    VirtualInputManager:SendKeyEvent(true, key, false, game)

    task.wait(0.01)

    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

--// MAIN ABUSE
local function ExecuteAbuse()

    if not getgenv().AbuseActive then
        return
    end

    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    local hum = char:WaitForChild("Humanoid", 10)

    if hrp and hum and hum.Health > 0 then

        hrp.CFrame = hrp.CFrame * CFrame.new(0, 500, 0)

        Press(getgenv().SelectedSlot)

        task.wait(0.08)

        Press(Enum.KeyCode.J)

        local targetPos = CFrame.new(923.2, 3000000000000000000000, 32852.8)

        hrp.Anchored = true
        hrp.CFrame = targetPos

        workspace.CurrentCamera.CFrame = targetPos

        task.wait(0.05)

        Press(Enum.KeyCode.Z)

        task.spawn(function()
            task.wait(0.03)
            hum.Health = 0
        end)

        local s = tick()

        while tick() - s < 0.6 do
            RunService.Heartbeat:Wait()
        end
    end
end

--// VOID SKILL
local function VoidSkill()

    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if hrp then

        local oldPos = hrp.CFrame

        hrp.Anchored = true

        hrp.CFrame = CFrame.new(923.2, 3000000000000000000000, 32852.8)

        workspace.CurrentCamera.CFrame = hrp.CFrame

        task.wait(0.1)

        Press(Enum.KeyCode.Z)

        task.wait(0.8)

        hrp.CFrame = oldPos

        workspace.CurrentCamera.CameraSubject = char.Humanoid

        hrp.Anchored = false
    end
end

--// BUTTON CREATOR
local function MakeButton(parent, text, yPos)

    local btn = Instance.new("TextButton")

    btn.Parent = parent
    btn.Size = UDim2.new(0.86,0,0,44)
    btn.Position = UDim2.new(0.07,0,0,yPos)

    btn.BackgroundColor3 = BG_TOP
    btn.Text = text
    btn.TextColor3 = TEXT

    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 14
    btn.TextStrokeTransparency = 0.3
    btn.TextStrokeColor3 = Color3.fromRGB(0,0,0)

    btn.BorderSizePixel = 0

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    local grad = Instance.new("UIGradient")
    grad.Parent = btn
    grad.Rotation = 45
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,10,60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,35,70))
    }

    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Color = ACCENT
    stroke.Thickness = 1.5

    return btn
end

--// BUTTONS
local Abuse3Btn = MakeButton(ContentFrame, "DRAGON HEART", 12)
local Abuse1Btn = MakeButton(ContentFrame, "MELEE", 70)
local VoidBtn = MakeButton(ContentFrame, "INF", 128)
local FixBtn = MakeButton(ContentFrame, "FIX CAMERA", 196)

FixBtn.TextColor3 = ACCENT2
FixBtn.Size = UDim2.new(0.86,0,0,32)

--// BUTTON LOGIC
Abuse3Btn.MouseButton1Click:Connect(function()

    getgenv().SelectedSlot = Enum.KeyCode.Three

    getgenv().AbuseActive = not getgenv().AbuseActive

    Abuse3Btn.BackgroundColor3 =
        getgenv().AbuseActive
        and Color3.fromRGB(120, 0, 200)
        or BG_TOP

    if getgenv().AbuseActive then
        task.spawn(ExecuteAbuse)
    end
end)

Abuse1Btn.MouseButton1Click:Connect(function()

    getgenv().SelectedSlot = Enum.KeyCode.One

    getgenv().AbuseActive = not getgenv().AbuseActive

    Abuse1Btn.BackgroundColor3 =
        getgenv().AbuseActive
        and Color3.fromRGB(120, 0, 200)
        or BG_TOP

    if getgenv().AbuseActive then
        task.spawn(ExecuteAbuse)
    end
end)

VoidBtn.MouseButton1Click:Connect(VoidSkill)

FixBtn.MouseButton1Click:Connect(function()

    getgenv().AbuseActive = false

    if lp.Character then

        workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid

        lp.Character.HumanoidRootPart.Anchored = false
    end
end)

--// RESPAWN
lp.CharacterAdded:Connect(function()

    if getgenv().AbuseActive then

        task.wait(0.5)

        task.spawn(ExecuteAbuse)
    end
end)

--// DRAG GUI
local dragging = false
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStart

        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

--// DRAG FLOAT BUTTON
local draggingFloat = false
local dragStartFloat
local startPosFloat

FloatButton.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        draggingFloat = true
        dragStartFloat = input.Position
        startPosFloat = FloatButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if draggingFloat and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStartFloat

        FloatButton.Position = UDim2.new(
            startPosFloat.X.Scale,
            startPosFloat.X.Offset + delta.X,
            startPosFloat.Y.Scale,
            startPosFloat.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFloat = false
    end
end)
