require 'paddle'
require 'ball'

class GameWindow < Gosu::Window

  attr_accessor :font
  
  def initialize(w, h)
    super(w, h, false)
    @paddle_right = Paddle.new(self, height / 2, :right)
    @paddle_left = Paddle.new(self, height / 2, :left)
    @ball = Ball.new(self, width - 100, height / 2, :left, :up)
    @ping_input = PingInput.new(self)
    @paddle_left_position = @paddle_right_position = height / 2
    self.font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @right_score = @left_score = 0
    @next_start_direction = :right
  end

  def update
    @paddle_left_position, @paddle_right_position = @ping_input.position
    
    [@ball, @paddle_right, @paddle_left].each do |object|
      object.update
    end
    if @ball.off_screen?   
      if @time_until_next_round.nil?
        case @ball.off_screen_side
          when :left
            @next_start_direction = :left
            @right_score += 1
          when :right
            @next_start_direction = :right
            @left_score += 1
        end
        @time_until_next_round = 80
      else
        if (@time_until_next_round / 20).floor > 0 
          @time_until_next_round -= 1
        else
          @time_until_next_round = nil
          start_position = 
            case @next_start_direction
              when :right
                100
              when :left
                width - 100
            end
          @ball = Ball.new(self, start_position, height / 2, @next_start_direction, [:down, :up][rand(2)])
        end    
      end        
    end
  end
  
  def draw
    [@ball, @paddle_right, @paddle_left].each do |object|
      object.draw
    end
    if @time_until_next_round
      font.draw("Next Ball In: #{(@time_until_next_round / 20).floor}", (width / 2) - 50, height / 2, 0, 1.0, 1.0, 0xffffff00)
    end
    font.draw("#{@right_score}", width - 200, 10, 0, 1.0, 1.0, 0xffffff00)
    font.draw("#{@left_score}", 200, 10, 0, 1.0, 1.0, 0xffffff00)
  end
  
  def paddle_right
    @paddle_right
  end

  def paddle_left
    @paddle_left
  end
  
  def paddles
    [@paddle_left, @paddle_right]
  end
  
  def paddle_position(side)
    case side
      when :right
        @paddle_right_position
      when :left
        @paddle_left_position
    end
  end
  
  def ball
    @ball
  end
end
