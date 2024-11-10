cannon_sensor_target = peripheral.wrap("create_target_0")

chargeCount = 4
cannonLength = 9

function getCannonYaw()
    local yaw_string = cannon_sensor_target.getLine(2)
    local data = yaw_string:match("([-+]?%d+%.?%d*)")

    return tonumber(data)
end

function getCannonPitch()
    local pitch_string = cannon_sensor_target.getLine(1)
    local data = pitch_string:match("([-+]?%d+%.?%d*)")

    return tonumber(data)
end

function getFacingDirection(yaw)
    if(yaw >= -45 and yaw < 45) then
        return "s"
    elseif(yaw >= 45 and yaw < 135) then
        return "w"
    elseif(yaw >= 135 and yaw < -135) then
        return "n"
    else
        return "e"
    end
end

function calculateCannonAngle(cx, cy, cz, tx, ty, tz)
    local dx = tx - cx
    local dy = ty - cy
    local dz = tz - cz

    local dxy = math.sqrt(dx^2 + dz^2)

    local facing = getFacingDirection(getCannonYaw())
    local yaw

    if(facing == "n") then
        yaw = math.deg(math.atan2(dz, -dx))
    elseif(facing == "s") then
        yaw = math.deg(math.atan2(-dz, dx))
    elseif(facing == "e") then
        yaw = math.deg(math.atan2(dz, dx))
    elseif(facing == "w") then
        yaw = math.deg(math.atan2(-dz, -dx))
    end

    local init_velocity = chargeCount * 20 + cannonLength * 0.5
    local discrim = init_velocity^4 - 9.8 * (9.8 * dxy^2 + 2 * dy + init_velocity^2)

    local pitch_a = math.deg(math.atan((init_velocity^2 + math.sqrt(discrim)) / (9.8 * dxy)))
    local pitch_b = math.deg(math.atan((init_velocity^2 - math.sqrt(discrim)) / (9.8 * dxy)))

    return yaw, math.min(pitch_a, pitch_b)
end

