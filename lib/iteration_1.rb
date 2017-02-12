# Let’s start to rip apart that request and output it in your response. In the body of your response, include a block of HTML like this including the actual information from the request:

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
  # puts request_lines.inspect



  puts "I (the server) am sending response."
  # response = "<pre>" + request_lines.join("\n") + "</pre>"
  # output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  # client.puts headers
  # client.puts output
  client.puts headers

  # puts ["Wrote this response:", headers, output].join("\n")
  client.close
end


# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>
