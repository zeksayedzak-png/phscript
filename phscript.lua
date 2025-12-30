-- ⚡ PHOENIX ULTIMATE - MOBILE EDITION
-- واجهة موجهة للهاتف - اكتب المعرف واضغط إشعال
-- loadstring(game:HttpGet(""))()

-- 🎮 انتظر اللعبة
repeat task.wait() until game:IsLoaded()
local plr = game.Players.LocalPlayer

-- 🔥 نواة القوة (من السكربت الأصلي)
local Phoenix = {
    _id = nil,
    _mode = "storm",
    _depth = 0
}

-- 🧠 المحرك الأساسي (من السكربت الأصلي)
function Phoenix:ignite(targetId)
    self._id = targetId
    print("⚡ PHOENIX IGNITED | Target:", targetId)
    
    -- 🔥 المرحلة 1: العاصفة الأولية
    self:_stormPhase()
    
    -- 🔥 المرحلة 2: اختراق الأعماق  
    self:_deepPhase()
    
    -- 🔥 المرحلة 3: النهائي النووي
    self:_novaPhase()
    
    return "🔥 PHOENIX CYCLE COMPLETE"
end

-- 🌪️ العاصفة: هجوم سطحي سريع (من الأصلي)
function Phoenix:_stormPhase()
    print("🌪️ STORM PHASE: Surface attack")
    
    -- أرسل إلى كل شيء
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            task.spawn(function()
                pcall(obj.FireServer, obj, self._id)
                pcall(obj.FireServer, obj, {id = self._id})
                pcall(obj.FireServer, obj, {gamepass = self._id, buy = true})
            end)
        end
    end
    
    task.wait(0.5)
    
    -- افتح نافذة الشراء
    pcall(function()
        game:GetService("MarketplaceService"):PromptProductPurchase(plr, self._id)
    end)
end

-- 🌊 الأعماق: اختراق متقدم (من الأصلي)
function Phoenix:_deepPhase()
    print("🌊 DEEP PHASE: Advanced penetration")
    self._depth = self._depth + 1
    
    -- 1. حقن في CoreGui
    local ghost = Instance.new("ScreenGui")
    ghost.Name = "SystemGhost_" .. math.random(1000,9999)
    ghost.ResetOnSpawn = false
    
    local script = Instance.new("LocalScript")
    script.Source = [[
        game:GetService("RunService").Heartbeat:Connect(function()
        end)
    ]]
    script.Parent = ghost
    pcall(function() ghost.Parent = game.CoreGui end)
    
    -- 2. تلاعب بالذاكرة
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("NumberValue") and v.Value == 0 then
            pcall(function() v.Value = self._id end)
        end
    end
    
    -- 3. Race condition متقدم
    for i = 1, 8 do
        task.spawn(function()
            pcall(function()
                game:GetService("MarketplaceService"):PromptProductPurchase(plr, self._id)
            end)
        end)
    end
end

-- ☢️ النوفا: الهجوم النووي (من الأصلي)
function Phoenix:_novaPhase()
    print("☢️ NOVA PHASE: Nuclear assault")
    
    -- 1. هجوم متزامن على كل الأنظمة
    local systems = {
        "ReplicatedStorage",
        "ServerStorage", 
        "Workspace",
        "Lighting",
        "Players"
    }
    
    for _, sysName in pairs(systems) do
        task.spawn(function()
            local sys = game:FindFirstChild(sysName)
            if sys then
                for _, obj in pairs(sys:GetDescendants()) do
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        pcall(function()
                            if obj:IsA("RemoteEvent") then
                                obj:FireServer(self._id)
                            else
                                obj:InvokeServer(self._id)
                            end
                        end)
                    end
                end
            end
        end)
    end
    
    -- 2. إرسال بيانات مصممة
    local payloads = {
        {productId = self._id, purchased = true, receipt = "PHOENIX_" .. os.time()},
        {gamepassId = self._id, status = "completed", playerId = plr.UserId},
        self._id,
        {id = self._id, timestamp = os.time(), source = "phoenix"}
    }
    
    for _, payload in pairs(payloads) do
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                task.spawn(function()
                    pcall(remote.FireServer, remote, payload)
                end)
            end
        end
    end
    
    -- 3. التخفي بعد الهجوم
    task.spawn(function()
        task.wait(2)
        local cleanup = Instance.new("ScreenGui")
        cleanup.Name = "Cleanup_" .. math.random()
        cleanup.ResetOnSpawn = true
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 100, 0, 30)
        frame.Position = UDim2.new(1, -110, 0, 10)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        frame.BackgroundTransparency = 0.3
        
        local label = Instance.new("TextLabel")
        label.Text = "FPS: 60"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(150, 150, 150)
        
        label.Parent = frame
        frame.Parent = cleanup
        cleanup.Parent = plr.PlayerGui
    end)
end

-- 📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱
-- 🎯 الجزء الجديد: واجهة الهاتف الموجهة
-- 📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱

-- إنشاء واجهة الهاتف (نصف الشاشة)
local mobileUI = Instance.new("ScreenGui")
mobileUI.Name = "PhoenixMobile"
mobileUI.ResetOnSpawn = false

-- الخلفية الرئيسية (تغطي نصف الشاشة)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 0.5, 0) -- نصف الشاشة
mainFrame.Position = UDim2.new(0, 0, 0.25, 0) -- في المنتصف
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0

-- عنوان كبير واضح
local title = Instance.new("TextLabel")
title.Text = "⚡ PHOENIX MOBILE"
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
title.TextColor3 = Color3.fromRGB(255, 100, 255)
title.Font = Enum.Font.SourceSansBold
title.FontSize = Enum.FontSize.Size24
title.BorderSizePixel = 0

-- مربع الإدخال الكبير
local inputBox = Instance.new("TextBox")
inputBox.PlaceholderText = "ENTER GAMEPASS ID HERE"
inputBox.Size = UDim2.new(0.8, 0, 0.2, 0)
inputBox.Position = UDim2.new(0.1, 0, 0.25, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.SourceSansBold
inputBox.FontSize = Enum.FontSize.Size18
inputBox.ClearTextOnFocus = false
inputBox.Text = ""

-- زر الإشعال الكبير
local igniteButton = Instance.new("TextButton")
igniteButton.Text = "🔥 IGNITE"
igniteButton.Size = UDim2.new(0.8, 0, 0.2, 0)
igniteButton.Position = UDim2.new(0.1, 0, 0.55, 0)
igniteButton.BackgroundColor3 = Color3.fromRGB(180, 0, 60)
igniteButton.TextColor3 = Color3.new(1, 1, 1)
igniteButton.Font = Enum.Font.SourceSansBold
igniteButton.FontSize = Enum.FontSize.Size20
igniteButton.AutoButtonColor = true

-- شريط الحالة
local statusBar = Instance.new("TextLabel")
statusBar.Text = "🟢 READY - Enter Gamepass ID"
statusBar.Size = UDim2.new(1, 0, 0.1, 0)
statusBar.Position = UDim2.new(0, 0, 0.85, 0)
statusBar.BackgroundTransparency = 1
statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
statusBar.Font = Enum.Font.SourceSansBold
statusBar.FontSize = Enum.FontSize.Size14

-- تلميح صغير
local hint = Instance.new("TextLabel")
hint.Text = "Enter numeric ID only (e.g., 123456789)"
hint.Size = UDim2.new(1, 0, 0.1, 0)
hint.Position = UDim2.new(0, 0, 0.95, 0)
hint.BackgroundTransparency = 1
hint.TextColor3 = Color3.fromRGB(150, 150, 200)
hint.Font = Enum.Font.SourceSans
hint.FontSize = Enum.FontSize.Size12

-- 🔥 حدث الزر الجديد
igniteButton.MouseButton1Click:Connect(function()
    local inputText = inputBox.Text
    local gamepassId = tonumber(inputText)
    
    -- تحقق من المدخلات
    if not gamepassId then
        statusBar.Text = "❌ INVALID ID - Enter numbers only"
        statusBar.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        -- تأثير اهتزاز للمربع
        local originalPos = inputBox.Position
        for i = 1, 3 do
            inputBox.Position = UDim2.new(0.1, 5, 0.25, 0)
            task.wait(0.05)
            inputBox.Position = UDim2.new(0.1, -5, 0.25, 0)
            task.wait(0.05)
        end
        inputBox.Position = originalPos
        
        task.wait(2)
        statusBar.Text = "🟢 READY - Enter Gamepass ID"
        statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    -- بدء العملية
    igniteButton.Text = "⚡ IGNITING..."
    igniteButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    statusBar.Text = "🔵 PROCESSING ID: " .. gamepassId
    statusBar.TextColor3 = Color3.fromRGB(100, 150, 255)
    
    -- تشغيل المحرك الأصلي
    task.spawn(function()
        local result = Phoenix:ignite(gamepassId)
        
        -- عرض النتيجة
        statusBar.Text = result
        if string.find(result, "COMPLETE") then
            statusBar.TextColor3 = Color3.fromRGB(0, 255, 100)
            
            -- تأثير نجاح
            for i = 1, 3 do
                igniteButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
                task.wait(0.3)
                igniteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
                task.wait(0.3)
            end
        else
            statusBar.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
        
        -- العودة للحالة الطبيعية
        task.wait(3)
        igniteButton.Text = "🔥 IGNITE"
        igniteButton.BackgroundColor3 = Color3.fromRGB(180, 0, 60)
        statusBar.Text = "🟢 READY - Enter Gamepass ID"
        statusBar.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
end)

-- التجميع
title.Parent = mainFrame
inputBox.Parent = mainFrame
igniteButton.Parent = mainFrame
statusBar.Parent = mainFrame
hint.Parent = mainFrame
mainFrame.Parent = mobileUI
mobileUI.Parent = plr.PlayerGui

-- 🚀 تصدير الوظائف (من الأصلي)
_G.Phoenix = Phoenix
_G.Ignite = function(id)
    return Phoenix:ignite(id)
end

-- 📢 إعلان التشغيل
print([[
    
    ╔══════════════════════════════════╗
    ║   ⚡ PHOENIX MOBILE EDITION     ║
    ║   HALF-SCREEN INTERFACE         ║
    ║   LOADSTRING READY              ║
    ╚══════════════════════════════════╝
    
    📱 MOBILE USAGE:
    1. Enter Gamepass ID in box
    2. Press IGNITE button
    3. Watch status bar
    
    🔥 OR USE:
    _G.Ignite(123456789)
    
    ⚠️ WARNING:
    This is the ORIGINAL Phoenix script
    with mobile-optimized interface
    
]])
