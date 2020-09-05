# frozen_string_literal: true

# Munchies class
# This class is responsible for spawning apples in the playground
class Munchies
  attr_accessor :available_munchies

  def initialize(size, width, height)
    @width = width
    @height = height
    @size = size
    @new_munch = [false, [0, 0]]
    @food_tick = 0
    @available_munchies = [[random_coord_x, random_coord_y], [random_coord_x, random_coord_y]]
  end

  def draw
    @available_munchies.each do |part|
      Square.new(
        x: part[0] * @size,
        y: part[1] * @size,
        color: 'red',
        size: @size - 1
      )
    end
  end

  def random_coord_x
    rand @width
  end

  def random_coord_y
    rand @height
  end

  def new_random
    @available_munchies.push([random_coord_x, random_coord_y])
  end

  def get_munchied(apple)
    index = 0
    @available_munchies.each do |part|
      @available_munchies.delete_at(index) if (part[0] == apple[0]) && (apple[1] == part[1])
      index += 1
    end
  end

  def food_update
    if @food_tick == 15
      new_random if @available_munchies.length < 4
      @food_tick = 0
    end
    @food_tick += 1
  end
end
