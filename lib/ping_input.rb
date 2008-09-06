class PingInput
  
  attr_accessor :median_buffer_length, :average_buffer_length
  
  def initialize(window)
    port_str = "/dev/tty.usbserial-FTAJM79K"  #may be different for you
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE

    @serial_port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    self.median_buffer_length = 5
    self.average_buffer_length = 5
    @median_buffer = []
    @average_buffer = []
    @window = window
  end
  
  def position  
    @serial_port.putc 1
    normalized_position(@serial_port.gets.chomp.to_i) 
  end
  
  def calibrate
    #FIXME
  end
  
  def calibrated_position(raw)
    #FIXME
    contain(raw - 700)
  end
  
  def normalized_position(raw)
    @median_buffer.shift if @median_buffer[median_buffer_length]
    @median_buffer.push(calibrated_position(raw))

    @average_buffer.shift if @average_buffer[average_buffer_length]    
    if @median_buffer.sort.size % 2 == 0  
       @average_buffer.push(@median_buffer.sort[@median_buffer.sort.size / 2])
    else  
      @average_buffer.push((@median_buffer.sort[(@median_buffer.sort.size / 2).ceil] + @median_buffer.sort[(@median_buffer.sort.size / 2).floor]) / 2)
    end
    
    sum = @average_buffer.inject do |sum, i|
      sum + i
    end
    
    contain(sum / @average_buffer.length)
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
