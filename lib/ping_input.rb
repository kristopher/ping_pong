class PingInput
  
  attr_accessor :buffer_length
  
  def initialize(window)
    port_str = "/dev/tty.usbserial-FTAJM79K"  #may be different for you
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE

    @serial_port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    self.buffer_length = 19
    @buffer = []
    @window = window
  end
  
  def position  
    @serial_port.putc 1
    normalized_position(@serial_port.gets.chomp.to_i) 
  end
  
  def calibrate
    #FIXME implement.
  end
  
  def calibrated_position(raw)
    #FIXME just pull 700 out of my ass.
    cal_pos = raw - 700

    if cal_pos <= 0 || cal_pos >= @window.height
      if cal_pos < 0
        cal_pos = 0
      elsif cal_pos >= @window.height 
        #FIXME window height minus the sprite height
        cal_pos = @window.height - 80
      end
    end
    cal_pos
  end
  
  def normalized_position(raw)
    @buffer.shift if @buffer[buffer_length]
    @buffer.push(calibrated_position(raw))
    
    sum = @buffer.inject do |sum, i|
      sum + i
    end
    
    sum / @buffer.length
  end
  
end
