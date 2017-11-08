import Foundation

class Unit {
  let id:CLongLong
  let x:Double
  let y:Double
  
  init(id:CLongLong, x:Double, y:Double) {
    self.id = id
    self.x = x
    self.y = y
  }
  
  func distanceTo(x: Double, y: Double) -> Double {
    let rangeX = x-self.x
    let rangeY = y-self.y
    return sqrt(rangeX*rangeX+rangeY*rangeY)
  }
  
  func distanceTo(unit:Unit) -> Double {
    return distanceTo(x: unit.x, y: unit.y)
  }
}
