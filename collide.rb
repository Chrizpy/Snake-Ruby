class Collide
    def check_collision(snake, apples)
        retn = false
        snake.each do |part, index|
            if index > 0
                if snake.first[0] == part[0] && snake.first[1] == part[1]
                    retn = ['game over', part]
                    break
                end
            end
        end
        apples.each do |apple|
            if snake.first[0] == apple[0] && snake.first[1] == apple[1]
                retn = ['grow', apple]
                puts "GROWING"
            end
            break
        end
        retn
    end
end