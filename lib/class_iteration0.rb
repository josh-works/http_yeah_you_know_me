require 'pry'
require 'socket'

class HTTP
  attr_reader :server
  attr_accessor :counter

  def initialize
    @server = TCPServer.new(9090)
    @counter = 0
  end

  # note to myself in terminal when this gets hit.
  puts "server's up, capiTAN"

  def send_message
    client_response = []
    while client = server.accept
      while line = client.gets and !line.chomp.empty?
        client_response << line = line.chomp
      end

      path = client_response[0].split()[1]
      header = "HTTP/1.1 200 OK"
      server = "Josh's ugly little server"
      date = Time.now.strftime("%Y-%B-%d, %l:%M %P")
      content_type = "text/html; charset=UTF-8"
      content_length = helloworld_path.join.length
      connection = "close"

      header_block = <<END
  #{header}
  server: #{server}
  date: #{date}
  content-type: #{content_type}
  content-length: #{content_length}
  connection: #{connection}
  \r\n\r\n
END

      helloworld_path = ["<html><head></head><body>" +
        "hello world, this has been reloaded #{counter} times." +
        "</body></html>"]

      @counter += 1

      default_path = ["<html><head></head><body>\r\n" +
        "<pre>#{client_response.join("\n")}</pre>\r\n" +
        "this server has been (re)started #{counter} times\r\n" +
        "</body></html>\n"
      ]

      client.puts header_block



      if path == "/"
        client.puts default_path
      elsif path == "/helloworld"
        client.puts helloworld_path
      end

    end
  end
end

my_server = HTTP.new
my_server.send_message
