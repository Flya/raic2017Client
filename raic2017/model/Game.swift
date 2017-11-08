import Foundation

class Game
{
  let randomSeed:CLongLong
  let tickCount:Int32
  let worldWidth:Double
  let worldHeight:Double
  let fogOfWarEnabled:Bool
  let victoryScore:Int32
  let facilityCaptureScore:Int32
  let vehicleEliminationScore:Int32
  let actionDetectionInterval:Int32
  let baseActionCount:Int32
  let additionalActionCountPerControlCenter:Int32
  let maxUnitGroup:Int32
  let terrainWeatherMapColumnCount:Int32
  let terrainWeatherMapRowCount:Int32
  let plainTerrainVisionFactor:Double
  let plainTerrainStealthFactor:Double
  let plainTerrainSpeedFactor:Double
  let swampTerrainVisionFactor:Double
  let swampTerrainStealthFactor:Double
  let swampTerrainSpeedFactor:Double
  let forestTerrainVisionFactor:Double
  let forestTerrainStealthFactor:Double
  let forestTerrainSpeedFactor:Double
  let clearWeatherVisionFactor:Double
  let clearWeatherStealthFactor:Double
  let clearWeatherSpeedFactor:Double
  let cloudWeatherVisionFactor:Double
  let cloudWeatherStealthFactor:Double
  let cloudWeatherSpeedFactor:Double
  let rainWeatherVisionFactor:Double
  let rainWeatherStealthFactor:Double
  let rainWeatherSpeedFactor:Double
  let vehicleRadius:Double
  let tankDurability:Int32
  let tankSpeed:Double
  let tankVisionRange:Double
  let tankGroundAttackRange:Double
  let tankAerialAttackRange:Double
  let tankGroundDamage:Int32
  let tankAerialDamage:Int32
  let tankGroundDefence:Int32
  let tankAerialDefence:Int32
  let tankAttackCooldownTicks:Int32
  let tankProductionCost:Int32
  let ifvDurability:Int32
  let ifvSpeed:Double
  let ifvVisionRange:Double
  let ifvGroundAttackRange:Double
  let ifvAerialAttackRange:Double
  let ifvGroundDamage:Int32
  let ifvAerialDamage:Int32
  let ifvGroundDefence:Int32
  let ifvAerialDefence:Int32
  let ifvAttackCooldownTicks:Int32
  let ifvProductionCost:Int32
  let arrvDurability:Int32
  let arrvSpeed:Double
  let arrvVisionRange:Double
  let arrvGroundDefence:Int32
  let arrvAerialDefence:Int32
  let arrvProductionCost:Int32
  let arrvRepairRange:Double
  let arrvRepairSpeed:Double
  let helicopterDurability:Int32
  let helicopterSpeed:Double
  let helicopterVisionRange:Double
  let helicopterGroundAttackRange:Double
  let helicopterAerialAttackRange:Double
  let helicopterGroundDamage:Int32
  let helicopterAerialDamage:Int32
  let helicopterGroundDefence:Int32
  let helicopterAerialDefence:Int32
  let helicopterAttackCooldownTicks:Int32
  let helicopterProductionCost:Int32
  let fighterDurability:Int32
  let fighterSpeed:Double
  let fighterVisionRange:Double
  let fighterGroundAttackRange:Double
  let fighterAerialAttackRange:Double
  let fighterGroundDamage:Int32
  let fighterAerialDamage:Int32
  let fighterGroundDefence:Int32
  let fighterAerialDefence:Int32
  let fighterAttackCooldownTicks:Int32
  let fighterProductionCost:Int32
  let maxFacilityCapturePoints:Double
  let facilityCapturePointsPerVehiclePerTick:Double
  let facilityWidth:Double
  let facilityHeight:Double
  init(randomSeed:CLongLong,
       tickCount:Int32,
       worldWidth:Double,
       worldHeight:Double,
       fogOfWarEnabled:Bool,
       victoryScore:Int32,
       facilityCaptureScore:Int32,
       vehicleEliminationScore:Int32,
       actionDetectionInterval:Int32,
       baseActionCount:Int32,
       additionalActionCountPerControlCenter:Int32,
       maxUnitGroup:Int32,
       terrainWeatherMapColumnCount:Int32,
       terrainWeatherMapRowCount:Int32,
       plainTerrainVisionFactor:Double,
       plainTerrainStealthFactor:Double,
       plainTerrainSpeedFactor:Double,
       swampTerrainVisionFactor:Double,
       swampTerrainStealthFactor:Double,
       swampTerrainSpeedFactor:Double,
       forestTerrainVisionFactor:Double,
       forestTerrainStealthFactor:Double,
       forestTerrainSpeedFactor:Double,
       clearWeatherVisionFactor:Double,
       clearWeatherStealthFactor:Double,
       clearWeatherSpeedFactor:Double,
       cloudWeatherVisionFactor:Double,
       cloudWeatherStealthFactor:Double,
       cloudWeatherSpeedFactor:Double,
       rainWeatherVisionFactor:Double,
       rainWeatherStealthFactor:Double,
       rainWeatherSpeedFactor:Double,
       vehicleRadius:Double,
       tankDurability:Int32,
       tankSpeed:Double,
       tankVisionRange:Double,
       tankGroundAttackRange:Double,
       tankAerialAttackRange:Double,
       tankGroundDamage:Int32,
       tankAerialDamage:Int32,
       tankGroundDefence:Int32,
       tankAerialDefence:Int32,
       tankAttackCooldownTicks:Int32,
       tankProductionCost:Int32,
       ifvDurability:Int32,
       ifvSpeed:Double,
       ifvVisionRange:Double,
       ifvGroundAttackRange:Double,
       ifvAerialAttackRange:Double,
       ifvGroundDamage:Int32,
       ifvAerialDamage:Int32,
       ifvGroundDefence:Int32,
       ifvAerialDefence:Int32,
       ifvAttackCooldownTicks:Int32,
       ifvProductionCost:Int32,
       arrvDurability:Int32,
       arrvSpeed:Double,
       arrvVisionRange:Double,
       arrvGroundDefence:Int32,
       arrvAerialDefence:Int32,
       arrvProductionCost:Int32,
       arrvRepairRange:Double,
       arrvRepairSpeed:Double,
       helicopterDurability:Int32,
       helicopterSpeed:Double,
       helicopterVisionRange:Double,
       helicopterGroundAttackRange:Double,
       helicopterAerialAttackRange:Double,
       helicopterGroundDamage:Int32,
       helicopterAerialDamage:Int32,
       helicopterGroundDefence:Int32,
       helicopterAerialDefence:Int32,
       helicopterAttackCooldownTicks:Int32,
       helicopterProductionCost:Int32,
       fighterDurability:Int32,
       fighterSpeed:Double,
       fighterVisionRange:Double,
       fighterGroundAttackRange:Double,
       fighterAerialAttackRange:Double,
       fighterGroundDamage:Int32,
       fighterAerialDamage:Int32,
       fighterGroundDefence:Int32,
       fighterAerialDefence:Int32,
       fighterAttackCooldownTicks:Int32,
       fighterProductionCost:Int32,
       maxFacilityCapturePoints:Double,
       facilityCapturePointsPerVehiclePerTick:Double,
       facilityWidth:Double,
       facilityHeight:Double){
    
    self.randomSeed=randomSeed
    self.tickCount=tickCount
    self.worldWidth=worldWidth
    self.worldHeight=worldHeight
    self.fogOfWarEnabled=fogOfWarEnabled
    self.victoryScore=victoryScore
    self.facilityCaptureScore=facilityCaptureScore
    self.vehicleEliminationScore=vehicleEliminationScore
    self.actionDetectionInterval=actionDetectionInterval
    self.baseActionCount=baseActionCount
    self.additionalActionCountPerControlCenter=additionalActionCountPerControlCenter
    self.maxUnitGroup=maxUnitGroup
    self.terrainWeatherMapColumnCount=terrainWeatherMapColumnCount
    self.terrainWeatherMapRowCount=terrainWeatherMapRowCount
    self.plainTerrainVisionFactor=plainTerrainVisionFactor
    self.plainTerrainStealthFactor=plainTerrainStealthFactor
    self.plainTerrainSpeedFactor=plainTerrainSpeedFactor
    self.swampTerrainVisionFactor=swampTerrainVisionFactor
    self.swampTerrainStealthFactor=swampTerrainStealthFactor
    self.swampTerrainSpeedFactor=swampTerrainSpeedFactor
    self.forestTerrainVisionFactor=forestTerrainVisionFactor
    self.forestTerrainStealthFactor=forestTerrainStealthFactor
    self.forestTerrainSpeedFactor=forestTerrainSpeedFactor
    self.clearWeatherVisionFactor=clearWeatherVisionFactor
    self.clearWeatherStealthFactor=clearWeatherStealthFactor
    self.clearWeatherSpeedFactor=clearWeatherSpeedFactor
    self.cloudWeatherVisionFactor=cloudWeatherVisionFactor
    self.cloudWeatherStealthFactor=cloudWeatherStealthFactor
    self.cloudWeatherSpeedFactor=cloudWeatherSpeedFactor
    self.rainWeatherVisionFactor=rainWeatherVisionFactor
    self.rainWeatherStealthFactor=rainWeatherStealthFactor
    self.rainWeatherSpeedFactor=rainWeatherSpeedFactor
    self.vehicleRadius=vehicleRadius
    self.tankDurability=tankDurability
    self.tankSpeed=tankSpeed
    self.tankVisionRange=tankVisionRange
    self.tankGroundAttackRange=tankGroundAttackRange
    self.tankAerialAttackRange=tankAerialAttackRange
    self.tankGroundDamage=tankGroundDamage
    self.tankAerialDamage=tankAerialDamage
    self.tankGroundDefence=tankGroundDefence
    self.tankAerialDefence=tankAerialDefence
    self.tankAttackCooldownTicks=tankAttackCooldownTicks
    self.tankProductionCost=tankProductionCost
    self.ifvDurability=ifvDurability
    self.ifvSpeed=ifvSpeed
    self.ifvVisionRange=ifvVisionRange
    self.ifvGroundAttackRange=ifvGroundAttackRange
    self.ifvAerialAttackRange=ifvAerialAttackRange
    self.ifvGroundDamage=ifvGroundDamage
    self.ifvAerialDamage=ifvAerialDamage
    self.ifvGroundDefence=ifvGroundDefence
    self.ifvAerialDefence=ifvAerialDefence
    self.ifvAttackCooldownTicks=ifvAttackCooldownTicks
    self.ifvProductionCost=ifvProductionCost
    self.arrvDurability=arrvDurability
    self.arrvSpeed=arrvSpeed
    self.arrvVisionRange=arrvVisionRange
    self.arrvGroundDefence=arrvGroundDefence
    self.arrvAerialDefence=arrvAerialDefence
    self.arrvProductionCost=arrvProductionCost
    self.arrvRepairRange=arrvRepairRange
    self.arrvRepairSpeed=arrvRepairSpeed
    self.helicopterDurability=helicopterDurability
    self.helicopterSpeed=helicopterSpeed
    self.helicopterVisionRange=helicopterVisionRange
    self.helicopterGroundAttackRange=helicopterGroundAttackRange
    self.helicopterAerialAttackRange=helicopterAerialAttackRange
    self.helicopterGroundDamage=helicopterGroundDamage
    self.helicopterAerialDamage=helicopterAerialDamage
    self.helicopterGroundDefence=helicopterGroundDefence
    self.helicopterAerialDefence=helicopterAerialDefence
    self.helicopterAttackCooldownTicks=helicopterAttackCooldownTicks
    self.helicopterProductionCost=helicopterProductionCost
    self.fighterDurability=fighterDurability
    self.fighterSpeed=fighterSpeed
    self.fighterVisionRange=fighterVisionRange
    self.fighterGroundAttackRange=fighterGroundAttackRange
    self.fighterAerialAttackRange=fighterAerialAttackRange
    self.fighterGroundDamage=fighterGroundDamage
    self.fighterAerialDamage=fighterAerialDamage
    self.fighterGroundDefence=fighterGroundDefence
    self.fighterAerialDefence=fighterAerialDefence
    self.fighterAttackCooldownTicks=fighterAttackCooldownTicks
    self.fighterProductionCost=fighterProductionCost
    self.maxFacilityCapturePoints=maxFacilityCapturePoints
    self.facilityCapturePointsPerVehiclePerTick=facilityCapturePointsPerVehiclePerTick
    self.facilityWidth=facilityWidth
    self.facilityHeight=facilityHeight
  }
}
