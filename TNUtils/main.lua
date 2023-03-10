
local function hasProperty(object, prop)
	local t = object[prop] --this is just done to check if the property existed, if it did nothing would happen, if it didn't an error will pop, the object[prop] is a different way of writing object.prop, (object.Transparency or object["Transparency"])
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Roact = require(ReplicatedStorage.Roact)
local Properties = require(ReplicatedStorage.Properties)
local RoactProperties = nil
local RPInit = false



local module = {
	getobjectfromfullname=function (fullName)
		local segments = fullName:split(".")
		local current = game

		for _,location in pairs(segments) do
			current = current[location]
		end

		return current
	end,
	toindex=function (vtable)
		local result = {}
		local i = 0
		for _,v in pairs(vtable) do
			result[i] = v
			i = i + 1
		end
		return result
	end,
	hasprop=function (v,prop)
		return pcall(function() hasProperty(v, prop) end)
	end,
	tablelength=function (table)
		local count = 0
		for _,_ in pairs(table) do
			count = count + 1
		end
		return count
	end,
	getsafename=function (object)
		local result = {}
		local temp = object
		while temp ~= game do
			table.insert(result,temp.Name)
			temp = temp.Parent
		end
		local reversed = {}
		for i = #result, 1, -1 do
			table.insert(reversed,result[i])
		end
		return game:GetService("HttpService"):JSONEncode(reversed)
	end,
	fromsafename=function (name)
		local current = game
		for i,v in pairs(game:GetService("HttpService"):JSONDecode(name)) do
			current = current[v]
		end
		return current
	end,
	getunscopedsafename=function (object,max)
		local result = {}
		local temp = object
		while temp ~= max do
			table.insert(result,temp.Name)
			temp = temp.Parent
		end
		local reversed = {}
		for i = #result, 1, -1 do
			table.insert(reversed,result[i])
		end
		return game:GetService("HttpService"):JSONEncode(reversed)
	end,
	fromunscopedname=function (start,name)
		local current = start
		for i,v in pairs(game:GetService("HttpService"):JSONDecode(name)) do
			current = current[v]
		end
		return current
	end,
	waitforunlessmore= function(duration,delta)
		if (delta >= duration) then
			return 0
		elseif (delta < duration) then
			wait(duration-delta)
			return duration-delta
		end
	end,
	keyisintable = function(table1,item)
		for i,_ in pairs(table1) do
			if i == item then
				return true
			end
		end 
		return false
	end,
	valueisintable = function(table1,item)
		for _,v in pairs(table1) do
			if v == item then
				return true
			end
		end 
		return false
	end,
	removefromtable = function(table1,item)
		local copy = {}
		for i,v in pairs(table1) do
			copy[i] = table1[i]
		end
		local index = 0
		for i,v in pairs(copy) do
			if v == item or i == item then
				table.remove(copy,index)
			end
			index = index + 1
		end 
		return copy
	end,
	removefromtable2 = function(table1,item)
		local copy = {}
		for i,v in pairs(table1) do
			if (i == item) then
				goto down;
			end
			copy[i] = table1[i]
      ::down::
		end
		return copy
	end,
	sort = function(table1)
		local copy = {}
		for i,v in pairs(table1) do
			copy[i] = table1[v]
		end
		table.sort(copy, function(a,b)
			return a < b
		end)
		return copy
	end,
	createTemplateElement = function(template, modifyprops, children, makevisible)
		if not RunService:IsClient() then
			error("This function can only run on client.")
			return nil
		end
		if not RPInit then
			RPInit = true
			RoactProperties = require(game:GetService("Players").LocalPlayer.PlayerScripts.Properties)
		end
		if pcall(function() hasProperty(template, "Visible") end) then
			template.Visible = false
		end
		local result = {}
		if (RoactProperties.GetProperties(template.ClassName) == nil) then
			print("oops")
		end
		for _,v in pairs(RoactProperties.GetProperties(template.ClassName)) do
			result[v] = template[v]
		end
		for i,v in pairs(modifyprops)  do
			result[i] = v
		end
		if (makevisible == nil or makevisible) and pcall(function() hasProperty(template, "Visible") end) then
			result["Visible"] = true
		end
		
		return Roact.createElement(template.ClassName,result,(function()
			if children == nil then
				return nil
			else
				return children(template)
			end
		end)())
	end,
	roactify = function (template,makevisible)
		if not RunService:IsClient() then
			error("This function can only run on client.")
			return nil
		end
		if not RPInit then
			RPInit = true
			RoactProperties = require(game:GetService("Players").LocalPlayer.PlayerScripts.Properties)
		end
		if pcall(function() hasProperty(template, "Visible") end) then
			template.Visible = false
		end
		local result = {}
		for _,v in pairs(RoactProperties.GetProperties(template.ClassName)) do
			result[v] = template[v]
		end
		if (makevisible == nil or makevisible) and pcall(function() hasProperty(template, "Visible") end) then
			result["Visible"] = true
		end
		return Roact.createElement(template.ClassName,result,nil)
	end,
	mergetables = function (table1,table2)
		local result = {}
		for i,v in pairs(table1) do
			result[i] = table1[i]
		end
		for i,v in pairs(table2)  do
			result[i] = table2[i]
		end
		return result
	end,
}

return module
