require 'pry'
require 'socket'

class HTTP
  attr_reader :server
  attr_accessor :counter

  def initialize
    @server = TCPServer.new(9292)
    @counter = 0
  end
  puts "server's up, capiTAN"

  def send_message
    client_response = []
    while client = server.accept
      while line = client.gets and !line.chomp.empty?
        client_response << line = line.chomp
      end
      path = client_response[0].split[1]
      word_search = path.split("=")[1]

      time = Time.now.strftime("%Y %B %d, %H:%M %z")

      hello_path = ["hello world, this has been reloaded #{counter} times."]
      default_path = ["<pre>#{Time.now}\nThis is my default path\n#{client_response.join("\n")}</pre>\r\n"]
      datetime_path = ["<pre>The time is #{time}</pre>"]
      shutdown_path = ["Total requests: #{counter}\nExiting..."]
      word_search_found_path = ["your word '#{word_search}' was found"]
      word_search_not_found_path = ["your word '#{word_search}' was NOT found"]

      if path == "/"
        response = default_path
      elsif path == "/hello"
        response = hello_path
      elsif path == "/datetime"
        response = datetime_path
      elsif path == "/shutdown"
        response = shutdown_path

      elsif path.include?("/word_search")
        dict = File.open("/usr/share/dict/words", "r").read.split("\n")
          if dict.include?(word_search)
            response = word_search_found_path
          elsif !dict.include?(word_search)
            response = word_search_not_found_path
          end
      else
        response = default_path
      end


      output = "<html><head></head><body>#{response.join}</body></html>"

      headers = ["http/1.1 200 ok",
                "date: #{time}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length + 1}\r\n\r\n"].join("\r\n")

      @counter += 1
      client.puts headers
      client.puts output
      client.close

      client.exit if path == "/shutdown"

      response = nil
      path = nil
      client_response = []
    end


  end
end

my_server = HTTP.new
my_server.send_message
