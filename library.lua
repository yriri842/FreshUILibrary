local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ACCENT_COLOR = Color3.fromRGB(0, 171, 128)
local BG_MAIN = Color3.fromRGB(0, 0, 0)
local BG_TOPBAR = Color3.fromRGB(16, 16, 16)
local BG_NAV = Color3.fromRGB(16, 16, 16)
local ELEMENT_BG_IMAGE = "rbxassetid://124184486064815"
local FONT_BOLD = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local FONT_MEDIUM = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local FONT_REGULAR = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local FONT_VALUE = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingOut)
local TWEEN_FAST = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingOut)

local function Tween(obj, props, info)
    local t = TweenService:Create(obj, info or TWEEN_INFO, props)
    t:Play()
    return t
end

local function Create(className, props, children)
    local inst = Instance.new(className)
    for prop, value in pairs(props or {}) do
        inst[prop] = value
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

local function Corner(radius, parent)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 3),
        Parent = parent
    })
end

local function Padding(parent, l, r, t, b)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, l or 0),
        PaddingRight = UDim.new(0, r or 0),
        PaddingTop = UDim.new(0, t or 0),
        PaddingBottom = UDim.new(0, b or 0),
        Parent = parent
    })
end

--// Library
local Fresh = {}
Fresh.__index = Fresh

function Fresh:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "Fresh UI Library"
    local status = config.Status or "Version : 1.0.0 | Status: Idle"

    local existing = PlayerGui:FindFirstChild("FreshUILibrary")
    if existing then existing:Destroy() end

    local ScreenGui = Create("ScreenGui", {
        Name = "FreshUILibrary",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(ScreenGui)
        elseif gethui then
            ScreenGui.Parent = gethui()
        end
    end)

    local Main = Create("Frame", {
        Name = "Main",
        ZIndex = 0,
        BorderSizePixel = 0,
        BackgroundColor3 = BG_MAIN,
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Parent = ScreenGui
    })
    Corner(5, Main)

    local DropShadowHolder = Create("Frame", {
        Name = "DropShadowHolder",
        ZIndex = -1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = Main
    })
    Create("ImageLabel", {
        Name = "DropShadow",
        ZIndex = -1,
        BorderSizePixel = 0,
        SliceCenter = Rect.new(49, 49, 450, 450),
        ScaleType = Enum.ScaleType.Slice,
        ImageTransparency = 0.5,
        ImageColor3 = Color3.fromRGB(26, 26, 26),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = "rbxassetid://6014261993",
        Size = UDim2.new(1, 47, 1, 47),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        Parent = DropShadowHolder
    })

    local TopBar = Create("Frame", {
        Name = "TopBar",
        BorderSizePixel = 0,
        BackgroundColor3 = BG_TOPBAR,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, 30),
        Parent = Main
    })
    Corner(5, TopBar)
    Create("Frame", {
        Name = "TopBarExtender",
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(71, 71, 71),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(1, 0, 1, 0),
        Parent = TopBar
    })

    local Title = Create("TextLabel", {
        Name = "Title",
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 20,
        FontFace = FONT_BOLD,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Text = windowTitle,
        Parent = TopBar
    })
    Padding(Title, 10)

    local ExitBtn = Create("ImageLabel", {
        Name = "ExitBtn",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Image = "rbxassetid://77116027143147",
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -8, 0, 4),
        Parent = TopBar
    })
    local MaximizeBtn = Create("ImageLabel", {
        Name = "MaximizeBtn",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Image = "rbxassetid://137769918231880",
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -34, 0, 4),
        Parent = TopBar
    })
    local MinimizeBtn = Create("ImageLabel", {
        Name = "MinimizeBtn",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Image = "rbxassetid://79608346017361",
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -58, 0, 4),
        Parent = TopBar
    })

    local function ButtonHover(btn)
        btn.MouseEnter:Connect(function()
            Tween(btn, { ImageTransparency = 0.3 }, TWEEN_FAST)
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, { ImageTransparency = 0 }, TWEEN_FAST)
        end)
    end

    local Navigation = Create("Frame", {
        Name = "Navigation",
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BorderSizePixel = 0,
        BackgroundColor3 = BG_NAV,
        ClipsDescendants = true,
        Size = UDim2.new(0, 200, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        Parent = Main
    })
    Corner(5, Navigation)
    Create("Frame", {
        Name = "NavigationExtender",
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(71, 71, 71),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Parent = Navigation
    })

    local ButtonHolder = Create("Frame", {
        Name = "ButtonHolder",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = Navigation
    })
    local NavScroll = Create("ScrollingFrame", {
        Name = "ButtonHolderScrollingFrame",
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Name = "ButtonHolderScrollingFrame",
        Selectable = false,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        Parent = ButtonHolder
    })
    Padding(NavScroll, 5, 5, 5, 15)
    Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = NavScroll
    })

    local StatusLabel = Create("TextLabel", {
        Name = "Status",
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        BackgroundColor3 = BG_NAV,
        TextSize = 14,
        FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(241, 241, 241),
        Size = UDim2.new(0, 200, 0, 10),
        Text = status,
        Position = UDim2.new(0, 0, 1, -10),
        Parent = Navigation
    })
    Padding(StatusLabel, 10, 0, 0, 2)

    local ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        BorderSizePixel = 0,
        BackgroundColor3 = BG_MAIN,
        AnchorPoint = Vector2.new(1, 0),
        ClipsDescendants = true,
        Size = UDim2.new(1, -210, 1, -40),
        Position = UDim2.new(1, -5, 0, 35),
        BackgroundTransparency = 1,
        Parent = Main
    })

    --// Resizer
    local Resizer = Create("TextButton", {
        Name = "Resizer",
        Active = true,
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        Selectable = false,
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.new(0, 15, 0, 15),
        BackgroundTransparency = 1,
        Text = "",
        Position = UDim2.new(1, 0, 1, 0),
        Parent = Main
    })

    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.Minimized = false
    Window.Maximized = false
    Window.NavButtons = {}

    ButtonHover(ExitBtn)
    ButtonHover(MaximizeBtn)
    ButtonHover(MinimizeBtn)

    -- drag
    do
        local dragging, dragInput, dragStart, startPos
        TopBar.Active = true
        TopBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        TopBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                Main.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    --resize
    do
        local resizing, resizeStart, startSize
        local MIN_SIZE = Vector2.new(400, 250)
        Resizer.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                resizing = true
                resizeStart = input.Position
                startSize = Main.AbsoluteSize
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        resizing = false
                    end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - resizeStart
                local newX = math.max(MIN_SIZE.X, startSize.X + delta.X)
                local newY = math.max(MIN_SIZE.Y, startSize.Y + delta.Y)
                Main.Size = UDim2.new(0, newX, 0, newY)
            end
        end)
    end

    -- minimize
    local savedSize = Main.Size
    MinimizeBtn.MouseButton1Click = nil
    Create("TextButton", { -- görünmez tıklama alanı
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.new(1, 0, 1, 0),
        Parent = MinimizeBtn
    }).MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            savedSize = Main.Size
            Navigation.Visible = false
            ContentContainer.Visible = false
            Resizer.Visible = false
            Tween(Main, { Size = UDim2.new(0, savedSize.X.Offset, 0, 30) })
        else
            Navigation.Visible = true
            ContentContainer.Visible = true
            Resizer.Visible = true
            Tween(Main, { Size = savedSize })
        end
    end)

    --// maximize
    local preMaxSize, preMaxPos
    Create("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.new(1, 0, 1, 0),
        Parent = MaximizeBtn
    }).MouseButton1Click:Connect(function()
        Window.Maximized = not Window.Maximized
        if Window.Maximized then
            preMaxSize = Main.Size
            preMaxPos = Main.Position
            local vp = workspace.CurrentCamera.ViewportSize
            Tween(Main, {
                Size = UDim2.new(0, vp.X - 40, 0, vp.Y - 40),
                Position = UDim2.new(0.5, -(vp.X - 40) / 2, 0.5, -(vp.Y - 40) / 2)
            })
        else
            Tween(Main, { Size = preMaxSize, Position = preMaxPos })
        end
    end)

    -- close
    Create("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.new(1, 0, 1, 0),
        Parent = ExitBtn
    }).MouseButton1Click:Connect(function()
        Tween(Main, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }).Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)

    -- opening anim
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Tween(Main, {
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200)
    }, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out))

    -- tab choose
    function Window:SelectTab(tab)
        for _, t in ipairs(self.Tabs) do
            if t == tab then
                t.Page.Visible = true
                t.Selected.Visible = true
                Tween(t.NavButton, { ImageTransparency = 0.5 }, TWEEN_FAST)
                Tween(t.NavTitle, { TextTransparency = 0 }, TWEEN_FAST)
            else
                t.Page.Visible = false
                t.Selected.Visible = false
                Tween(t.NavButton, { ImageTransparency = 1 }, TWEEN_FAST)
                Tween(t.NavTitle, { TextTransparency = 0.2 }, TWEEN_FAST)
            end
        end
        self.CurrentTab = tab
    end

    -- create tab
    function Window:CreateTab(name)
        name = name or "Tab"

        --navigation btn
        local NavButton = Create("ImageLabel", {
            Name = "NavButton",
            Active = true,
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BorderSizePixel = 0,
            ImageTransparency = 1,
            Image = "rbxassetid://15095614794",
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundTransparency = 1,
            Selectable = true,
            Parent = NavScroll
        })
        NavButton.SizeConstraint = Enum.SizeConstraint.None
        Corner(4, NavButton)
        Padding(NavButton, 5, 0, 5, 5)

        local NavTitle = Create("TextLabel", {
            Name = "ButtonTitle",
            TextWrapped = true,
            Active = true,
            BorderSizePixel = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextSize = 16,
            FontFace = FONT_MEDIUM,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.2,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = name,
            Parent = NavButton
        })
        Padding(NavTitle, 10)

        local Selected = Create("Frame", {
            Name = "Selected",
            Visible = false,
            BorderSizePixel = 0,
            BackgroundColor3 = ACCENT_COLOR,
            Size = UDim2.new(0, 5, 1, 0),
            Parent = NavButton
        })
        Corner(4, Selected)

        local Page = Create("ScrollingFrame", {
            Name = name .. "Tab",
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Selectable = false,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ClipsDescendants = false,
            Size = UDim2.new(1, 0, 1, 0),
            ScrollBarThickness = 0,
            BackgroundTransparency = 1,
            Visible = false,
            Parent = ContentContainer
        })
        Create("UIListLayout", {
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Page
        })
        Padding(Page, 5, 5, 5, 5)

        local Tab = {}
        Tab.NavButton = NavButton
        Tab.NavTitle = NavTitle
        Tab.Selected = Selected
        Tab.Page = Page

        local isSelected = function() return Window.CurrentTab == Tab end
        NavButton.MouseEnter:Connect(function()
            if not isSelected() then
                Tween(NavButton, { ImageTransparency = 0.8 }, TWEEN_FAST)
                Tween(NavTitle, { TextTransparency = 0 }, TWEEN_FAST)
            end
        end)
        NavButton.MouseLeave:Connect(function()
            if not isSelected() then
                Tween(NavButton, { ImageTransparency = 1 }, TWEEN_FAST)
                Tween(NavTitle, { TextTransparency = 0.2 }, TWEEN_FAST)
            end
        end)
        NavButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                Window:SelectTab(Tab)
            end
        end)

        table.insert(Window.Tabs, Tab)
    
        local function CreateBaseElement(height)
            local Frame = Create("Frame", {
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(21, 21, 21),
                ClipsDescendants = true,
                Size = UDim2.new(1, 0, 0, height or 40),
                BackgroundTransparency = 1,
                Parent = Page
            })
            Corner(3, Frame)
            local Background = Create("ImageLabel", {
                Name = "Background",
                BorderSizePixel = 0,
                ImageTransparency = 0.9,
                Image = ELEMENT_BG_IMAGE,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Parent = Frame
            })
            Corner(3, Background)
            return Frame, Background
        end

        local function BindHover(clickable, background)
            clickable.MouseEnter:Connect(function()
                Tween(background, { ImageTransparency = 0.75 }, TWEEN_FAST)
            end)
            clickable.MouseLeave:Connect(function()
                Tween(background, { ImageTransparency = 0.9 }, TWEEN_FAST)
            end)
            clickable.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    Tween(background, { ImageTransparency = 0.5 }, TWEEN_FAST)
                end
            end)
            clickable.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    Tween(background, { ImageTransparency = 0.75 }, TWEEN_FAST)
                end
            end)
        end

        local function CreateTitles(parent, titleText, subheadText, widthOffset)
            widthOffset = widthOffset or -30
            local Title = Create("TextLabel", {
                Name = "Title",
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                FontFace = FONT_BOLD,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, widthOffset, 0.5, 0),
                Text = titleText or "Title",
                Parent = parent
            })
            Padding(Title, 5)
            local Subhead = Create("TextLabel", {
                Name = "Subhead",
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                FontFace = FONT_MEDIUM,
                TextColor3 = Color3.fromRGB(181, 181, 181),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, widthOffset, 0.5, 0),
                Position = UDim2.new(0, 0, 0.5, 0),
                Text = subheadText or "",
                Parent = parent
            })
            Padding(Subhead, 5)
            return Title, Subhead
        end

        -- btn
        function Tab:CreateButton(cfg)
            cfg = cfg or {}
            local Frame, Background = CreateBaseElement(40)

            local ButtonHolderLabel = Create("TextLabel", {
                Name = "Button",
                BorderSizePixel = 0,
                TextTransparency = 1,
                TextSize = 14,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                Parent = Frame
            })
            local Title, Subhead = CreateTitles(ButtonHolderLabel, cfg.Title, cfg.Subhead, -30)

            local Icon = Create("ImageLabel", {
                Name = "Icon",
                BorderSizePixel = 0,
                Image = cfg.Icon or "rbxassetid://107598224139375",
                Size = UDim2.new(0, 30, 0, 30),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -30, 0, 5),
                Parent = Frame
            })

            --// Tıklanabilir alan
            local Clickable = Create("TextButton", {
                BackgroundTransparency = 1,
                Text = "",
                Size = UDim2.new(1, 0, 1, 0),
                Parent = Frame
            })
            BindHover(Clickable, Background)
            Clickable.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    task.spawn(cfg.Callback)
                end
            end)

            local ButtonObj = {}
            function ButtonObj:SetTitle(t) Title.Text = t end
            function ButtonObj:SetSubhead(t) Subhead.Text = t end
            return ButtonObj
        end

        -- toggle
        function Tab:CreateToggle(cfg)
            cfg = cfg or {}
            local state = cfg.Default or false

            local Frame, Background = CreateBaseElement(40)
            local Title, Subhead = CreateTitles(Frame, cfg.Title, cfg.Subhead, -100)

            local ToggleBackground = Create("Frame", {
                Name = "ToggleBackground",
                BorderSizePixel = 0,
                BackgroundColor3 = state and ACCENT_COLOR or Color3.fromRGB(71, 71, 71),
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -5, 0, 10),
                Parent = Frame
            })
            Corner(999, ToggleBackground)
            Padding(ToggleBackground, 2, 2, 2, 2)

            local Round = Create("Frame", {
                Name = "Round",
                BorderSizePixel = 0,
                BackgroundColor3 = state and Color3.fromRGB(11, 11, 11) or Color3.fromRGB(255, 255, 255),
                Size = UDim2.new(0, 16, 0, 16),
                Position = state and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0),
                Parent = ToggleBackground
            })
            Corner(999, Round)

            local Clickable = Create("TextButton", {
                Name = "Clickable",
                BackgroundTransparency = 1,
                Text = "",
                Size = UDim2.new(1, 0, 1, 0),
                Parent = Frame
            })

            local ToggleObj = {}

            local function updateVisual()
                if state then
                    Tween(ToggleBackground, { BackgroundColor3 = ACCENT_COLOR })
                    Tween(Round, {
                        Position = UDim2.new(0, 20, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(11, 11, 11)
                    })
                else
                    Tween(ToggleBackground, { BackgroundColor3 = Color3.fromRGB(71, 71, 71) })
                    Tween(Round, {
                        Position = UDim2.new(0, 0, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                end
            end

            function ToggleObj:Set(value)
                state = value
                updateVisual()
                if cfg.Callback then task.spawn(cfg.Callback, state) end
            end
            function ToggleObj:Get() return state end

            BindHover(Clickable, Background)
            Clickable.MouseButton1Click:Connect(function()
                state = not state
                updateVisual()
                if cfg.Callback then task.spawn(cfg.Callback, state) end
            end)

            return ToggleObj
        end

        -- label
        function Tab:CreateLabel(cfg)
            cfg = cfg or {}
            local Frame, Background = CreateBaseElement(40)

            local Title = Create("TextLabel", {
                Name = "Title",
                TextWrapped = true,
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 14,
                FontFace = FONT_MEDIUM,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = cfg.Text or "Label Text",
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = Frame
            })
            Padding(Title, 4, 2, 2, 2)

            local LabelObj = {}
            function LabelObj:SetText(t) Title.Text = t end
            return LabelObj
        end

        -- slider
        function Tab:CreateSlider(cfg)
            cfg = cfg or {}
            local min = cfg.Min or 0
            local max = cfg.Max or 100
            local default = cfg.Default or min
            local decimals = cfg.Decimals or 0
            local value = default

            local Frame, Background = CreateBaseElement(40)
            local Title, Subhead = CreateTitles(Frame, cfg.Title, cfg.Subhead, -175)

            local InputHolder = Create("Frame", {
                Name = "InputHolder",
                Active = true,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                Selectable = true,
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 50, 0, 20),
                Position = UDim2.new(1, -135, 0, 10),
                Parent = Frame
            })
            Corner(3, InputHolder)
            local InputStroke = Create("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Thickness = 1.45,
                Color = Color3.fromRGB(101, 101, 101),
                Parent = InputHolder
            })
            local Input = Create("TextBox", {
                Name = "Input",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                PlaceholderColor3 = Color3.fromRGB(179, 179, 179),
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                FontFace = FONT_REGULAR,
                PlaceholderText = "Input",
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                Parent = InputHolder
            })
            Padding(Input, 4)
            Corner(3, Input)

            local SliderBackground = Create("Frame", {
                Name = "SliderBackground",
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 125, 0, 20),
                Position = UDim2.new(1, -5, 0, 10),
                Parent = Frame
            })
            Corner(5, SliderBackground)
            local SliderStroke = Create("UIStroke", {
                Color = Color3.fromRGB(101, 101, 101),
                Parent = SliderBackground
            })

            local ValueText = Create("TextLabel", {
                Name = "ValueText",
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextSize = 14,
                FontFace = FONT_VALUE,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 40, 1, 0),
                ZIndex = 3,
                Text = tostring(value),
                Position = UDim2.new(1, -5, 0, 0),
                Parent = SliderBackground
            })

            local SliderBar = Create("CanvasGroup", {
                Name = "SliderBar",
                BorderSizePixel = 0,
                BackgroundColor3 = ACCENT_COLOR,
                Size = UDim2.new(0, 30, 1, 0),
                Parent = SliderBackground
            })
            Corner(5, SliderBar)

            local SliderObj = {}

            local function round(n)
                local mult = 10 ^ decimals
                return math.floor(n * mult + 0.5) / mult
            end

            local function updateSlider(pct, fireCallback)
                pct = math.clamp(pct, 0, 1)
                value = round(min + (max - min) * pct)
                Tween(SliderBar, { Size = UDim2.new(pct, 0, 1, 0) }, TWEEN_FAST)
                ValueText.Text = tostring(value)
                Input.Text = tostring(value)
                if fireCallback and cfg.Callback then
                    task.spawn(cfg.Callback, value)
                end
            end

            function SliderObj:Set(v)
                local pct = (v - min) / (max - min)
                updateSlider(pct, true)
            end
            function SliderObj:Get() return value end

            local dragging = false
            local function inputToPct(input)
                local rel = (input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X
                return math.clamp(rel, 0, 1)
            end

            SliderBackground.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    Tween(SliderStroke, { Color = ACCENT_COLOR }, TWEEN_FAST)
                    updateSlider(inputToPct(input), true)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        Tween(SliderStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST)
                    end
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(inputToPct(input), true)
                end
            end)

            Input.Focused:Connect(function()
                Tween(InputStroke, { Color = ACCENT_COLOR }, TWEEN_FAST)
            end)
            Input.FocusLost:Connect(function()
                Tween(InputStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST)
                local num = tonumber(Input.Text)
                if num then
                    num = math.clamp(num, min, max)
                    SliderObj:Set(num)
                else
                    Input.Text = tostring(value)
                end
            end)

            SliderBackground.MouseEnter:Connect(function()
                if not dragging then Tween(SliderStroke, { Color = ACCENT_COLOR }, TWEEN_FAST) end
            end)
            SliderBackground.MouseLeave:Connect(function()
                if not dragging then Tween(SliderStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST) end
            end)

            SliderObj:Set(default)
            return SliderObj
        end

        function Tab:CreateTextbox(cfg)
            cfg = cfg or {}
            local Frame, Background = CreateBaseElement(40)
            local Title, Subhead = CreateTitles(Frame, cfg.Title, cfg.Subhead, -100)

            local InputHolder = Create("Frame", {
                Name = "InputHolder",
                Active = true,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                Selectable = true,
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 100, 0, 20),
                Position = UDim2.new(1, -5, 0, 10),
                Parent = Frame
            })
            Corner(3, InputHolder)
            local InputStroke = Create("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Thickness = 1.45,
                Color = Color3.fromRGB(101, 101, 101),
                Parent = InputHolder
            })
            local Input = Create("TextBox", {
                Name = "Input",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                PlaceholderColor3 = Color3.fromRGB(179, 179, 179),
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                FontFace = FONT_REGULAR,
                PlaceholderText = cfg.Placeholder or "Input",
                Size = UDim2.new(1, 0, 1, 0),
                Text = cfg.Default or "",
                Parent = InputHolder
            })
            Padding(Input, 4)
            Corner(3, Input)

            Input.Focused:Connect(function()
                Tween(InputStroke, { Color = ACCENT_COLOR }, TWEEN_FAST)
                Tween(Background, { ImageTransparency = 0.75 }, TWEEN_FAST)
            end)
            Input.FocusLost:Connect(function(enterPressed)
                Tween(InputStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST)
                Tween(Background, { ImageTransparency = 0.9 }, TWEEN_FAST)
                if cfg.Callback then
                    task.spawn(cfg.Callback, Input.Text, enterPressed)
                end
            end)

            InputHolder.MouseEnter:Connect(function()
                Tween(Background, { ImageTransparency = 0.75 }, TWEEN_FAST)
            end)
            InputHolder.MouseLeave:Connect(function()
                if not Input:IsFocused() then
                    Tween(Background, { ImageTransparency = 0.9 }, TWEEN_FAST)
                end
            end)

            local TextObj = {}
            function TextObj:Set(t) Input.Text = t end
            function TextObj:Get() return Input.Text end
            return TextObj
        end

        -- keybind
        function Tab:CreateKeybind(cfg)
            cfg = cfg or {}
            local currentKey = cfg.Default
            local binding = false

            local Frame, Background = CreateBaseElement(40)

            local Icon = Create("ImageLabel", {
                Name = "Icon",
                BorderSizePixel = 0,
                Image = "rbxassetid://117516602212921",
                Size = UDim2.new(0, 30, 0, 30),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 5),
                Parent = Frame
            })

            local Title = Create("TextLabel", {
                Name = "Title",
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                FontFace = FONT_BOLD,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -100, 0.5, 0),
                Position = UDim2.new(0, 30, 0, 0),
                Text = cfg.Title or "Title",
                Parent = Frame
            })
            Padding(Title, 5)

            local Subhead = Create("TextLabel", {
                Name = "Subhead",
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                FontFace = FONT_MEDIUM,
                TextColor3 = Color3.fromRGB(181, 181, 181),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -100, 0.5, 0),
                Position = UDim2.new(0, 30, 0.5, 0),
                Text = cfg.Subhead or "",
                Parent = Frame
            })
            Padding(Subhead, 5)

            local KeyBackground = Create("Frame", {
                Name = "KeyBackground",
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(71, 71, 71),
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -5, 0, 5),
                Parent = Frame
            })
            Corner(5, KeyBackground)
            local KeyStroke = Create("UIStroke", {
                Color = Color3.fromRGB(101, 101, 101),
                Parent = KeyBackground
            })
            local KeyButton = Create("TextButton", {
                Name = "Button",
                BorderSizePixel = 0,
                TextSize = 18,
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = currentKey and currentKey.Name or "...",
                Parent = KeyBackground
            })

            local KeybindObj = {}

            KeyButton.MouseButton1Click:Connect(function()
                binding = true
                KeyButton.Text = "..."
                Tween(KeyStroke, { Color = ACCENT_COLOR }, TWEEN_FAST)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if binding then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        KeyButton.Text = currentKey.Name
                        binding = false
                        Tween(KeyStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST)
                    end
                elseif not gpe and currentKey and input.KeyCode == currentKey then
                    if cfg.Callback then task.spawn(cfg.Callback, currentKey) end
                end
            end)

            KeyBackground.MouseEnter:Connect(function()
                if not binding then Tween(KeyStroke, { Color = ACCENT_COLOR }, TWEEN_FAST) end
            end)
            KeyBackground.MouseLeave:Connect(function()
                if not binding then Tween(KeyStroke, { Color = Color3.fromRGB(101, 101, 101) }, TWEEN_FAST) end
            end)

            function KeybindObj:Set(key) currentKey = key; KeyButton.Text = key.Name end
            function KeybindObj:Get() return currentKey end
            return KeybindObj
        end

        if #Window.Tabs == 1 then
            Window:SelectTab(Tab)
        end

        return Tab
    end

    function Window:SetStatus(text)
        StatusLabel.Text = text
    end

    function Window:Destroy()
        ScreenGui:Destroy()
    end

    return Window
end

return Fresh
