require 'ping_input'

class Paddle
  
  attr_accessor :y, :image, :side
  
  def initialize(window, pos_y, side)
    @window = window
    self.image = Gosu::Image.new(@window, "images/paddle.png", false)
    self.y = pos_y
    self.side = side
  end
  
  def update
  end
  
  def draw
    image.draw(x, y, 0)
  end
  
  def x
    case side
      when :left
        10
      when :right
        @window.width - 30
    end
  end
  
  def y
    @window.paddle_position(side)
  end
end