class Snake
    attr_accessor :body

    def initialize(gridsize, width, height)
        @@grid = gridsize
        @body = [[16, 16], [17, 16], [18, 16]]
        @@grid_dim = [width - 1, height - 1]
        @@will_grow = false
        @@new_part = [] 
        @@stop_delete = false
    end
    def move(direction)
        @@save = Marshal.load(Marshal.dump(@body))
        
        case direction
        when 'left'
            @body.first[0] -= 1
            if @body.first[0] < 0
                @body.first[0] = @@grid_dim[0]
            end
            @@save.each_with_index do |part, index|
                if index < @@save.length-1
                    @body[index+1][1] = part[1]
                    @body[index+1][0] = part[0]
                end
            end
        when 'right'
            @body.first[0] += 1
            if @body.first[0] > @@grid_dim[0]
                @body.first[0] = 0
            end
            @@save.each_with_index do |part, index|
                if index < @@save.length-1
                    @body[index+1][1] = part[1]
                    @body[index+1][0] = part[0]
                end
            end
        when 'up'
            @body.first[1] -= 1
            if @body.first[1] < 0
                @body.first[1] = @@grid_dim[1]
            end
            @@save.each_with_index do |part, index|
                if index < @@save.length-1
                    @body[index+1][1] = part[1]
                    @body[index+1][0] = part[0]
                end
            end
        when 'down'
            @body.first[1] += 1
            if @body.first[1] > @@grid_dim[1]
                @body.first[1] = 0
            end
            @@save.each_with_index do |part, index|
                if index < @@save.length-1
                    @body[index+1][1] = part[1]
                    @body[index+1][0] = part[0]
                end
            end
        end
        @@to_delete = @@save.last

        if @@will_grow
            if @body.last[0] == @@new_part[0] && body.last[1] == @@new_part[1]
                @body.push(@@to_delete)
                @@will_grow = false
                @@stop_delete = true
            end
        end
    end
    def draw
        @body.each do |part|
            Square.new(
                x: part[0] * @@grid, 
                y: part[1] * @@grid, 
                color: 'white',
                size: @@grid - 1
                )
        end
        if !@@stop_delete
            Square.new(
                x: @@to_delete[0] * @@grid,
                y: @@to_delete[1] * @@grid,
                color: 'green',
                size: @@grid - 1
            )
        end
    end
    def grow(new_piece)
        @@will_grow = true
        @@new_part = new_piece
    end
    
end

