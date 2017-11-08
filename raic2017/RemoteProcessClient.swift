import Foundation


enum MessageType:Int8 {
  case UNKNOWN_MESSAGE,GAME_OVER,AUTHENTICATION_TOKEN,TEAM_SIZE,PROTOCOL_VERSION,GAME_CONTEXT,PLAYER_CONTEXT,MOVE_MESSAGE
}

class RemoteProcessClient{
  let socket:Socket
  var cachedBoolFlag = false
  var cachedBoolValue:Bool!
  
  var terrainByCellXY = [[TerrainType]]()
  var weatherByCellXY = [[WeatherType]]()
  
  var previousPlayerById = [CLongLong: Player]()
  var previousFacilityById = [CLongLong: Facility]()
  
  
  var previousPlayers = [Player]()
  
  var previousFacility = [Facility]()
  
  
  init(host:String, port:Int) throws
  {
    socket = Socket(host:host, port:port)
    socket.connect()
  }
  
  func write(token:String)
  {
    write(bytes: [MessageType.AUTHENTICATION_TOKEN.rawValue])
    write(string: token)
  }
  
  func writeProtocolVersion(){
    write(bytes: [MessageType.PROTOCOL_VERSION.rawValue])
    write(Int32(1))
  }
  
  func readTeamSizeMessage()
  {
    ensure(messageType: read(), is: .TEAM_SIZE)
    let _:Int32 = read()
  }
  
  func readGameContextMessage() -> Game
  {
    ensure(messageType: read(), is: .GAME_CONTEXT)
    return read()
  }
  
  func readPlayerContextMessage() -> PlayerContext?
  {
    let messageType:MessageType = read();
    if (messageType == .GAME_OVER) {
      return nil;
    }
    ensure(messageType: messageType, is: .PLAYER_CONTEXT)

    
    if !read() {
      return nil;
    }
    
    cachedBoolFlag = true;
    cachedBoolValue = true;
    
    return read()
  }
  
  
  
  func write(move:Move)
  {
    write(MessageType.MOVE_MESSAGE)
    write(move)
  }
  fileprivate func write(_ move:Move)
  {
    write(true);
    write(move.action);
    write(move.group);
    write(move.left);
    write(move.top);
    write(move.right);
    write(move.bottom);
    write(move.x);
    write(move.y);
    write(move.angle);
    write(move.maxSpeed);
    write(move.maxAngularSpeed);
    write(move.vehicleType);
    write(move.facilityId);
  }
  
  fileprivate func write(_ value:Bool)
  {
    var v:Int8 = value ? 1 : 0
    write(byte:&v);
  }
  
  fileprivate func write(_ value:Double)
  {
    var value = value
    withUnsafePointer(to: &value) {
      $0.withMemoryRebound(to: CLongLong.self, capacity: 1, {
        write($0.pointee)
      })
    }
  }
  
  fileprivate func write<T:RawRepresentable>(_ value:T) where T.RawValue == Int8
  {
    var v = value.rawValue
    write(byte:&v);
  }
  
  fileprivate func write(bytes:[Int8]) {
    var offset = 0
    var sentByteCount:Int = 0
    let byteCount = bytes.count
    
    
    while offset<byteCount {
      sentByteCount = bytes.suffix(from: offset).withUnsafeBufferPointer {buffer -> Int in
        return socket.send(bytes: buffer.baseAddress!, count: Int32(buffer.count))
      }
      if sentByteCount <= 0
      {
        break;
      }
      offset += sentByteCount;
    }
    
    if offset != byteCount
    {
      fatalError("cant send data")
    }
  }
  fileprivate func write(byte:UnsafePointer<Int8>)
  {
    if socket.send(bytes: byte, count: 1) != 1
    {
      fatalError("cant send data")
    }
  }
  
  fileprivate func write<T>(_ value:T)
  {
    
    let sendValue = typetobinary(value)
    if Int(OSHostByteOrder()) != OSLittleEndian
    {
      self.write(bytes:sendValue.reversed())
    }else
    {
      self.write(bytes:sendValue)
    }
  }
  
  fileprivate func write(string:String)
  {
    let size = string.lengthOfBytes(using: .utf8)
    self.write(Int32(size))
    if size == 0
    {
      return
    }
    string.data(using: .utf8)!.withUnsafeBytes { pointer  in
      self.write(bytes:  [Int8](UnsafeBufferPointer<Int8>(start: UnsafePointer<Int8>(pointer), count: string.lengthOfBytes(using: .utf8))))
    }
  }
  fileprivate func read<T:RawRepresentable>() -> T where T.RawValue == Int8
  {
    return T.init(rawValue: read())!
  }
  
  fileprivate func read() -> Int8
  {
    if socket.receive(1) != 1
    {
      exit(10021)
    }
    
    return socket.buffer.withUnsafeBytes{
      return $0.load(as: Int8.self)
    }
  }
  fileprivate func ensure(messageType:MessageType, is expectedType:MessageType)
  {
    if messageType != expectedType
    {
      exit(10011)
    }
  }
  fileprivate func read()->Int32
  {
    let bytes = read(bytes: MemoryLayout<Int32>.size)
    if Int(OSHostByteOrder()) != OSLittleEndian
    {
      return bytes.reversed().withUnsafeBytes{
        return $0.baseAddress!.load(as: Int32.self)
      }
    }else
    {
      return bytes.withUnsafeBytes{
        return $0.baseAddress!.load(as: Int32.self)
      }
    }
  }
  
  fileprivate func read()->CLongLong
  {
    let bytes = read(bytes: MemoryLayout<CLongLong>.size)
    if Int(OSHostByteOrder()) != OSLittleEndian
    {
      return bytes.reversed().withUnsafeBytes{
        return $0.baseAddress!.load(as: CLongLong.self)
      }
    }else
    {
      return bytes.withUnsafeBytes{
        return $0.baseAddress!.load(as: CLongLong.self)
      }
    }
  }
  
  fileprivate func read(bytes count: Int) -> [Int8]
  {
    var bytes = [Int8]()
    var offset = 0
    var readBytes:Int
    
    
    while offset<count {
      readBytes = socket.receive(count - offset)
      if readBytes<=0
      {
        break
      }
      bytes.append(contentsOf: socket.buffer[0..<readBytes])
      offset += readBytes
    }
    
    if offset != count
    {
      exit(10012)
    }
    return bytes
  }
  
  fileprivate func read()-> Bool
  {
    if cachedBoolFlag {
      cachedBoolFlag = false;
      return cachedBoolValue;
    }
    let byte:Int8 = read()
    return byte != 0;
  }
  
  fileprivate func read()->Double
  {
    var value:CLongLong = read()
    
    return withUnsafePointer(to: &value) {
      return $0.withMemoryRebound(to: Double.self, capacity: 1, {
        return $0.pointee
      })
      
    }
  }
  
  fileprivate func read() -> Game
  {
    if !read() {
      exit(20003);
    }
    
    let randomSeed: CLongLong = read()
    let tickCount:Int32 = read()
    let worldWidth:Double = read()
    let worldHeight:Double = read()
    let fogOfWarEnabled:Bool = read()
    let victoryScore:Int32 = read()
    let facilityCaptureScore:Int32 = read()
    let vehicleEliminationScore:Int32 = read()
    let actionDetectionInterval:Int32 = read()
    let baseActionCount:Int32 = read()
    let additionalActionCountPerControlCenter:Int32 = read()
    let maxUnitGroup:Int32 = read()
    let terrainWeatherMapColumnCount:Int32 = read()
    let terrainWeatherMapRowCount:Int32 = read()
    let plainTerrainVisionFactor:Double = read();
    let plainTerrainStealthFactor:Double = read();
    let plainTerrainSpeedFactor:Double = read();
    let swampTerrainVisionFactor:Double = read();
    let swampTerrainStealthFactor:Double = read();
    let swampTerrainSpeedFactor:Double = read();
    let forestTerrainVisionFactor:Double = read();
    let forestTerrainStealthFactor:Double = read();
    let forestTerrainSpeedFactor:Double = read();
    let clearWeatherVisionFactor:Double = read();
    let clearWeatherStealthFactor:Double = read();
    let clearWeatherSpeedFactor:Double = read();
    let cloudWeatherVisionFactor:Double = read();
    let cloudWeatherStealthFactor:Double = read();
    let cloudWeatherSpeedFactor:Double = read();
    let rainWeatherVisionFactor:Double = read();
    let rainWeatherStealthFactor:Double = read();
    let rainWeatherSpeedFactor:Double = read();
    let vehicleRadius:Double = read();
    let tankDurability:Int32 = read();
    let tankSpeed:Double = read();
    let tankVisionRange:Double = read();
    let tankGroundAttackRange:Double = read();
    let tankAerialAttackRange:Double = read();
    let tankGroundDamage:Int32 = read();
    let tankAerialDamage:Int32 = read();
    let tankGroundDefence:Int32 = read();
    let tankAerialDefence:Int32 = read();
    let tankAttackCooldownTicks:Int32 = read();
    let tankProductionCost:Int32 = read();
    let ifvDurability:Int32 = read();
    let ifvSpeed:Double = read();
    let ifvVisionRange:Double = read();
    let ifvGroundAttackRange:Double = read();
    let ifvAerialAttackRange:Double = read();
    let ifvGroundDamage:Int32 = read();
    let ifvAerialDamage:Int32 = read();
    let ifvGroundDefence:Int32 = read();
    let ifvAerialDefence:Int32 = read();
    let ifvAttackCooldownTicks:Int32 = read();
    let ifvProductionCost:Int32 = read();
    let arrvDurability:Int32 = read();
    let arrvSpeed:Double = read();
    let arrvVisionRange:Double = read();
    let arrvGroundDefence:Int32 = read();
    let arrvAerialDefence:Int32 = read();
    let arrvProductionCost:Int32 = read();
    let arrvRepairRange:Double = read();
    let arrvRepairSpeed:Double = read();
    let helicopterDurability:Int32 = read();
    let helicopterSpeed:Double = read();
    let helicopterVisionRange:Double = read();
    let helicopterGroundAttackRange:Double = read();
    let helicopterAerialAttackRange:Double = read();
    let helicopterGroundDamage:Int32 = read();
    let helicopterAerialDamage:Int32 = read();
    let helicopterGroundDefence:Int32 = read();
    let helicopterAerialDefence:Int32 = read();
    let helicopterAttackCooldownTicks:Int32 = read();
    let helicopterProductionCost:Int32 = read();
    let fighterDurability:Int32 = read();
    let fighterSpeed:Double = read();
    let fighterVisionRange:Double = read();
    let fighterGroundAttackRange:Double = read();
    let fighterAerialAttackRange:Double = read();
    let fighterGroundDamage:Int32 = read();
    let fighterAerialDamage:Int32 = read();
    let fighterGroundDefence:Int32 = read();
    let fighterAerialDefence:Int32 = read();
    let fighterAttackCooldownTicks:Int32 = read();
    let fighterProductionCost:Int32 = read();
    let maxFacilityCapturePoints:Double = read();
    let facilityCapturePointsPerVehiclePerTick:Double = read();
    let facilityWidth:Double = read();
    let facilityHeight:Double = read();
    
    return Game(randomSeed: randomSeed,
                tickCount: tickCount,
                worldWidth: worldWidth,
                worldHeight: worldHeight,
                fogOfWarEnabled: fogOfWarEnabled,
                victoryScore: victoryScore,
                facilityCaptureScore: facilityCaptureScore,
                vehicleEliminationScore: vehicleEliminationScore,
                actionDetectionInterval: actionDetectionInterval,
                baseActionCount: baseActionCount,
                additionalActionCountPerControlCenter: additionalActionCountPerControlCenter,
                maxUnitGroup: maxUnitGroup,
                terrainWeatherMapColumnCount: terrainWeatherMapColumnCount,
                terrainWeatherMapRowCount: terrainWeatherMapRowCount,
                plainTerrainVisionFactor: plainTerrainVisionFactor,
                plainTerrainStealthFactor: plainTerrainStealthFactor,
                plainTerrainSpeedFactor: plainTerrainSpeedFactor,
                swampTerrainVisionFactor: swampTerrainVisionFactor,
                swampTerrainStealthFactor: swampTerrainStealthFactor,
                swampTerrainSpeedFactor: swampTerrainSpeedFactor,
                forestTerrainVisionFactor: forestTerrainVisionFactor,
                forestTerrainStealthFactor: forestTerrainStealthFactor,
                forestTerrainSpeedFactor: forestTerrainSpeedFactor,
                clearWeatherVisionFactor: clearWeatherVisionFactor,
                clearWeatherStealthFactor: clearWeatherStealthFactor,
                clearWeatherSpeedFactor: clearWeatherSpeedFactor,
                cloudWeatherVisionFactor: cloudWeatherVisionFactor,
                cloudWeatherStealthFactor: cloudWeatherStealthFactor,
                cloudWeatherSpeedFactor: cloudWeatherSpeedFactor,
                rainWeatherVisionFactor: rainWeatherVisionFactor,
                rainWeatherStealthFactor: rainWeatherStealthFactor,
                rainWeatherSpeedFactor: rainWeatherSpeedFactor,
                vehicleRadius: vehicleRadius,
                tankDurability: tankDurability,
                tankSpeed: tankSpeed,
                tankVisionRange: tankVisionRange,
                tankGroundAttackRange: tankGroundAttackRange,
                tankAerialAttackRange: tankAerialAttackRange,
                tankGroundDamage: tankGroundDamage,
                tankAerialDamage: tankAerialDamage,
                tankGroundDefence: tankGroundDefence,
                tankAerialDefence: tankAerialDefence,
                tankAttackCooldownTicks: tankAttackCooldownTicks,
                tankProductionCost: tankProductionCost,
                ifvDurability: ifvDurability,
                ifvSpeed: ifvSpeed,
                ifvVisionRange: ifvVisionRange,
                ifvGroundAttackRange: ifvGroundAttackRange,
                ifvAerialAttackRange: ifvAerialAttackRange,
                ifvGroundDamage: ifvGroundDamage,
                ifvAerialDamage: ifvAerialDamage,
                ifvGroundDefence: ifvGroundDefence,
                ifvAerialDefence: ifvAerialDefence,
                ifvAttackCooldownTicks: ifvAttackCooldownTicks,
                ifvProductionCost: ifvProductionCost,
                arrvDurability: arrvDurability,
                arrvSpeed: arrvSpeed,
                arrvVisionRange: arrvVisionRange,
                arrvGroundDefence: arrvGroundDefence,
                arrvAerialDefence: arrvAerialDefence,
                arrvProductionCost: arrvProductionCost,
                arrvRepairRange: arrvRepairRange,
                arrvRepairSpeed: arrvRepairSpeed,
                helicopterDurability: helicopterDurability,
                helicopterSpeed: helicopterSpeed,
                helicopterVisionRange: helicopterVisionRange,
                helicopterGroundAttackRange: helicopterGroundAttackRange,
                helicopterAerialAttackRange: helicopterAerialAttackRange,
                helicopterGroundDamage: helicopterGroundDamage,
                helicopterAerialDamage: helicopterAerialDamage,
                helicopterGroundDefence: helicopterGroundDefence,
                helicopterAerialDefence: helicopterAerialDefence,
                helicopterAttackCooldownTicks: helicopterAttackCooldownTicks,
                helicopterProductionCost: helicopterProductionCost,
                fighterDurability: fighterDurability,
                fighterSpeed: fighterSpeed,
                fighterVisionRange: fighterVisionRange,
                fighterGroundAttackRange: fighterGroundAttackRange,
                fighterAerialAttackRange: fighterAerialAttackRange,
                fighterGroundDamage: fighterGroundDamage,
                fighterAerialDamage: fighterAerialDamage,
                fighterGroundDefence: fighterGroundDefence,
                fighterAerialDefence: fighterAerialDefence,
                fighterAttackCooldownTicks: fighterAttackCooldownTicks,
                fighterProductionCost: fighterProductionCost,
                maxFacilityCapturePoints: maxFacilityCapturePoints,
                facilityCapturePointsPerVehiclePerTick: facilityCapturePointsPerVehiclePerTick,
                facilityWidth: facilityWidth,
                facilityHeight: facilityHeight);
  }
  
  fileprivate func read()->PlayerContext
  {
    if !read() {
      exit(20009);
    }
    
    let player:Player = read();
    let world:World = read();
    
    return PlayerContext(player: player, world: world);
  }
  
  fileprivate func read() -> Player {
    let flag:Int8 = read();
    
    if flag == 0 {
      exit(20007);
    }
    
    if flag == 127 {
      return previousPlayerById[read()]!;
    }
    
    let id:CLongLong = read();
    let me:Bool = read();
    let strategyCrashed:Bool = read();
    let score:Int32 = read();
    let remainingActionCooldownTicks:Int32 = read();
    
    let player = Player(id: id,
                        me: me,
                        strategyCrashed: strategyCrashed,
                        score: score,
                        remainingActionCooldownTicks: remainingActionCooldownTicks);
    previousPlayerById[player.id] = player;
    return player;
  }
  
  fileprivate func read()->Vehicle
  {
    if !read() {
      exit(20011);
    }
    
    let id:CLongLong = read();
    let x:Double = read();
    let y:Double = read();
    let radius:Double = read();
    let playerId:CLongLong = read();
    let durability:Int32 = read();
    let maxDurability:Int32 = read();
    let maxSpeed:Double = read();
    let visionRange:Double = read();
    let squaredVisionRange:Double = read();
    let groundAttackRange:Double = read();
    let squaredGroundAttackRange:Double = read();
    let aerialAttackRange:Double = read();
    let squaredAerialAttackRange:Double = read();
    let groundDamage:Int32 = read();
    let aerialDamage:Int32 = read();
    let groundDefence:Int32 = read();
    let aerialDefence:Int32 = read();
    let attackCooldownTicks:Int32 = read();
    let remainingAttackCooldownTicks:Int32 = read();
    let type:VehicleType = read();
    let aerial:Bool = read();
    let selected:Bool = read();
    let groups:[Int32] = read();
    return Vehicle(id: id, x: x, y: y, radius: radius, playerId: playerId, durability: durability, maxDurability: maxDurability, maxSpeed: maxSpeed, visionRange: visionRange, squaredVisionRange: squaredVisionRange, groundAttackRange: groundAttackRange, squaredGroundAttackRange: squaredGroundAttackRange, aerialAttackRange: aerialAttackRange, squaredAerialAttackRange: squaredAerialAttackRange, groundDamage: groundDamage, aerialDamage: aerialDamage, groundDefence: groundDefence, aerialDefence: aerialDefence, attackCooldownTicks: attackCooldownTicks, remainingAttackCooldownTicks: remainingAttackCooldownTicks, type: type, aerial: aerial, selected: selected, groups: groups)
  }
  
  fileprivate func read()->VehicleUpdate
  {
    if !read() {
      exit(20013);
    }
    
    let id:CLongLong = read();
    let x:Double = read();
    let y:Double = read();
    let durability:Int32 = read();
    let remainingAttackCooldownTicks:Int32 = read();
    let selected:Bool = read();
    let groups:[Int32] = read();
    
    return VehicleUpdate(id: id, x: x, y: y, durability: durability, remainingAttackCooldownTicks: remainingAttackCooldownTicks, selected: selected, groups: groups)
  }
  
  fileprivate func read<T:RawRepresentable>() -> [[T]] where T.RawValue == Int8
  {
    let length:Int32 = read();
    if (length < 0) {
      exit(10016);
    }
    

    var value = [[T]]();
    value.reserveCapacity(Int(length))
    
    for _ in 0..<length {
      let length2:Int32 = read();
      if (length2 < 0) {
        exit(10017);
      }
      
      var value2 = [T]()
      value2.reserveCapacity(Int(length2))
      for _ in 0..<length2 {
        let value:T = read()
        value2.append(value)
      }
      value.append(value2)
    }
    
    return value;
  }
  
  fileprivate func read() -> World {
    if !read() {
      exit(20015);
    }
    
    let tickIndex:Int32 = read();
    let tickCount:Int32 = read();
    let width:Double = read();
    let height:Double = read();
    let players:[Player] = read();
    let newVehicles:[Vehicle] = read();
    let vehicleUpdates:[VehicleUpdate] = read();
    
    if (terrainByCellXY.isEmpty) {
      terrainByCellXY = read();
    }
    
    if (weatherByCellXY.isEmpty) {
      weatherByCellXY = read();
    }
    
    let facilities:[Facility] = read();
    
    return World(tickIndex: tickIndex,
                 tickCount: tickCount,
                 width: width,
                 height: height,
                 players: players,
                 newVehicles: newVehicles,
                 vehicleUpdates: vehicleUpdates,
                 terrainByCellXY: terrainByCellXY,
                 weatherByCellXY: weatherByCellXY,
                 facilities: facilities)
  }
  
  func read() -> Facility {
    let flag:Int8 = read();
    
    if (flag == 0) {
      exit(20001);
    }
    
    if (flag == 127) {
      return previousFacilityById[read()]!;
    }
    
    let id:CLongLong = read();
    let type:FacilityType = read();
    let ownerPlayerId:CLongLong = read();
    let left:Double = read();
    let top:Double = read();
    let capturePoints:Double = read();
    let vehicleType:VehicleType = read();
    let productionProgress:Int32 = read();
    
    let facility = Facility(id: id, type: type, ownerPlayerId: ownerPlayerId, left: left, top: top, capturePoints: capturePoints, vehicleType: vehicleType, productionProgress: productionProgress)
    previousFacilityById[facility.id] = facility;
    return facility;
  }
  
  fileprivate func read()->[Vehicle]
  {
    let count:Int32 = read();
    if (count < 0) {
      exit(20012);
    }
    
    var values = [Vehicle]()
    values.reserveCapacity(Int(count))
    
    for _ in 0..<count {
      values.append(read())
    }
    return values;
  }
  
  fileprivate func read()->[Int32]
  {
    let count:Int32 = read();
    if (count < 0) {
      exit(20012);
    }
    
    var values = [Int32]()
    values.reserveCapacity(Int(count))
    
    for _ in 0..<count {
      values.append(read())
    }
    return values;
  }
  
  fileprivate func read()->[VehicleUpdate]
  {
    let count:Int32 = read();
    if (count < 0) {
      exit(20012);
    }
    
    var values = [VehicleUpdate]()
    values.reserveCapacity(Int(count))
    
    for _ in 0..<count {
      values.append(read())
    }
    return values;
  }
  
  fileprivate func read() ->[Player]
  {
    let playerCount:Int32 = read();
    if (playerCount < 0) {
      return previousPlayers;
    }
    
    var players = [Player]()
    players.reserveCapacity(Int(playerCount))
    
    for _ in 0..<playerCount {
      players.append(read())
    }
    
    previousPlayers = players;
    return players;
  }
  
  fileprivate func read() ->[Facility]
  {
    let facilityCount:Int32 = read();
    if (facilityCount < 0) {
      return previousFacility
    }
    
    var facility = [Facility]()
    facility.reserveCapacity(Int(facilityCount))
    
    for _ in 0..<facilityCount {
      let value:Facility = read()
      facility.append(value)
    }
    
    previousFacility = facility;
    return facility;
  }
}
func typetobinary<T>(_ value: T) -> [Int8] {
  var data = [Int8](repeating: 0, count: MemoryLayout<T>.size)
  data.withUnsafeMutableBufferPointer {
    UnsafeMutableRawPointer($0.baseAddress!).storeBytes(of: value, as: T.self)
  }
  return data
}
