# frozen_string_literal: true

require 'ruby2d'
require_relative 'snake/grid'
require_relative 'snake/snake'
require_relative 'snake/controller'
require_relative 'snake/munchies'
require_relative 'snake/collide'

# Game class, creates a game object from the game input parameter.
class Game
  attr_reader :title, :background, :snake

  def initialize
    @game_score = 0
    @title = 'Classic Snake Game'
    @background = 'black'

    @grid = Grid.new(Window.width, Window.height)
    @snake = Snake.new(@grid.size, @grid.width, @grid.height)
    @munchies = Munchies.new(@grid.size, @grid.width, @grid.height)
    @collision = Collide.new
    @controller = Controller.new
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def logic
    @controller.check_input

    @snake.move(@controller.direction)

    # Ruby way of copying array values to another array (?)
    col_result = Marshal.load(Marshal.dump(@collision.check_collision(@snake.body, @munchies.available_munchies)))

    case col_result[0]
    when 'grow'
      @snake.speed_update
      @snake.grow(col_result[1])
      @munchies.get_munchied(col_result[1])
    when 'game over'
      @game_score = @snake.score
      return
    end    
  end

  def draw
    @grid.draw
    @munchies.draw
    @snake.draw
    @controller.last_input
    @munchies.food_update
  end
end

