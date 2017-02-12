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
  client.close
end


<pre>
Verb: POST
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>
