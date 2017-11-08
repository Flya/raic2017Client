import Foundation

class CircularUnit: Unit {
  let radius:Double
  
  init(id: CLongLong, x: Double, y: Double,radius:Double) {
    self.radius = radius
    super.init(id: id, x: x, y: y)
  }
}
