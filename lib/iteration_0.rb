require 'pry'
require 'socket'

server = TCPServer.new(9090)

puts "server's up, capiTAN"
puts server

counter = 0

while client = server.accept
  whole_response = []
  while line = client.gets and !line.chomp.empty?
    whole_response << line = line.chomp
  end


  puts "some shit that is"
  puts "client says #{client}"

  output = "<html><head></head><body>Whatever the hell I want this to be.#{counter}</body></html>"
  counter += 1

  # the response is rendered via 'client.puts response', I think.
  # So I need it to read like real HTML w/white space
  headers = [
    "HTTP/1.1 200 OK",
    "date = #{Time.now.strftime("%Y-%B-%d, %l:%M %P")}",
    "server: ruby",
    "content-type: text/html; charset=UTF-8",
    "content-length: #{output.length}",
    "\r\n"
  ]


  client.puts headers
  message = "#{headers}"

  puts "about to send headers to client"
  puts "#{headers}"

  client.puts output

  puts "server response is #{whole_response}"

end
