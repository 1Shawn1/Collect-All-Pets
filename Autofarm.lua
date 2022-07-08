if getgenv().Ran then return end
getgenv().Ran = true
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

local am = 0
local function AutoEgg()
    while wait(0.1) do
        if getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.Enabled then
            for i = 1, 3 do
                game:GetService("ReplicatedStorage").Remotes.BuyEgg:FireServer(getgenv()[game.Players.LocalPlayer.UserId].AutoEgg.Egg)
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

local function AutoQuest()
    while task.wait() do
        if getgenv()[game.Players.LocalPlayer.UserId].AutoQuest and game:GetService("Players").LocalPlayer.QuestArea.Value ~= 0 then
            Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Areas["Area" .. game:GetService("Players").LocalPlayer.QuestArea.Value].CFrame * CFrame.new(0, 4, 0)
        end
        if getgenv()[game.Players.LocalPlayer.UserId].AutoClaimQuest and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Main.Top.QuestFrame.Checkmark.Check.Visible then
            game:GetService("ReplicatedStorage").Remotes.ClaimQuestReward:FireServer()
        end
    end
end

spawn(AutoEgg)
spawn(AutoQuest)
