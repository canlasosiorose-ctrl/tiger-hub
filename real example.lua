-- TIGER HUB: PREMIUM NEON DESIGN FRAMEWORK
local TigerLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function TigerLib:CreateWindow(titleText)
    local Window = {}
    
    -- Main Container
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TigerHubPremium"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    
    -- 1. Modern Glass Panel (Not Orion Style!)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.fromOffset(540, 430)
    MainFrame.Position = UDim2.new(0.5, -270, 0.5, -215)
    MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 13) -- Deep Void Black
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16) -- Aggressive rounding
    MainCorner.Parent = MainFrame
    
    -- Neon Orange Glowing Border Outline
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(242, 100, 25) -- Neon Tiger Orange
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame

    -- Dragging Handler
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- 2. Floating Header Accent (Sleek Typography instead of a big bar)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 40)
    Title.Position = UDim2.fromOffset(20, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🐯 " .. string.upper(titleText)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    -- 3. The Builder Canvas 
    local ControlPanel = Instance.new("Frame")
    ControlPanel.Size = UDim2.new(1, -40, 0, 95)
    ControlPanel.Position = UDim2.fromOffset(20, 65)
    ControlPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 22) -- Slate dark fill
    ControlPanel.Parent = MainFrame
    Instance.new("UICorner", ControlPanel).CornerRadius = UDim.new(0, 10)
    
    local CPStroke = Instance.new("UIStroke")
    CPStroke.Color = Color3.fromRGB(30, 30, 35)
    CPStroke.Parent = ControlPanel

    local NameInput = Instance.new("TextBox")
    NameInput.Size = UDim2.new(0, 160, 0, 32)
    NameInput.Position = UDim2.fromOffset(12, 12)
    NameInput.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    NameInput.PlaceholderText = "Script Reference Name"
    NameInput.Text = ""
    NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameInput.Font = Enum.Font.Gotham
    NameInput.TextSize = 12
    NameInput.Parent = ControlPanel
    Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

    local URLInput = Instance.new("TextBox")
    URLInput.Size = UDim2.new(1, -204, 0, 32)
    URLInput.Position = UDim2.fromOffset(184, 12)
    URLInput.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    URLInput.PlaceholderText = "Paste script link or loadstring..."
    URLInput.Text = ""
    URLInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    URLInput.Font = Enum.Font.Gotham
    URLInput.TextSize = 12
    URLInput.Parent = ControlPanel
    Instance.new("UICorner", URLInput).CornerRadius = UDim.new(0, 6)

    local BuildBtn = Instance.new("TextButton")
    BuildBtn.Size = UDim2.new(1, -24, 0, 32)
    BuildBtn.Position = UDim2.fromOffset(12, 52)
    BuildBtn.BackgroundColor3 = Color3.fromRGB(242, 100, 25)
    BuildBtn.Text = "DEPLOY CUSTOM LOADSTRING INTERFACE"
    BuildBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BuildBtn.Font = Enum.Font.GothamBold
    BuildBtn.TextSize = 11
    BuildBtn.Parent = ControlPanel
    Instance.new("UICorner", BuildBtn).CornerRadius = UDim.new(0, 6)

    -- Scroll List View Area
    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -40, 1, -195)
    Container.Position = UDim2.fromOffset(20, 180)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 500)
    Container.ScrollBarThickness = 2
    Container.ScrollBarImageColor3 = Color3.fromRGB(242, 100, 25)
    Container.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = Container
    ContentLayout.Padding = UDim.new(0, 10)

    -- 4. Premium Glowing Toggle Factory Component
    function Window:AddCustomScriptToggle(text, targetUrl)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -10, 0, 50)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
        ToggleFrame.Parent = Container
        Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)
        
        -- Smooth Glowing Frame Border
        local FrameStroke = Instance.new("UIStroke")
        FrameStroke.Color = Color3.fromRGB(35, 35, 40)
        FrameStroke.Thickness = 1
        FrameStroke.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -80, 1, 0)
        Label.Position = UDim2.fromOffset(15, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(230, 230, 235)
        Label.TextSize = 13
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        -- Modern Capsule Switch Component
        local Switch = Instance.new("TextButton")
        Switch.Size = UDim2.fromOffset(44, 22)
        Switch.Position = UDim2.new(1, -60, 0.5, -11)
        Switch.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        Switch.Text = ""
        Switch.Parent = ToggleFrame
        Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
        
        local SwitchStroke = Instance.new("UIStroke")
        SwitchStroke.Color = Color3.fromRGB(50, 50, 55)
        SwitchStroke.Parent = Switch
        
        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.fromOffset(14, 14)
        Dot.Position = UDim2.fromOffset(4, 4)
        Dot.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
        Dot.Parent = Switch
        Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

        local toggled = false
        Switch.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            -- Complex Neon Color Tweens
            local targetBg = toggled and Color3.fromRGB(35, 20, 15) or Color3.fromRGB(30, 30, 35)
            local targetDotColor = toggled and Color3.fromRGB(242, 100, 25) or Color3.fromRGB(150, 150, 160)
            local targetDotPos = toggled and UDim2.fromOffset(26, 4) or UDim2.fromOffset(4, 4)
            local targetBorder = toggled and Color3.fromRGB(242, 100, 25) or Color3.fromRGB(35, 35, 40)
            
            TweenService:Create(Switch, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = targetBg}):Play()
            TweenService:Create(SwitchStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Color = targetDotColor}):Play()
            TweenService:Create(Dot, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = targetDotPos, BackgroundColor3 = targetDotColor}):Play()
            TweenService:Create(FrameStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Color = targetBorder}):Play()
            
            if toggled then
                pcall(function()
                    loadstring(game:HttpGet(targetUrl))()
                end)
            end
        end)
    end

    BuildBtn.MouseButton1Click:Connect(function()
        if NameInput.Text ~= "" and URLInput.Text ~= "" then
            Window:AddCustomScriptToggle(NameInput.Text, URLInput.Text)
            NameInput.Text = ""
            URLInput.Text = ""
        end
    end)

    return Window
end

-- Launch the updated Premium design variant
local TigerHubMain = TigerLib:CreateWindow("Tiger Hub")

-- Built-in utility components
TigerHubMain:AddCustomScriptToggle("System Admin Tools (Infinite Yield)", "https://githubusercontent.com")
TigerHubMain:AddCustomScriptToggle("Universal Orca Utility Platform", "https://githubusercontent.com")
