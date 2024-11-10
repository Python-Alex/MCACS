local RedstoneController = require("gun.redstone_controller")

yawActuationC = colors.orange
pitchActuationC = colors.red

yawGearshiftC = colors.pink
pitchGearshiftC = colors.magenta

breachGctuactionC = colors.blue
breachGearshiftC = colors.lightBlue

yawDirection =  RedstoneController.isSignalOn(yawGearshiftC)
pitchDirection = RedstoneController.isSignalOn(pitchGearshiftC)

function toggleYawDirection()
    print(yawDirection)
    print(pitchDirection)

end