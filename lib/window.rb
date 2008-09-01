require 'ping_input'

class GameWindow < Gosu::Window
  
  def initialize(w, h)
    super(w, h, false)
    @star = Gosu::Image.new(self, "images/paddle.png", false)
    @range_input = PingInput.new(self)
  end

  def update
  end
  
  def draw
    @star.draw(10, @range_input.position, 0)
  end
end
