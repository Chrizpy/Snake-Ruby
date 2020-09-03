# frozen_string_literal: true

# Collide class
# This class is used to check the collision between snake and apples
# and snake itself
class Collide
  def initialize
    @retn = [false, false]
  end

  def check_collision(snake, apples)
    reset_retn
    check_snake(snake)
    check_food(snake, apples)
    @retn
  end

  def check_food(snake, apples)
    apples.each do |apple|
      if (snake.first[0] == apple[0]) && (snake.first[1] == apple[1]) then @retn = ['grow', apple] end
    end
  end

  def check_snake(snake)
    index = 0
    snake.each do |part|
      if index.positive?
        if (snake.first[0] == part[0]) && (snake.first[1] == part[1])
          @retn = ['game over', part]
          break
        end
      end
      index += 1
    end
  end

  def reset_retn
    @retn = [false, false]
  end
end
