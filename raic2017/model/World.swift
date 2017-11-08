import Foundation

class World
{
  let tickIndex:Int32
  let tickCount:Int32
  let width:Double
  let height:Double
  let players:[Player]
  let newVehicles:[Vehicle]
  let vehicleUpdates:[VehicleUpdate]
  let terrainByCellXY:[[TerrainType]]
  let weatherByCellXY:[[WeatherType]]
  let facilities:[Facility];
  
  var myPlayer:Player!{
    get{
      for player in players {
        if player.me
        {
          return player
        }
      }
      return nil
    }
  }
  
  var oponentPlayer:Player!{
    get{
      for player in players {
        if !player.me
        {
          return player
        }
      }
      return nil
    }
  }
  
  init(tickIndex:Int32,
       tickCount:Int32,
       width:Double,
       height:Double,
       players:[Player],
       newVehicles:[Vehicle],
       vehicleUpdates:[VehicleUpdate],
       terrainByCellXY:[[TerrainType]],
       weatherByCellXY:[[WeatherType]],
       facilities:[Facility]) {
    self.tickIndex=tickIndex
    self.tickCount=tickCount
    self.width=width
    self.height=height
    self.players=players
    self.newVehicles=newVehicles
    self.vehicleUpdates=vehicleUpdates
    self.terrainByCellXY=terrainByCellXY
    self.weatherByCellXY=weatherByCellXY
    self.facilities=facilities
  }
}
