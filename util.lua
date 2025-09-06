-- GitHub script content:
return function(targetPosition)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    workspace.Gravity = 0
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)

    local function moveTo(target, speed)
        local dt = RunService.Heartbeat:Wait()
        local direction = (target - hrp.Position)
        local distance = direction.Magnitude
        if distance < 1 then return true end
        local moveStep = direction.Unit * math.min(speed * dt, distance)
        hrp.CFrame = hrp.CFrame + moveStep
        return false
    end

    spawn(function()
        while hrp.Position.Y < 350 - 1 do
            moveTo(Vector3.new(hrp.Position.X, 350, hrp.Position.Z), 500)
        end
        while (Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(targetPosition.X, 0, targetPosition.Z)).Magnitude > 1 do
            moveTo(Vector3.new(targetPosition.X, 350, targetPosition.Z), 120)
        end
        while math.abs(hrp.Position.Y - targetPosition.Y) > 1 do
            local distance = math.abs(hrp.Position.Y - targetPosition.Y)
            local speed = 300
            if distance <= 20 then
                speed = 30
            end
            moveTo(Vector3.new(targetPosition.X, targetPosition.Y, targetPosition.Z), speed)
        end
        workspace.Gravity = 196.2
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end)
end
