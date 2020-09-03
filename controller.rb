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
      case event.key
      when 'left'
        if @last != 'right' then @direction = 'left' end
      when 'right'
        if @last != 'left' then @direction = 'right' end
      when 'up'
        if @last != 'down' then @direction = 'up' end
      when 'down'
        if @last != 'up' then @direction = 'down' end
      when 'p' then @play = true end
    end
  end

  def last_input
    @last = @direction
  end
end
