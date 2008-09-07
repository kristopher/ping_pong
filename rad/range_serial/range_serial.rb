class RangeSerial < ArduinoSketch
  
  serial_begin
  
  external_vars :sig_pin_1 => 'int, 7'
  external_vars :sig_pin_2 => 'int, 8'
  
  def loop
    if serial_available 
      if serial_read == 1
        serial_print(ping(sig_pin_1))
        serial_print(',')
        serial_println(ping(sig_pin_2))
      end
    end
  end
end
