require_relative 'lib/game'
require_relative 'lib/ui_handler'

snake_game = Game.new

set title: snake_game.title
set background: snake_game.background

tick = 0

update do
    if tick % snake_game.snake.speed == 0
      snake_game.logic
      clear
      snake_game.draw
    end
    tick += 1
  end

show

