# frozen_string_literal: true

# Grid class
# This class is responsible for creating the grid in which the playground
# is used for playing the game.
class Grid
  attr_reader :background, :size, :width, :height, :grid

  def initialize(width, height)
    @background = 'blue'
    @size = 20
    @width = width / @size
    @height = height / @size
    @grid = []

    for y in 0..self.height
      for x in 0..self.width
        grid.push([x, y])
      end
    end
  end

  def draw
    grid.each do |part|
      Square.new(
        x: part[0] * size,
        y: part[1] * size,
        color: background,
        size: size - 1
      )
    end
  end
end
