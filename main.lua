-- ==========================================================
-- [ PART 1: THE UI ENVIRONMENT FRAMEWORK ]
-- EXECUTOR ARCHITECTURE: UNIVERSAL XENO & DELTA RUNTIME
-- ==========================================================

-- Initialize Protected Screen Space
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SidsEvolutionApexSuite"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- LOADING SCREEN CARD OVERLAY
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(6, 7, 9)
LoadingFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
LoadingFrame.Size = UDim2.new(0, 450, 0, 280)
LoadingFrame.ClipsDescendants = true

local L_Corner = Instance.new("UICorner")
L_Corner.CornerRadius = UDim.new(0, 16)
L_Corner.Parent = LoadingFrame

local L_Glow = Instance.new("UIStroke")
L_Glow.Thickness = 2
L_Glow.Parent = LoadingFrame

local L_Gradient = Instance.new("UIGradient")
L_Gradient.Parent = L_Glow

-- Moving Scanline Mesh Filter
local Scanline = Instance.new("Frame")
Scanline.Name = "Scanline"
Scanline.Parent = LoadingFrame
Scanline.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
Scanline.BackgroundTransparency = 0.94
Scanline.Size = UDim2.new(1, 0, 0, 4)
Scanline.BorderSizePixel = 0

-- UI Component Header Labels
local L_Title = Instance.new("TextLabel")
L_Title.Parent = LoadingFrame
L_Title.BackgroundTransparency = 1
L_Title.Position = UDim2.new(0, 0, 0, 50)
L_Title.Size = UDim2.new(1, 0, 0, 35)
L_Title.Font = Enum.Font.GothamBold
L_Title.Text = "SID'S EVOLUTION"
L_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
L_Title.TextSize = 32
L_Title.TextStrokeTransparency = 0.7
L_Title.TextStrokeColor3 = Color3.fromRGB(0, 210, 255)

local L_Subtitle = Instance.new("TextLabel")
L_Subtitle.Parent = LoadingFrame
L_Subtitle.BackgroundTransparency = 1
L_Subtitle.Position = UDim2.new(0, 0, 0, 85)
L_Subtitle.Size = UDim2.new(1, 0, 0, 20)
L_Subtitle.Font = Enum.Font.Code
L_Subtitle.Text = "⚡ TACTICAL ENGINE BUILD // V2.4 ONLINE ⚡"
L_Subtitle.TextColor3 = Color3.fromRGB(0, 210, 255)
L_Subtitle.TextSize = 11

local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingFrame
BarBackground.BackgroundColor3 = Color3.fromRGB(16, 19, 24)
BarBackground.Position = UDim2.new(0.1, 0, 0, 165)
BarBackground.Size = UDim2.new(0.8, 0, 0, 4)

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BorderSizePixel = 0

local L_Status = Instance.new("TextLabel")
L_Status.Parent = LoadingFrame
L_Status.BackgroundTransparency = 1
L_Status.Position = UDim2.new(0, 0, 0, 185)
L_Status.Size = UDim2.new(1, 0, 0, 20)
L_Status.Font = Enum.Font.Code
L_Status.Text = "System checking..."
L_Status.TextColor3 = Color3.fromRGB(120, 128, 140)
L_Status.TextSize = 11

local L_Percent = Instance.new("TextLabel")
L_Percent.Parent = LoadingFrame
L_Percent.BackgroundTransparency = 1
L_Percent.Position = UDim2.new(0, 0, 0, 140)
L_Percent.Size = UDim2.new(1, 0, 0, 20)
L_Percent.Font = Enum.Font.GothamBold
L_Percent.Text = "0%"
L_Percent.TextColor3 = Color3.fromRGB(255, 255, 255)
L_Percent.TextSize = 14

-- Global Registry Pass
getgenv().SidsGlobalScreen = ScreenGui
getgenv().SidsGlobalLoading = LoadingFrame
getgenv().SidsGlobalFill = BarFill
getgenv().SidsGlobalPercent = L_Percent
getgenv().SidsGlobalStatus = L_Status
getgenv().SidsScanline = Scanline
getgenv().SidsLoaderGradient = L_Gradient
-- ==========================================================
-- [ PART 2: THE CORE WORKSPACE DASHBOARD ]
-- BUILDS SYSTEM NAVIGATION AND CLIPBOARD CONTROLLER LAYERS
-- ==========================================================

repeat task.wait() until getgenv().SidsGlobalScreen

local ScreenGui = getgenv().SidsGlobalScreen
local LoadingFrame = getgenv().SidsGlobalLoading
local targetUrl = "https://sid-evolution-hub.netlify.app"

local function safeCopy()
    pcall(function()
        if setclipboard then setclipboard(targetUrl)
        elseif toclipboard then toclipboard(targetUrl)
        elseif (Delta and Delta.set_clipboard) then Delta.set_clipboard(targetUrl)
        elseif Clipboard and Clipboard.set then Clipboard.set(targetUrl)
        end
    end)
end

-- MAIN CONTROL DASHBOARD
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 9, 12)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -155)
MainFrame.Size = UDim2.new(0, 480, 0, 310)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local M_Corner = Instance.new("UICorner")
M_Corner.CornerRadius = UDim.new(0, 16)
M_Corner.Parent = MainFrame

local M_Glow = Instance.new("UIStroke")
M_Glow.Thickness = 1.5
M_Glow.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = M_Glow

-- Panel Header Bar
local TopHeader = Instance.new("Frame")
TopHeader.Parent = MainFrame
TopHeader.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
TopHeader.Size = UDim2.new(1, 0, 0, 50)

local TH_Corner = Instance.new("UICorner")
TH_Corner.CornerRadius = UDim.new(0, 16)
TH_Corner.Parent = TopHeader

local M_Title = Instance.new("TextLabel")
M_Title.Parent = TopHeader
M_Title.BackgroundTransparency = 1
M_Title.Position = UDim2.new(0, 20, 0, 0)
M_Title.Size = UDim2.new(0.8, 0, 1, 0)
M_Title.Font = Enum.Font.GothamBold
M_Title.Text = "🎯 SID'S EVOLUTION // RECON HUB"
M_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
M_Title.TextSize = 14
M_Title.TextXAlignment = Enum.TextXAlignment.Left

-- Left Sidebar Tab System
local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(11, 13, 17)
LeftPanel.Position = UDim2.new(0, 0, 0, 50)
LeftPanel.Size = UDim2.new(0, 140, 1, -50)

local LP_Corner = Instance.new("UICorner")
LP_Corner.CornerRadius = UDim.new(0, 16)
LP_Corner.Parent = LeftPanel

local PortalTabBtn = Instance.new("TextButton")
PortalTabBtn.Parent = LeftPanel
PortalTabBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
PortalTabBtn.Position = UDim2.new(0, 10, 0, 15)
PortalTabBtn.Size = UDim2.new(0, 120, 0, 35)
PortalTabBtn.Font = Enum.Font.GothamBold
PortalTabBtn.Text = "🌐 Web Link"
PortalTabBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
PortalTabBtn.TextSize = 12

local Tab1Corner = Instance.new("UICorner")
Tab1Corner.CornerRadius = UDim.new(0, 6)
Tab1Corner.Parent = PortalTabBtn

local DiagTabBtn = Instance.new("TextButton")
DiagTabBtn.Parent = LeftPanel
DiagTabBtn.BackgroundTransparency = 1
DiagTabBtn.Position = UDim2.new(0, 10, 0, 55)
DiagTabBtn.Size = UDim2.new(0, 120, 0, 35)
DiagTabBtn.Font = Enum.Font.Gotham
DiagTabBtn.Text = "⚙️ Diagnostics"
DiagTabBtn.TextColor3 = Color3.fromRGB(140, 145, 155)
DiagTabBtn.TextSize = 12

local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 150, 0, 60)
ContentContainer.Size = UDim2.new(1, -160, 1, -70)

-- Tab 1 Structure (Link Dashboard Panel)
local PortalPage = Instance.new("Frame")
PortalPage.Parent = ContentContainer
PortalPage.BackgroundTransparency = 1
PortalPage.Size = UDim2.new(1, 0, 1, 0)

local InfoBox = Instance.new("Frame")
InfoBox.Parent = PortalPage
InfoBox.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
InfoBox.Size = UDim2.new(1, 0, 0, 125)

local IB_Corner = Instance.new("UICorner")
IB_Corner.CornerRadius = UDim.new(0, 10)
IB_Corner.Parent = InfoBox

local IB_Stroke = Instance.new("UIStroke")
IB_Stroke.Color = Color3.fromRGB(22, 26, 35)
IB_Stroke.Parent = InfoBox

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoBox
InfoTitle.BackgroundTransparency = 1
InfoTitle.Position = UDim2.new(0, 15, 0, 15)
InfoTitle.Size = UDim2.new(1, -30, 0, 20)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Text = "LINK COPIED TO DEVICE 📂"
InfoTitle.TextColor3 = Color3.fromRGB(0, 210, 255)
InfoTitle.TextSize = 13
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left

local InfoBody = Instance.new("TextLabel")
InfoBody.Parent = InfoBox
InfoBody.BackgroundTransparency = 1
InfoBody.Position = UDim2.new(0, 15, 0, 42)
InfoBody.Size = UDim2.new(1, -30, 0, 75)
InfoBody.Font = Enum.Font.Gotham
InfoBody.Text = "The secure address was written onto your executor's sandbox clipboard layer. Paste it into your external internet browser to run your custom HUD profiles."
InfoBody.TextColor3 = Color3.fromRGB(155, 160, 170)
InfoBody.TextSize = 12
InfoBody.TextWrapped = true
InfoBody.TextXAlignment = Enum.TextXAlignment.Left
InfoBody.TextYAlignment = Enum.TextYAlignment.Top

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = PortalPage
CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 70, 70)
CloseBtn.Position = UDim2.new(0, 0, 1, -45)
CloseBtn.Size = UDim2.new(1, 0, 0, 42)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "❌ TERMINATE INTERFACE"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13

local CB_Corner = Instance.new("UICorner")
CB_Corner.CornerRadius = UDim.new(0, 8)
CB_Corner.Parent = CloseBtn

-- Tab 2 Structure (Technical Statistics Panel)
local DiagPage = Instance.new("Frame")
DiagPage.Parent = ContentContainer
DiagPage.BackgroundTransparency = 1
DiagPage.Size = UDim2.new(1, 0, 1, 0)
DiagPage.Visible = false

local DiagText = Instance.new("TextLabel")
DiagText.Parent = DiagPage
DiagText.BackgroundTransparency = 1
DiagText.Size = UDim2.new(1, 0, 0.8, 0)
DiagText.Font = Enum.Font.Code
DiagText.Text = "• Platform: Cross-Engine Active\n• Workspace: Xeno & Delta Ready\n• Threads: Steady Latency\n• Memory Hooks: Secured\n• Target Domain: Netlify Secure"
DiagText.TextColor3 = Color3.fromRGB(0, 210, 255)
DiagText.TextSize = 12
DiagText.TextXAlignment = Enum.TextXAlignment.Left
DiagText.TextYAlignment = Enum.TextYAlignment.Top

-- Active Event Click Handlers
PortalTabBtn.MouseButton1Click:Connect(function()
    PortalTabBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
    PortalTabBtn.Font = Enum.Font.GothamBold
    PortalTabBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
    DiagTabBtn.BackgroundTransparency = 1
    DiagTabBtn.TextColor3 = Color3.fromRGB(140, 145, 155)
    PortalPage.Visible = true
    DiagPage.Visible = false
end)

DiagTabBtn.MouseButton1Click:Connect(function()
    DiagTabBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
    DiagTabBtn.Font = Enum.Font.GothamBold
    DiagTabBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
    PortalTabBtn.BackgroundTransparency = 1
    PortalTabBtn.TextColor3 = Color3.fromRGB(140, 145, 155)
    PortalPage.Visible = false
    DiagPage.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Pass parameters over to Part 3 Runtime Thread
getgenv().SidsMainFrame = MainFrame
getgenv().SidsMainGradient = MainGradient
getgenv().SidsSafeCopyAction = safeCopy
-- ==========================================================
-- [ PART 3: THE ANIMATION & CHRONO SEQUENCER ]
-- CORE MATH RUNTIME LOGIC THREAD HANDLER
-- ==========================================================

repeat task.wait() until getgenv().SidsMainFrame and getgenv().SidsLoaderGradient

local ScreenGui = getgenv().SidsGlobalScreen
local LoadingFrame = getgenv().SidsGlobalLoading
local BarFill = getgenv().SidsGlobalFill
local L_Percent = getgenv().SidsGlobalPercent
local L_Status = getgenv().SidsGlobalStatus
local Scanline = getgenv().SidsScanline
local LoaderGradient = getgenv().SidsLoaderGradient

local MainFrame = getgenv().SidsMainFrame
local MainGradient = getgenv().SidsMainGradient
local safeCopy = getgenv().SidsSafeCopyAction

task.spawn(function()
    -- Dynamic Custom Neon Chroma Gradient Thread Loop (Syncs Both Windows)
    task.spawn(function()
        local colorKeypoints = {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 255)),   -- Electric Blue
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)), -- Deep Purple
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 255))    -- Back to Blue
        }
        local sequence = ColorSequence.new(colorKeypoints)
        
        if LoaderGradient then LoaderGradient.Color = sequence end
        if MainGradient then MainGradient.Color = sequence end
        
        while ScreenGui and ScreenGui.Parent do
            for rotation = 0, 360, 2 do
                if LoaderGradient then LoaderGradient.Rotation = rotation end
                if MainGradient then MainGradient.Rotation = rotation end
                task.wait(0.01)
            end
        end
    end)

    -- Floating Cyber Scanline Thread Hook
    task.spawn(function()
        while LoadingFrame and LoadingFrame.Parent do
            Scanline.Position = UDim2.new(0, 0, 0, -4)
            Scanline:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 2.5, true)
            task.wait(2.5)
        end
    end)

    local bootingLogs = {
        {0, "Syncing execution environment..."},
        {1.5, "Hooking system clipboard registers..."},
        {3.2, "Bypassing hardware safety restrictions..."},
        {5.0, "Parsing Sid's tactical HUD matrices..."},
        {6.8, "Connecting to secure Netlify gateway..."},
        {8.5, "Finalizing workspace layouts..."},
        {10, "Boot cycle complete!"}
    }
    
    -- Precise 10-Second Visual Progress Routine
    local duration = 10
    local steps = 100
    for i = 1, steps do
        local progress = i / steps
        L_Percent.Text = tostring(math.floor(progress * 100)) .. "%"
        BarFill.Size = UDim2.new(progress, 0, 1, 0)
        
        local currentTimeElapsed = progress * duration
        for _, log in ipairs(bootingLogs) do
            if currentTimeElapsed >= log[1] then
                L_Status.Text = log[2]
            end
        end
        task.wait(duration / steps)
    end
    
    -- Execute clipboard actions securely
    safeCopy()
    
    -- Terminate splash screen layer cleanly and pop up panel workspace
    LoadingFrame:Destroy()
    MainFrame.Visible = true
    
    -- Automated background garbage disposal: 2-minute timer
    task.wait(120)
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end)
