
getgenv()[game.Players.LocalPlayer.UserId] = {
    AutoEgg = {
        Enabled = true,
        --Egg = 2,
        AutoFuse = {
            Enabled = true,
            FuseEquipPets = false,
            Common = true,
            Uncommon = true,
            Rare = true,
            Epic = true,
            Legendary = true,
            Prodigious = true,
            Ascended = true
        },
    },
    AutoQuest = true,
    AutoClaimQuest = true
}


print("Ran")
local LocalPlayer = game.Players.LocalPlayer
local Character =  LocalPlayer.Character
local QuestArea = game:GetService("Players").LocalPlayer.QuestArea
local HatchRemote = game.ReplicatedStorage.Remotes.HatchEgg
local ConstantMod = require(game:GetService("ReplicatedStorage").Constants)

ConstantMod.BaseDropCollectionRange = math.huge

for i, v in next, getconnections(HatchRemote.OnClientEvent) do
    v:Disable()
end

local AutoFuzeRemote = game.ReplicatedStorage.Remotes.AutoFuse;
for i, v in next, getconnections(AutoFuzeRemote.OnClientEvent) do
    v:Disable()
end

local function GetEggToBuy()
	local Egg = 0
	for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Main.Left.Checklist:GetDescendants()) do
		if v.Name == "Check" and v.Visible then
		    Egg = Egg+1
		end
	end
    if Egg >= 6 then
        return 6
     else
	    return Egg+1
     end
end


local am = 0
local function AutoEgg()
    while wait(0.1) do
        if getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.Enabled then
            for i = 1, 3 do
                game:GetService("ReplicatedStorage").Remotes.BuyEgg:FireServer(GetEggToBuy())
            end
            if am > 100 and getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Enabled then
                game:GetService("ReplicatedStorage").Remotes.AutoFuse:FireServer({[1] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Common,[2] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Uncommon,[3] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Rare,[4] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Epic,[5] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Legendary,[6] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Prodigious,[7] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.Ascended,[8] = getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.AutoFuse.FuseEquipPets})
                am = 0
            else
                am++
            end
        end
    end
end

local function AutoQuest()	while task.wait() do
		if getgenv()[game.Players.LocalPlayer.UserId].AutoQuest and game:GetService("Players").LocalPlayer.QuestArea.Value ~= 0 then
			Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Areas["Area" .. game:GetService("Players").LocalPlayer.QuestArea.Value].CFrame * CFrame.new(0, 4, 0)
		end
	end
end

local function AutoClaimQuest()
	while task.wait() do
		if getgenv()[game.Players.LocalPlayer.UserId].AutoClaimQuest and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Main.Top.QuestFrame.Checkmark.Check.Visible then
			game:GetService("ReplicatedStorage").Remotes.ClaimQuestReward:FireServer()
			wait(1)
			game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
		end
	end
end

spawn(AutoClaimQuest)
spawn(AutoEgg)
spawn(AutoQuest)
