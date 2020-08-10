class Controller
    attr_accessor :direction, :play

    def initialize
        @direction = 'left'
        @@last = @direction
        @play = false
    end
    def check_input
        Window.on :key_down do |event|
            case event.key
            when 'left'
                if @@last != 'right'
                    @direction = 'left'
                end
            when 'right'
                if @@last != 'left'
                    @direction = 'right'
                end
            when 'up'
                if @@last != 'down'
                    @direction = 'up'
                end
            when 'down'
                if @@last != 'up'
                    @direction = 'down'
                end
            when 'p'
                @play = true
            end
        end
    end
    def last_input
        @@last = @direction
    end
end
