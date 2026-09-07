-- TIGER HUB UNIVERSAL BUILDER
local TigerLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function TigerLib:CreateWindow(titleText)
    local Window = {}
    
    -- Main Container
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TigerHubUniversal"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    
    -- Main UI Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.fromOffset(520, 420)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(45, 45, 45)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Smooth Dragging System
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

    -- Dynamic Title Header (Tiger Hub Theme)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(242, 100, 25) -- Tiger Orange Stripe Color
    Title.Text = "  🐯 " .. titleText
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    -- Scroll Container for generated script buttons
    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -30, 1, -170)
    Container.Position = UDim2.fromOffset(15, 155)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 500)
    Container.ScrollBarThickness = 4
    Container.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = Container
    ContentLayout.Padding = UDim.new(0, 8)

    -- Builder Control Panel 
    local ControlPanel = Instance.new("Frame")
    ControlPanel.Size = UDim2.new(1, -30, 0, 100)
    ControlPanel.Position = UDim2.fromOffset(15, 50)
    ControlPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ControlPanel.Parent = MainFrame
    
    local CPCorner = Instance.new("UICorner")
    CPCorner.CornerRadius = UDim.new(0, 8)
    CPCorner.Parent = ControlPanel

    -- Name input box
    local NameInput = Instance.new("TextBox")
    NameInput.Size = UDim2.new(0, 150, 0, 35)
    NameInput.Position = UDim2.fromOffset(10, 10)
    NameInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    NameInput.PlaceholderText = "Script Name (e.g. Fly)"
    NameInput.Text = ""
    NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameInput.Font = Enum.Font.Gotham
    NameInput.TextSize = 12
    NameInput.Parent = ControlPanel
    Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

    -- Script URL link box
    local URLInput = Instance.new("TextBox")
    URLInput.Size = UDim2.new(1, -190, 0, 35)
    URLInput.Position = UDim2.fromOffset(170, 10)
    URLInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    URLInput.PlaceholderText = "Paste Raw Script URL link here..."
    URLInput.Text = ""
    URLInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    URLInput.Font = Enum.Font.Gotham
    URLInput.TextSize = 12
    URLInput.Parent = ControlPanel
    Instance.new("UICorner", URLInput).CornerRadius = UDim.new(0, 6)

    -- Action Build Button
    local BuildBtn = Instance.new("TextButton")
    BuildBtn.Size = UDim2.new(1, -20, 0, 35)
    BuildBtn.Position = UDim2.fromOffset(10, 55)
    BuildBtn.BackgroundColor3 = Color3.fromRGB(242, 100, 25)
    BuildBtn.Text = "🧡 Inject Custom Toggle Button into Tiger Hub"
    BuildBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BuildBtn.Font = Enum.Font.GothamBold
    BuildBtn.TextSize = 14
    BuildBtn.Parent = ControlPanel
    Instance.new("UICorner", BuildBtn).CornerRadius = UDim.new(0, 6)

    -- Custom Toggle Factory Component
    function Window:AddCustomScriptToggle(text, targetUrl)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -10, 0, 45)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = Container
        
        local TFCorner = Instance.new("UICorner")
        TFCorner.CornerRadius = UDim.new(0, 6)
        TFCorner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -70, 1, 0)
        Label.Position = UDim2.fromOffset(15, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(240, 240, 240)
        Label.TextSize = 14
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local Switch = Instance.new("TextButton")
        Switch.Size = UDim2.fromOffset(40, 22)
        Switch.Position = UDim2.new(1, -55, 0.5, -11)
        Switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Switch.Text = ""
        Switch.Parent = ToggleFrame
        
        local SwitchCorner = Instance.new("UICorner")
        SwitchCorner.CornerRadius = UDim.new(1, 0)
        SwitchCorner.Parent = Switch
        
        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.fromOffset(16, 16)
        Dot.Position = UDim2.fromOffset(3, 3)
        Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dot.Parent = Switch
        
        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = Dot

        local toggled = false
        Switch.MouseButton1Click:Connect(function()
            toggled = not toggled
            local targetColor = toggled and Color3.fromRGB(242, 100, 25) or Color3.fromRGB(45, 45, 45)
            local targetDotPos = toggled and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)
            
            TweenService:Create(Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = targetColor}):Play()
            TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetDotPos}):Play()
            
            if toggled then
                pcall(function()
                    loadstring(game:HttpGet(targetUrl))()
                end)
            end
        end)
    end

    -- Hook up the builder logic
    BuildBtn.MouseButton1Click:Connect(function()
        if NameInput.Text ~= "" and URLInput.Text ~= "" then
            Window:AddCustomScriptToggle(NameInput.Text, URLInput.Text)
            NameInput.Text = ""
            URLInput.Text = ""
        end
    end)

    return Window
end

-- Start up Tiger Hub
local TigerHubMain = TigerLib:CreateWindow("TIGER HUB: SCRIPT ENGINE")
