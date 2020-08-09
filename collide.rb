class Collide
    def check_collision(snake, apples)
        retn = [false, false]
        index = 0
        snake.each do |part|
            if index > 0
                if (snake.first[0] == part[0]) && (snake.first[1] == part[1])
                    retn = ['game over', part]
                    break
                end
            end
            index += 1
        end

        apples.each do |apple|
            if (snake.first[0] == apple[0]) && (snake.first[1] == apple[1])
                retn = ['grow', apple]
            end
        end
        retn
    end
end