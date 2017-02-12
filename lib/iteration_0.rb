# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

require 'socket'
require 'faraday'

server = TCPServer.new 9292
counter = 0

loop do
  client = server.accept
  client.puts "Hello!\r\n"
  client.puts "Hello world!\r\n"
  client.puts "Time is #{Time.now}, and counter is #{counter}"
  counter += 1
  client.close
end
