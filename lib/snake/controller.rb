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

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
  def check_input
    Window.on :key_down do |event|
      case event.key
      when 'left'
        @direction = 'left'  if @last != 'right'
      when 'right'
        @direction = 'right' if @last != 'left'
      when 'up'
        @direction = 'up'    if @last != 'down'
      when 'down'
        @direction = 'down'  if @last != 'up'
      when 'escape'
        exit
      when 'p'
        @play = true
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

  def last_input
    @last = @direction
  end
end
