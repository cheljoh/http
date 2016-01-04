require 'socket'
require 'pry'

class Server
  attr_reader :client

  def initialize
    #request
    @request_counter = 0
  end

   def request
     tcp_server = TCPServer.new(9292)
     @client = tcp_server.accept
     request_lines = []
     while line = client.gets and !line.chomp.empty? #assign while, loop through
       request_lines << line.chomp
     end
     client.puts "<pre>\nVerb: #{request_lines[0].split[0]}\nPath: #{request_lines[0].split[1]}\nProtocol: #{request_lines[0].split[2]}"\
     "Host: #{request_lines[1].split[1][0..8]}\nPort: #{request_lines[1].split[1][10..13]}\nOrigin: not sure what to put here\n"\
     "Accept: #{request_lines[4].split[1]}\n #{request_lines}</pre>"
     request_lines
   end

   def diagnostics
     request_lines = request
     client.puts "<pre>\nVerb: #{request_lines[0].split[0]}\nPath: #{request_lines[0].split[1]}\nProtocol: #{request_lines[0].split[2]}"\
     "Host: #{request_lines[1].split[1][0..8]}\nPort: #{request_lines[1].split[1][10..13]}\nOrigin: not sure what to put here\n"\
     "Accept: #{request_lines[4].split[1]}\n #{request_lines}</pre>"
   end

  def message
    message = "Hello, World! (#{@request_counter})"
    @request_counter += 1
    client.puts message
  end

  def close
    client.close
  end
end

server = Server.new
server.request
#server.diagnostics
server.message
server.message
server.message
server.close


# class Server
#   attr_reader :tcp_server, :requests
#
#   def initialize
#     #restart
#     @tcp_server = TCPServer.new(9292)
#     @requests = []
#   end
#
#   #  def restart
#   #    tcp_server = TCPServer.new(9292)
#   #  end
#
#   def request
#     r = Request.new(tcp_server)
#     requests << r
#   end
#
#   def output
#     message = "Hello, World (#{requests.count})"
#     client.puts message
#   end
# end
#
# class Request
#   attr_reader :socket, :message
#
#   def initialize(tcp_server)
#     socket = tcp_server.accept
#
#     request_lines = []
#     while line = socket.gets and !line.chomp.empty? #assign while, loop through
#       request_lines << line.chomp
#     end
#
#     message = request_lines.join("\n")
#   end
# end
#
# server = Server.new
# server.request
# server.output
#server.close
