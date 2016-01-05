require_relative 'setup_reqs'

class Server
  attr_reader :server

  def initialize
    @server = TCPServer.new(9292)
    @request_counter = 0
    @hello_counter = 0
  end


  def request
    loop do
      puts "Enter what you want to do"
      user_input = gets.chomp

      client = server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      respond(client, request_lines, user_input)
      client.close
      break if user_input == "/shutdown"
    end
  end

  def respond(client, request_lines, user_input)
    @request_counter += 1
    output_diagnostics = diagnostics(client, request_lines)
    if user_input == "/"
      client.puts(output_diagnostics)
    elsif user_input == "/hello"
      client.puts(hello_message)
      @hello_counter += 1
    elsif user_input == "/datetime"
      client.puts(date)
    elsif user_input == "/shutdown"
      client.puts(shutdown)
    end

    #why does this have to be an IVar? In line 45 it isn't, but it works?
  end

  def hello_message
      "<pre> Hello, World! (#{@hello_counter}) </pre>" #have hello counter
  end

  def date
    Time.now.strftime("%I:%M%p on %A, %B %d, %Y")
  end

  def shutdown
    "Total requests: #{@request_counter}"
  end

  def diagnostics(client, request_lines)
    "<pre>
Verb: #{request_lines[0].split[0]}
Path: #{request_lines[0].split[1]}
Protocol: #{request_lines[0].split[2]}
Host: #{request_lines[1].split[1].split(":")[0]}
Port: #{request_lines[1].split[1].split(":")[1]}
Origin: #{request_lines[1].split[1].split(":")[0]}
Accept: #{request_lines[4].split[1]}
    </pre>"
#Host: #{request_lines[1].split[1].split(":")[0]}
  end

end

# binding.pry
server = Server.new
server.request


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
