require 'ping_input'

class Paddle
  
  attr_accessor :y, :image
  
  def initialize(window, pos_y)
    @window = window
    self.image = Gosu::Image.new(@window, "images/paddle.png", false)
    self.y = pos_y
    @range_input = PingInput.new(@window)
  end
  
  def update
  end
  
  def draw
    image.draw(x, y, 0)
  end
  
  def x
    10
  end
  
  def y
    @range_input.position
  end
end