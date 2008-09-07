class PingInput
  
  attr_accessor :median_buffer_length, :average_buffer_length
  
  def initialize(window)
    port_str = "/dev/tty.usbserial-FTAJM79K"  #may be different for you
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE

    @serial_port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    self.median_buffer_length = 3
    self.average_buffer_length = 5
    @median_buffer_right = []
    @median_buffer_left = []
    @average_buffer_right = []
    @average_buffer_left = []
    @window = window
  end
  
  def position  
    @serial_port.putc 1
    positions = @serial_port.gets.chomp.split(',')
    [normalized_position(positions.first().to_i, :left), normalized_position(positions.last().to_i, :right)]
  end
  
  def calibrate
    #FIXME
  end
  
  def calibrated_position(raw)
    #FIXME
    contain(raw - 700)
  end
  
  def normalized_position(raw, side)
    instance_variable_get("@median_buffer_#{side}").shift if instance_variable_get("@median_buffer_#{side}")[median_buffer_length]
    instance_variable_get("@median_buffer_#{side}").push(calibrated_position(raw))

    instance_variable_get("@average_buffer_#{side}").shift if instance_variable_get("@average_buffer_#{side}")[average_buffer_length]    
    if instance_variable_get("@median_buffer_#{side}").sort.size % 2 == 0  
       instance_variable_get("@average_buffer_#{side}").push(instance_variable_get("@median_buffer_#{side}").sort[instance_variable_get("@median_buffer_#{side}").sort.size / 2])
    else  
      instance_variable_get("@average_buffer_#{side}").push((instance_variable_get("@median_buffer_#{side}").sort[(instance_variable_get("@median_buffer_#{side}").sort.size / 2).ceil] + instance_variable_get("@median_buffer_#{side}").sort[(instance_variable_get("@median_buffer_#{side}").sort.size / 2).floor]) / 2)
    end
    
    sum = instance_variable_get("@average_buffer_#{side}").inject do |sum, i|
      sum + i
    end
    
    contain(sum / instance_variable_get("@average_buffer_#{side}").length)
  end
  
  def contain(position)
    if position < 0
      0
    elsif position > @window.height - 80
      @window.height - 80
    else
      position
    end
  end
end
