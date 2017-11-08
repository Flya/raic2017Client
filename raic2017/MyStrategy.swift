import Foundation

class MyStrategy:Strategy
{
  func move(me: Player, world: World, game: Game, move: inout Move) {
    if (world.tickIndex == 0) {
      move.action = .ACTION_CLEAR_AND_SELECT
      move.right = world.width
      move.bottom = world.height
      return;
    }
    
    if (world.tickIndex == 1) {
      move.action = .ACTION_MOVE
      move.x = world.width / 2.0
      move.y = world.height / 2.0
    }
  }
}
