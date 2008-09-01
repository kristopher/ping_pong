require "serialport.so"
require 'rubygems'
require 'gosu'

$: << 'lib'
require 'window'

window = GameWindow.new(640, 480)
window.show