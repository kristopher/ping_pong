class Ball 
   
  attr_accessor :x, :y, :image, :x_direction, :y_direction
  
  def initialize(window, pos_x, pos_y, x_direction, y_direction)
    @window = window
    self.image = Gosu::Image.new(@window, "images/ball.png", false)
    self.x, self.y = pos_x, pos_y
    self.x_direction = x_direction
    self.y_direction = y_direction
  end
  
  def speed
    10
  end

  def update
    if Range.new(10, 30).include?(x) && Range.new(@window.paddle.y, @window.paddle.y + 80).include?(y)
      case x_direction
        when :left
          self.x_direction = :right
        when :right
          self.x_direction = :left
      end

    else
      if x >= @window.width - 20
        self.x_direction = :left
      elsif x <= 0
        self.x_direction = :right
      end
    
    
      if y >= @window.height - 20
        self.y_direction = :up
      elsif y <= 0
        self.y_direction = :down
      end

    end

    case x_direction
      when :left
        self.x = x - speed
      when :right
        self.x = x + speed
    end

    case y_direction
      when :up
        self.y = y - speed
      when :down
        self.y = y + speed
    end    
  end
  
  def draw
    image.draw(x, y, 0)
  end
  
  
end