require 'pry'
gem 'minitest'
require 'minitest/autorun'
require './lib/message'

class SimpleServerTest < Minitest::Test

  def test_tcp_server_is_TCP_server
    tcp_server = TCPServer.new(9090)
    Message.send_message(tcp_server)
    puts "this thing on?"
    binding.pry

  end
end
