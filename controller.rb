class Controller
    attr_accessor :direction

    def initialize
        @direction = 'left'
        @@last = @direction
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
            end
        end
    end
    def last_input
        @@last = @direction
    end
end
