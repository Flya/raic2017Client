import Foundation

enum ActionType:Int8 {
  case _ACTION_UNKNOWN_ = -1, ACTION_NONE = 0,
  ACTION_CLEAR_AND_SELECT = 1,
  ACTION_ADD_TO_SELECTION = 2,
  ACTION_DESELECT = 3,
  ACTION_ASSIGN = 4,
  ACTION_DISMISS = 5,
  ACTION_DISBAND = 6,
  ACTION_MOVE = 7,
  ACTION_ROTATE = 8,
  ACTION_SETUP_VEHICLE_PRODUCTION = 9
}
class Move
{
  var action:ActionType = ._ACTION_UNKNOWN_
  var group:Int32 = 0
  var left:Double = 0
  var top:Double = 0
  var right:Double = 0
  var bottom:Double = 0
  var x:Double = 0
  var y:Double = 0
  var angle:Double = 0
  var maxSpeed:Double = 0
  var maxAngularSpeed:Double = 0
  var vehicleType:VehicleType = ._VEHICLE_UNKNOWN_
  var facilityId:CLongLong = -1
}
