-- Create a leaderboard
local Players = game:GetService("Players")
local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"

-- Create a datastore
local DataStoreService = game:GetService("DataStoreService")
local MoneyDataStore = DataStoreService:GetDataStore("Money")

-- Define a function to give money to a player
local function giveMoney(player, amount)
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        local money = stats:FindFirstChild("Money")
        if money then
            money.Value = money.Value + amount -- Update the value of money
            MoneyDataStore:SetAsync(player.UserId, money.Value) -- Save the value of money to the datastore
        end
    end
end

-- Define a function to load money from the datastore for a player
local function loadMoney(player)
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        local money = stats:FindFirstChild("Money")
        if money then
            local savedMoney = MoneyDataStore:GetAsync(player.UserId) -- Get the saved value of money from the datastore
            if savedMoney then -- If there is a saved value, use it
                money.Value = savedMoney 
            else -- If there is no saved value, use 0 as default
                money.Value = 5000 
            end
        end
    end    
end

-- Define a function to create a leaderboard for a player when they join the game
local function onPlayerAdded(player)
    local stats = leaderstats:Clone() -- Clone the leaderstats folder
    
    -- Create an IntValue object to store the player's money 
    local money = Instance.new("IntValue") 
    money.Name = "Sierrians"
    
    -- Add the IntValue object as a child of the leaderstats folder 
    money.Parent = stats 
    
    -- Add the leaderstats folder as a child of the player 
    stats.Parent = player 
    
    loadMoney(player) -- Load the player's money from the datastore
    
end

-- Connect the onPlayerAdded function to run when any player joins 
Players.PlayerAdded:Connect(onPlayerAdded)