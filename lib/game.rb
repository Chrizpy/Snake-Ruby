# frozen_string_literal: true

require 'ruby2d'
require_relative 'snake/grid'
require_relative 'snake/snake'
require_relative 'snake/controller'
require_relative 'snake/munchies'
require_relative 'snake/collide'
require_relative 'ui/ui_handler'

# Game class, creates a game object from the game input parameter.
class Game
  def initialize(game)
    @game = game
    @game_score = 0
    @window = Window.new
    @ui_handler = UIHandler.new(@game, @window)
  end

  def create
    case @game
    when 'snake' then create_snake end
  end

  def create_snake
    grid = Grid.new(Window.width, Window.height)
    snake = Snake.new(grid.size, grid.width, grid.height)
    munchies = Munchies.new(grid.size, grid.width, grid.height)
    collision = Collide.new
    controller = Controller.new

    [grid, snake, munchies, collision, controller]
  end

  def start
    case @game
    when 'snake' then start_snake end
  end

  def start_snake
    loop do
      case @ui_handler.current
      when 'menu' then @ui_handler.main_menu
      when 'play' then start_snake_loop
      when 'game_over' then @ui_handler.game_over(@game_score)
      end
    end
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def start_snake_loop
    @window.set background: 'black'
    @window.set title: 'Classic Snake Game'
    grid, snake, munchies, collision, controller = create_snake
    tick = 0

    @window.update do
      controller.check_input

      if (tick % snake.speed).zero?
        snake.move(controller.direction)

        # Ruby way of copying array values to another array (?)
        col_result = Marshal.load(Marshal.dump(collision.check_collision(snake.body, munchies.available_munchies)))

        case col_result[0]
        when 'grow'
          snake.speed_update
          snake.grow(col_result[1])
          munchies.get_munchied(col_result[1])
        when 'game over'
          @ui_handler.current = 'game_over'
          @game_score = snake.score
          return
        end

        @window.clear
        grid.draw
        munchies.draw
        snake.draw
        controller.last_input
        munchies.food_update
      end
      tick += 1
    end
    @window.show
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
