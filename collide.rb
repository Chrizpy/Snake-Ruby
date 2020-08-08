class Collide
    def check_collision(snake, apples)
        #puts "#{snake} snakes in the collision"
       # puts "#{apples} apples in the collision"
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
        #puts "#{snake.first} body"
        apples.each do |apple|
            #puts "#{apple}"
    
            #puts "#{snake.first[0]}, == #{apple[0]}"
            #puts "#{snake.first[1]}, == #{apple[1]}"
            if (snake.first[0] == apple[0]) && (snake.first[1] == apple[1])
                retn = ['grow', apple]
                puts "GROWING"
            end
        #break
        end
        retn
    end
end