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
  #
  # # this should be regex
  # method = whole_response[0]
  # path = method.split()[1]
  # host = whole_response[1]
  # user_agent = whole_response[2]
  # accept = user_agent[3]
  #
  # if path == "/"
  #   requests_root
  # elsif path == "/hello"
  #   request_hello
  # end


    output = "<html><head></head><body>\n#{whole_response.join("\n")} \n this server has been (re)started #{counter} times\n</body></html>\n"
    counter += 1

    headers = [
      "HTTP/1.1 200 OK",
      "date = #{Time.now.strftime("%Y-%B-%d, %l:%M %P")}",
      "server: ruby",
      "content-type: text/html; charset=UTF-8",
      "content-length: #{output.length}",
      "\r\n"
    ]

  def requests_root
    client.puts headers
    client.puts output
  end

end
