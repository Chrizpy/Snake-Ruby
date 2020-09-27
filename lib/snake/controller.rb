# frozen_string_literal: true

# Controller class
# This class is responsible for the maneuvering through out the game.
class Controller
  attr_accessor :direction, :play

  def initialize
    @direction = 'left'
    @last = @direction
    @play = false
  end

  def check_input
    Window.on :key_down do |event|
      switcher event.key
    end
  end

  def switcher(key)
    case key
    when 'left'
      turn_left
    when 'right'
      turn_right
    when 'up'
      turn_up
    when 'down'
      turn_down
    when 'escape'
      escape_game
    when 'p'
      start_game
    end
  end

  def turn_left
    @direction = 'left' if @last != 'right'
  end

  def turn_right
    @direction = 'right' if @last != 'left'
  end

  def turn_up
    @direction = 'up' if @last != 'down'
  end

  def turn_down
    @direction = 'down' if @last != 'up'
  end

  def escape_game
    exit
  end

  def start_game
    @play = true
  end

  def last_input
    @last = @direction
  end
end
