require 'paddle'
require 'ball'

class GameWindow < Gosu::Window
  
  def initialize(w, h)
    super(w, h, false)
    @paddle = Paddle.new(self, height / 2)
    @ball = Ball.new(self, width / 2, height / 2, :left, :up)
  end

  def update
    [@ball, @paddle].each do |object|
      object.update
    end
  end
  
  def draw
    [@ball, @paddle].each do |object|
      object.draw
    end
  end
  
  def paddle
    @paddle
  end
  
  def ball
    @ball
  end
end
