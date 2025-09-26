-- // GUI Profissional com Sliders Avançados, Scroll e BigHead V2

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MT_HAZE_GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Estados salvos
local Settings = {}

-- Janela principal
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 650, 0, 400)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Sombra
local Shadow = Instance.new("ImageLabel", MainFrame)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5,0,0.5,0)
Shadow.Size = UDim2.new(1,40,1,40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5028857084"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(24,24,276,276)

-- Botão fechar
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-40,0,10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,6)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Container lateral (tabs)
local SideTabs = Instance.new("Frame", MainFrame)
SideTabs.Size = UDim2.new(0,150,1,0)
SideTabs.BackgroundColor3 = Color3.fromRGB(35,35,35)
SideTabs.BorderSizePixel = 0

local SideLayout = Instance.new("UIListLayout", SideTabs)
SideLayout.FillDirection = Enum.FillDirection.Vertical
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.VerticalAlignment = Enum.VerticalAlignment.Top
SideLayout.Padding = UDim.new(0,12)

local SidePadding = Instance.new("UIPadding", SideTabs)
SidePadding.PaddingTop = UDim.new(0,15)

-- Content com Scroll
local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
ContentFrame.Size = UDim2.new(1,-150,1,0)
ContentFrame.Position = UDim2.new(0,150,0,0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.CanvasSize = UDim2.new(0,0,0,0)
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(150,0,0)

local ContentLayout = Instance.new("UIListLayout", ContentFrame)
ContentLayout.FillDirection = Enum.FillDirection.Vertical
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ContentLayout.Padding = UDim.new(0,12)

local ContentPadding = Instance.new("UIPadding", ContentFrame)
ContentPadding.PaddingTop = UDim.new(0,15)

-- Atualizar scroll
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- limpar conteúdo
local function clearContent()
    for _,c in pairs(ContentFrame:GetChildren()) do
        if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then
            c:Destroy()
        end
    end
end

-- criar botão lateral
local function createTab(name, onClick)
    local btn = Instance.new("TextButton", SideTabs)
    btn.Size = UDim2.new(0,130,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        clearContent()
        onClick()
    end)
end

-- criar toggle
local function createToggle(id, name)
    Settings[id] = Settings[id] or false

    local frame = Instance.new("Frame", ContentFrame)
    frame.Size = UDim2.new(0,400,0,40)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Text = name

    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Size = UDim2.new(0,60,0,25)
    toggleBtn.Position = UDim2.new(1,-70,0.5,-12)
    toggleBtn.BackgroundColor3 = Settings[id] and Color3.fromRGB(0,120,0) or Color3.fromRGB(80,0,0)
    toggleBtn.Text = Settings[id] and "ON" or "OFF"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 14
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,6)

    toggleBtn.MouseButton1Click:Connect(function()
        Settings[id] = not Settings[id]
        toggleBtn.Text = Settings[id] and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = Settings[id] and Color3.fromRGB(0,120,0) or Color3.fromRGB(80,0,0)
    end)
end

-- criar slider avançado
local function createSlider(id, name, min, max)
    Settings[id] = Settings[id] or ((min+max)/2)

    local frame = Instance.new("Frame", ContentFrame)
    frame.Size = UDim2.new(0,400,0,70)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,0,20)
    label.Position = UDim2.new(0,10,0,5)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Text = name

    local valueLabel = Instance.new("TextLabel", frame)
    valueLabel.Size = UDim2.new(0.3,-20,0,20)
    valueLabel.Position = UDim2.new(0.7,0,0,5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextColor3 = Color3.fromRGB(255,100,100)
    valueLabel.Text = tostring(Settings[id])

    local sliderBar = Instance.new("Frame", frame)
    sliderBar.Size = UDim2.new(0.9,0,0,8)
    sliderBar.Position = UDim2.new(0.05,0,0,40)
    sliderBar.BackgroundColor3 = Color3.fromRGB(70,70,70)
    Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1,0)

    local fill = Instance.new("Frame", sliderBar)
    local rel = (Settings[id]-min)/(max-min)
    fill.Size = UDim2.new(rel,0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(200,0,0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", sliderBar)
    knob.Size = UDim2.new(0,16,0,16)
    knob.Position = UDim2.new(rel,-8,0.5,-8)
    knob.BackgroundColor3 = Color3.fromRGB(255,100,100)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    -- arrastar slider
    local UserInputService = game:GetService("UserInputService")
    local dragging = false

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            local newValue = math.floor(min + (max-min)*relX)
            Settings[id] = newValue
            fill.Size = UDim2.new(relX,0,1,0)
            knob.Position = UDim2.new(relX,-8,0.5,-8)
            valueLabel.Text = tostring(newValue)
        end
    end)
end

-- abas
createTab("Rage", function()
    createToggle("fly","Fly")
    createSlider("flyspeed","Fly Speed",1,100)
    createToggle("spinbot","Spinbot")
    createSlider("spinspeed","Spin Speed",1,50)
    createToggle("bring","Bring Player") -- NOVO
end)

createTab("Aim", function()
    createToggle("aimbot","Aimbot")
    createSlider("fov","Aim FOV",10,360)
    createSlider("smooth","Aim Smooth",1,100) -- atualizado
    createToggle("bighead","Big Head")
    createSlider("headsize","Head Size",1,20) -- atualizado
    createToggle("bigheadv2","Big Head V2")
    createSlider("headsizev2","Head Size V2",1,20) -- atualizado
end)

createTab("Visual", function()
    createToggle("esp","ESP")
    createToggle("espbox","ESP Box")
    createToggle("espname","ESP Name")
    createToggle("esptracer","ESP Tracer")
    createToggle("espdist","ESP Distance") -- NOVO
    createSlider("distvalue","Distance",100,2000) -- NOVO
end)
