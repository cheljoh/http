require 'socket'
require 'pry'

class Server
  attr_accessor :client, :request_counter
  attr_reader :request_lines

  def initialize
    @client = TCPServer.new(9292).accept
    @request_counter = 0
    @request_lines = []
    while line = client.gets and !line.chomp.empty? #assign while, loop through
      request_lines << line.chomp
    end
  end

 #   def request
 #     request_counter += 1
 # #     client.puts "<pre>
 # # Verb: #{request_lines[0].split[0]}
 # # Path: #{request_lines[0].split[1]}
 # # Protocol: #{request_lines[0].split[2]}
 # # Host: #{request_lines[1].split[1][0..8]}
 # # Port: #{request_lines[1].split[1][10..13]}
 # # Origin: #{request_lines[1].split[1][0..8]}
 # # Accept: #{request_lines[4].split[1]}
 # #     </pre>"
 #     request_lines
 #   end

   def diagnostics
     request_lines = request
     client.puts "<pre>
 Verb: #{request_lines[0].split[0]}
 Path: #{request_lines[0].split[1]}
 Protocol: #{request_lines[0].split[2]}
 Host: #{request_lines[1].split[1][0..8]}
 Port: #{request_lines[1].split[1][10..13]}
 Origin: #{request_lines[1].split[1][0..8]}
 Accept: #{request_lines[4].split[1]}
     </pre>"
   end

  def respond
    output_message = "<pre> Hello, World! (#{request_counter}) </pre>"
    client.puts output_message
  end

  def close
    client.close
  end
end

# binding.pry
server = Server.new
server.respond
# server.request
# server.diagnostics
# server.message
# server.request
# server.message
# server.close


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
