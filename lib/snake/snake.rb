# frozen_string_literal: true

# Snake class
# This class is responsible for spawning snake and
# general things about snake
class Snake
  attr_accessor :body, :score, :speed

  def initialize(gridsize, width, height)
    @grid = gridsize
    @body = [[16, 16], [17, 16], [18, 16]]
    @grid_dim = [width - 1, height - 1]
    @will_grow = false
    @new_part = []
    @stop_delete = false
    @score = 0
    @save = [[]]
    @to_delete = 0
    @speed = 45
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def move(direction)
    @save = Marshal.load(Marshal.dump(body))

    case direction
    when 'left'
      body.first[0] -= 1
      body.first[0] = @grid_dim[0] if body.first[0].negative?
      indexing_parts
    when 'right'
      body.first[0] += 1
      body.first[0] = 0 if body.first[0] > @grid_dim[0]
      indexing_parts
    when 'up'
      body.first[1] -= 1
      body.first[1] = @grid_dim[1] if body.first[1].negative?
      indexing_parts
    when 'down'
      body.first[1] += 1
      body.first[1] = 0 if body.first[1] > @grid_dim[1]
      indexing_parts
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    @to_delete = @save.last

    # rubocop:disable Style/GuardClause
    if @will_grow && (body.last[0] == @new_part[0] && body.last[1] == @new_part[1])
      @body.push(@to_delete)
      @will_grow = false
    end
    # rubocop:enable Style/GuardClause
  end

  def draw
    body.each do |part|
      Square.new(
        x: part[0] * @grid,
        y: part[1] * @grid,
        color: 'white',
        size: @grid - 1
      )
    end
  end

  def grow(new_piece)
    @will_grow = true
    @new_part = new_piece
    @score += 150
  end

  def indexing_parts
    @save.each_with_index do |part, index|
      if index < @save.length - 1
        @body[index + 1][1] = part[1]
        @body[index + 1][0] = part[0]
      end
    end
  end

  def speed_update
    # rubocop:disable Style/GuardClause)
    if @speed > 5
      @speed -= if @speed > 30
                  5
                else
                  2
                end
    end
    # rubocop:enable Style/GuardClause)
    # For debugging purposes
    # puts "Current speed is #{@speed}"
  end
end
