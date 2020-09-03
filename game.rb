# frozen_string_literal: true

require 'ruby2d'
require './grid'
require './snake'
require './controller'
require './munchies'
require './collide'

# Ruby2d's standard window size is 640x480.
# 640 / 20 = 32px on the x-axis.
# 480 / 20 = 24px on the y-axis.
#
# Snake Game File
# This is the heart of the program
#
def snake_game()
  # Init values #
  tick = 0
  food = 0
  speed = 40
  res = ['null']
  game_state = 'menu'

  grid = Grid.new(Window.width, Window.height)
  snake = Snake.new(grid.size, grid.width, grid.height)
  munchies = Munchies.new(grid.size, grid.width, grid.height)
  collision = Collide.new
  controller = Controller.new
  ################
  snake_loop = lambda {
    controller.check_input
    if tick % speed == 0
      snake.move(controller.direction) 
      # Ruby way of copying array values to another array (?)
      res = Marshal.load(Marshal.dump(collision.check_collision(snake.body, munchies.available_munchies)))
      case res[0]
      when 'game over' then game_state = 'game_over'
      when 'grow'
        snake.grow(res[1])
        munchies.get_munchied(res[1])
        unless speed == 1 then if speed < 7 then speed -= 1 else speed -=2 end end
      end
      munchies.draw
      snake.draw
      controller.last_input
      food += 1
    end

    tick += 1

    if food == 15
      food = 0
      if munchies.available_munchies.length < 3 then munchies.new_random end
    end
  }
  menu_loop = lambda {
    controller.check_input
    Text.new(
      'Press "p" to start the game',
      x: ((Window.width / 2) - 120), y: Window.height / 2,
      size: 20,
      color: 'lime'
    )
    if controller.play
      game_state = 'play'
      controller.play = false
      clear
      grid.draw
    end
  }
  game_over_loop = lambda {
    controller.check_input
    Text.new(
      'Game over',
      x: ((Window.width / 2) - 60), y: Window.height / 2,
      size: 20,
      color: 'red'
      )
    Text.new(
      "Score: #{snake.score}",
      x: ((Window.width / 2) - 60), y: Window.height / 3,
      size: 20,
      color: 'yellow'
    )
    if controller.play
      game_state = 'play'
      snake = Snake.new(grid.size, grid.width, grid.height)
      munchies = Munchies.new(grid.size, grid.width, grid.height)
      clear
      grid.draw
    end
  }

  ##############
  clear
  grid.draw
  ##############

  update do
    case game_state
    when 'menu' then menu_loop.call
    when 'play' then snake_loop.call
    when 'game_over' then game_over_loop.call end
  end
end

if __FILE__ == $PROGRAM_NAME
  set background: 'white'
  set title: 'Classic Snake Game'

  ### Game Loop ###
  snake_game
  show
  ################
end
