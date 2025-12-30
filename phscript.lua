-- 🎯 PHOENIX TARGETED v1.0
-- واجهة موجهة للهاتف - تكتب ID وتضغط
-- loadstring(game:HttpGet(""))()

repeat task.wait() until game:IsLoaded()
local plr = game.Players.LocalPlayer

-- 🔥 نفس نواة القوة الأصلية
local Phoenix = {
    _id = nil,
    _mode = "targeted"
}

function Phoenix:ignite(targetId)
    self._id = targetId
    print("🎯 TARGETING ID:", targetId)
    
    -- 🌪️ نفس هجوم العاصفة
    print("🌪️ STORM PHASE: Targeted attack")
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            task.spawn(function()
                pcall(obj.FireServer, obj, {gamepass = self._id, buy = true})
            end)
        end
    end
    
    task.wait(0.3)
    
    -- 🛒 فتح نافذة الشراء المستهدفة
    local success, msg = pcall(function()
        game:GetService("MarketplaceService"):PromptProductPurchase(plr, self._id)
    end)
    
    return success and "✅ PURCHASE WINDOW OPENED" or "❌ FAILED"
end

-- 📱📱📱 واجهة الهاتف الموجهة 📱📱📱
local mobileUI = Instance.new("ScreenGui")
mobileUI.Name = "PhoenixTarget"
mobileUI.ResetOnSpawn = false

-- إطار النصف السفلي
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 0.35, 0) -- 35% من الشاشة
frame.Position = UDim2.new(0, 0, 0.65, 0) -- في الأسفل
frame.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
frame.BorderSizePixel = 0

-- العنوان
local title = Instance.new("TextLabel")
title.Text = "🎯 TARGET BUYER"
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
title.TextColor3 = Color3.new(1, 0.8, 0.2)
title.Font = Enum.Font.SourceSansBold
title.FontSize = Enum.FontSize.Size20

-- مربع الإدخال الكبير
local inputBox = Instance.new("TextBox")
inputBox.PlaceholderText = "ENTER GAMEPASS ID"
inputBox.Size = UDim2.new(0.9, 0, 0.25, 0)
inputBox.Position = UDim2.new(0.05, 0, 0.25, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.SourceSansBold
inputBox.FontSize = Enum.FontSize.Size16
inputBox.Text = ""

-- زر الشراء الكبير
local buyButton = Instance.new("TextButton")
buyButton.Text = "🛒 BUY NOW"
buyButton.Size = UDim2.new(0.9, 0, 0.25, 0)
buyButton.Position = UDim2.new(0.05, 0, 0.55, 0)
buyButton.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
buyButton.TextColor3 = Color3.new(1, 1, 1)
buyButton.Font = Enum.Font.SourceSansBold
buyButton.FontSize = Enum.FontSize.Size18

-- شريط الحالة
local statusBar = Instance.new("TextLabel")
statusBar.Text = "🟢 READY"
statusBar.Size = UDim2.new(1, 0, 0.15, 0)
statusBar.Position = UDim2.new(0, 0, 0.85, 0)
statusBar.BackgroundTransparency = 1
statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
statusBar.Font = Enum.Font.SourceSansBold

-- 🔥 حدث الشراء
buyButton.MouseButton1Click:Connect(function()
    local idText = inputBox.Text
    local gamepassId = tonumber(idText)
    
    if not gamepassId then
        statusBar.Text = "❌ ENTER VALID NUMBER"
        statusBar.TextColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(1.5)
        statusBar.Text = "🟢 READY"
        statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    -- تبديل حالة الزر
    buyButton.Text = "⚡ PROCESSING..."
    buyButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    statusBar.Text = "🎯 TARGETING ID: " .. gamepassId
    statusBar.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    -- تنفيذ الهجوم
    task.spawn(function()
        local result = Phoenix:ignite(gamepassId)
        
        statusBar.Text = result
        if string.sub(result, 1, 1) == "✅" then
            statusBar.TextColor3 = Color3.fromRGB(80, 255, 80)
            buyButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        else
            statusBar.TextColor3 = Color3.fromRGB(255, 80, 80)
            buyButton.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
        end
        
        task.wait(2)
        buyButton.Text = "🛒 BUY NOW"
        buyButton.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
        statusBar.Text = "🟢 READY"
        statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
end)

-- التجميع
title.Parent = frame
inputBox.Parent = frame
buyButton.Parent = frame
statusBar.Parent = frame
frame.Parent = mobileUI
mobileUI.Parent = plr.PlayerGui

-- 📢 إعلان التشغيل
print("🎯 PHOENIX TARGETED LOADED!")
print("📱 Mobile interface ready at bottom")
print("🎯 Enter Gamepass ID → Press BUY NOW")

-- 🚀 تصدير للاستخدام المباشر
_G.BuyTarget = function(id)
    return Phoenix:ignite(id)
end
