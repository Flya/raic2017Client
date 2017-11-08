import Foundation

class PlayerContext{
  let player:Player
  let world:World
  init(player:Player, world:World) {
    self.player = player
    self.world = world
  }
}
