import Foundation

class Runner{
  let token: String
  let remoteProcessClient:RemoteProcessClient
  init(host:String, port:String, token:String)
  {
    remoteProcessClient = try! RemoteProcessClient(host:host, port:Int(port)!)
    self.token = token
    
  }
  func run(){
    remoteProcessClient.write(token:token)
    remoteProcessClient.writeProtocolVersion()
    remoteProcessClient.readTeamSizeMessage()
    let game = remoteProcessClient.readGameContextMessage()
    
    let strategy = MyStrategy()
    while let playerContext = remoteProcessClient.readPlayerContextMessage() {
      var move = Move()
      strategy.move(me: playerContext.player, world: playerContext.world, game: game, move: &move)

      remoteProcessClient.write(move:move);
    }
  }
}

if CommandLine.argc == 4
{
  let runner = Runner( host:CommandLine.arguments[1], port:CommandLine.arguments[2],token:CommandLine.arguments[3])
  runner.run()
}else
{
  let runner = Runner( host:"127.0.0.1", port:"31001",token:"0000000000000000")
  runner.run()
}
