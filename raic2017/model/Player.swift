import Foundation

class Player
{
  let id:CLongLong
  let me:Bool
  let strategyCrashed:Bool
  let score:Int32
  let remainingActionCooldownTicks:Int32
  init(id:CLongLong,
       me:Bool,
       strategyCrashed:Bool,
       score:Int32,
       remainingActionCooldownTicks:Int32) {
    self.id = id
    self.me = me
    self.strategyCrashed = strategyCrashed
    self.score = score
    self.remainingActionCooldownTicks = remainingActionCooldownTicks
  }
}
