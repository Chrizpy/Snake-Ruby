require 'ruby2d'
require './grid.rb'
require './snake.rb'
require './controller.rb'
require './munchies.rb'
require './collide.rb'

# Ruby2d's standard window size is 640x480.
# 640 / 20 = 32px on the x-axis.
# 480 / 20 = 24px on the y-axis.

# TODO: Remove clear and paint snakes tail green before moving forward and remove from array.
# 

if __FILE__ == $PROGRAM_NAME
    grid = Grid.new(Window.width, Window.height)

    GRID_WIDTH  = grid.width
    GRID_HEIGHT = grid.height
    GRID_SIZE   = grid.size

    GAME_OVER = 0
    GROW      = 1

    snake = Snake.new(GRID_SIZE, GRID_WIDTH, GRID_HEIGHT)
    munchies = Munchies.new(GRID_SIZE, GRID_WIDTH, GRID_HEIGHT)
    collision = Collide.new
    controller = Controller.new
    set background: 'white'
    set title: 'Classic Snake Game'


    ### Game Loop ###
    tick = 0
    food = 0
    clear
    grid.draw 
    res = ['null']
    
    update do
        controller.check_input
        if tick % 40 == 0
            snake.move(controller.direction)
            if collision.check_collision(snake.body, munchies.available_munchies)
                res = Marshal.load(Marshal.dump(collision.check_collision(snake.body, munchies.available_munchies)))
            end
            if res[0] == 'game over'
                break
            elsif res[0] == 'grow'
                puts "GROWING"
                snake.grow(res[1])
                munchies.get_munchied(res[1])
            end
            munchies.draw
            snake.draw
            controller.last_input
            food += 1
        end
        tick += 1

        if food == 30
            food = 0
            munchies.new_random
        end
      end

    show
    ################
end