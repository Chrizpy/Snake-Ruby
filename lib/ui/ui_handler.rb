# frozen_string_literal: true

# Menuclass
# This class defines objects that handles menus for games.
class UIHandler
  attr_accessor :current

  def initialize(game, window)
    @game = game
    @window = window
    @controller = Controller.new
    @current = 'menu'
  end

  def main_menu
    @window.set background: 'white'
    @window.set title: 'Classic Snake Game : Main Menu'
    @controller.check_input
    window_text(120, 2, 'Press "p" to start the game', 'blue')

    wait_input
  end

  def game_over(score)
    @window.set background: 'white'
    @window.set title: 'Classic Snake Game : Game Over'
    @controller.check_input
    sleep(1)
    @window.clear
    window_text(60, 2, 'Game over', 'red')
    window_text(60, 3, "Score: #{score}", 'yellow')

    wait_input
  end

  def wait_input
    @window.update do
      if @controller.play
        @current = 'play'
        @controller.play = false
        return
      end
    end
    @window.show
  end

  def window_text(width, height, text, color)
    Text.new(
      text,
      x: ((Window.width / 2) - width), y: Window.height / height,
      size: 20,
      color: color
    )
  end
end
