-- troll your friends!
-- funny prank :>

local src = [==[
repeat task.wait() until game:IsLoaded()

local plr = game:GetService("Players").LocalPlayer
local ts = game:GetService("TeleportService")
local gs = game:GetService("GuiService")
local uis = game:GetService("UserInputService")
local sg = game:GetService("StarterGui")
local cg = game:GetService("CoreGui")
local ss = game:GetService("SoundService") -- sound service cuz yes (i dunno ion wanna use workspace)

local w = "rbxassetid://11660423541"
local b = "rbxassetid://4616500111"
local bar = nil
local conn = nil
local run = true

task.spawn(function()
    for i = 1, 50 do
        local t = cg:FindFirstChild("TopBarApp")
        if t then
            bar = t
            bar.Parent = nil
            break
        end
        task.wait(0.1)
    end
end)

while not pcall(function() sg:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end) do
    task.wait()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999999999999999999999
gui.Parent = plr:WaitForChild("PlayerGui")

local img = Instance.new("ImageLabel")
img.Size = UDim2.fromScale(1, 1)
img.Position = UDim2.fromScale(0, 0)
img.BackgroundColor3 = Color3.new(1, 1, 1)
img.BorderSizePixel = 0
img.Image = w
img.ScaleType = Enum.ScaleType.Stretch
img.Parent = gui

task.spawn(function()
    local c = w
    while run and img.Parent do
        c = (c == w) and b or w
        img.Image = c
        task.wait(0.25)
    end
end)

local snd = Instance.new("Sound")
snd.SoundId = "rbxassetid://3200130016" 

snd.Looped = true
snd.Volume = 1
snd.Parent = ss
snd:Play()

conn = gs.MenuOpened:Connect(function()
    if run then
        snd.TimePosition = 0
        snd:Play()
        pcall(function()
            ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
        end)
    end
end)

local function stop()
    if not run then return end
    run = false
    
    if conn then conn:Disconnect() end
    
    snd:Stop()
    snd:Destroy()
    gui:Destroy()

    if bar then bar.Parent = cg end

    pcall(function() sg:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
    pcall(function() sg:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
    pcall(function() sg:SetCore("TopbarEnabled", true) end)
    
    if queue_on_teleport then pcall(function() queue_on_teleport("") end) end
    if syn and syn.queue_on_teleport then pcall(function() syn.queue_on_teleport("") end) end
end

uis.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.One then
        stop()
    end
end)
]==]

if queue_on_teleport then
    queue_on_teleport(src)
elseif syn and syn.queue_on_teleport then
    syn.queue_on_teleport(src)
elseif fluxus and fluxus.queue_on_teleport then
    fluxus.queue_on_teleport(src)
end

local f = loadstring or load
if f then
    f(src)()
end
