gem 'minitest'
require 'minitest/autorun'
require './lib/simple_server'

class SimpleServerTest < Minitest::Test

  def test_tcp_server_is_TCP_server
    tcp_server = TCPServer.new(9292)
    assert_instance_of TCPServer, tcp_server
  end
end
