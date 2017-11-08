import Foundation

enum FacilityType:Int8 {
  case _FACILITY_UNKNOWN_ = -1,
  FACILITY_CONTROL_CENTER = 0,
  FACILITY_VEHICLE_FACTORY = 1,
  _FACILITY_COUNT_ = 2
};
class Facility {
  let id:CLongLong
  let type:FacilityType
  let ownerPlayerId:CLongLong
  let left:Double
  let top:Double
  let capturePoints:Double
  let vehicleType:VehicleType
  let productionProgress:Int32
  init( id:CLongLong,
        type:FacilityType,
        ownerPlayerId:CLongLong,
        left:Double,
        top:Double,
        capturePoints:Double,
        vehicleType:VehicleType,
        productionProgress:Int32)
  {
    self.id = id
    self.type = type
    self.ownerPlayerId = ownerPlayerId
    self.left = left
    self.top = top
    self.capturePoints = capturePoints
    self.vehicleType = vehicleType
    self.productionProgress = productionProgress
  }
}
