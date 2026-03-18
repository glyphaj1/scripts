-- [ 
--      Snowfall . cc UI     
--  ]


local repo = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"
local Library      = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager  = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- basic but effective ac bypass

local AntiDetection = {}
AntiDetection.RandomSeed = tick() * math.random(1000, 9999)

function AntiDetection:RandomDelay(min, max)
    min = min or 0.001
    max = max or 0.05
    local delay = min + (max - min) * math.random()
    task.wait(delay)
end

function AntiDetection:SafeCall(func, ...)
    self:RandomDelay(0.001, 0.01)
    local success, result = pcall(func, ...)
    if not success then
        task.wait(math.random(10, 50) / 1000)
    end
    return success, result
end

function AntiDetection:IsEnvironmentSafe()
    local checks = {
        function() return game:GetService("CoreGui") ~= nil end,
        function() return game:GetService("Players").LocalPlayer ~= nil end,
        function() return workspace.CurrentCamera ~= nil end,
    }
    for _, check in ipairs(checks) do
        if not pcall(check) then return false end
    end
    return true
end

local config = getgenv().SnowfallConfig or {}
local function cfgOr(v, def) return v ~= nil and v or def end

local SHOW_AIM_STATUS_TEXT     = cfgOr(config.SHOW_AIM_STATUS_TEXT,    true)
local SILENT_AIM_ENABLED       = false
local TRACER_ENABLED           = cfgOr(config.TRACER_ENABLED,           false)
local TRACER_COLOR             = config.TRACER_COLOR             or Color3.fromRGB(255, 50, 50)
local TRACER_THICKNESS         = config.TRACER_THICKNESS         or 1.5
local SILENT_AIM_KEY           = config.SILENT_AIM_KEY           or "E"
local SILENT_HIT_CHANCE        = config.SILENT_HIT_CHANCE        or 100
local SILENT_HIT_PART          = config.SILENT_HIT_PART          or "Head"
local AIMLOCK_KEY              = config.AIMLOCK_KEY              or "MouseButton2"
local AIMLOCK_SMOOTH           = config.AIMLOCK_SMOOTH           or 1
local AIMLOCK_FOV              = config.AIMLOCK_FOV              or 50
local AIMLOCK_PART             = config.AIMLOCK_PART             or "Head"
local AIMLOCK_FOV_TYPE         = config.AIMLOCK_FOV_TYPE         or "static"
local AIMLOCK_FOV_COLOR        = config.AIMLOCK_FOV_COLOR        or Color3.fromHex("64859d")
local ENABLE_AIMLOCK           = cfgOr(config.ENABLE_AIMLOCK,           false)
local ENABLE_TRIGGER_BOT       = cfgOr(config.ENABLE_TRIGGER_BOT,       false)
local TRIGGER_SHOOT_DELAY      = config.TRIGGER_SHOOT_DELAY      or 0.05

local ENABLE_ESP               = cfgOr(config.ENABLE_ESP,               false)
local ENABLE_LOCAL_PLAYER_ESP  = cfgOr(config.ENABLE_LOCAL_PLAYER_ESP,  false)
local ENABLE_2D_BOX_ESP        = cfgOr(config.ENABLE_2D_BOX_ESP,        false)
local ENABLE_AIM_VIEW          = cfgOr(config.ENABLE_AIM_VIEW,          false)
local ENABLE_HEALTHBAR_ESP     = cfgOr(config.ENABLE_HEALTHBAR_ESP,     false)
local ENABLE_DISTANCE_ESP      = cfgOr(config.ENABLE_DISTANCE_ESP,      false)
local ENABLE_SKELETON_ESP      = cfgOr(config.ENABLE_SKELETON_ESP,      false)
local ENABLE_CHAMS             = cfgOr(config.ENABLE_CHAMS,             false)
local CHAMS_COLOR              = config.CHAMS_COLOR              or Color3.fromRGB(138, 43, 226)
local CHAMS_TRANSPARENCY       = config.CHAMS_TRANSPARENCY       or 0.5
local ESP_MAX_DISTANCE         = config.ESP_MAX_DISTANCE         or 1000
local ESP_MODE                 = config.ESP_MODE                 or "performance"
local ESP_BOX_COLOR            = config.ESP_BOX_COLOR            or Color3.fromRGB(180, 100, 255)
local ESP_NAME_COLOR           = config.ESP_NAME_COLOR           or Color3.fromRGB(255, 255, 255)
local ESP_DIST_COLOR           = config.ESP_DIST_COLOR           or Color3.fromRGB(200, 200, 200)
local ESP_SKELETON_COLOR       = config.ESP_SKELETON_COLOR       or Color3.fromRGB(255, 105, 180)
local ENABLE_RAINBOW_MODE      = cfgOr(config.ENABLE_RAINBOW_MODE,      false)
local AIM_VIEW_DANGER_COLOR    = config.AIM_VIEW_DANGER_COLOR    or Color3.fromRGB(255, 0, 0)
local AIM_VIEW_SAFE_COLOR      = config.AIM_VIEW_SAFE_COLOR      or Color3.fromRGB(0, 255, 0)
local AIM_VIEW_LENGTH          = config.AIM_VIEW_LENGTH          or 10
local AIM_VIEW_THICKNESS       = config.AIM_VIEW_THICKNESS       or 1
local ESP_UPDATE_INTERVAL      = config.ESP_UPDATE_INTERVAL      or 0.001

local ENABLE_SPINBOT           = cfgOr(config.ENABLE_SPINBOT,           false)
local SPINBOT_KEY              = config.SPINBOT_KEY              or "F8"
local SPINBOT_SPEED            = config.SPINBOT_SPEED            or 100
local HVH_KEY                  = config.HVH_KEY                  or "H"

local USE_VELOCITY_SPEED       = cfgOr(config.USE_VELOCITY_SPEED,       true)
local VELOCITY_SPEED_VALUE     = config.VELOCITY_SPEED_VALUE     or 121
local WALKSPEED_VALUE          = config.WALKSPEED_VALUE          or 121
local DEFAULT_SPEED            = config.DEFAULT_SPEED            or 16
local SPEED_KEY                = config.SPEED_KEY                or "Q"
local ENABLE_NOCLIP            = cfgOr(config.ENABLE_NOCLIP,            false)
local NOCLIP_KEY               = config.NOCLIP_KEY               or "N"
local ENABLE_INFINITE_JUMP     = cfgOr(config.ENABLE_INFINITE_JUMP,     false)
local JUMP_POWER               = config.JUMP_POWER               or 50
local TARGET_FPS               = config.TARGET_FPS               or 1000

local EQUIP_KORBLOX            = cfgOr(config.EQUIP_KORBLOX,            false)
local EQUIP_HEADLESS           = cfgOr(config.EQUIP_HEADLESS,           false)
local EQUIP_SKOTN              = cfgOr(config.EQUIP_SKOTN,              false)
local TERMINATE_KEY            = config.TERMINATE_KEY            or "F3"
local SHOW_WATERMARK           = cfgOr(config.SHOW_WATERMARK,           true)

local YOUTUBE_LINK = "youtube.com/@vxo66"
local DISCORD_LINK = "discord.com/NCcTwpNQ2S"

pcall(function() setfpscap(TARGET_FPS) end)

local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace  = game:GetService("Workspace")
local Stats      = game:GetService("Stats")
local VIM        = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()
local Camera      = Workspace.CurrentCamera

local InternalRunning  = true
local HookKilled       = false
local SilentAimEnabled = false
local LockedTarget     = nil
local Connections      = {}
local SpeedEnabled     = false
local SpinbotEnabled   = false
local NoclipEnabled    = false
local LastTriggerShot  = 0
local AimlockActive    = false
local AimlockTarget    = nil
local AimlockIsKey     = false
local AimlockKeyCode   = nil
local AimlockMouseBtn  = nil
local lastESPUpdate    = 0
local espUpdateTick    = 0
local cachedLockedChar = nil
local cachedLockedHead = nil
local BangStates       = {}
local PlayerButtons    = {}

getgenv().ScriptRunning = true

local IS_DAHOOD              = false
local DaHoodOriginalNameCall = nil
local DaHoodOriginalNewIndex = nil
local IS_RIVALS              = false
local RivalsOriginalNameCall = nil
local _metaOldIndex          = nil
local _metaTable             = nil

do
    local ok, result = pcall(function()
        local gi = loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/TheRealXORA/Roblox/refs/heads/Main/Scripts%20/Utilities%20/Fetch%20Game%20Information.luau", true))()
        return gi and gi.Name and gi.Name:find("Da Hood") and true or false
    end)
    IS_DAHOOD = ok and result or false
end

do
    local ok, result = pcall(function()
        local id = game.PlaceId
        return id == 17625359962 or id == 16076472490
            or (game.Name and game.Name:lower():find("rivals") ~= nil)
    end)
    IS_RIVALS = ok and result or false
end

local tick        = tick
local math_min    = math.min
local math_max    = math.max
local math_huge   = math.huge
local math_rad    = math.rad
local math_floor  = math.floor
local math_sin    = math.sin
local math_pi     = math.pi
local math_random = math.random
local Vector2_new    = Vector2.new
local Vector3_new    = Vector3.new
local CFrame_new     = CFrame.new
local CFrame_Angles  = CFrame.Angles
local Color3_fromRGB = Color3.fromRGB

local rainbowHue = 0
local function GetRainbowColor()
    rainbowHue = (rainbowHue + 0.005) % 1
    local r = math_floor(math_sin(rainbowHue * math_pi * 2) * 127 + 128)
    local g = math_floor(math_sin((rainbowHue + 0.33) * math_pi * 2) * 127 + 128)
    local b = math_floor(math_sin((rainbowHue + 0.66) * math_pi * 2) * 127 + 128)
    return Color3_fromRGB(r, g, b)
end

-- ═══════════════════════════════════════════════════════════════
--         DA HOOD HOOKS - MINIMAL VERSION (BYPASS DETECTOR)
-- ═══════════════════════════════════════════════════════════════

if IS_DAHOOD then
    task.spawn(function()
        AntiDetection:RandomDelay(2, 4)  -- Longer delay
        
        if not AntiDetection:IsEnvironmentSafe() then
            warn("[Snowfall] Skipping Da Hood hooks - environment unsafe")
            return
        end
        
        warn("[Snowfall] Da Hood detected - using minimal hooks only")
        
        pcall(function()
            task.wait(math.random(100, 300) / 100)
            
            DaHoodOriginalNameCall = hookmetamethod(game, "__namecall", newcclosure(function(Object, ...)
                local Method = getnamecallmethod()
                
                if not checkcaller() and Method == "Kick" then
                    if Object == Players.LocalPlayer or Object == LocalPlayer then
                        warn("[Snowfall] Blocked kick attempt")
                        return wait(9e9)  -- Infinite wait
                    end
                end
                
                return DaHoodOriginalNameCall(Object, ...)
            end))
            
            warn("[Snowfall] Kick protection enabled")
        end)
    end)
end

local AimStatusText           = nil
local _aimStatusDismissHandle = nil

do
    local ok, t = pcall(function()
        local d        = Drawing.new("Text")
        d.Visible      = false
        d.Center       = true
        d.Outline      = true
        d.Font         = 2
        d.Size         = 18
        d.Color        = Color3_fromRGB(200, 150, 255)
        d.Transparency = 1
        d.Position     = Vector2_new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 - 60)
        return d
    end)
    AimStatusText = ok and t or nil
end

local function ShowAimStatus(msg)
    if not SHOW_AIM_STATUS_TEXT or not AimStatusText then return end
    AimStatusText.Visible  = false
    local token = {}
    _aimStatusDismissHandle = token
    AimStatusText.Position = Vector2_new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 - 60)
    AimStatusText.Text     = msg
    AimStatusText.Visible  = true
    task.delay(2, function()
        if _aimStatusDismissHandle == token and AimStatusText then
            AimStatusText.Visible = false
        end
    end)
end

local _keyAliases = {
    LEFTCONTROL  = "LeftControl",  RIGHTCONTROL = "RightControl",
    LEFTSHIFT    = "LeftShift",    RIGHTSHIFT   = "RightShift",
    LEFTALT      = "LeftAlt",      RIGHTALT     = "RightAlt",
}

local function StringToKeyCode(keyString)
    if not keyString or type(keyString) ~= "string" or keyString == "" then return Enum.KeyCode.F1 end
    local upper = string.upper(keyString)
    local ok, res = pcall(function() return Enum.KeyCode[upper] end)
    if ok and res then return res end
    local alias = _keyAliases[upper]
    if alias then
        ok, res = pcall(function() return Enum.KeyCode[alias] end)
        if ok and res then return res end
    end
    return Enum.KeyCode.F1
end

local cachedTerminateKey = StringToKeyCode(TERMINATE_KEY)
local cachedSilentAimKey = StringToKeyCode(SILENT_AIM_KEY)
local cachedSpeedKey     = StringToKeyCode(SPEED_KEY)
local cachedSpinbotKey   = StringToKeyCode(SPINBOT_KEY)
local cachedHvHKey       = StringToKeyCode(HVH_KEY)
local cachedNoclipKey    = StringToKeyCode(NOCLIP_KEY)

local function RefreshKeycodeCache()
    cachedTerminateKey = StringToKeyCode(TERMINATE_KEY)
    cachedSilentAimKey = StringToKeyCode(SILENT_AIM_KEY)
    cachedSpeedKey     = StringToKeyCode(SPEED_KEY)
    cachedSpinbotKey   = StringToKeyCode(SPINBOT_KEY)
    cachedHvHKey       = StringToKeyCode(HVH_KEY)
    cachedNoclipKey    = StringToKeyCode(NOCLIP_KEY)
end

local function RefreshAimlockBind()
    local upper = type(AIMLOCK_KEY) == "string" and string.upper(AIMLOCK_KEY) or ""
    if upper == "MOUSEBUTTON2" then
        AimlockIsKey = false; AimlockMouseBtn = Enum.UserInputType.MouseButton2; AimlockKeyCode = nil
    elseif upper == "MOUSEBUTTON1" then
        AimlockIsKey = false; AimlockMouseBtn = Enum.UserInputType.MouseButton1; AimlockKeyCode = nil
    else
        AimlockIsKey = true; AimlockKeyCode = StringToKeyCode(AIMLOCK_KEY); AimlockMouseBtn = nil
    end
end
RefreshAimlockBind()

local function SetCfg(key, val)
    getgenv().SnowfallConfig = getgenv().SnowfallConfig or {}
    getgenv().SnowfallConfig[key] = val
end

local function ApplyCosmetics()
    local char = LocalPlayer.Character
    if not char then return end
    task.spawn(function()
        pcall(function()
            if EQUIP_KORBLOX then
                local rf  = char:FindFirstChild("RightFoot")
                local rll = char:FindFirstChild("RightLowerLeg")
                local rul = char:FindFirstChild("RightUpperLeg")
                if rf  then rf.MeshId  = "http://www.roblox.com/asset/?id=902942089"; rf.Transparency  = 1 end
                if rll then rll.MeshId = "http://www.roblox.com/asset/?id=902942093"; rll.Transparency = 1 end
                if rul then
                    rul.MeshId    = "http://www.roblox.com/asset/?id=902942096"
                    rul.TextureID = "http://roblox.com/asset/?id=902843398"
                end
            end
            if EQUIP_HEADLESS then
                local head = char:FindFirstChild("Head")
                if head then head.Transparency = 1 end
            end
            if EQUIP_SKOTN then
                local ok2, hat = pcall(function() return game:GetObjects("rbxassetid://439945661")[1] end)
                if ok2 and hat and char:FindFirstChild("Head") then
                    hat.Parent = char
                    local base = hat:FindFirstChildWhichIsA("BasePart")
                    if base then
                        local weld  = Instance.new("Weld")
                        weld.Part0  = char.Head
                        weld.Part1  = base
                        weld.C0     = CFrame_new(0, 0.5, 0)
                        weld.Parent = char.Head
                    end
                end
            end
        end)
    end)
end

local Tracer
do
    local ok, t = pcall(function()
        local line = Drawing.new("Line")
        line.Visible = false; line.Color = TRACER_COLOR
        line.Thickness = TRACER_THICKNESS; line.Transparency = 1
        return line
    end)
    Tracer = ok and t or nil
end

local function SetTracerVisible(v)
    if Tracer then Tracer.Visible = v end
end

local FOVCircle = nil
do
    local ok, t = pcall(function()
        local c = Drawing.new("Circle")
        c.Visible = false; c.Color = AIMLOCK_FOV_COLOR
        c.Thickness = 1; c.Radius = AIMLOCK_FOV; c.Filled = false; c.Transparency = 0.8
        c.Position = Vector2_new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        return c
    end)
    FOVCircle = ok and t or nil
end

local NameESP     = {}
local BoxESP      = {}
local DistESP     = {}
local SkeletonESP = {}
local ChamsESP    = {}
local AimViewBeams = {}
local ESPCache    = {}

local SKELETON_CONNECTIONS = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
}

local visRayParams = RaycastParams.new()
visRayParams.IgnoreWater = true
visRayParams.FilterType  = Enum.RaycastFilterType.Exclude
local _visFilterChar = nil

local function IsVisible(targetPart)
    if not targetPart then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local head = char:FindFirstChild("Head")
    if not head then return false end
    if _visFilterChar ~= char then
        _visFilterChar = char
        visRayParams.FilterDescendantsInstances = {char, Camera}
    end
    local dir = targetPart.Position - head.Position
    local hit = Workspace:Raycast(head.Position, dir, visRayParams)
    return hit == nil or hit.Instance:IsDescendantOf(targetPart.Parent)
end

local function HasForceField(character)
    return character and character:FindFirstChildOfClass("ForceField") ~= nil
end

local _playerListCache       = {}
local _playerListLastRefresh = 0
local PLAYER_LIST_TTL        = 0.5

local function GetCachedPlayers()
    local now = tick()
    if now - _playerListLastRefresh >= PLAYER_LIST_TTL then
        _playerListLastRefresh = now
        _playerListCache       = Players:GetPlayers()
    end
    return _playerListCache
end

local function GetClosestPlayerInFOV(fovRadius)
    local ok, result = pcall(function()
        local closest  = nil
        local shortest = math_huge
        local cx, cy
        if AIMLOCK_FOV_TYPE == "dynamic" then
            local mpos = UIS:GetMouseLocation()
            cx = mpos.X; cy = mpos.Y
        else
            cx = Camera.ViewportSize.X / 2; cy = Camera.ViewportSize.Y / 2
        end
        local fovSq = fovRadius * fovRadius
        for _, plr in ipairs(GetCachedPlayers()) do
            if plr == LocalPlayer or not plr.Character or not plr.Parent then continue end
            local char = plr.Character
            if not char.Parent then continue end
            
            local partName = AIMLOCK_PART == "HRP" and "HumanoidRootPart" or AIMLOCK_PART
            local target = char:FindFirstChild(partName) or char:FindFirstChild("Head")
            if not target or not target.Parent then continue end
            
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or not hum.Parent or hum.Health <= 0 then continue end
            if HasForceField(char) then continue end
            
            local pos, onscreen = Camera:WorldToViewportPoint(target.Position)
            if onscreen then
                local dx = pos.X - cx
                local dy = pos.Y - cy
                local d2 = dx*dx + dy*dy
                if d2 < fovSq and d2 < shortest then shortest = d2; closest = plr end
            end
        end
        return closest
    end)
    return ok and result or nil
end

local function GetClosestPlayer()
    local ok, result = pcall(function()
        local closest  = nil
        local shortest = math_huge
        if not Mouse then return nil end
        local mx, my = Mouse.X, Mouse.Y
        if not mx or not my then return nil end
        
        for _, plr in ipairs(GetCachedPlayers()) do
            if plr == LocalPlayer or not plr.Character or not plr.Parent then continue end
            local head = plr.Character:FindFirstChild("Head")
            if not head or not head.Parent then continue end
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if not hum or not hum.Parent or hum.Health <= 0 then continue end
            if HasForceField(plr.Character) then continue end
            
            local pos, onscreen = Camera:WorldToViewportPoint(head.Position)
            if onscreen then
                local dx = pos.X - mx
                local dy = pos.Y - my
                local d2 = dx*dx + dy*dy
                if d2 < shortest then shortest = d2; closest = plr end
            end
        end
        return closest
    end)
    return ok and result or nil
end

local TRIGGER_HOVER_THRESH_SQ = 60 * 60

local function GetPlayerUnderCursor()
    local ok, result = pcall(function()
        if not Mouse then return nil end
        local mx, my = Mouse.X, Mouse.Y
        if not mx or not my then return nil end
        
        local bestPlr, bestDist = nil, math_huge
        for _, plr in ipairs(GetCachedPlayers()) do
            if plr == LocalPlayer or not plr.Parent then continue end
            local char = plr.Character
            if not char or not char.Parent then continue end
            if HasForceField(char) then continue end
            
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or not hum.Parent or hum.Health <= 0 then continue end
            
            local minD2 = math_huge
            local head = char:FindFirstChild("Head")
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            
            if head and head.Parent then
                local pos, on = Camera:WorldToViewportPoint(head.Position)
                if on then
                    local dx = pos.X - mx; local dy = pos.Y - my
                    local d2 = dx*dx + dy*dy
                    if d2 < minD2 then minD2 = d2 end
                end
            end
            if hrp and hrp.Parent then
                local pos, on = Camera:WorldToViewportPoint(hrp.Position)
                if on then
                    local dx = pos.X - mx; local dy = pos.Y - my
                    local d2 = dx*dx + dy*dy
                    if d2 < minD2 then minD2 = d2 end
                end
            end
            if minD2 <= TRIGGER_HOVER_THRESH_SQ and minD2 < bestDist then
                bestDist = minD2; bestPlr = plr
            end
        end
        return bestPlr
    end)
    return ok and result or nil
end

local function GetCharacterBounds(char)
    if not char then return nil, nil end
    local head = char:FindFirstChild("Head")
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil, nil end
    local topY = head and (head.Position.Y + head.Size.Y * 0.5)
                       or (hrp.Position.Y  + hrp.Size.Y  * 0.5 + 1.5)
    local botY = hrp.Position.Y - hrp.Size.Y * 0.5 - 0.5
    return topY, botY
end

-- ═══════════════════════════════════════════════════════════════
--         RIVALS HOOKS - DISABLED (BYPASS DETECTOR)
-- ═══════════════════════════════════════════════════════════════

if IS_RIVALS then
    warn("[Snowfall] Rivals detected - hooks DISABLED to bypass detector")
    warn("[Snowfall] Use Aimlock feature instead - works without hooks")
    -- NO HOOKS for Rivals - use camera-based aiming only
end

Connections[#Connections + 1] = Players.PlayerAdded:Connect(function()   _playerListLastRefresh = 0 end)
Connections[#Connections + 1] = Players.PlayerRemoving:Connect(function()
    _playerListLastRefresh = 0
end)

local function ResetMovementDefaults()
    SpeedEnabled       = false
    NoclipEnabled      = false
    ENABLE_NOCLIP      = false
    ENABLE_INFINITE_JUMP = false
    USE_VELOCITY_SPEED = true
    VELOCITY_SPEED_VALUE = 121
    WALKSPEED_VALUE    = 121
    DEFAULT_SPEED      = 16
    JUMP_POWER         = 50
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed  = DEFAULT_SPEED
                hum.JumpPower  = 50
                hum.AutoRotate = true
            end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = true end)
                end
            end
        end
    end)
end

local function Cleanup()
    warn("[Snowfall] Starting cleanup process...")
    
    InternalRunning         = false
    HookKilled              = true
    getgenv().ScriptRunning = false
    _aimStatusDismissHandle = nil
    SilentAimEnabled = false; LockedTarget   = nil
    SpeedEnabled     = false; SpinbotEnabled = false
    NoclipEnabled  = false
    AimlockActive    = false; AimlockTarget  = nil
    
    ENABLE_ESP = false
    ENABLE_2D_BOX_ESP = false
    ENABLE_HEALTHBAR_ESP = false
    ENABLE_DISTANCE_ESP = false
    ENABLE_SKELETON_ESP = false
    ENABLE_CHAMS = false
    ENABLE_LOCAL_PLAYER_ESP = false
    ENABLE_AIM_VIEW = false
    ENABLE_RAINBOW_MODE = false
    SILENT_AIM_ENABLED = false
    ENABLE_AIMLOCK = false
    ENABLE_TRIGGER_BOT = false
    ENABLE_SPINBOT = false
    
    for plr, state in pairs(BangStates) do
        if state.active then
            state.active = false
            if state.connection then
                state.connection:Disconnect()
            end
            pcall(function()
                local localChar = LocalPlayer.Character
                if localChar and state.originalPos then
                    local localHRP = localChar:FindFirstChild("HumanoidRootPart")
                    if localHRP then
                        localHRP.CFrame = state.originalPos
                    end
                end
            end)
        end
    end
    BangStates = {}

    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = DEFAULT_SPEED; hum.AutoRotate = true; hum.JumpPower = 50 end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = true end)
                end
            end
        end
    end)

    pcall(function()
        if _metaTable and _metaOldIndex then
            warn("[Snowfall] No metamethod hooks to clean up")
        end
    end)

    pcall(function()
        if IS_DAHOOD then
            if DaHoodOriginalNameCall then pcall(hookmetamethod, game, "__namecall", DaHoodOriginalNameCall) end
            if DaHoodOriginalNewIndex then pcall(hookmetamethod, game, "__newindex", DaHoodOriginalNewIndex) end
        end
    end)

    pcall(function()
        if IS_RIVALS and RivalsOriginalNameCall then
            local RS = game:GetService("ReplicatedStorage")
            local utilityModule = RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("Utility")
            if utilityModule then
                local ok2, utility = pcall(require, utilityModule)
                if ok2 and utility and type(utility.Raycast) == "function" then
                    utility.Raycast = RivalsOriginalNameCall
                end
            end
            RivalsOriginalNameCall = nil
        end
    end)

    if Tracer        then pcall(function() Tracer.Visible = false;        Tracer:Remove()        end); Tracer        = nil end
    if AimStatusText then pcall(function() AimStatusText.Visible = false; AimStatusText:Remove() end); AimStatusText = nil end
    if FOVCircle     then pcall(function() FOVCircle.Visible = false;     FOVCircle:Remove()     end); FOVCircle     = nil end

    for _, txt  in pairs(NameESP)  do pcall(function() txt.Visible  = false; txt:Remove()  end) end
    for _, dtxt in pairs(DistESP)  do pcall(function() dtxt.Visible = false; dtxt:Remove() end) end
    NameESP = {}; DistESP = {}; ESPCache = {}

    for _, plrSkel in pairs(SkeletonESP) do
        for _, line in pairs(plrSkel) do pcall(function() line.Visible = false; line:Remove() end) end
    end
    SkeletonESP = {}

    for _, box in pairs(BoxESP) do
        for _, line in pairs(box) do pcall(function() line.Visible = false; line:Remove() end) end
    end
    BoxESP = {}
    
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            if RemoveChamsFromPlayer then
                RemoveChamsFromPlayer(plr)
            end
        end)
    end
    ChamsESP = {}

    for _, beamData in pairs(AimViewBeams) do
        if beamData then
            pcall(function() if beamData.line then beamData.line.Visible = false; beamData.line:Remove() end end)
            pcall(function() if beamData.charConnection then beamData.charConnection:Disconnect() end end)
        end
    end
    AimViewBeams = {}

    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    Connections = {}

    pcall(function() 
        if Library and Library.Unload then
            Library:Unload() 
        end
    end)
    
    pcall(function() 
        if SilentAimHooks and SilentAimHooks.Uninstall then
            SilentAimHooks:Uninstall()
        end
    end)
    
    getgenv().SnowfallConfig = nil
    getgenv().ScriptRunning = nil
    
    pcall(function()
        for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
            if obj.Name and (obj.Name:find("Linoria") or obj.Name:find("ScreenGui")) then
                obj:Destroy()
            end
        end
    end)
    
    warn("[Snowfall] All settings reset to default, script completely terminated and destroyed")
    
    pcall(function()
        script:Destroy()
    end)
end

local function CreateESPForPlayer(plr)
    if NameESP[plr] then return end
    if plr == LocalPlayer and not ENABLE_LOCAL_PLAYER_ESP then return end
    local success = pcall(function()
        if not NameESP[plr] then
            local text = Drawing.new("Text")
            text.Size = 14; text.Color = ESP_NAME_COLOR; text.Center = true
            text.Outline = true; text.Visible = false; text.Font = 2; text.Transparency = 1
            NameESP[plr] = text
        end
    end)
    if not success then
        task.wait(0.05)
        pcall(function()
            if not NameESP[plr] then
                local text = Drawing.new("Text")
                text.Size = 14; text.Color = ESP_NAME_COLOR; text.Center = true
                text.Outline = true; text.Visible = false; text.Font = 2; text.Transparency = 1
                NameESP[plr] = text
            end
        end)
    end
    pcall(function()
        if not DistESP[plr] then
            local dtxt = Drawing.new("Text")
            dtxt.Size = 12; dtxt.Color = ESP_DIST_COLOR; dtxt.Center = true
            dtxt.Outline = true; dtxt.Visible = false; dtxt.Font = 2; dtxt.Transparency = 1
            DistESP[plr] = dtxt
        end
    end)
end

local function CreateBoxESPForPlayer(plr)
    if BoxESP[plr] then return end
    if plr == LocalPlayer and not ENABLE_LOCAL_PLAYER_ESP then return end
    local success = pcall(function()
        if not BoxESP[plr] then
            local box = {}
            for i = 1, 4 do
                local line = Drawing.new("Line")
                line.Visible = false; line.Color = ESP_BOX_COLOR; line.Thickness = 1; line.Transparency = 1
                box[i] = line
            end
            local hbar = Drawing.new("Line")
            hbar.Visible = false; hbar.Color = Color3_fromRGB(0,255,0); hbar.Thickness = 2; hbar.Transparency = 1
            box[5] = hbar
            BoxESP[plr] = box
        end
    end)
    if not success then
        task.wait(0.05)
        pcall(function()
            if not BoxESP[plr] then
                local box = {}
                for i = 1, 4 do
                    local line = Drawing.new("Line")
                    line.Visible = false; line.Color = ESP_BOX_COLOR; line.Thickness = 1; line.Transparency = 1
                    box[i] = line
                end
                local hbar = Drawing.new("Line")
                hbar.Visible = false; hbar.Color = Color3_fromRGB(0,255,0); hbar.Thickness = 2; hbar.Transparency = 1
                box[5] = hbar
                BoxESP[plr] = box
            end
        end)
    end
end

local function CreateSkeletonESPForPlayer(plr)
    if SkeletonESP[plr] then return end
    if plr == LocalPlayer and not ENABLE_LOCAL_PLAYER_ESP then return end
    local success = pcall(function()
        if not SkeletonESP[plr] then
            local lines = {}
            for i = 1, #SKELETON_CONNECTIONS do
                local line = Drawing.new("Line")
                line.Visible = false; line.Color = ESP_BOX_COLOR; line.Thickness = 1; line.Transparency = 1
                lines[i] = line
            end
            SkeletonESP[plr] = lines
        end
    end)
    if not success then
        task.wait(0.05)
        pcall(function()
            if not SkeletonESP[plr] then
                local lines = {}
                for i = 1, #SKELETON_CONNECTIONS do
                    local line = Drawing.new("Line")
                    line.Visible = false; line.Color = ESP_BOX_COLOR; line.Thickness = 1; line.Transparency = 1
                    lines[i] = line
                end
                SkeletonESP[plr] = lines
            end
        end)
    end
end

local function CreateChamsForPlayer(plr)
    if ChamsESP[plr] then return end
    if plr == LocalPlayer and not ENABLE_LOCAL_PLAYER_ESP then return end
    local success = pcall(function()
        if not ChamsESP[plr] then
            ChamsESP[plr] = {}
        end
    end)
    if not success then
        task.wait(0.05)
        pcall(function()
            if not ChamsESP[plr] then
                ChamsESP[plr] = {}
            end
        end)
    end
end

local function ApplyChamsToCharacter(plr)
    if not ENABLE_CHAMS then return end
    if not plr or not plr.Parent then return end
    if plr == LocalPlayer and not ENABLE_LOCAL_PLAYER_ESP then return end
    
    pcall(function()
        if not ChamsESP[plr] then 
            ChamsESP[plr] = { highlights = {} }
        else
            ChamsESP[plr].highlights = ChamsESP[plr].highlights or {}
        end
        
        local char = plr.Character
        if not char or not char.Parent then return end
        
        -- Use rainbow color if gay ESP is enabled, otherwise use selected color
        local chamColor = ENABLE_RAINBOW_MODE and GetRainbowColor() or CHAMS_COLOR
        
        for _, part in ipairs(char:GetDescendants()) do
            if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Name ~= "HumanoidRootPart" then
                local existingHighlight = part:FindFirstChild("SnowfallCham")
                if existingHighlight then
                    existingHighlight.FillColor = chamColor
                    existingHighlight.OutlineColor = chamColor
                    existingHighlight.FillTransparency = CHAMS_TRANSPARENCY
                    existingHighlight.OutlineTransparency = 0
                else
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "SnowfallCham"
                    highlight.Adornee = part
                    highlight.FillColor = chamColor
                    highlight.OutlineColor = chamColor
                    highlight.FillTransparency = CHAMS_TRANSPARENCY
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = part
                    
                    table.insert(ChamsESP[plr].highlights, highlight)
                end
            end
        end
    end)
end

local function RemoveChamsFromPlayer(plr)
    if not plr then return end
    
    pcall(function()
        if ChamsESP[plr] and ChamsESP[plr].highlights then
            for _, highlight in ipairs(ChamsESP[plr].highlights) do
                pcall(function() highlight:Destroy() end)
            end
            ChamsESP[plr].highlights = {}
        end
        
        local char = plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    local highlight = part:FindFirstChild("SnowfallCham")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end)
end

local function InitAllESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if not NameESP[plr] then CreateESPForPlayer(plr) end
        if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
        if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
        if not ChamsESP[plr] then CreateChamsForPlayer(plr) end
        if plr.Character and ENABLE_CHAMS then ApplyChamsToCharacter(plr) end
        if plr.Character then
            task.spawn(function()
                task.wait(0.15)
                if not NameESP[plr] then CreateESPForPlayer(plr) end
                if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
                if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
                if not ChamsESP[plr] then CreateChamsForPlayer(plr) end
                if ENABLE_CHAMS then ApplyChamsToCharacter(plr) end
            end)
        end
    end
    if ENABLE_LOCAL_PLAYER_ESP then
        if not NameESP[LocalPlayer] then CreateESPForPlayer(LocalPlayer) end
        if not BoxESP[LocalPlayer] then CreateBoxESPForPlayer(LocalPlayer) end
        if not SkeletonESP[LocalPlayer] then CreateSkeletonESPForPlayer(LocalPlayer) end
        if not ChamsESP[LocalPlayer] then CreateChamsForPlayer(LocalPlayer) end
        if ENABLE_CHAMS and LocalPlayer.Character then ApplyChamsToCharacter(LocalPlayer) end
    end
end
InitAllESP()

task.spawn(function()
    task.wait(2)
    InitAllESP()
end)

local _espCreationTick = 0
Connections[#Connections + 1] = RunService.Heartbeat:Connect(function()
    if not InternalRunning then return end
    -- Only check for missing ESP objects every 2 seconds, not every frame
    local now2 = tick()
    if now2 - _espCreationTick < 2 then return end
    _espCreationTick = now2
    if not (ENABLE_ESP or ENABLE_2D_BOX_ESP or ENABLE_SKELETON_ESP) then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
            if not NameESP[plr] then CreateESPForPlayer(plr) end
            if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
            if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
            if ENABLE_CHAMS and not ChamsESP[plr] then
                CreateChamsForPlayer(plr)
                if plr.Character then ApplyChamsToCharacter(plr) end
            end
        end
    end
end)

Connections[#Connections + 1] = Players.PlayerAdded:Connect(function(plr)
    task.wait(0.15)
    if not NameESP[plr] then CreateESPForPlayer(plr) end
    if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
    if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
    if not ChamsESP[plr] then CreateChamsForPlayer(plr) end
    if plr.Character then
        task.wait(0.15)
        if not NameESP[plr] then CreateESPForPlayer(plr) end
        if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
        if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
        if not ChamsESP[plr] then CreateChamsForPlayer(plr) end
        if ENABLE_CHAMS then ApplyChamsToCharacter(plr) end
    end
    plr.CharacterAdded:Connect(function()
        task.wait(0.15)
        if not NameESP[plr] then CreateESPForPlayer(plr) end
        if not BoxESP[plr] then CreateBoxESPForPlayer(plr) end
        if not SkeletonESP[plr] then CreateSkeletonESPForPlayer(plr) end
        if not ChamsESP[plr] then CreateChamsForPlayer(plr) end
        if ENABLE_CHAMS then ApplyChamsToCharacter(plr) end
    end)
end)

Connections[#Connections + 1] = Players.PlayerRemoving:Connect(function(plr)
    if plr == LocalPlayer then return end
    local txt  = NameESP[plr];  if txt  then pcall(function() txt:Remove()  end); NameESP[plr]     = nil end
    local dtxt = DistESP[plr];  if dtxt then pcall(function() dtxt:Remove() end); DistESP[plr]     = nil end
    local box  = BoxESP[plr]
    if box then for _, line in pairs(box) do pcall(function() line:Remove() end) end; BoxESP[plr]   = nil end
    local skel = SkeletonESP[plr]
    if skel then for _, line in pairs(skel) do pcall(function() line:Remove() end) end; SkeletonESP[plr] = nil end
    RemoveChamsFromPlayer(plr)
    ChamsESP[plr] = nil
    ESPCache[plr] = nil
end)

do
    local function CreateAimViewBeam(plr)
        if AimViewBeams[plr] or plr == LocalPlayer then return end
        local beamData = { line = nil, player = plr, character = nil, charConnection = nil }
        local function setupBeam(char)
            if not char then return end
            pcall(function()
                if beamData.line then beamData.line:Remove(); beamData.line = nil end
                local head = char:WaitForChild("Head", 5)
                if not head then return end
                local line = Drawing.new("Line")
                line.Visible = false; line.Color = AIM_VIEW_SAFE_COLOR
                line.Thickness = AIM_VIEW_THICKNESS; line.Transparency = 1
                beamData.line = line; beamData.character = char
            end)
        end
        if plr.Character then setupBeam(plr.Character) end
        beamData.charConnection = plr.CharacterAdded:Connect(setupBeam)
        AimViewBeams[plr] = beamData
    end
    for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then CreateAimViewBeam(plr) end end
    Connections[#Connections + 1] = Players.PlayerAdded:Connect(function(plr)
        if plr ~= LocalPlayer then CreateAimViewBeam(plr) end
    end)
    Connections[#Connections + 1] = Players.PlayerRemoving:Connect(function(plr)
        local bd = AimViewBeams[plr]
        if bd then
            pcall(function() if bd.line then bd.line:Remove() end end)
            pcall(function() if bd.charConnection then bd.charConnection:Disconnect() end end)
            AimViewBeams[plr] = nil
        end
    end)
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║          DUAL SILENT AIM SYSTEM - SEMI-UD & FULL-UD          ║
-- ║     Professional Implementation with Method Selection         ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- ═══════════════════════════════════════════════════════════════
--              METHOD 1: SEMI-UD (Hook-Based)
--              Higher accuracy, smoother, slight detection risk
-- ═══════════════════════════════════════════════════════════════

local SemiUDSilentAim = {
    Installed = false,
    OriginalIndex = nil,
}

function SemiUDSilentAim:Install()
    if self.Installed then return true end
    
    local success = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then error("Cannot get metatable") end
        
        local oldIndex = rawget(mt, "__index")
        if not oldIndex then oldIndex = mt.__index end
        
        self.OriginalIndex = oldIndex
        _metaOldIndex = oldIndex
        _metaTable = mt
        
        local makeWritable = setreadonly or make_writeable or set_readonly
        if not makeWritable then error("No setreadonly function") end
        if not pcall(makeWritable, mt, false) then error("Cannot make metatable writable") end

        local _saLastTarget   = nil
        local _saLastChar     = nil
        local _saLastPart     = nil
        local _saLastPartName = nil
        local _saThisShot     = false

        mt.__index = newcclosure(function(self, key)
            if HookKilled or not SilentAimEnabled or self ~= Mouse then
                return oldIndex(self, key)
            end
            if key ~= "Hit" and key ~= "Target" then
                return oldIndex(self, key)
            end
            if key == "Hit" then
                _saThisShot = math_random(1, 100) <= SILENT_HIT_CHANCE
            end
            if not _saThisShot then return oldIndex(self, key) end
            local resolvedTarget = (TRACER_ENABLED and LockedTarget) or GetClosestPlayer()
            if not resolvedTarget then return oldIndex(self, key) end
            local Character = resolvedTarget.Character
            if not Character then return oldIndex(self, key) end
            local targetPart
            if resolvedTarget == _saLastTarget and Character == _saLastChar
                and SILENT_HIT_PART == _saLastPartName and _saLastPart and _saLastPart.Parent then
                targetPart = _saLastPart
            else
                if SILENT_HIT_PART == "Head" then
                    targetPart = Character:FindFirstChild("Head")
                elseif SILENT_HIT_PART == "Torso" then
                    targetPart = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
                elseif SILENT_HIT_PART == "HumanoidRootPart" or SILENT_HIT_PART == "HRP" then
                    targetPart = Character:FindFirstChild("HumanoidRootPart")
                else
                    targetPart = Character:FindFirstChild("Head")
                end
                _saLastTarget = resolvedTarget; _saLastChar = Character
                _saLastPart = targetPart; _saLastPartName = SILENT_HIT_PART
            end
            if not targetPart then return oldIndex(self, key) end
            if key == "Hit"    then return CFrame_new(targetPart.Position) end
            if key == "Target" then return targetPart end
            return oldIndex(self, key)
        end)

        pcall(makeWritable, mt, true)
        self.Installed = true
    end)
    
    return success
end

function SemiUDSilentAim:Uninstall()
    if not self.Installed then return end
    
    pcall(function()
        if _metaTable and self.OriginalIndex then
            local makeWritable = setreadonly or make_writeable or set_readonly
            pcall(makeWritable, _metaTable, false)
            rawset(_metaTable, "__index", self.OriginalIndex)
            pcall(makeWritable, _metaTable, true)
        end
    end)
    
    self.Installed = false
    self.OriginalIndex = nil
    _metaTable = nil
    _metaOldIndex = nil
    warn("[Snowfall] Semi-UD Silent Aim uninstalled")
end

-- ═══════════════════════════════════════════════════════════════
--              METHOD 2: FULL-UD (Camera Flicker)
--              ELITE MOVEMENT PREDICTION - 100% accuracy
-- ═══════════════════════════════════════════════════════════════

local FullUDSilentAim = {
    Enabled = false,
    Connections = {},
    FlickerDuration = 0.01,
    IsFlickering = false,
    -- Advanced prediction cache
    TargetHistory = {},
}

function FullUDSilentAim:GetTargetOnClick()
    if TRACER_ENABLED and LockedTarget and LockedTarget.Parent then
        local char = LockedTarget.Character
        if char and char.Parent then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Parent and hum.Health > 0 then
                local head = char:FindFirstChild("Head")
                if head and head.Parent then
                    return head, LockedTarget
                end
            end
        end
    end
    
    local closest = GetClosestPlayer()
    if closest and closest.Parent and closest.Character and closest.Character.Parent then
        local hum = closest.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Parent and hum.Health > 0 then
            local head = closest.Character:FindFirstChild("Head")
            if head and head.Parent then
                return head, closest
            end
        end
    end
    
    return nil, nil
end

function FullUDSilentAim:PredictTargetPosition(targetHead, targetPlayer)
    if not targetHead or not targetHead.Parent then return targetHead.Position end
    
    local char = targetHead.Parent
    if not char or not char.Parent then return targetHead.Position end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not hrp.Parent or not hum or not hum.Parent then return targetHead.Position end
    
    local localChar = LocalPlayer.Character
    local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
    if not localHRP or not localHRP.Parent then return targetHead.Position end
    
    -- Calculate distance and time to hit
    local distance = (hrp.Position - localHRP.Position).Magnitude
    if distance <= 0 then return targetHead.Position end
    
    local bulletSpeed = 2000
    local timeToHit = distance / bulletSpeed
    
    -- Get velocity safely
    local velocity = Vector3_new(0, 0, 0)
    pcall(function()
        velocity = hrp.AssemblyLinearVelocity
    end)
    local speed = velocity.Magnitude
    
    local predictedPos = targetHead.Position
    
    -- Velocity prediction
    if speed > 0.3 then
        local velocityPrediction = velocity * timeToHit * 1.15
        predictedPos = predictedPos + velocityPrediction
    end
    
    -- Movement direction prediction
    if hum.MoveDirection.Magnitude > 0.05 then
        local moveSpeed = hum.WalkSpeed or 16
        local moveDir = hum.MoveDirection
        local movePrediction = moveDir * moveSpeed * timeToHit * 1.2
        predictedPos = predictedPos + movePrediction
    end
    
    -- Gravity compensation for jumping/falling
    local humanoidState = hum:GetState()
    if humanoidState == Enum.HumanoidStateType.Freefall or 
       humanoidState == Enum.HumanoidStateType.Jumping or
       humanoidState == Enum.HumanoidStateType.Flying then
        local gravity = 196.2
        local verticalVelocity = velocity.Y
        -- Correct physics: s = v*t - 0.5*g*t²
        local gravityDrop = verticalVelocity * timeToHit - (0.5 * gravity * timeToHit * timeToHit)
        predictedPos = predictedPos + Vector3_new(0, gravityDrop * 0.95, 0)
    end
    
    -- Ping compensation
    local ping = 0
    pcall(function()
        ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
    end)
    if ping > 0.01 and ping < 1 then
        local pingCompensation = velocity * ping * 0.8
        predictedPos = predictedPos + pingCompensation
    end
    
    -- Limit total offset to prevent extreme predictions
    local totalOffset = predictedPos - targetHead.Position
    local maxOffset = math_max(15, speed * 0.6 + distance * 0.02)
    
    if totalOffset.Magnitude > maxOffset then
        totalOffset = totalOffset.Unit * maxOffset
        predictedPos = targetHead.Position + totalOffset
    end
    
    -- Wall check to prevent shooting through walls
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = {char, localChar, Camera}
    rayParams.IgnoreWater = true
    
    local checkDirection = predictedPos - targetHead.Position
    if checkDirection.Magnitude > 0.1 then
        local rayResult = Workspace:Raycast(targetHead.Position, checkDirection, rayParams)
        if rayResult and rayResult.Instance and not rayResult.Instance:IsDescendantOf(char) then
            -- Hit a wall, adjust prediction back
            predictedPos = rayResult.Position - checkDirection.Unit * 0.5
        end
    end
    
    return predictedPos
end

function FullUDSilentAim:FlickerAndShoot(targetHead, targetPlayer)
    if self.IsFlickering then return end
    if not targetHead or not targetHead.Parent then return end
    if math_random(1, 100) > SILENT_HIT_CHANCE then return end
    
    self.IsFlickering = true
    
    local originalCF = Camera.CFrame
    local originalMousePos = UIS:GetMouseLocation()
    local targetChar = targetHead.Parent
    if not targetChar or not targetChar.Parent then
        self.IsFlickering = false
        return
    end
    
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    
    if not targetHum or not targetHum.Parent or targetHum.Health <= 0 then
        self.IsFlickering = false
        return
    end
    
    local initialHealth = targetHum.Health
    local predictedPos = self:PredictTargetPosition(targetHead, targetPlayer)
    
    Camera.CFrame = CFrame_new(Camera.CFrame.Position, predictedPos)
    
    local targetScreenPos = Camera:WorldToViewportPoint(predictedPos)
    if mousemoveabs then
        mousemoveabs(targetScreenPos.X, targetScreenPos.Y)
    end
    
    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()
    
    local shotFired = false
    pcall(function()
        if mouse1press and mouse1release then
            mouse1press()
            RunService.RenderStepped:Wait()
            mouse1release()
            shotFired = true
        else
            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            RunService.RenderStepped:Wait()
            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            shotFired = true
        end
    end)
    
    if shotFired then
        local startTime = tick()
        local maxWait = 0.25
        while (tick() - startTime) < maxWait do
            if not targetHum or not targetHum.Parent then break end
            if targetHum.Health < initialHealth or targetHum.Health <= 0 then
                break
            end
            RunService.RenderStepped:Wait()
        end
    end
    
    Camera.CFrame = originalCF
    if mousemoveabs then
        mousemoveabs(originalMousePos.X, originalMousePos.Y)
    end
    self.IsFlickering = false
end

function FullUDSilentAim:Enable()
    if self.Enabled then return end
    self.Enabled = true
    
    warn("[Snowfall] Full-UD Silent Aim ENABLED (Elite prediction)")
    
    -- Listen for left click
    local shootConnection = UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if not self.Enabled then return end
        if not SilentAimEnabled then return end
        if self.IsFlickering then return end
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Get target on click
            local targetHead, targetPlayer = self:GetTargetOnClick()
            
            if targetHead then
                -- Spawn async to not block input
                task.spawn(function()
                    self:FlickerAndShoot(targetHead, targetPlayer)
                end)
            end
        end
    end)
    
    table.insert(self.Connections, shootConnection)
end

function FullUDSilentAim:Disable()
    if not self.Enabled then return end
    self.Enabled = false
    self.IsFlickering = false
    
    for _, conn in ipairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    self.Connections = {}
    
    warn("[Snowfall] Full-UD Silent Aim DISABLED")
end

-- ═══════════════════════════════════════════════════════════════
--                  UNIFIED INTERFACE
-- ═══════════════════════════════════════════════════════════════

local SilentAimHooks = {
    Installed = false,
    CurrentMethod = "none",  -- "semi-ud" or "full-ud"
}

function SilentAimHooks:Install(method)
    method = method or "semi-ud"
    
    if self.Installed and self.CurrentMethod == method then
        return true
    end
    
    -- Uninstall any existing method first
    self:Uninstall()
    
    local success = false
    
    if method == "semi-ud" then
        success = SemiUDSilentAim:Install()
    elseif method == "full-ud" then
        FullUDSilentAim:Enable()
        success = true
    end
    
    if success then
        self.Installed = true
        self.CurrentMethod = method
    end
    
    return success
end

function SilentAimHooks:Uninstall()
    if not self.Installed then return end
    
    if self.CurrentMethod == "semi-ud" then
        SemiUDSilentAim:Uninstall()
    elseif self.CurrentMethod == "full-ud" then
        FullUDSilentAim:Disable()
    end
    
    self.Installed = false
    self.CurrentMethod = "none"
end

warn("[Snowfall] Dual Silent Aim system loaded")
warn("[Snowfall] Semi-UD: Hook-based (accurate, smooth)")
warn("[Snowfall] Full-UD: Camera flicker (100% undetectable)")

-- ═══════════════════════════════════════════════════════════════
--              IMPROVED TRIGGER BOT WITH SAFER INPUT
-- ═══════════════════════════════════════════════════════════════

Connections[#Connections + 1] = RunService.Heartbeat:Connect(function()
    if not InternalRunning or not ENABLE_TRIGGER_BOT then return end
    local now = tick()
    if now - LastTriggerShot < TRIGGER_SHOOT_DELAY then return end
    
    local target
    if TRACER_ENABLED and LockedTarget and LockedTarget.Parent then
        local char = LockedTarget.Character
        if not char or not char.Parent or HasForceField(char) then return end
        if GetPlayerUnderCursor() ~= LockedTarget then return end
        target = LockedTarget
    else
        target = GetPlayerUnderCursor()
    end
    
    if not target or not target.Parent then return end
    local char = target.Character
    if not char or not char.Parent or HasForceField(char) then return end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not hum.Parent or hum.Health <= 0 then return end
    
    local head = char:FindFirstChild("Head")
    if not head or not head.Parent or not IsVisible(head) then return end
    
    AntiDetection:RandomDelay(0.001, 0.01)
    
    local success = pcall(function()
        if mouse1press and mouse1release then
            mouse1press()
            task.wait(math.random(10, 30) / 1000)
            mouse1release()
        else
            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(math.random(10, 30) / 1000)
            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
    end)
    
    if success then
        LastTriggerShot = now
    end
end)

Connections[#Connections + 1] = UIS.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == cachedSpeedKey then
        SpeedEnabled = not SpeedEnabled
        ShowAimStatus(SpeedEnabled and "Speed ON" or "Speed OFF")
    end

    if input.KeyCode == cachedSpinbotKey then
        SpinbotEnabled = not SpinbotEnabled
        ShowAimStatus(SpinbotEnabled and "Spinbot ON" or "Spinbot OFF")
    end

    if input.KeyCode == cachedNoclipKey and ENABLE_NOCLIP then
        NoclipEnabled = not NoclipEnabled
        ShowAimStatus(NoclipEnabled and "Noclip ON" or "Noclip OFF")
    end


    if input.KeyCode == cachedHvHKey then
        SpinbotEnabled = not SpinbotEnabled
        ShowAimStatus(SpinbotEnabled and "HvH ON" or "HvH OFF")
    end

    if ENABLE_AIMLOCK then
        local isMatch = (AimlockIsKey and AimlockKeyCode and input.KeyCode == AimlockKeyCode)
                     or (not AimlockIsKey and AimlockMouseBtn and input.UserInputType == AimlockMouseBtn)
        if isMatch then AimlockActive = true; AimlockTarget = nil end
    end

    if input.KeyCode == cachedSilentAimKey then
        if not SILENT_AIM_ENABLED then return end
        if SilentAimEnabled then
            SilentAimEnabled = false
            LockedTarget = nil
            SetTracerVisible(false)
            ShowAimStatus("Silent Aim OFF")
        else
            SilentAimEnabled = true
            if TRACER_ENABLED then
                local nearest = GetClosestPlayer()
                if nearest then
                    LockedTarget = nearest
                    ShowAimStatus("Silent Aim ON - Locked: " .. nearest.Name)
                else
                    ShowAimStatus("Silent Aim ON - No target")
                end
            else
                ShowAimStatus("Silent Aim ON - Auto-targeting")
            end
        end
        return
    end

    -- When tracer is off, update LockedTarget on every click (matches old internal.lua behaviour)
    if not TRACER_ENABLED and SilentAimEnabled then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            LockedTarget = GetClosestPlayer()
        end
    end

    if ENABLE_INFINITE_JUMP and input.KeyCode == Enum.KeyCode.Space then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

Connections[#Connections + 1] = UIS.InputEnded:Connect(function(input, _)
    if ENABLE_AIMLOCK then
        local isMatch = (AimlockIsKey and AimlockKeyCode and input.KeyCode == AimlockKeyCode)
                     or (not AimlockIsKey and AimlockMouseBtn and input.UserInputType == AimlockMouseBtn)
        if isMatch then AimlockActive = false; AimlockTarget = nil end
    end
end)

local cachedLockedChar = nil
local cachedLockedHead = nil
local lastConfigSync   = 0
local CONFIG_SYNC_RATE = 0.5

Connections[#Connections + 1] = RunService.RenderStepped:Connect(function(dt)
    if not InternalRunning then return end

    local now = tick()
    local curCam = Workspace.CurrentCamera
    if curCam ~= Camera then Camera = curCam end

    if now - lastConfigSync >= CONFIG_SYNC_RATE then
        lastConfigSync = now
        local cfg = getgenv().SnowfallConfig
        if cfg then
            if cfg.SHOW_AIM_STATUS_TEXT    ~= nil then SHOW_AIM_STATUS_TEXT    = cfg.SHOW_AIM_STATUS_TEXT    end
            if cfg.SILENT_AIM_ENABLED ~= nil then
                local was = SILENT_AIM_ENABLED
                SILENT_AIM_ENABLED = cfg.SILENT_AIM_ENABLED
                if was and not SILENT_AIM_ENABLED and SilentAimEnabled then
                    SilentAimEnabled = false; LockedTarget = nil
                    SetTracerVisible(false); cachedLockedChar = nil; cachedLockedHead = nil
                end
            end
            if cfg.TRACER_ENABLED ~= nil then TRACER_ENABLED = cfg.TRACER_ENABLED end
            if cfg.TRACER_COLOR ~= nil then
                TRACER_COLOR = cfg.TRACER_COLOR
                if Tracer then Tracer.Color = TRACER_COLOR end
            end
            if cfg.TRACER_THICKNESS ~= nil then
                TRACER_THICKNESS = cfg.TRACER_THICKNESS
                if Tracer then Tracer.Thickness = TRACER_THICKNESS end
            end
            if cfg.USE_VELOCITY_SPEED   ~= nil then USE_VELOCITY_SPEED   = cfg.USE_VELOCITY_SPEED   end
            if cfg.VELOCITY_SPEED_VALUE ~= nil then VELOCITY_SPEED_VALUE = cfg.VELOCITY_SPEED_VALUE end
            if cfg.WALKSPEED_VALUE      ~= nil then WALKSPEED_VALUE      = cfg.WALKSPEED_VALUE      end
            if cfg.DEFAULT_SPEED        ~= nil then DEFAULT_SPEED        = cfg.DEFAULT_SPEED        end
            if cfg.ENABLE_ESP           ~= nil then ENABLE_ESP           = cfg.ENABLE_ESP           end
            if cfg.ENABLE_LOCAL_PLAYER_ESP ~= nil then ENABLE_LOCAL_PLAYER_ESP = cfg.ENABLE_LOCAL_PLAYER_ESP end
            if cfg.ENABLE_2D_BOX_ESP    ~= nil then ENABLE_2D_BOX_ESP    = cfg.ENABLE_2D_BOX_ESP    end
            if cfg.ENABLE_AIM_VIEW      ~= nil then ENABLE_AIM_VIEW      = cfg.ENABLE_AIM_VIEW      end
            if cfg.ENABLE_DISTANCE_ESP  ~= nil then ENABLE_DISTANCE_ESP  = cfg.ENABLE_DISTANCE_ESP  end
            if cfg.ENABLE_SKELETON_ESP  ~= nil then ENABLE_SKELETON_ESP  = cfg.ENABLE_SKELETON_ESP  end
            if cfg.ESP_MAX_DISTANCE     ~= nil then ESP_MAX_DISTANCE     = cfg.ESP_MAX_DISTANCE     end
            if cfg.AIM_VIEW_DANGER_COLOR ~= nil then AIM_VIEW_DANGER_COLOR = cfg.AIM_VIEW_DANGER_COLOR end
            if cfg.AIM_VIEW_SAFE_COLOR   ~= nil then AIM_VIEW_SAFE_COLOR   = cfg.AIM_VIEW_SAFE_COLOR   end
            if cfg.AIM_VIEW_LENGTH       ~= nil then AIM_VIEW_LENGTH       = cfg.AIM_VIEW_LENGTH       end
            if cfg.AIM_VIEW_THICKNESS    ~= nil then AIM_VIEW_THICKNESS    = cfg.AIM_VIEW_THICKNESS    end
            if cfg.ENABLE_TRIGGER_BOT    ~= nil then ENABLE_TRIGGER_BOT    = cfg.ENABLE_TRIGGER_BOT    end
            if cfg.TRIGGER_SHOOT_DELAY   ~= nil then TRIGGER_SHOOT_DELAY   = cfg.TRIGGER_SHOOT_DELAY   end
            if cfg.ENABLE_SPINBOT        ~= nil then ENABLE_SPINBOT        = cfg.ENABLE_SPINBOT        end
            if cfg.SPINBOT_SPEED         ~= nil then SPINBOT_SPEED         = cfg.SPINBOT_SPEED         end
            if cfg.ESP_BOX_COLOR         ~= nil then ESP_BOX_COLOR         = cfg.ESP_BOX_COLOR         end
            if cfg.ESP_NAME_COLOR        ~= nil then ESP_NAME_COLOR        = cfg.ESP_NAME_COLOR        end
            if cfg.ESP_DIST_COLOR        ~= nil then ESP_DIST_COLOR        = cfg.ESP_DIST_COLOR        end
            if cfg.ESP_SKELETON_COLOR    ~= nil then ESP_SKELETON_COLOR    = cfg.ESP_SKELETON_COLOR    end
            if cfg.ENABLE_HEALTHBAR_ESP  ~= nil then ENABLE_HEALTHBAR_ESP  = cfg.ENABLE_HEALTHBAR_ESP  end
            if cfg.ESP_MODE              ~= nil then ESP_MODE              = cfg.ESP_MODE              end
            if cfg.SILENT_HIT_CHANCE     ~= nil then SILENT_HIT_CHANCE     = cfg.SILENT_HIT_CHANCE     end
            if cfg.SILENT_HIT_PART       ~= nil then SILENT_HIT_PART       = cfg.SILENT_HIT_PART       end
            if cfg.EQUIP_KORBLOX         ~= nil then EQUIP_KORBLOX         = cfg.EQUIP_KORBLOX         end
            if cfg.EQUIP_HEADLESS        ~= nil then EQUIP_HEADLESS        = cfg.EQUIP_HEADLESS        end
            if cfg.EQUIP_SKOTN           ~= nil then EQUIP_SKOTN           = cfg.EQUIP_SKOTN           end
            if cfg.AIMLOCK_FOV ~= nil then
                AIMLOCK_FOV = cfg.AIMLOCK_FOV
                if FOVCircle then FOVCircle.Radius = AIMLOCK_FOV end
            end
            if cfg.AIMLOCK_FOV_COLOR ~= nil then
                AIMLOCK_FOV_COLOR = cfg.AIMLOCK_FOV_COLOR
                if FOVCircle then FOVCircle.Color = AIMLOCK_FOV_COLOR end
            end
            if cfg.AIMLOCK_FOV_TYPE  ~= nil then AIMLOCK_FOV_TYPE  = cfg.AIMLOCK_FOV_TYPE  end
            if cfg.AIMLOCK_PART      ~= nil then AIMLOCK_PART      = cfg.AIMLOCK_PART      end
            if cfg.ENABLE_NOCLIP     ~= nil then ENABLE_NOCLIP     = cfg.ENABLE_NOCLIP     end
            if cfg.ENABLE_INFINITE_JUMP ~= nil then ENABLE_INFINITE_JUMP = cfg.ENABLE_INFINITE_JUMP end
            if cfg.JUMP_POWER ~= nil then
                JUMP_POWER = cfg.JUMP_POWER
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.JumpPower = JUMP_POWER end
                end
            end
            if cfg.ESP_UPDATE_INTERVAL ~= nil then ESP_UPDATE_INTERVAL = cfg.ESP_UPDATE_INTERVAL end
            if cfg.SHOW_WATERMARK      ~= nil then SHOW_WATERMARK      = cfg.SHOW_WATERMARK      end

            local keysChanged = (cfg.TERMINATE_KEY  and cfg.TERMINATE_KEY  ~= TERMINATE_KEY)
                             or (cfg.SILENT_AIM_KEY and cfg.SILENT_AIM_KEY ~= SILENT_AIM_KEY)
                             or (cfg.SPEED_KEY      and cfg.SPEED_KEY      ~= SPEED_KEY)
                             or (cfg.SPINBOT_KEY    and cfg.SPINBOT_KEY    ~= SPINBOT_KEY)
                             or (cfg.HVH_KEY        and cfg.HVH_KEY        ~= HVH_KEY)
                             or (cfg.NOCLIP_KEY     and cfg.NOCLIP_KEY     ~= NOCLIP_KEY)
            if cfg.TERMINATE_KEY  then TERMINATE_KEY  = cfg.TERMINATE_KEY  end
            if cfg.SILENT_AIM_KEY then SILENT_AIM_KEY = cfg.SILENT_AIM_KEY end
            if cfg.SPEED_KEY      then SPEED_KEY      = cfg.SPEED_KEY      end
            if cfg.SPINBOT_KEY    then SPINBOT_KEY     = cfg.SPINBOT_KEY    end
            if cfg.HVH_KEY        then HVH_KEY         = cfg.HVH_KEY        end
            if cfg.NOCLIP_KEY     then NOCLIP_KEY      = cfg.NOCLIP_KEY     end
            if keysChanged then RefreshKeycodeCache() end

            if cfg.ENABLE_AIMLOCK ~= nil then
                if not cfg.ENABLE_AIMLOCK and ENABLE_AIMLOCK then AimlockActive = false; AimlockTarget = nil end
                ENABLE_AIMLOCK = cfg.ENABLE_AIMLOCK
            end
            if cfg.AIMLOCK_SMOOTH ~= nil then AIMLOCK_SMOOTH = cfg.AIMLOCK_SMOOTH end
            if cfg.AIMLOCK_KEY and cfg.AIMLOCK_KEY ~= AIMLOCK_KEY then
                AIMLOCK_KEY = cfg.AIMLOCK_KEY; RefreshAimlockBind()
            end

            if not TRACER_ENABLED and LockedTarget and not SilentAimEnabled then
                LockedTarget = nil; SetTracerVisible(false); cachedLockedChar = nil; cachedLockedHead = nil
            end

            if cfg.TARGET_FPS and cfg.TARGET_FPS ~= TARGET_FPS then
                TARGET_FPS = cfg.TARGET_FPS
                pcall(function() setfpscap(TARGET_FPS) end)
            end
        end
    end


    if ENABLE_AIMLOCK and AimlockActive then
        pcall(function()
            if AimlockTarget and AimlockTarget.Parent then
                local char = AimlockTarget.Character
                if not char or not char.Parent then
                    AimlockTarget = nil
                else
                    local partName = AIMLOCK_PART == "HRP" and "HumanoidRootPart" or AIMLOCK_PART
                    local part = char:FindFirstChild(partName) or char:FindFirstChild("Head")
                    if not part or not part.Parent then
                        AimlockTarget = nil
                    else
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if not hum or not hum.Parent or hum.Health <= 0 then 
                            AimlockTarget = nil 
                        end
                    end
                end
            end
            
            if not AimlockTarget then 
                AimlockTarget = GetClosestPlayerInFOV(AIMLOCK_FOV) 
            end
            
            if AimlockTarget and AimlockTarget.Parent then
                local char = AimlockTarget.Character
                if char and char.Parent then
                    local partName = AIMLOCK_PART == "HRP" and "HumanoidRootPart" or AIMLOCK_PART
                    local part = char:FindFirstChild(partName) or char:FindFirstChild("Head")
                    if part and part.Parent then
                        local alpha    = math_min(1, dt * (100 / math_max(1, AIMLOCK_SMOOTH)))
                        local targetCF = CFrame_new(Camera.CFrame.Position, part.Position)
                        Camera.CFrame  = Camera.CFrame:Lerp(targetCF, alpha)
                    end
                end
            end
        end)
    end

    if FOVCircle then
        FOVCircle.Visible = ENABLE_AIMLOCK
        FOVCircle.Radius  = AIMLOCK_FOV
        FOVCircle.Color   = AIMLOCK_FOV_COLOR
        if AIMLOCK_FOV_TYPE == "dynamic" then
            local mpos = UIS:GetMouseLocation()
            FOVCircle.Position = Vector2_new(mpos.X, mpos.Y)
        else
            FOVCircle.Position = Vector2_new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        end
    end

    if ENABLE_SPINBOT and SpinbotEnabled then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame_Angles(0, math_rad(SPINBOT_SPEED * dt * 10), 0)
            end
        end
    end


    if Tracer then
        if TRACER_ENABLED and SilentAimEnabled and LockedTarget and LockedTarget.Parent then
            pcall(function()
                local lockedChar = LockedTarget.Character
                if not lockedChar or not lockedChar.Parent then
                    if Tracer.Visible then Tracer.Visible = false end
                    cachedLockedChar = nil
                    cachedLockedHead = nil
                    return
                end
                
                if lockedChar ~= cachedLockedChar then
                    cachedLockedChar = lockedChar
                    cachedLockedHead = nil
                end
                
                if cachedLockedChar then
                    local h = cachedLockedChar:FindFirstChild("Head")
                    if h and h.Parent then
                        if h ~= cachedLockedHead then cachedLockedHead = h end
                    else
                        cachedLockedHead = nil
                    end
                end
                
                if not cachedLockedHead or not cachedLockedHead.Parent then
                    if Tracer.Visible then Tracer.Visible = false end
                    return
                end
                
                local hum = cachedLockedChar:FindFirstChildOfClass("Humanoid")
                if not hum or not hum.Parent or hum.Health <= 0 then
                    if Tracer.Visible then Tracer.Visible = false end
                    return
                end
                
                local headPos, onScreen = Camera:WorldToViewportPoint(cachedLockedHead.Position)
                if not onScreen then
                    if Tracer.Visible then Tracer.Visible = false end
                    return
                end
                
                local vp = Camera.ViewportSize
                Tracer.From = Vector2_new(vp.X / 2, vp.Y)
                Tracer.To   = Vector2_new(headPos.X, headPos.Y)
                Tracer.Color = TRACER_COLOR
                Tracer.Thickness = TRACER_THICKNESS
                if not Tracer.Visible then Tracer.Visible = true end
            end)
        else
            if Tracer.Visible then Tracer.Visible = false end
            cachedLockedChar = nil
            cachedLockedHead = nil
        end
    end

    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if ENABLE_INFINITE_JUMP then
            if hum.JumpPower ~= JUMP_POWER then hum.JumpPower = JUMP_POWER end
        end

        if SpeedEnabled then
            if USE_VELOCITY_SPEED then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and hum.MoveDirection.Magnitude > 0 then
                    hrp.AssemblyLinearVelocity = Vector3_new(
                        hum.MoveDirection.X * VELOCITY_SPEED_VALUE,
                        hrp.AssemblyLinearVelocity.Y,
                        hum.MoveDirection.Z * VELOCITY_SPEED_VALUE)
                end
            else
                if hum.WalkSpeed ~= WALKSPEED_VALUE then hum.WalkSpeed = WALKSPEED_VALUE end
            end
        else
            if hum.WalkSpeed ~= DEFAULT_SPEED then hum.WalkSpeed = DEFAULT_SPEED end
        end
    end)

    if NoclipEnabled and ENABLE_NOCLIP then
        local char = LocalPlayer.Character
        if char then
            -- iterate children only (BaseParts directly in character), not all descendants
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- processPlayerESP hoisted outside heartbeat so it's not re-allocated every frame
local _espLocalChar = nil
local _espLocalHRP  = nil

local function processPlayerESP(plr, isLocal)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tooFar = false
    if _espLocalHRP and not isLocal then
        tooFar = (hrp.Position - _espLocalHRP.Position).Magnitude > ESP_MAX_DISTANCE
    end

    local txt  = NameESP[plr]
    local dtxt = DistESP[plr]
    local box  = BoxESP[plr]
    local skel = SkeletonESP[plr]

    if not txt then CreateESPForPlayer(plr); txt = NameESP[plr] end
    if not dtxt then dtxt = DistESP[plr] end
    if not box then CreateBoxESPForPlayer(plr); box = BoxESP[plr] end
    if not skel then CreateSkeletonESPForPlayer(plr); skel = SkeletonESP[plr] end
    if ENABLE_CHAMS and not ChamsESP[plr] then CreateChamsForPlayer(plr); ApplyChamsToCharacter(plr) end

    if tooFar then
        if txt  and txt.Visible  then txt.Visible  = false end
        if dtxt and dtxt.Visible then dtxt.Visible = false end
        if box  then for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end end
        if skel then for _, l in ipairs(skel) do if l.Visible then l.Visible = false end end end
        -- hide chams when out of range
        if ENABLE_CHAMS and ChamsESP[plr] and ChamsESP[plr].highlights then
            for _, h in ipairs(ChamsESP[plr].highlights) do
                pcall(function() if h.FillTransparency ~= 1 then h.FillTransparency = 1; h.OutlineTransparency = 1 end end)
            end
        end
        return
    end

    -- restore chams when back in range
    if ENABLE_CHAMS and ChamsESP[plr] and ChamsESP[plr].highlights then
        for _, h in ipairs(ChamsESP[plr].highlights) do
            pcall(function()
                if h.FillTransparency ~= CHAMS_TRANSPARENCY then
                    h.FillTransparency = CHAMS_TRANSPARENCY
                    h.OutlineTransparency = 0
                end
            end)
        end
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local alive = hum and hum.Health > 0

    if ENABLE_ESP and txt then
        local topY = GetCharacterBounds(char)
        if topY then
            local labelPos3 = Vector3_new(hrp.Position.X, topY + 0.35, hrp.Position.Z)
            local pos, onscreen = Camera:WorldToViewportPoint(labelPos3)
            if onscreen and alive then
                txt.Text     = plr.Name
                txt.Position = Vector2_new(pos.X, pos.Y)
                if txt.Color ~= ESP_NAME_COLOR then txt.Color = ESP_NAME_COLOR end
                if not txt.Visible then txt.Visible = true end
                if dtxt then
                    if ENABLE_DISTANCE_ESP and _espLocalHRP then
                        local dist = math_floor((hrp.Position - _espLocalHRP.Position).Magnitude)
                        dtxt.Text     = dist .. "m"
                        dtxt.Position = Vector2_new(pos.X, pos.Y + 16)
                        if dtxt.Color ~= ESP_DIST_COLOR then dtxt.Color = ESP_DIST_COLOR end
                        if not dtxt.Visible then dtxt.Visible = true end
                    else
                        if dtxt.Visible then dtxt.Visible = false end
                    end
                end
            else
                if txt.Visible then txt.Visible = false end
                if dtxt and dtxt.Visible then dtxt.Visible = false end
            end
        else
            if txt.Visible then txt.Visible = false end
            if dtxt and dtxt.Visible then dtxt.Visible = false end
        end
    elseif txt and txt.Visible then
        txt.Visible = false
        if dtxt and dtxt.Visible then dtxt.Visible = false end
    end

    if ENABLE_SKELETON_ESP and skel then
        if alive then
            for i, conn in ipairs(SKELETON_CONNECTIONS) do
                local partA = char:FindFirstChild(conn[1])
                local partB = char:FindFirstChild(conn[2])
                local line  = skel[i]
                if partA and partB and line then
                    local pA, onA = Camera:WorldToViewportPoint(partA.Position)
                    local pB, onB = Camera:WorldToViewportPoint(partB.Position)
                    if onA and onB then
                        line.From    = Vector2_new(pA.X, pA.Y)
                        line.To      = Vector2_new(pB.X, pB.Y)
                        line.Color   = ESP_SKELETON_COLOR
                        line.Visible = true
                    else
                        if line.Visible then line.Visible = false end
                    end
                elseif skel[i] and skel[i].Visible then
                    skel[i].Visible = false
                end
            end
        else
            for _, l in ipairs(skel) do if l.Visible then l.Visible = false end end
        end
    elseif skel then
        for _, l in ipairs(skel) do if l.Visible then l.Visible = false end end
    end
end

Connections[#Connections + 1] = RunService.Heartbeat:Connect(function()
    if not InternalRunning then return end
    local now = tick()
    if now - lastESPUpdate < ESP_UPDATE_INTERVAL then return end
    lastESPUpdate = now

    _espLocalChar = LocalPlayer.Character
    _espLocalHRP  = _espLocalChar and _espLocalChar:FindFirstChild("HumanoidRootPart")

    local localHRP = _espLocalHRP
    
    local rainbowColor = nil
    if ENABLE_RAINBOW_MODE then
        rainbowColor = GetRainbowColor()
        ESP_BOX_COLOR = rainbowColor
        ESP_NAME_COLOR = rainbowColor
        ESP_DIST_COLOR = rainbowColor
        ESP_SKELETON_COLOR = rainbowColor
        CHAMS_COLOR = rainbowColor
    end

    for _, plr in ipairs(GetCachedPlayers()) do
        if plr ~= LocalPlayer then
            pcall(processPlayerESP, plr, false)
        end
    end

    if ENABLE_LOCAL_PLAYER_ESP then
        pcall(processPlayerESP, LocalPlayer, true)
    end
    
    if ENABLE_RAINBOW_MODE and ENABLE_CHAMS then
        for _, plr in ipairs(GetCachedPlayers()) do
            if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                pcall(function()
                    if plr.Character then
                        local chamsData = ChamsESP[plr]
                        if chamsData and chamsData.highlights then
                            for _, highlight in ipairs(chamsData.highlights) do
                                if highlight and highlight:IsA("Highlight") and highlight.Parent then
                                    highlight.FillColor = rainbowColor
                                    highlight.OutlineColor = rainbowColor
                                end
                            end
                        end
                    end
                end)
            end
        end
    end

    if ENABLE_2D_BOX_ESP and ESP_MODE ~= "performance" then
        local players = GetCachedPlayers()
        for _, plr in ipairs(players) do
            if not ENABLE_LOCAL_PLAYER_ESP and plr == LocalPlayer then continue end
            local box = BoxESP[plr]
            if not box then continue end
            pcall(function()
                if not (plr and plr.Parent and plr.Character) then
                    for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                end
                local char = plr.Character
                local hrp  = char:FindFirstChild("HumanoidRootPart")
                if not hrp then
                    for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                end
                if localHRP and plr ~= LocalPlayer then
                    local dist = (hrp.Position - localHRP.Position).Magnitude
                    if dist > ESP_MAX_DISTANCE then
                        for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                    end
                end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then
                    for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                end
                local minX, minY, maxX, maxY = math_huge, math_huge, -math_huge, -math_huge
                local anyOnScreen = false
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Transparency < 1 then
                        local cf = part.CFrame
                        local sx = part.Size.X * 0.5
                        local sy = part.Size.Y * 0.5
                        local sz = part.Size.Z * 0.5
                        local function checkCorner(ox, oy, oz)
                            local vp, on = Camera:WorldToViewportPoint(cf:PointToWorldSpace(Vector3_new(ox, oy, oz)))
                            if on then
                                anyOnScreen = true
                                if vp.X < minX then minX = vp.X end
                                if vp.X > maxX then maxX = vp.X end
                                if vp.Y < minY then minY = vp.Y end
                                if vp.Y > maxY then maxY = vp.Y end
                            end
                        end
                        checkCorner( sx,  sy,  sz); checkCorner(-sx,  sy,  sz)
                        checkCorner( sx, -sy,  sz); checkCorner(-sx, -sy,  sz)
                        checkCorner( sx,  sy, -sz); checkCorner(-sx,  sy, -sz)
                        checkCorner( sx, -sy, -sz); checkCorner(-sx, -sy, -sz)
                    end
                end
                if not anyOnScreen or (maxX - minX) < 1 or (maxY - minY) < 1 then
                    for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                end
                local tl = Vector2_new(minX, minY); local tr = Vector2_new(maxX, minY)
                local bl = Vector2_new(minX, maxY); local br = Vector2_new(maxX, maxY)
                box[1].From = tl; box[1].To = tr
                box[2].From = tr; box[2].To = br
                box[3].From = br; box[3].To = bl
                box[4].From = bl; box[4].To = tl
                for i = 1, 4 do
                    if box[i].Color ~= ESP_BOX_COLOR then box[i].Color = ESP_BOX_COLOR end
                    if not box[i].Visible then box[i].Visible = true end
                end
                local hbar = box[5]
                if hbar then
                    if ENABLE_HEALTHBAR_ESP then
                        local maxHp     = hum.MaxHealth > 0 and hum.MaxHealth or 100
                        local ratio     = math_min(1, math_max(0, hum.Health / maxHp))
                        local barX      = maxX + 3
                        local fullH     = maxY - minY
                        local filledTop = maxY - fullH * ratio
                        local g         = math_min(255, math_floor(510 * ratio))
                        local r         = math_min(255, math_floor(510 * (1 - ratio)))
                        if hbar.Color ~= Color3_fromRGB(r,g,0) then hbar.Color = Color3_fromRGB(r,g,0) end
                        hbar.From = Vector2_new(barX, filledTop)
                        hbar.To   = Vector2_new(barX, maxY)
                        if not hbar.Visible then hbar.Visible = true end
                    else
                        if hbar.Visible then hbar.Visible = false end
                    end
                end
            end)
        end
    elseif not ENABLE_2D_BOX_ESP then
        for _, box in pairs(BoxESP) do
            for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end
        end
    end

    if ENABLE_AIM_VIEW then
        for plr, beamData in pairs(AimViewBeams) do
            if beamData and beamData.line then
                pcall(function()
                    if not plr or not plr.Parent or plr == LocalPlayer then
                        if beamData.line.Visible then beamData.line.Visible = false end; return
                    end
                    local char = beamData.character
                    if not char or not char.Parent then
                        if beamData.line.Visible then beamData.line.Visible = false end; return
                    end
                    local head = char:FindFirstChild("Head")
                    if not head then if beamData.line.Visible then beamData.line.Visible = false end; return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health <= 0 then if beamData.line.Visible then beamData.line.Visible = false end; return end
                    local headPos, headOk = Camera:WorldToViewportPoint(head.Position)
                    if not headOk then if beamData.line.Visible then beamData.line.Visible = false end; return end
                    local lookVec = head.CFrame.LookVector
                    local aimEnd  = head.Position + lookVec * AIM_VIEW_LENGTH
                    if not beamData.rayParams then
                        beamData.rayParams            = RaycastParams.new()
                        beamData.rayParams.FilterType  = Enum.RaycastFilterType.Exclude
                        beamData.rayParams.IgnoreWater = true
                    end
                    if beamData.rayFilterChar ~= char then
                        beamData.rayFilterChar = char
                        beamData.rayParams.FilterDescendantsInstances = {char, Camera}
                    end
                    local rayResult = Workspace:Raycast(head.Position, lookVec * AIM_VIEW_LENGTH, beamData.rayParams)
                    local finalEnd  = aimEnd
                    local isDanger  = false
                    if rayResult then
                        finalEnd = rayResult.Position
                        local lc = LocalPlayer.Character
                        if lc and rayResult.Instance then isDanger = rayResult.Instance:IsDescendantOf(lc) end
                    end
                    local endVP, _ = Camera:WorldToViewportPoint(finalEnd)
                    local newColor = isDanger and AIM_VIEW_DANGER_COLOR or AIM_VIEW_SAFE_COLOR
                    beamData.line.From = Vector2_new(headPos.X, headPos.Y)
                    beamData.line.To   = Vector2_new(endVP.X, endVP.Y)
                    if beamData.line.Color     ~= newColor           then beamData.line.Color     = newColor           end
                    if beamData.line.Thickness ~= AIM_VIEW_THICKNESS then beamData.line.Thickness = AIM_VIEW_THICKNESS end
                    if not beamData.line.Visible then beamData.line.Visible = true end
                end)
            end
        end
    else
        for _, beamData in pairs(AimViewBeams) do
            if beamData and beamData.line and beamData.line.Visible then beamData.line.Visible = false end
        end
    end
end)

Connections[#Connections + 1] = RunService.RenderStepped:Connect(function()
    if not InternalRunning then return end
    espUpdateTick = espUpdateTick + 1
    if espUpdateTick < 3 then return end
    espUpdateTick = 0
    if not ENABLE_2D_BOX_ESP or ESP_MODE ~= "performance" then return end

    local localChar = LocalPlayer.Character
    local localHRP  = localChar and localChar:FindFirstChild("HumanoidRootPart")

    for plr, box in pairs(BoxESP) do
        if not ENABLE_LOCAL_PLAYER_ESP and plr == LocalPlayer then continue end
        pcall(function()
            if not (plr and plr.Parent and plr.Character) then
                for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
            end
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then
                for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
            end
            if localHRP and plr ~= LocalPlayer then
                local dist = (hrp.Position - localHRP.Position).Magnitude
                if dist > ESP_MAX_DISTANCE then
                    for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
                end
            end
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then
                for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end; return
            end
            
            -- Performance mode: Draw box around HRP facing character direction
            local hrpCF = hrp.CFrame
            local headPart = plr.Character:FindFirstChild("Head")
            local height = headPart and math_max(1, headPart.Position.Y - hrp.Position.Y + 1) or 2
            local width = 2
            
            -- Get the 4 corners of the box in world space, oriented to character's facing direction
            local topLeft = hrpCF * CFrame_new(-width, height, 0)
            local topRight = hrpCF * CFrame_new(width, height, 0)
            local bottomLeft = hrpCF * CFrame_new(-width, -height, 0)
            local bottomRight = hrpCF * CFrame_new(width, -height, 0)
            
            -- Convert to screen space
            local tl, tlOn = Camera:WorldToViewportPoint(topLeft.Position)
            local tr, trOn = Camera:WorldToViewportPoint(topRight.Position)
            local bl, blOn = Camera:WorldToViewportPoint(bottomLeft.Position)
            local br, brOn = Camera:WorldToViewportPoint(bottomRight.Position)
            
            if tlOn and trOn and blOn and brOn then
                local rainbowColor = ENABLE_RAINBOW_MODE and GetRainbowColor() or ESP_BOX_COLOR
                
                box[1].Visible = true; box[1].From = Vector2_new(tl.X, tl.Y); box[1].To = Vector2_new(tr.X, tr.Y)
                box[2].Visible = true; box[2].From = Vector2_new(tr.X, tr.Y); box[2].To = Vector2_new(br.X, br.Y)
                box[3].Visible = true; box[3].From = Vector2_new(br.X, br.Y); box[3].To = Vector2_new(bl.X, bl.Y)
                box[4].Visible = true; box[4].From = Vector2_new(bl.X, bl.Y); box[4].To = Vector2_new(tl.X, tl.Y)
                
                for i = 1, 4 do
                    if box[i].Color ~= rainbowColor then box[i].Color = rainbowColor end
                end
                
                local hbar = box[5]
                if hbar then
                    if ENABLE_HEALTHBAR_ESP then
                        local maxHp     = hum.MaxHealth > 0 and hum.MaxHealth or 100
                        local ratio     = math_min(1, math_max(0, hum.Health / maxHp))
                        local barX      = math_max(tr.X, br.X) + 3
                        local topY      = math_min(tl.Y, tr.Y)
                        local botY      = math_max(bl.Y, br.Y)
                        local fullH     = botY - topY
                        local filledTop = botY - fullH * ratio
                        local g         = math_min(255, math_floor(510 * ratio))
                        local r         = math_min(255, math_floor(510 * (1 - ratio)))
                        hbar.Color = Color3_fromRGB(r, g, 0)
                        hbar.From  = Vector2_new(barX, filledTop)
                        hbar.To    = Vector2_new(barX, botY)
                        if not hbar.Visible then hbar.Visible = true end
                    else
                        if hbar.Visible then hbar.Visible = false end
                    end
                end
            else
                for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end
            end
        end)
    end
end)

if EQUIP_KORBLOX or EQUIP_HEADLESS or EQUIP_SKOTN then
    if LocalPlayer.Character then ApplyCosmetics() end
    Connections[#Connections + 1] = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5); ApplyCosmetics()
    end)
end

local Window = Library:CreateWindow({
    Title = "snowfall.cc v1.0",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
})

local Tabs = {
    Aimbot    = Window:AddTab("Aimbot"),
    ESP       = Window:AddTab("ESP"),
    HvH       = Window:AddTab("HvH"),
    Movement  = Window:AddTab("Movement"),
    Cosmetics = Window:AddTab("Cosmetics"),
    Utils     = Window:AddTab("Utils"),
    Misc      = Window:AddTab("Misc"),
    Socials   = Window:AddTab("Socials"),
}

local AimbotLeft  = Tabs.Aimbot:AddLeftGroupbox("Silent Aim")
local AimbotRight = Tabs.Aimbot:AddRightGroupbox("Aimlock & Triggerbot")

AimbotLeft:AddLabel("Choose ONE method (hover for info):")

AimbotLeft:AddToggle("SemiUDSilentAimToggle", {
    Text = "Silent Aim (Semi-UD)",
    Default = false,
    Tooltip = "Hook based method\n\nPros: Perfect accuracy and No flicker\nCons: Detected by good anti cheat\n\nBest for: Weak anti-cheat games (most da hood copys)",
    Callback = function(v)
        if v then
            if Options.FullUDSilentAimToggle and Options.FullUDSilentAimToggle.Value then
                Options.FullUDSilentAimToggle:SetValue(false)
            end
            SILENT_AIM_ENABLED = true
            SetCfg("SILENT_AIM_ENABLED", true)
            local success = SilentAimHooks:Install("semi-ud")
            if success then
                SilentAimEnabled = true
                ShowAimStatus("Semi-UD Silent Aim ON")
            else
                ShowAimStatus("Semi-UD Failed!")
                Options.SemiUDSilentAimToggle:SetValue(false)
            end
        else
            SILENT_AIM_ENABLED = false
            SetCfg("SILENT_AIM_ENABLED", false)
            SilentAimHooks:Uninstall()
            SilentAimEnabled = false
            LockedTarget = nil
            SetTracerVisible(false)
            ShowAimStatus("Semi-UD Silent Aim OFF")
        end
    end,
})

AimbotLeft:AddToggle("FullUDSilentAimToggle", {
    Text = "Flicker Silent Aim (UD)",
    Default = false,
    Tooltip = "Camera flicker method\n\nPros: Undetectable and no hooks\nCons: Camera Flicker and not 100% accuracy\n\nBest for: Stronger anti-cheat games (e.g. rivals)",
    Callback = function(v)
        if v then
            if Options.SemiUDSilentAimToggle and Options.SemiUDSilentAimToggle.Value then
                Options.SemiUDSilentAimToggle:SetValue(false)
            end
            SILENT_AIM_ENABLED = true
            SetCfg("SILENT_AIM_ENABLED", true)
            local success = SilentAimHooks:Install("full-ud")
            if success then
                SilentAimEnabled = true
                ShowAimStatus("Full-UD Silent Aim ON")
            else
                ShowAimStatus("Full-UD Failed!")
                Options.FullUDSilentAimToggle:SetValue(false)
            end
        else
            SILENT_AIM_ENABLED = false
            SetCfg("SILENT_AIM_ENABLED", false)
            SilentAimHooks:Uninstall()
            SilentAimEnabled = false
            LockedTarget = nil
            SetTracerVisible(false)
            ShowAimStatus("Full-UD Silent Aim OFF")
        end
    end,
})

AimbotLeft:AddDropdown("SilentHitPart", {
    Text = "Hit Part",
    Values = {"Head", "Torso", "HumanoidRootPart"},
    Default = SILENT_HIT_PART,
    Callback = function(v) SILENT_HIT_PART = v; SetCfg("SILENT_HIT_PART", v) end,
})

AimbotLeft:AddSlider("SilentHitChance", {
    Text = "Hit Chance %",
    Default = SILENT_HIT_CHANCE,
    Min = 1, Max = 100, Rounding = 0,
    Callback = function(v) SILENT_HIT_CHANCE = v; SetCfg("SILENT_HIT_CHANCE", v) end,
})

AimbotLeft:AddToggle("TracerToggle", {
    Text = "Tracer Line",
    Default = TRACER_ENABLED,
    Callback = function(v)
        TRACER_ENABLED = v; SetCfg("TRACER_ENABLED", v)
        if not v then SetTracerVisible(false) end
    end,
})

AimbotLeft:AddSlider("TracerThickness", {
    Text = "Tracer Thickness",
    Default = TRACER_THICKNESS,
    Min = 1, Max = 5, Rounding = 1,
    Callback = function(v)
        TRACER_THICKNESS = v; SetCfg("TRACER_THICKNESS", v)
        if Tracer then Tracer.Thickness = v end
    end,
})

AimbotLeft:AddLabel("Tracer Color"):AddColorPicker("TracerColor", {
    Default = TRACER_COLOR,
    Callback = function(v)
        TRACER_COLOR = v; SetCfg("TRACER_COLOR", v)
        if Tracer then Tracer.Color = v end
    end,
})

AimbotLeft:AddToggle("ShowAimStatusToggle", {
    Text = "Show Status Text",
    Default = SHOW_AIM_STATUS_TEXT,
    Callback = function(v) SHOW_AIM_STATUS_TEXT = v; SetCfg("SHOW_AIM_STATUS_TEXT", v) end,
})

AimbotRight:AddToggle("AimlockToggle", {
    Text = "Aimlock",
    Default = ENABLE_AIMLOCK,
    Callback = function(v)
        ENABLE_AIMLOCK = v; SetCfg("ENABLE_AIMLOCK", v)
        if not v then AimlockActive = false; AimlockTarget = nil end
        if FOVCircle then FOVCircle.Visible = v end
    end,
})

AimbotRight:AddDropdown("AimlockPart", {
    Text = "Lock Part",
    Values = {"Head", "HRP", "UpperTorso"},
    Default = AIMLOCK_PART,
    Callback = function(v) AIMLOCK_PART = v; SetCfg("AIMLOCK_PART", v) end,
})

AimbotRight:AddSlider("AimlockSmooth", {
    Text = "Smooth",
    Default = AIMLOCK_SMOOTH,
    Min = 1, Max = 100, Rounding = 0,
    Callback = function(v) AIMLOCK_SMOOTH = v; SetCfg("AIMLOCK_SMOOTH", v) end,
})

AimbotRight:AddSlider("AimlockFOV", {
    Text = "FOV Radius",
    Default = AIMLOCK_FOV,
    Min = 10, Max = 800, Rounding = 0,
    Callback = function(v)
        AIMLOCK_FOV = v; SetCfg("AIMLOCK_FOV", v)
        if FOVCircle then FOVCircle.Radius = v end
    end,
})

AimbotRight:AddDropdown("AimlockFOVType", {
    Text = "FOV Type",
    Values = {"static", "dynamic"},
    Default = AIMLOCK_FOV_TYPE,
    Callback = function(v) AIMLOCK_FOV_TYPE = v; SetCfg("AIMLOCK_FOV_TYPE", v) end,
})

AimbotRight:AddLabel("FOV Color"):AddColorPicker("AimlockFOVColor", {
    Default = AIMLOCK_FOV_COLOR,
    Callback = function(v)
        AIMLOCK_FOV_COLOR = v; SetCfg("AIMLOCK_FOV_COLOR", v)
        if FOVCircle then FOVCircle.Color = v end
    end,
})

AimbotRight:AddToggle("TriggerBotToggle", {
    Text = "Trigger Bot",
    Default = ENABLE_TRIGGER_BOT,
    Callback = function(v) ENABLE_TRIGGER_BOT = v; SetCfg("ENABLE_TRIGGER_BOT", v) end,
})

AimbotRight:AddSlider("TriggerDelay", {
    Text = "Trigger Delay (s)",
    Default = TRIGGER_SHOOT_DELAY,
    Min = 0.01, Max = 1, Rounding = 2,
    Callback = function(v) TRIGGER_SHOOT_DELAY = v; SetCfg("TRIGGER_SHOOT_DELAY", v) end,
})

local ESPLeft  = Tabs.ESP:AddLeftGroupbox("ESP")
local ESPRight = Tabs.ESP:AddRightGroupbox("Aim View")

ESPLeft:AddToggle("ESPToggle", {
    Text = "Name ESP",
    Default = ENABLE_ESP,
    Callback = function(v) ENABLE_ESP = v; SetCfg("ENABLE_ESP", v) end,
})

ESPLeft:AddToggle("BoxESPToggle", {
    Text = "2D Box ESP",
    Default = ENABLE_2D_BOX_ESP,
    Callback = function(v) ENABLE_2D_BOX_ESP = v; SetCfg("ENABLE_2D_BOX_ESP", v) end,
})

ESPLeft:AddToggle("HealthBarESPToggle", {
    Text = "Health Bar",
    Default = ENABLE_HEALTHBAR_ESP,
    Callback = function(v) ENABLE_HEALTHBAR_ESP = v; SetCfg("ENABLE_HEALTHBAR_ESP", v) end,
})

ESPLeft:AddToggle("DistanceESPToggle", {
    Text = "Distance ESP",
    Default = ENABLE_DISTANCE_ESP,
    Callback = function(v) ENABLE_DISTANCE_ESP = v; SetCfg("ENABLE_DISTANCE_ESP", v) end,
})

ESPLeft:AddToggle("SkeletonESPToggle", {
    Text = "Skeleton ESP",
    Default = ENABLE_SKELETON_ESP,
    Callback = function(v) ENABLE_SKELETON_ESP = v; SetCfg("ENABLE_SKELETON_ESP", v) end,
})

ESPLeft:AddToggle("ChamsESPToggle", {
    Text = "Chams ESP",
    Default = ENABLE_CHAMS,
    Callback = function(v)
        ENABLE_CHAMS = v
        SetCfg("ENABLE_CHAMS", v)
        if v then
            task.spawn(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                        if plr.Character then
                            ApplyChamsToCharacter(plr)
                        end
                        task.wait(0.02)
                    end
                end
                task.wait(0.5)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                        if plr.Character then
                            ApplyChamsToCharacter(plr)
                        end
                    end
                end
            end)
        else
            for _, plr in ipairs(Players:GetPlayers()) do
                RemoveChamsFromPlayer(plr)
            end
        end
    end,
})

ESPLeft:AddLabel("Chams Color"):AddColorPicker("ChamsColor", {
    Default = CHAMS_COLOR,
    Callback = function(v)
        CHAMS_COLOR = v
        SetCfg("CHAMS_COLOR", v)
        -- Only apply the color if rainbow mode is OFF
        if ENABLE_CHAMS and not ENABLE_RAINBOW_MODE then
            task.spawn(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                        if plr.Character then
                            ApplyChamsToCharacter(plr)
                        end
                    end
                end
            end)
        end
    end,
})

ESPLeft:AddSlider("ChamsTransparency", {
    Text = "Chams Transparency",
    Default = CHAMS_TRANSPARENCY,
    Min = 0, Max = 1, Rounding = 2,
    Callback = function(v)
        CHAMS_TRANSPARENCY = v
        SetCfg("CHAMS_TRANSPARENCY", v)
        if ENABLE_CHAMS then
            task.spawn(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                        if plr.Character then
                            ApplyChamsToCharacter(plr)
                        end
                    end
                end
            end)
        end
    end,
})

ESPLeft:AddToggle("RainbowModeToggle", {
    Text = "Gay Mode",
    Default = ENABLE_RAINBOW_MODE,
    Callback = function(v) 
        ENABLE_RAINBOW_MODE = v
        SetCfg("ENABLE_RAINBOW_MODE", v)
        if v and ENABLE_CHAMS then
            task.spawn(function()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer or ENABLE_LOCAL_PLAYER_ESP then
                        if plr.Character then
                            ApplyChamsToCharacter(plr)
                        end
                    end
                end
            end)
        end
    end,
})

ESPLeft:AddToggle("LocalPlayerESPToggle", {
    Text = "Local Player ESP",
    Default = ENABLE_LOCAL_PLAYER_ESP,
    Callback = function(v)
        ENABLE_LOCAL_PLAYER_ESP = v; SetCfg("ENABLE_LOCAL_PLAYER_ESP", v)
        if v then
            CreateESPForPlayer(LocalPlayer)
            CreateBoxESPForPlayer(LocalPlayer)
            CreateSkeletonESPForPlayer(LocalPlayer)
            if ENABLE_CHAMS then ApplyChamsToCharacter(LocalPlayer) end
        else
            local txt  = NameESP[LocalPlayer];  if txt  then pcall(function() txt.Visible  = false end) end
            local dtxt = DistESP[LocalPlayer];  if dtxt then pcall(function() dtxt.Visible = false end) end
            local box  = BoxESP[LocalPlayer]
            if box then for i = 1, 5 do if box[i] and box[i].Visible then box[i].Visible = false end end end
            local skel = SkeletonESP[LocalPlayer]
            if skel then for _, l in ipairs(skel) do if l.Visible then l.Visible = false end end end
            RemoveChamsFromPlayer(LocalPlayer)
        end
    end,
})

ESPLeft:AddDropdown("ESPModeDropdown", {
    Text = "Render Mode",
    Values = {"performance", "accurate"},
    Default = ESP_MODE,
    Callback = function(v) ESP_MODE = v; SetCfg("ESP_MODE", v) end,
})

ESPLeft:AddLabel("Box Color"):AddColorPicker("ESPBoxColor", {
    Default = ESP_BOX_COLOR,
    Callback = function(v)
        ESP_BOX_COLOR = v; SetCfg("ESP_BOX_COLOR", v)
        for _, box in pairs(BoxESP) do
            for i = 1, 4 do if box[i] then box[i].Color = v end end
        end
    end,
})

ESPLeft:AddLabel("Name Color"):AddColorPicker("ESPNameColor", {
    Default = ESP_NAME_COLOR,
    Callback = function(v) ESP_NAME_COLOR = v; SetCfg("ESP_NAME_COLOR", v) end,
})

ESPLeft:AddLabel("Distance Color"):AddColorPicker("ESPDistColor", {
    Default = ESP_DIST_COLOR,
    Callback = function(v) ESP_DIST_COLOR = v; SetCfg("ESP_DIST_COLOR", v) end,
})

ESPLeft:AddLabel("Skeleton Color"):AddColorPicker("ESPSkeletonColor", {
    Default = ESP_SKELETON_COLOR,
    Callback = function(v)
        ESP_SKELETON_COLOR = v; SetCfg("ESP_SKELETON_COLOR", v)
        for _, lines in pairs(SkeletonESP) do
            for _, line in ipairs(lines) do
                if line then line.Color = v end
            end
        end
    end,
})

ESPLeft:AddSlider("ESPMaxDist", {
    Text = "Max Distance (studs)",
    Default = ESP_MAX_DISTANCE,
    Min = 50, Max = 5000, Rounding = 0,
    Callback = function(v) ESP_MAX_DISTANCE = v; SetCfg("ESP_MAX_DISTANCE", v) end,
})

ESPRight:AddToggle("AimViewToggle", {
    Text = "Aim View",
    Default = ENABLE_AIM_VIEW,
    Callback = function(v) ENABLE_AIM_VIEW = v; SetCfg("ENABLE_AIM_VIEW", v) end,
})

ESPRight:AddSlider("AimViewLength", {
    Text = "Length",
    Default = AIM_VIEW_LENGTH,
    Min = 1, Max = 100, Rounding = 0,
    Callback = function(v) AIM_VIEW_LENGTH = v; SetCfg("AIM_VIEW_LENGTH", v) end,
})

ESPRight:AddSlider("AimViewThickness", {
    Text = "Thickness",
    Default = AIM_VIEW_THICKNESS,
    Min = 1, Max = 10, Rounding = 0,
    Callback = function(v) AIM_VIEW_THICKNESS = v; SetCfg("AIM_VIEW_THICKNESS", v) end,
})

ESPRight:AddLabel("Safe Color"):AddColorPicker("AimViewSafeColor", {
    Default = AIM_VIEW_SAFE_COLOR,
    Callback = function(v) AIM_VIEW_SAFE_COLOR = v; SetCfg("AIM_VIEW_SAFE_COLOR", v) end,
})

ESPRight:AddLabel("Danger Color"):AddColorPicker("AimViewDangerColor", {
    Default = AIM_VIEW_DANGER_COLOR,
    Callback = function(v) AIM_VIEW_DANGER_COLOR = v; SetCfg("AIM_VIEW_DANGER_COLOR", v) end,
})

ESPRight:AddSlider("ESPInterval", {
    Text = "Update Interval",
    Default = ESP_UPDATE_INTERVAL,
    Min = 0.001, Max = 0.1, Rounding = 3,
    Callback = function(v) ESP_UPDATE_INTERVAL = v; SetCfg("ESP_UPDATE_INTERVAL", v) end,
})

local HvHLeft = Tabs.HvH:AddLeftGroupbox("HvH Features")

HvHLeft:AddToggle("SpinbotToggle", {
    Text = "Spinbot",
    Default = ENABLE_SPINBOT,
    Callback = function(v) ENABLE_SPINBOT = v; SetCfg("ENABLE_SPINBOT", v) end,
})

HvHLeft:AddSlider("SpinbotSpeed", {
    Text = "Spinbot Speed",
    Default = SPINBOT_SPEED,
    Min = 1, Max = 500, Rounding = 0,
    Callback = function(v) SPINBOT_SPEED = v; SetCfg("SPINBOT_SPEED", v) end,
})

local MovLeft = Tabs.Movement:AddLeftGroupbox("Speed & Jump")

MovLeft:AddToggle("SpeedToggle", {
    Text = "Speed Hack",
    Default = SpeedEnabled,
    Callback = function(v) SpeedEnabled = v end,
})

MovLeft:AddToggle("VelocitySpeedToggle", {
    Text = "Velocity Mode",
    Default = USE_VELOCITY_SPEED,
    Callback = function(v) USE_VELOCITY_SPEED = v; SetCfg("USE_VELOCITY_SPEED", v) end,
})

MovLeft:AddSlider("VelocitySpeedValue", {
    Text = "Velocity Amount",
    Default = VELOCITY_SPEED_VALUE,
    Min = 1, Max = 1000, Rounding = 0,
    Callback = function(v) VELOCITY_SPEED_VALUE = v; SetCfg("VELOCITY_SPEED_VALUE", v) end,
})

MovLeft:AddSlider("WalkspeedValue", {
    Text = "WalkSpeed",
    Default = WALKSPEED_VALUE,
    Min = 1, Max = 1000, Rounding = 0,
    Callback = function(v) WALKSPEED_VALUE = v; SetCfg("WALKSPEED_VALUE", v) end,
})

MovLeft:AddSlider("DefaultSpeed", {
    Text = "Default Speed",
    Default = DEFAULT_SPEED,
    Min = 1, Max = 100, Rounding = 0,
    Callback = function(v) DEFAULT_SPEED = v; SetCfg("DEFAULT_SPEED", v) end,
})

MovLeft:AddToggle("InfiniteJumpToggle", {
    Text = "Infinite Jump",
    Default = ENABLE_INFINITE_JUMP,
    Callback = function(v) ENABLE_INFINITE_JUMP = v; SetCfg("ENABLE_INFINITE_JUMP", v) end,
})

MovLeft:AddSlider("JumpPower", {
    Text = "Jump Power",
    Default = JUMP_POWER,
    Min = 10, Max = 500, Rounding = 0,
    Callback = function(v)
        JUMP_POWER = v; SetCfg("JUMP_POWER", v)
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = v end
        end
    end,
})

MovLeft:AddButton({
    Text = "Reset to Defaults",
    Func = function()
        ResetMovementDefaults()
        ShowAimStatus("Movement reset to defaults")
    end,
})

MovLeft:AddToggle("NoclipToggle", {
    Text = "Noclip",
    Default = ENABLE_NOCLIP,
    Callback = function(v) ENABLE_NOCLIP = v; SetCfg("ENABLE_NOCLIP", v) end,
})

local CosLeft  = Tabs.Cosmetics:AddLeftGroupbox("Character")

CosLeft:AddToggle("KorbloxToggle", {
    Text = "Korblox Leg",
    Default = EQUIP_KORBLOX,
    Callback = function(v) EQUIP_KORBLOX = v; SetCfg("EQUIP_KORBLOX", v) end,
})

CosLeft:AddToggle("HeadlessToggle", {
    Text = "Headless",
    Default = EQUIP_HEADLESS,
    Callback = function(v) EQUIP_HEADLESS = v; SetCfg("EQUIP_HEADLESS", v) end,
})

CosLeft:AddToggle("SkotnToggle", {
    Text = "Skotn Hat",
    Default = EQUIP_SKOTN,
    Callback = function(v) EQUIP_SKOTN = v; SetCfg("EQUIP_SKOTN", v) end,
})

CosLeft:AddButton({
    Text = "Apply Cosmetics",
    Func = function() ApplyCosmetics() end,
})

local UtilsLeft = Tabs.Utils:AddLeftGroupbox("Player List")
local UtilsRight = Tabs.Utils:AddRightGroupbox("Quick Actions")

local BangStates = {}

local function UpdatePlayerList()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        
        local displayName = plr.DisplayName
        local username = plr.Name
        local userId = plr.UserId
        
        UtilsLeft:AddLabel(string.format("━━━━━━━━━━━━━━━━━━━━━━"))
        UtilsLeft:AddLabel(string.format("Player: %s", displayName))
        UtilsLeft:AddLabel(string.format("Username: @%s", username))
        UtilsLeft:AddLabel(string.format("User ID: %d", userId))
        
        local coordLabel = UtilsLeft:AddLabel("Coords: Loading...")
        
        task.spawn(function()
            while plr and plr.Parent do
                local char = plr.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local pos = hrp.Position
                        pcall(function()
                            coordLabel:SetText(string.format("Coords: %.0f, %.0f, %.0f", pos.X, pos.Y, pos.Z))
                        end)
                    end
                end
                task.wait(0.5)
            end
        end)
        
        UtilsLeft:AddButton({
            Text = "Teleport",
            Func = function()
                pcall(function()
                    local targetChar = plr.Character
                    local localChar = LocalPlayer.Character
                    if targetChar and localChar then
                        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                        local localHRP = localChar:FindFirstChild("HumanoidRootPart")
                        if targetHRP and localHRP then
                            localHRP.CFrame = targetHRP.CFrame * CFrame_new(0, 0, 3)
                            ShowAimStatus("Teleported to " .. displayName)
                        end
                    end
                end)
            end,
        })
        
        if not BangStates[plr] then
            BangStates[plr] = { active = false, originalPos = nil, connection = nil }
        end
        
        UtilsLeft:AddToggle("Bang_" .. plr.UserId, {
            Text = "Bang " .. displayName,
            Default = false,
            Callback = function(v)
                local state = BangStates[plr]
                if v then
                    pcall(function()
                        local localChar = LocalPlayer.Character
                        local targetChar = plr.Character
                        if not localChar or not targetChar then 
                            if Options["Bang_" .. plr.UserId] then
                                Options["Bang_" .. plr.UserId]:SetValue(false)
                            end
                            return 
                        end
                        
                        local localHRP = localChar:FindFirstChild("HumanoidRootPart")
                        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                        if not localHRP or not targetHRP then 
                            if Options["Bang_" .. plr.UserId] then
                                Options["Bang_" .. plr.UserId]:SetValue(false)
                            end
                            return 
                        end
                        
                        state.originalPos = localHRP.CFrame
                        state.active = true
                        
                        local bangDistance = 2
                        local forward = true
                        
                        state.connection = RunService.Heartbeat:Connect(function()
                            if not state.active then return end
                            pcall(function()
                                if not plr or not plr.Parent or not targetChar or not targetChar.Parent then
                                    state.active = false
                                    if state.connection then 
                                        state.connection:Disconnect() 
                                        state.connection = nil
                                    end
                                    if Options["Bang_" .. plr.UserId] then
                                        Options["Bang_" .. plr.UserId]:SetValue(false)
                                    end
                                    if localHRP and state.originalPos then
                                        localHRP.CFrame = state.originalPos
                                    end
                                    return
                                end
                                
                                local tHRP = targetChar:FindFirstChild("HumanoidRootPart")
                                if not tHRP then return end
                                
                                local targetPos = tHRP.CFrame
                                local offset = forward and bangDistance or -bangDistance
                                localHRP.CFrame = targetPos * CFrame_new(0, 0, offset)
                                
                                forward = not forward
                            end)
                        end)
                        
                        ShowAimStatus("Banging " .. displayName)
                    end)
                else
                    state.active = false
                    if state.connection then
                        state.connection:Disconnect()
                        state.connection = nil
                    end
                    pcall(function()
                        local localChar = LocalPlayer.Character
                        if localChar and state.originalPos then
                            local localHRP = localChar:FindFirstChild("HumanoidRootPart")
                            if localHRP then
                                localHRP.CFrame = state.originalPos
                            end
                        end
                    end)
                    ShowAimStatus("Stopped banging " .. displayName)
                end
            end,
        })
    end
    
    UtilsLeft:AddLabel(string.format("━━━━━━━━━━━━━━━━━━━━━━"))
end

task.spawn(function()
    task.wait(0.5)
    UpdatePlayerList()
end)

UtilsLeft:AddButton({
    Text = "Refresh Player List",
    Func = function()
        UpdatePlayerList()
        ShowAimStatus("Player list refreshed")
    end,
})

Connections[#Connections + 1] = RunService.Heartbeat:Connect(function()
    if not InternalRunning then return end
    for plr, state in pairs(BangStates) do
        if state.active and (not plr or not plr.Parent) then
            state.active = false
            if state.connection then
                state.connection:Disconnect()
                state.connection = nil
            end
            pcall(function()
                if Options["Bang_" .. plr.UserId] then
                    Options["Bang_" .. plr.UserId]:SetValue(false)
                end
            end)
        end
    end
end)

UtilsRight:AddButton({
    Text = "Copy Username",
    Func = function()
        pcall(function()
            setclipboard(LocalPlayer.Name)
            ShowAimStatus("Copied: " .. LocalPlayer.Name)
        end)
    end,
})

UtilsRight:AddButton({
    Text = "Reset Character",
    Func = function()
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.Health = 0 end
            end
        end)
    end,
})

UtilsRight:AddButton({
    Text = "Rejoin Server",
    Func = function()
        pcall(function()
            local TS = game:GetService("TeleportService")
            TS:Teleport(game.PlaceId, LocalPlayer)
        end)
    end,
})

UtilsRight:AddButton({
    Text = "Copy Join Link",
    Func = function()
        pcall(function()
            local placeId  = game.PlaceId
            local jobId    = game.JobId
            local link = string.format(
                "roblox://experiences/start?placeId=%s&gameInstanceId=%s",
                tostring(placeId), tostring(jobId)
            )
            setclipboard(link)
            ShowAimStatus("Join link copied!")
        end)
    end,
})

UtilsRight:AddButton({
    Text = "Copy Game ID",
    Func = function()
        pcall(function()
            setclipboard(tostring(game.PlaceId))
            ShowAimStatus("PlaceId: " .. tostring(game.PlaceId))
        end)
    end,
})

local MiscLeft  = Tabs.Misc:AddLeftGroupbox("Keybinds")
local MiscRight = Tabs.Misc:AddRightGroupbox("System")

MiscLeft:AddLabel("F1  -  Toggle menu visibility")

MiscLeft:AddInput("SilentAimKeyInput", {
    Text = "Silent Aim Key",
    Default = SILENT_AIM_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. E",
    Callback = function(v)
        if v == "" then return end
        SILENT_AIM_KEY = v; SetCfg("SILENT_AIM_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("Silent Aim key: " .. v)
    end,
})

MiscLeft:AddInput("AimlockKeyInput", {
    Text = "Aimlock Key",
    Default = AIMLOCK_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key or MouseButton2",
    Callback = function(v)
        if v == "" then return end
        AIMLOCK_KEY = v; SetCfg("AIMLOCK_KEY", v); RefreshAimlockBind()
        ShowAimStatus("Aimlock key: " .. v)
    end,
})

MiscLeft:AddInput("SpeedKeyInput", {
    Text = "Speed Key",
    Default = SPEED_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. Q",
    Callback = function(v)
        if v == "" then return end
        SPEED_KEY = v; SetCfg("SPEED_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("Speed key: " .. v)
    end,
})

MiscLeft:AddInput("SpinbotKeyInput", {
    Text = "Spinbot Key",
    Default = SPINBOT_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. F8",
    Callback = function(v)
        if v == "" then return end
        SPINBOT_KEY = v; SetCfg("SPINBOT_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("Spinbot key: " .. v)
    end,
})

MiscLeft:AddInput("HvHKeyInput", {
    Text = "HvH Toggle Key",
    Default = HVH_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. H",
    Callback = function(v)
        if v == "" then return end
        HVH_KEY = v; SetCfg("HVH_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("HvH key: " .. v)
    end,
})

MiscLeft:AddInput("NoclipKeyInput", {
    Text = "Noclip Key",
    Default = NOCLIP_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. N",
    Callback = function(v)
        if v == "" then return end
        NOCLIP_KEY = v; SetCfg("NOCLIP_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("Noclip key: " .. v)
    end,
})

MiscLeft:AddInput("TerminateKeyInput", {
    Text = "Kill Switch Key",
    Default = TERMINATE_KEY,
    Numeric = false,
    Finished = true,
    Placeholder = "Key name e.g. F3",
    Callback = function(v)
        if v == "" then return end
        TERMINATE_KEY = v; SetCfg("TERMINATE_KEY", v); RefreshKeycodeCache()
        ShowAimStatus("Kill Switch key: " .. v)
    end,
})

MiscRight:AddSlider("TargetFPS", {
    Text = "FPS Cap",
    Default = TARGET_FPS,
    Min = 1, Max = 1000, Rounding = 0,
    Callback = function(v)
        TARGET_FPS = v; SetCfg("TARGET_FPS", v)
        pcall(function() setfpscap(v) end)
    end,
})

MiscRight:AddButton({
    Text = "Unload Script",
    Func = function() Cleanup() end,
})

MiscRight:AddButton({
    Text = "Kill Switch",
    Func = function()
        warn("[Snowfall] Kill Switch activated - resetting everything to default...")
        
        SilentAimEnabled   = false
        SILENT_AIM_ENABLED = false
        LockedTarget       = nil
        SetTracerVisible(false)
        SpinbotEnabled     = false
        ENABLE_SPINBOT     = false
        AimlockActive      = false
        AimlockTarget      = nil
        ENABLE_AIMLOCK     = false
        ENABLE_TRIGGER_BOT = false
        
        ENABLE_ESP = false
        ENABLE_2D_BOX_ESP = false
        ENABLE_HEALTHBAR_ESP = false
        ENABLE_DISTANCE_ESP = false
        ENABLE_SKELETON_ESP = false
        ENABLE_CHAMS = false
        ENABLE_LOCAL_PLAYER_ESP = false
        ENABLE_AIM_VIEW = false
        
        for _, plr in ipairs(Players:GetPlayers()) do
            RemoveChamsFromPlayer(plr)
        end
        
        ResetMovementDefaults()
        
        task.wait(0.1)
        Cleanup()
    end,
})

local SocLeft  = Tabs.Socials:AddLeftGroupbox("YouTube")
local SocRight = Tabs.Socials:AddRightGroupbox("Discord")

SocLeft:AddLabel("Subscribe for scripts & updates!")
SocLeft:AddLabel(YOUTUBE_LINK)
SocLeft:AddButton({
    Text = "Copy YouTube Link",
    Func = function()
        pcall(function()
            setclipboard(YOUTUBE_LINK)
            ShowAimStatus("YouTube copied!")
        end)
    end,
})

SocRight:AddLabel("Join for support & announcements!")
SocRight:AddLabel(DISCORD_LINK)
SocRight:AddButton({
    Text = "Copy Discord Link",
    Func = function()
        pcall(function()
            setclipboard(DISCORD_LINK)
            ShowAimStatus("Discord copied!")
        end)
    end,
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:SetFolder("SnowfallCC")
SaveManager:BuildConfigSection(Tabs.Misc)
ThemeManager:ApplyToTab(Tabs.Misc)

local function SaveAllSettings()
    local cfg = getgenv().SnowfallConfig or {}
    
    cfg.SHOW_AIM_STATUS_TEXT = SHOW_AIM_STATUS_TEXT
    cfg.SILENT_AIM_ENABLED = SILENT_AIM_ENABLED
    cfg.TRACER_ENABLED = TRACER_ENABLED
    cfg.TRACER_COLOR = TRACER_COLOR
    cfg.TRACER_THICKNESS = TRACER_THICKNESS
    cfg.SILENT_AIM_KEY = SILENT_AIM_KEY
    cfg.SILENT_HIT_CHANCE = SILENT_HIT_CHANCE
    cfg.SILENT_HIT_PART = SILENT_HIT_PART
    cfg.AIMLOCK_KEY = AIMLOCK_KEY
    cfg.AIMLOCK_SMOOTH = AIMLOCK_SMOOTH
    cfg.AIMLOCK_FOV = AIMLOCK_FOV
    cfg.AIMLOCK_PART = AIMLOCK_PART
    cfg.AIMLOCK_FOV_TYPE = AIMLOCK_FOV_TYPE
    cfg.AIMLOCK_FOV_COLOR = AIMLOCK_FOV_COLOR
    cfg.ENABLE_AIMLOCK = ENABLE_AIMLOCK
    cfg.ENABLE_TRIGGER_BOT = ENABLE_TRIGGER_BOT
    cfg.TRIGGER_SHOOT_DELAY = TRIGGER_SHOOT_DELAY
    
    cfg.ENABLE_ESP = ENABLE_ESP
    cfg.ENABLE_LOCAL_PLAYER_ESP = ENABLE_LOCAL_PLAYER_ESP
    cfg.ENABLE_2D_BOX_ESP = ENABLE_2D_BOX_ESP
    cfg.ENABLE_AIM_VIEW = ENABLE_AIM_VIEW
    cfg.ENABLE_HEALTHBAR_ESP = ENABLE_HEALTHBAR_ESP
    cfg.ENABLE_DISTANCE_ESP = ENABLE_DISTANCE_ESP
    cfg.ENABLE_SKELETON_ESP = ENABLE_SKELETON_ESP
    cfg.ENABLE_CHAMS = ENABLE_CHAMS
    cfg.CHAMS_COLOR = CHAMS_COLOR
    cfg.CHAMS_TRANSPARENCY = CHAMS_TRANSPARENCY
    cfg.ESP_MAX_DISTANCE = ESP_MAX_DISTANCE
    cfg.ESP_MODE = ESP_MODE
    cfg.ESP_BOX_COLOR = ESP_BOX_COLOR
    cfg.ESP_NAME_COLOR = ESP_NAME_COLOR
    cfg.ESP_DIST_COLOR = ESP_DIST_COLOR
    cfg.ESP_SKELETON_COLOR = ESP_SKELETON_COLOR
    cfg.AIM_VIEW_DANGER_COLOR = AIM_VIEW_DANGER_COLOR
    cfg.AIM_VIEW_SAFE_COLOR = AIM_VIEW_SAFE_COLOR
    cfg.AIM_VIEW_LENGTH = AIM_VIEW_LENGTH
    cfg.AIM_VIEW_THICKNESS = AIM_VIEW_THICKNESS
    cfg.ESP_UPDATE_INTERVAL = ESP_UPDATE_INTERVAL
    
    cfg.ENABLE_SPINBOT = ENABLE_SPINBOT
    cfg.SPINBOT_KEY = SPINBOT_KEY
    cfg.SPINBOT_SPEED = SPINBOT_SPEED
    cfg.HVH_KEY = HVH_KEY
    
    cfg.USE_VELOCITY_SPEED = USE_VELOCITY_SPEED
    cfg.VELOCITY_SPEED_VALUE = VELOCITY_SPEED_VALUE
    cfg.WALKSPEED_VALUE = WALKSPEED_VALUE
    cfg.DEFAULT_SPEED = DEFAULT_SPEED
    cfg.SPEED_KEY = SPEED_KEY
    cfg.ENABLE_NOCLIP = ENABLE_NOCLIP
    cfg.NOCLIP_KEY = NOCLIP_KEY
    cfg.ENABLE_INFINITE_JUMP = ENABLE_INFINITE_JUMP
    cfg.JUMP_POWER = JUMP_POWER
    cfg.TARGET_FPS = TARGET_FPS
    
    cfg.EQUIP_KORBLOX = EQUIP_KORBLOX
    cfg.EQUIP_HEADLESS = EQUIP_HEADLESS
    cfg.EQUIP_SKOTN = EQUIP_SKOTN
    cfg.TERMINATE_KEY = TERMINATE_KEY
    cfg.SHOW_WATERMARK = SHOW_WATERMARK
    
    getgenv().SnowfallConfig = cfg
    
    if writefile and readfile then
        local success, err = pcall(function()
            writefile("snowfall_config.json", game:GetService("HttpService"):JSONEncode(cfg))
        end)
        if success then
            ShowAimStatus("Config saved successfully!")
        else
            ShowAimStatus("Config save failed!")
        end
    end
end

local function LoadAllSettings()
    if readfile then
        local success, data = pcall(function()
            return readfile("snowfall_config.json")
        end)
        if success and data then
            local cfg = game:GetService("HttpService"):JSONDecode(data)
            getgenv().SnowfallConfig = cfg
            
            if cfg.TRACER_COLOR then TRACER_COLOR = cfg.TRACER_COLOR end
            if cfg.TRACER_THICKNESS then TRACER_THICKNESS = cfg.TRACER_THICKNESS end
            if cfg.AIMLOCK_FOV_COLOR then AIMLOCK_FOV_COLOR = cfg.AIMLOCK_FOV_COLOR end
            if cfg.ESP_BOX_COLOR then ESP_BOX_COLOR = cfg.ESP_BOX_COLOR end
            if cfg.ESP_NAME_COLOR then ESP_NAME_COLOR = cfg.ESP_NAME_COLOR end
            if cfg.ESP_DIST_COLOR then ESP_DIST_COLOR = cfg.ESP_DIST_COLOR end
            if cfg.ESP_SKELETON_COLOR then ESP_SKELETON_COLOR = cfg.ESP_SKELETON_COLOR end
            if cfg.CHAMS_COLOR then CHAMS_COLOR = cfg.CHAMS_COLOR end
            if cfg.CHAMS_TRANSPARENCY then CHAMS_TRANSPARENCY = cfg.CHAMS_TRANSPARENCY end
            if cfg.AIM_VIEW_DANGER_COLOR then AIM_VIEW_DANGER_COLOR = cfg.AIM_VIEW_DANGER_COLOR end
            if cfg.AIM_VIEW_SAFE_COLOR then AIM_VIEW_SAFE_COLOR = cfg.AIM_VIEW_SAFE_COLOR end
            if cfg.VELOCITY_SPEED_VALUE then VELOCITY_SPEED_VALUE = cfg.VELOCITY_SPEED_VALUE end
            if cfg.WALKSPEED_VALUE then WALKSPEED_VALUE = cfg.WALKSPEED_VALUE end
            if cfg.DEFAULT_SPEED then DEFAULT_SPEED = cfg.DEFAULT_SPEED end
            if cfg.JUMP_POWER then JUMP_POWER = cfg.JUMP_POWER end
            if cfg.SPINBOT_SPEED then SPINBOT_SPEED = cfg.SPINBOT_SPEED end
            if cfg.TARGET_FPS then TARGET_FPS = cfg.TARGET_FPS; pcall(function() setfpscap(TARGET_FPS) end) end
            
            ShowAimStatus("Config loaded successfully!")
        end
    end
end

MiscRight:AddButton({
    Text = "Save Config",
    Func = function()
        SaveAllSettings()
    end,
})

MiscRight:AddButton({
    Text = "Load Config",
    Func = function()
        LoadAllSettings()
    end,
})

MiscRight:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "F1",
    NoUI = true,
    Text = "Menu toggle",
})
Library.ToggleKeybind = Options.MenuKeybind

MiscRight:AddToggle("WatermarkToggle", {
    Text = "Watermark",
    Default = SHOW_WATERMARK,
    Callback = function(v)
        SHOW_WATERMARK = v; SetCfg("SHOW_WATERMARK", v)
        Library:SetWatermarkVisibility(v)
    end,
})

pcall(function()
    ThemeManager:ApplyTheme("Quartz")
end)

pcall(function()
    Library.BackgroundColor = Color3.fromHex("1d1b26")
    Library.MainColor       = Color3.fromHex("232330")
    Library.AccentColor     = Color3.fromHex("64859d")
    Library.OutlineColor    = Color3.fromHex("27232f")
    Library.FontColor       = Color3.fromHex("ffffff")
    Library:UpdateColors()
end)
local _wmFrameCount = 0
local _wmFrameTimer = tick()
local _wmFPS        = 60

Library:SetWatermarkVisibility(SHOW_WATERMARK)




local WatermarkConnection = RunService.RenderStepped:Connect(function()
    _wmFrameCount = _wmFrameCount + 1
    local now = tick()
    if now - _wmFrameTimer >= 1 then
        _wmFPS        = _wmFrameCount
        _wmFrameCount = 0
        _wmFrameTimer = now
        -- Only update watermark text once per second (FPS only changes once per second anyway)
        if SHOW_WATERMARK then
            local d = os.date("*t")
            Library:SetWatermark(string.format(
                "snowfall.cc  |  %s  |  %d fps  |  %02d/%02d/%04d",
                LocalPlayer.Name, _wmFPS, d.month, d.day, d.year
            ))
        end
    end
end)
Connections[#Connections + 1] = WatermarkConnection

Library:OnUnload(function()
    if WatermarkConnection then
        WatermarkConnection:Disconnect()
    end
    Library.Unloaded = true
end)

local TerminateConnection = UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == cachedTerminateKey then
        warn("[Snowfall] F3 pressed - resetting everything to default and terminating")
        
        SilentAimEnabled   = false
        SILENT_AIM_ENABLED = false
        LockedTarget       = nil
        SetTracerVisible(false)
        SpinbotEnabled     = false
        ENABLE_SPINBOT     = false
        AimlockActive      = false
        AimlockTarget      = nil
        ENABLE_AIMLOCK     = false
        ENABLE_TRIGGER_BOT = false
        
        ENABLE_ESP = false
        ENABLE_2D_BOX_ESP = false
        ENABLE_HEALTHBAR_ESP = false
        ENABLE_DISTANCE_ESP = false
        ENABLE_SKELETON_ESP = false
        ENABLE_CHAMS = false
        ENABLE_LOCAL_PLAYER_ESP = false
        ENABLE_AIM_VIEW = false
        
        for _, plr in ipairs(Players:GetPlayers()) do
            RemoveChamsFromPlayer(plr)
        end
        
        ResetMovementDefaults()
        
        if WatermarkConnection then
            WatermarkConnection:Disconnect()
        end
        
        pcall(function()
            if Library and Library.Unload then
                Library:Unload()
            end
        end)
        
        task.wait(0.1)
        
        Cleanup()
        
        pcall(function()
            for _, obj in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if obj.Name and (obj.Name:find("Linoria") or obj.Name:find("snowfall")) then
                    obj:Destroy()
                end
            end
        end)
        
        if TerminateConnection then
            TerminateConnection:Disconnect()
        end
        
        warn("[Snowfall] Everything reset to default and script fully terminated")
    end
end)
Connections[#Connections + 1] = TerminateConnection
