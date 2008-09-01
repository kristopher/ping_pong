class PingSerial < ArduinoSketch
  
  serial_begin
  
  external_vars :sig_pin => 'int, 7'
  
  def loop
    if serial_available 
      if serial_read == 1
        serial_println(ping(sig_pin))
      end
    end
  end
end
