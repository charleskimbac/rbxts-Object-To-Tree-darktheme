-- Compiled with roblox-ts v1.0.0-beta.15
local TS = require(script.include.RuntimeLib)
-- / <reference types="@rbxts/types/plugin"/>
-- TODO: Make it automatically add to `default.project.json` files
-- TODO: Make it customizable what name the single-file Rojoesque generator should go to
local _0 = TS.import(script, script, "config")
local PLUGIN_NAME = _0.PLUGIN_NAME
local OPTIONS = _0.OPTIONS
local ICON_ID = _0.ICON_ID
local DEFAULT_SETTING = _0.DEFAULT_SETTING
local IO_SERVE_URL = _0.IO_SERVE_URL
local PLUGIN_DESCRIPTION = _0.PLUGIN_DESCRIPTION
local Radio = TS.import(script, script, "radio")
local generateOptions = TS.import(script, script, "generateTree")
local Feedback = TS.import(script, script, "feedback")
local delay = TS.import(script, TS.getModule(script, "delay-spawn-wait")).delay
local HttpService = game:GetService("HttpService")
local Selection = game:GetService("Selection")
delay(1, function()
	local widgetSize = Vector2.new(227, 232)
	local DockWidget = plugin:CreateDockWidgetPluginGui(PLUGIN_NAME, DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, widgetSize.X, widgetSize.Y, widgetSize.X, widgetSize.Y))
	DockWidget.Name = "rbxts-object-to-tree"
	DockWidget.Title = DockWidget.Name
	delay(0, function()
		DockWidget.Enabled = false
		return DockWidget.Enabled
	end)
	local Background = Instance.new("Frame")
	Background.AnchorPoint = Vector2.new(0.5, 0)
	Background.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	Background.BorderSizePixel = 0
	Background.Name = "Background"
	Background.Position = UDim2.new(0.5, 0, 0, 1)
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.ZIndex = -1
	local BackImage = Instance.new("ImageLabel")
	BackImage.AnchorPoint = Vector2.new(0.5, 0.5)
	BackImage.BackgroundTransparency = 1
	BackImage.Image = "rbxassetid://3561078226"
	BackImage.ImageColor3 = Color3.fromRGB(46, 46, 46)
	BackImage.ImageTransparency = 0.7
	BackImage.Name = "BackImage"
	BackImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	BackImage.Size = UDim2.new(0, 135, 0, 135)
	BackImage.ZIndex = 0
	BackImage.Parent = Background
	local Indicator = Instance.new("Frame")
	Indicator.BackgroundColor3 = Color3.fromRGB(4, 255, 0)
	Indicator.BorderSizePixel = 0
	Indicator.Name = "Indicator"
	Indicator.Position = UDim2.new(0, -1, 1, 2)
	Indicator.Size = UDim2.new(1, 2, 0, 4)
	Indicator.Visible = false
	local Choices = Instance.new("Frame")
	Choices.BackgroundTransparency = 1
	Choices.Name = "Choices"
	Choices.Position = UDim2.new(0, 0, 0, 0)
	Choices.Size = UDim2.new(1, 0, 1, 0)
	Choices.ZIndex = 10
	local Instructions = Instance.new("TextLabel")
	Instructions.BackgroundTransparency = 1
	Instructions.Font = Enum.Font.SourceSans
	Instructions.LayoutOrder = -1
	Instructions.Name = "Instructions"
	Instructions.Text = "  Export type:"
	Instructions.TextColor3 = Color3.fromRGB(255, 255, 255)
	Instructions.TextSize = 18
	Instructions.TextTransparency = 0.13
	Instructions.TextWrapped = true
	Instructions.TextXAlignment = Enum.TextXAlignment.Left
	Instructions.TextYAlignment = Enum.TextYAlignment.Center
	Instructions.Size = UDim2.new(-8, 1, 18, 0)
	Instructions.ZIndex = 2
	Instructions.Parent = Choices
	local BottomHint = Instance.new("TextLabel")
	BottomHint.TextSize = 11
	BottomHint.BackgroundTransparency = 1
	BottomHint.Font = Enum.Font.SourceSansSemibold
	BottomHint.LayoutOrder = 10
	BottomHint.Name = "BottomHint"
	BottomHint.Size = UDim2.new(-8, 1, 36, 0)
	BottomHint.Text = "Run `npx io-serve` with HTTP requests enabled to automatically place files in your project."
	BottomHint.TextColor3 = Color3.fromRGB(154, 154, 154)
	BottomHint.TextSize = 11
	BottomHint.TextTransparency = 0.46
	BottomHint.TextWrapped = true
	-- BottomHint.TextYAlignment = Enum.TextYAlignment.Bottom;
	BottomHint.ZIndex = 2
	BottomHint.Parent = Choices
	local UIGridLayout = Instance.new("UIGridLayout")
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout.CellSize = UDim2.new(1, 0, 0, 32)
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.FillDirection = Enum.FillDirection.Vertical
	UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	local GeneratorFrame = Instance.new("Frame")
	GeneratorFrame.BackgroundTransparency = 1
	GeneratorFrame.Name = "GenerateButton"
	GeneratorFrame.Size = UDim2.new(0, 200, 0, 50)
	GeneratorFrame.Parent = Choices
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Image = "rbxassetid://1934624205"
	ImageLabel.ImageColor3 = Color3.fromRGB(211, 33, 24)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.Size = UDim2.new(0.5, 0, 1, -4)
	ImageLabel.SliceCenter = Rect.new(8, 8, 248, 248)
	ImageLabel.Parent = GeneratorFrame
	local GenerateButton = Instance.new("TextButton")
	GenerateButton.BackgroundTransparency = 1
	GenerateButton.Font = Enum.Font.SourceSansBold
	GenerateButton.Size = UDim2.new(1, 0, 1, 0)
	GenerateButton.Text = "GENERATE"
	GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	GenerateButton.TextSize = 20
	GenerateButton.Parent = GeneratorFrame
	local options = {}
	local function makeOption(option, order)
		local FullButton = Instance.new("TextButton")
		FullButton.BackgroundTransparency = 1
		FullButton.Font = Enum.Font.SourceSans
		FullButton.Name = option
		FullButton.Size = UDim2.new(0, 200, 0, 50)
		FullButton.Text = ""
		FullButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		FullButton.TextSize = 14
		FullButton.LayoutOrder = order
		FullButton.Parent = Choices
		local GenerateType = Instance.new("TextLabel")
		GenerateType.BackgroundTransparency = 1
		GenerateType.Font = Enum.Font.SourceSans
		GenerateType.LayoutOrder = 1
		GenerateType.Name = option
		GenerateType.Position = UDim2.new(0, 48, 0, 0)
		GenerateType.Size = UDim2.new(1, -GenerateType.Position.X.Offset, 1, 0)
		GenerateType.Text = option
		GenerateType.TextColor3 = Color3.fromRGB(255, 255, 255)
		GenerateType.TextSize = 18
		GenerateType.TextTransparency = 0.13
		GenerateType.TextXAlignment = Enum.TextXAlignment.Left
		GenerateType.ZIndex = 11
		GenerateType.Parent = FullButton
		Radio:setTheme("dark")
		local checkbox = Radio.new({
			anchorPoint = Vector2.new(0, 0.5),
			position = UDim2.new(0, 16, 0.5, 0),
			size = 24,
			parent = FullButton,
			borderRadius = 16,
			isChecked = false,
			onChecked = function(isChecked)
				if isChecked then
					plugin:SetSetting(DEFAULT_SETTING, option)
					for opt, check in pairs(options) do
						if opt ~= option and check:getChecked() then
							check:setChecked(false)
						end
					end
				end
			end,
		})
		FullButton.MouseButton1Click:Connect(function()
			if not checkbox:getChecked() then
				checkbox:setChecked(true)
			end
		end)
		local _1 = options
		local _2 = option
		local _3 = checkbox
		-- ▼ Map.set ▼
		_1[_2] = _3
		-- ▲ Map.set ▲
	end
	local _1 = OPTIONS
	local _2 = makeOption
	-- ▼ ReadonlyArray.forEach ▼
	for _3, _4 in ipairs(_1) do
		_2(_4, _3 - 1, _1)
	end
	-- ▲ ReadonlyArray.forEach ▲
	local _3 = options
	local _4 = DEFAULT_SETTING
	_3[_4]:setChecked(true)
	GeneratorFrame.LayoutOrder = #OPTIONS
	local function getSelectedOption()
		for option, check in pairs(options) do
			if check:getChecked() then
				return option
			end
		end
		return DEFAULT_SETTING
	end
	local function toggleSettings()
		DockWidget.Enabled = not DockWidget.Enabled
	end
	-- * tests to see if io-serve is available
	local function isIoServeAvailable()
		local _5 = function()
			return HttpService:RequestAsync({
				Url = IO_SERVE_URL,
				Method = "HEAD",
			})
		end
		local _6, _7 = pcall(_5)
		local result = _6 and {
			success = true,
			value = _7,
		} or {
			success = false,
			error = _7,
		}
		return result.success and result.value.StatusCode == 200
	end
	local generating = false
	GenerateButton.MouseButton1Click:Connect(function()
		if not generating then
			generating = true
			local selection = Selection:Get()
			local selectionSize = #selection
			if 0 < selectionSize then
				local useIoServe = isIoServeAvailable()
				local success = true
				for _, selected in ipairs(selection) do
					local _5, _6 = TS.try(function()
						local _7 = generateOptions
						local _8 = getSelectedOption()
						if not _7[_8](selected, useIoServe) then
							success = false
						end
					end, function(e)
						Feedback.new(tostring(e))
						return TS.TRY_BREAK
					end)
					if _5 then
						break
					end
				end
				if success and selectionSize ~= 1 then
					Feedback.new(useIoServe and "Sent multiple files to io-serve" or "Generated multiple files in Lighting!")
				end
			else
				Feedback.new("Please select something to generate.")
			end
			generating = false
		end
	end)
	Choices.Parent = Background
	UIGridLayout.Parent = Choices
	Indicator.Parent = Background
	Background.Parent = DockWidget
	plugin:CreateToolbar(PLUGIN_NAME):CreateButton(PLUGIN_NAME, PLUGIN_DESCRIPTION, "rbxassetid://" .. tostring(ICON_ID)).Click:Connect(toggleSettings)
end)