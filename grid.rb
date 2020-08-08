class Grid
    attr_reader :background, :size, :width, :height

    def initialize(width, height)
        @background = 'green'
        @size = 20
        @width = width / @size
        @height = height / @size
        @grid = []

        for y in 0..@height
            for x in 0..@width
                @grid.push([x, y])
            end
        end
    end
    def draw
        @grid.each do |part|
            Square.new(
                x: part[0] * @size,
                y: part[1] * @size,
                color: 'green',
                size: @size - 1
                )
        end
    end
end