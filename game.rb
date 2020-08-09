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
def food_update(food, munchies)
    if food == 15
        food = 0
        if munchies.available_munchies.length < 3
            munchies.new_random
        end
    end

    food
end

def game_update(res, snake, munchies, controller, speed)
    speed_update = ->(speed) {
        if speed != 1
            if speed < 7
                speed -= 1
            else
                speed -=2
            end
        end

        return speed
    }

    if res[0] == 'game over'
        puts "Game Over"
    elsif res[0] == 'grow'
        snake.grow(res[1])
        munchies.get_munchied(res[1])
        speed = speed_update.call(speed)
    end
    munchies.draw
    snake.draw
    controller.last_input

    speed
end

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
    speed = 40
    clear
    grid.draw 
    res = ['null']
    
    update do
        controller.check_input
        if tick % speed == 0
            snake.move(controller.direction)
            #puts speed   
            # Ruby way of copying array values to another array (?)
            res = Marshal.load(Marshal.dump(collision.check_collision(snake.body, munchies.available_munchies)))
            speed = game_update(res, snake, munchies, controller, speed)
            food += 1
        end
        tick += 1
        food = food_update(food, munchies)
      end

    show
    ################
end