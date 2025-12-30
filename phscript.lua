-- ☢️ NUCLEAR EXPLOIT v1.0
-- loadstring(game:HttpGet(""))()

repeat task.wait() until game:IsLoaded()
local plr = game.Players.LocalPlayer

-- 📱 واجهة النصف السفلي
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "NuclearUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1, 0, 0.4, 0)
frame.Position = UDim2.new(0, 0, 0.6, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Text = "☢️ NUCLEAR EXPLOIT"
title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)

-- Input
local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.8, 0, 0.2, 0)
input.Position = UDim2.new(0.1, 0, 0.3, 0)
input.PlaceholderText = "Gamepass ID"
input.Text = ""
input.BackgroundColor3 = Color3.fromRGB(40, 0, 0)

-- Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.2, 0)
button.Position = UDim2.new(0.1, 0, 0.6, 0)
button.Text = "☢️ LAUNCH"
button.BackgroundColor3 = Color3.fromRGB(255, 50, 0)
button.TextColor3 = Color3.new(1, 1, 1)

-- Status
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0.2, 0)
status.Position = UDim2.new(0, 0, 0.85, 0)
status.Text = "READY"
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(0, 1, 0)

-- ☢️ الهجوم النووي
button.MouseButton1Click:Connect(function()
    local id = tonumber(input.Text)
    if not id then
        status.Text = "INVALID ID"
        status.TextColor3 = Color3.new(1, 0, 0)
        return
    end
    
    button.Text = "LAUNCHING..."
    status.Text = "NUCLEAR LAUNCH DETECTED"
    
    -- هجوم نووي حقيقي
    local function nuclearAttack()
        -- 1. هجوم RemoteEvents
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                pcall(obj.FireServer, obj, {gamepass = id, buy = true})
            end
        end
        
        -- 2. فتح نافذة الشراء
        pcall(function()
            game:GetService("MarketplaceService"):PromptProductPurchase(plr, id)
        end)
        
        -- 3. هجوم متعدد
        for i = 1, 5 do
            task.spawn(function()
                pcall(function()
                    game:GetService("MarketplaceService"):PromptProductPurchase(plr, id)
                end)
            end)
        end
        
        return "☢️ NUCLEAR LAUNCH COMPLETE"
    end
    
    task.spawn(function()
        local result = nuclearAttack()
        status.Text = result
        button.Text = "☢️ LAUNCH"
    end)
end)

print("☢️ NUCLEAR EXPLOIT LOADED")
print("📱 Mobile half-screen interface ready")
