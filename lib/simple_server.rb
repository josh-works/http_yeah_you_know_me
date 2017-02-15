require 'socket'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept

puts "ready for a request"

request_lines = []

while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "I (the server) just got this request:"
puts request_lines.inspect


puts "I (the server) am sending response."
response = "<pre>" + request_lines.join("\n") + "</pre>"
output = response
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output

puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."


# Notes

# the loop
