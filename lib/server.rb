require 'pry'

require 'socket'
require './lib/messages'

class HTTP
  attr_reader :server
  attr_accessor :counter

  def initialize
    @server = TCPServer.new(9090)
  end
  puts "server's up, capiTAN"

  def start_connection
    Messages.get_client_request(server)
  end

  def send_response
    Messages.send_server_response(server)
  end

end

my_server = HTTP.new
my_server.start_connection
my_server.send_response
