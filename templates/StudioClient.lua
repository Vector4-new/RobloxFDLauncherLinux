_G.ShowNames=true _G.app='%APPEARANCE%' print(_G.app)
origstring =_G.app
local foundchar=false
local username1 = '%USERNAME%'
local username = '%USERNAME%'
local a=Instance.new('StringValue') a.Parent=game:GetService('ReplicatedStorage') a.Name=game:GetService('Players').LocalPlayer.Name a.Value=username
local number= nil
 local words = {}
for w in (origstring .. ';'):gmatch('([^;]*);') do 
    table.insert(words, w) 
end
local num1=words[1]
function loadchar()
wait(1)
local char = game:GetService('Players').LocalPlayer.Character
for i,v in pairs(words) do
    pcall(function()
	local a=game:GetService('ReplicatedStorage'):FindFirstChild('charapp')
     a:FireServer(v)
	 end)
	end
game:GetService('ReplicatedStorage').BodyColorsRemote:FireServer('%BODYCOLOURS%')
local a={}
game:GetService('ReplicatedStorage').Nametag:FireServer(username)
end
game:GetService('Players').PlayerAdded:connect(function(plr)
if plr == game:GetService('Players').LocalPlayer then
foundchar=true
if workspace:FindFirstChild(plr.Name) then
if plr.Character~=nil then
loadchar()
end
end
game:GetService('Players').LocalPlayer.CharacterAdded:connect(function()
pcall(function()
loadchar()
end)
end)
end
end)
repeat wait() until game:GetService('Players').LocalPlayer.Character~=nil
local char=game:GetService('Players').LocalPlayer.Character

wait(0.1)
if foundchar==false and game:GetService('Players').LocalPlayer~=nil then
loadchar()
game:GetService('Players').LocalPlayer.CharacterAdded:connect(function()
pcall(function()
loadchar()
end)
end)
else
repeat wait() until game:GetService('Players').LocalPlayer~=nil
loadchar()
game:GetService('Players').LocalPlayer.CharacterAdded:connect(function()
pcall(function()
loadchar()
end)
end)
end
local shortcut=Instance.new('BoolValue',game:GetService('Players').LocalPlayer) shortcut.Name='ShowNames' shortcut.Value=_G.ShowNames