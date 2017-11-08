import Foundation

enum VehicleType:Int8 {
  case _VEHICLE_UNKNOWN_ = -1,VEHICLE_ARRV,
  VEHICLE_FIGHTER,
  VEHICLE_HELICOPTER,
  VEHICLE_IFV,
  VEHICLE_TANK
};

class Vehicle:CircularUnit {
  let playerId:CLongLong
  let durability:Int32
  let maxDurability:Int32
  let maxSpeed:Double
  let visionRange:Double
  let squaredVisionRange:Double
  let groundAttackRange:Double
  let squaredGroundAttackRange:Double
  let aerialAttackRange:Double
  let squaredAerialAttackRange:Double
  let groundDamage:Int32
  let aerialDamage:Int32
  let groundDefence:Int32
  let aerialDefence:Int32
  let attackCooldownTicks:Int32
  let remainingAttackCooldownTicks:Int32
  let type:VehicleType
  let aerial:Bool
  let selected:Bool
  let groups:[Int32]
  init(id: CLongLong,
       x: Double,
       y: Double,
       radius:Double,
       playerId:CLongLong,
       durability:Int32,
       maxDurability:Int32,
       maxSpeed:Double,
       visionRange:Double,
       squaredVisionRange:Double,
       groundAttackRange:Double,
       squaredGroundAttackRange:Double,
       aerialAttackRange:Double,
       squaredAerialAttackRange:Double,
       groundDamage:Int32,
       aerialDamage:Int32,
       groundDefence:Int32,
       aerialDefence:Int32,
       attackCooldownTicks:Int32,
       remainingAttackCooldownTicks:Int32,
       type:VehicleType,
       aerial:Bool,
       selected:Bool,
       groups:[Int32]) {
    self.playerId=playerId
    self.durability=durability
    self.maxDurability=maxDurability
    self.maxSpeed=maxSpeed
    self.visionRange=visionRange
    self.squaredVisionRange=squaredVisionRange
    self.groundAttackRange=groundAttackRange
    self.squaredGroundAttackRange=squaredGroundAttackRange
    self.aerialAttackRange=aerialAttackRange
    self.squaredAerialAttackRange=squaredAerialAttackRange
    self.groundDamage=groundDamage
    self.aerialDamage=aerialDamage
    self.groundDefence=groundDefence
    self.aerialDefence=aerialDefence
    self.attackCooldownTicks=attackCooldownTicks
    self.remainingAttackCooldownTicks=remainingAttackCooldownTicks
    self.type=type
    self.aerial=aerial
    self.selected=selected
    self.groups=groups
    super.init(id: id, x: x, y: y, radius: radius)
  }
}
