-- FEDORA AC DETECTION
-- useful for sum

local pat = { ":Kick", ":Ban" }
local acw = { "anticheat", "anti cheat", "anti-cheat", "antiexploit", "anti exploit", "anti-exploit" }
local max = 200
local step = 10
local pause = 0.05

local list, seen = {}, {}
local function add(inst, src)
    if typeof(inst) ~= "Instance" or seen[inst] then return end
    local ok, hit = pcall(function()
        return inst:IsA("LocalScript") or inst:IsA("ModuleScript")
    end)
    if not ok or not hit then return end
    local okF, full = pcall(function() return inst:GetFullName() end)
    seen[inst] = true
    list[#list + 1] = {
        inst = inst,
        source = src,
        full = (okF and full or "?"):gsub("[\r\n\t]", " "),
    }
end

local ok, d = pcall(function() return game:GetDescendants() end)
if ok and d then for _, i in ipairs(d) do add(i, "tree") end end
if type(getnilinstances) == "function" then
    local ok2, a = pcall(getnilinstances)
    if ok2 and type(a) == "table" then for _, i in ipairs(a) do add(i, "nilinst") end end
end
if type(getloadedmodules) == "function" then
    local ok2, a = pcall(getloadedmodules)
    if ok2 and type(a) == "table" then for _, i in ipairs(a) do add(i, "loaded") end end
end

local function isac(name, full)
    local n = name:lower():gsub("[%s%-_]", "")
    if n == "ae" or n == "ac" or n == "anticheat" or n == "antiexploit" then return true end
    for seg in full:lower():gmatch("[^%.]+") do
        local s = seg:gsub("[%s%-_]", "")
        if s == "ae" or s == "ac" or s == "anticheat" or s == "antiexploit" then return true end
    end
    local f = full:lower()
    local nn = name:lower()
    for _, w in ipairs(acw) do
        if nn:find(w, 1, true) then return true end
        if f:find(w, 1, true) then return true end
    end
    return false
end

local cnt = { tree = 0, nilinst = 0, loaded = 0 }
local aclist, byname, det, tree = {}, {}, {}, {}
for _, e in ipairs(list) do
    cnt[e.source] = (cnt[e.source] or 0) + 1
    local okR, r = pcall(function() return e.inst:IsDescendantOf(game) end)
    e.rooted = okR and r or false
    local n = e.inst.Name:lower()
    if isac(e.inst.Name, e.full) then
        aclist[#aclist + 1] = e
    elseif n:find("kick", 1, true) or n:find("ban", 1, true) then
        byname[#byname + 1] = e
    elseif not e.rooted then
        det[#det + 1] = e
    else
        tree[#tree + 1] = e
    end
end

print(("[scan] %d scripts (tree=%d nil=%d loaded=%d)")
    :format(#list, cnt.tree, cnt.nilinst, cnt.loaded))
print(("[scan] ac=%d byname=%d det=%d tree=%d")
    :format(#aclist, #byname, #det, #tree))

local q, qs = {}, {}
local function push(arr)
    for _, e in ipairs(arr) do
        if not qs[e.inst] then
            qs[e.inst] = true
            q[#q + 1] = e
        end
    end
end
push(aclist)
push(byname)
push(det)
push(tree)

local function getsrc(inst)
    if type(decompile) ~= "function" then return nil end
    local ok, s = pcall(decompile, inst)
    if ok and type(s) == "string" and #s > 0 then return s end
    return nil
end

local kb, ac, n, bad = {}, {}, 0, 0

local function check(e)
    local ok, s = pcall(getsrc, e.inst)
    local is_ac = isac(e.inst.Name, e.full)
    local ctx = {}
    if ok and s then
        for line in s:gmatch("[^\n]+") do
            for _, p in ipairs(pat) do
                if line:find(p, 1, true) then
                    ctx[#ctx + 1] = { p = p, t = line:sub(1, 180) }
                    break
                end
            end
            if #ctx >= 8 then break end
        end
    else
        bad = bad + 1
    end
    local item = {
        cls = e.inst.ClassName,
        full = e.full,
        rooted = e.rooted,
        src = e.source,
        ctx = ctx,
        ok = (ok and s ~= nil),
    }
    if #ctx > 0 then kb[#kb + 1] = item end
    if is_ac then ac[#ac + 1] = item end
end

print(("[scan] decompiling %d/%d"):format(math.min(max, #q), #q))
for i, e in ipairs(q) do
    if n >= max then break end
    n = n + 1
    pcall(check, e)
    if i % step == 0 then
        print(("[scan] %d/%d kb=%d ac=%d"):format(i, math.min(#q, max), #kb, #ac))
        task.wait(pause)
    end
end

print(("\n[scan] done: tried=%d bad=%d kb=%d ac=%d"):format(n, bad, #kb, #ac))

local function show(title, arr)
    if #arr == 0 then return end
    print(("\n[scan] -- %s (%d) --"):format(title, #arr))
    for i, h in ipairs(arr) do
        local tag = h.rooted and "ROOTED" or "DETACHED"
        local u = h.ok and "" or " (unreadable)"
        print(("[%d] [%s] [%s] %s%s"):format(i, tag, h.cls, h.full, u))
        for _, m in ipairs(h.ctx) do
            print(("    [%s] > %s"):format(m.p, m.t))
        end
    end
end
show("AntiCheat", ac)
show("Kick/Ban", kb)

if type(writefile) == "function" then
    if type(isfolder) == "function" and type(makefolder) == "function" then
        if not isfolder("fedora") then makefolder("fedora") end
        if not isfolder("fedora/Detected") then makefolder("fedora/Detected") end
    end

    local function build(title, arr)
        local f = {}
        f[#f + 1] = title
        f[#f + 1] = os.date("%Y-%m-%d %H:%M:%S")
        f[#f + 1] = ("tried=%d bad=%d count=%d"):format(n, bad, #arr)
        f[#f + 1] = ""
        for i, h in ipairs(arr) do
            local tag = h.rooted and "ROOTED" or "DETACHED"
            local u = h.ok and "" or " (unreadable)"
            f[#f + 1] = ("[%d] [%s] %s [%s] src=%s%s")
                :format(i, tag, h.full, h.cls, h.src, u)
            for _, m in ipairs(h.ctx) do
                f[#f + 1] = ("    [%s] > %s"):format(m.p, m.t)
            end
            f[#f + 1] = ""
        end
        return table.concat(f, "\n")
    end

    local acpath = "fedora/Detected/anticheat.txt"
    local kbpath = "fedora/Detected/kickban.txt"

    local ok1 = pcall(writefile, acpath, build("AntiCheat matches", ac))
    local ok2 = pcall(writefile, kbpath, build("Kick/Ban matches", kb))

    print(ok1 and ("\n[scan] saved -> "..acpath) or "\n[scan] ac save failed")
    print(ok2 and ("[scan] saved -> "..kbpath) or "[scan] kb save failed")
end

_G.KICKBAN_SCRIPTS = kb
_G.ANTICHEAT_SCRIPTS = ac
