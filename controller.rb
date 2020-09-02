# frozen_string_literal: true

# Controller class
# This class is responsible for the maneuvering through out the game.
class Controller
  attr_accessor :direction, :play, :last

  def initialize
    @direction = 'left'
    @last = @direction
    @play = false
  end

  def check_input
    Window.on :key_down do |event|
      case event.key
      when 'left'
        if last != 'right' then self.direction = 'left' end
      when 'right'
        if last != 'left' then self.direction = 'right' end
      when 'up'
        if last != 'down' then self.direction = 'up' end
      when 'down'
        if last != 'up' then self.direction = 'down' end
      when 'p' then self.play = true end
    end
  end

  def last_input
    self.last = direction
  end
end
