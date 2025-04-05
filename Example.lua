local Material = loadstring(game:HttpGet("https://github.com/icewinrages/roblox/blob/master/Module.lua"), "MaterialLua")()
local Lightning = game:GetService("Lighting")

local ui = Material.Load({
     Title = "Mining Inc Xray",
     Style = 3,
     SizeX = 300,
     SizeY = 300,
     Theme = "Dark"
})

local main = ui.New({
     Title = "Main"
})

local XrayOutLineColor = Color3.new(0, 0, 0)
main.ColorPicker({
    Text = "XRay Outline Color",
    Callback = function(color)
        XrayOutLineColor = color
    end,
    Default = XrayOutLineColor
})

function getAllOre()
    local ores = {}
    for i,v in ipairs(game:GetService("Workspace").Minerals:GetChildren()) do
        local model = v
        local oreName = v.Type.Value
        ores[#ores+1] = {model = model, oreName = oreName}
    end
    return ores
end

function drawOreEsp(ore)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "OreEsp"
    billboardGui.Adornee = ore.model
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 100, 0, 100)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = ore.model
    local esp = Instance.new("TextLabel", billboardGui)
    esp.Name = "Text"
    esp.Size = UDim2.new(0, 100, 0, 10)
    esp.BackgroundTransparency = 1
    esp.Text = ore.oreName
    esp.TextColor3 = ore.model.Color
    esp.TextStrokeColor3 = XrayOutLineColor
    esp.TextStrokeTransparency = 0
    esp.TextScaled = true
    esp.TextWrapped = true
    esp.TextXAlignment = Enum.TextXAlignment.Center
    esp.TextYAlignment = Enum.TextYAlignment.Center
    esp.TextSize = 10
    print("Drawed Esp", "Ore Name: " .. ore.oreName)
end

function deleteOreEsp()
    for i,v in ipairs(workspace.Minerals:GetChildren()) do
        if v:FindFirstChild("OreEsp") then
            v.OreEsp:Destroy()
        end
    end
end

main.Toggle({
    Text = "Toggle Xray",
    Callback = function(value)
        if value then
            for i,v in ipairs(getAllOre()) do
                drawOreEsp(v)
            end
        else
            deleteOreEsp()
        end
    end
})

main.Toggle({
    Text = "Fullbright",
    Callback = function (value)
        if value then 
            Lightning.Ambient = Color3.new(1, 1, 1)
            Lightning.ColorShift_Bottom = Color3.new(1, 1, 1)
            Lightning.ColorShift_Top = Color3.new(1, 1, 1)
        else
            Lightning.Ambient = Color3.new(0.5, 0.5, 0.5)
            Lightning.ColorShift_Bottom = Color3.new(0.5, 0.5, 0.5)
            Lightning.ColorShift_Top = Color3.new(0.5, 0.5, 0.5)
        end
    end
})
