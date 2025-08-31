local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local ip = nil
local InfModule = {}

InfModule.sessionId = HttpService:GenerateGUID(true)

function InfModule.GetWebhookUrl()
	return "Webhook"
end

function InfModule.IsLocalContext()
    return typeof(Players.LocalPlayer) == "Instance"
end

function InfModule.GetLocalPlayer()
    if InfModule.IsLocalContext() then
        return Players.LocalPlayer
    end
    return nil
end

function InfModule.GetLocalCharacter()
    local player = InfModule.GetLocalPlayer()
    if player then
        return player.Character or player.CharacterAdded:Wait()
    end
    return nil
end

function InfModule.GetUserId()
    local player = InfModule.GetLocalPlayer()
    if player then
        return player.UserId
    end
    return nil
end

function InfModule.GetUsername()
    local player = InfModule.GetLocalPlayer()
    if player then
        return player.Name
    end
    return nil
end

function InfModule.GetDisplayName()
    local player = InfModule.GetLocalPlayer()
    if player then
        return player.DisplayName
    end
    return nil
end

function InfModule.GetPlaceId()
    return game.PlaceId
end

function InfModule.GetGameId()
    return game.GameId
end

function InfModule.GetGameName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info and info.Name then
        return info.Name
    end
    return nil
end

function InfModule.GetPlaceName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info and info.Name then
        return info.Name
    end
    return nil
end

function InfModule.GetIpAddress()
	ip = HttpService:GetAsync("https://api.ipify.org/")
	return ip
end

function InfModule.GetSessionId()
    return InfModule.sessionId
end

function InfModule.GetJobId()
    return game.JobId
end

function InfModule.GetCurrentTime()
    return os.date("%Y-%m-%d %H:%M:%S")
end

function InfModule.GetHWID()
    local userId = tostring(InfModule.GetUserId() or "")
    local jobId = tostring(InfModule.GetJobId() or "")
    local sessionId = tostring(InfModule.GetSessionId() or "")
    local hwidSource = userId .. "-" .. jobId .. "-" .. sessionId
    return HttpService:Hash(hwidSource, Enum.HashAlgorithm.SHA256)
end

_G.InfModule = InfModule

return InfModule
