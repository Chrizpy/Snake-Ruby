class Munchies
    attr_accessor :available_munchies

    def initialize(size, width, height)
        @@width = width
        @@height = height
        @@size = size
        @available_munchies = [[self.random_coord_x, self.random_coord_y], [self.random_coord_x, self.random_coord_y]]
        @@new_munch = [false, [0, 0]]
    end
    def draw
        @available_munchies.each do |part|
            Square.new(
                x: part[0] * @@size, 
                y: part[1] * @@size, 
                color: 'red',
                size: @@size - 1
                )
        end
        if @@new_munch[0]
            Square.new(
                x: @@new_munch[1][0] * @@size, 
                y: @@new_munch[1][1] * @@size, 
                color: 'green',
                size: @@size - 1
                )
        end

    end
    def random_coord_x
        rand @@width
    end
    def random_coord_y
        rand @@height
    end
    def new_random
        @available_munchies.each do |part|
            Square.new(
                x: part[0] * @@size, 
                y: part[1] * @@size, 
                color: 'green',
                size: @@size - 1
                )
        end
        @available_munchies.each do |part|
            part[0] = self.random_coord_x
            part[1] = self.random_coord_y
        end
    end
    def get_munchied(apple)
        @available_munchies.each do |part, index|
            if part[0] == apple[0] && apple[1] == part[1]
                @@available_munchies.delete_at(index)
                @@new_munch[0] = true
                @@new_munch[1][0] = part[0]
                @@new_munch[1][1] = part[1] 
            end
        end

    end
end