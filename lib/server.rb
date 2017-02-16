require 'socket'
require './lib/message'

class HTTP
  attr_reader :server
  attr_accessor :counter

  def initialize
    @server = TCPServer.new(9090)
    @counter = 0
  end
  puts "server's up, capiTAN"

  def send_message
    Message.send_message(server)
  end
end

my_server = HTTP.new
my_server.send_message
