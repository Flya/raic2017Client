import Foundation

class VehicleUpdate {
  let id:CLongLong
  let x:Double
  let y:Double
  let durability:Int32
  let remainingAttackCooldownTicks:Int32
  let selected:Bool
  let groups:[Int32]
  init( id:CLongLong,
        x:Double,
        y:Double,
        durability:Int32,
        remainingAttackCooldownTicks:Int32,
        selected:Bool,
        groups:[Int32])
  {
    self.id = id
    self.x = x
    self.y = y
    self.durability = durability
    self.remainingAttackCooldownTicks = remainingAttackCooldownTicks
    self.selected = selected
    self.groups = groups
  }
}
