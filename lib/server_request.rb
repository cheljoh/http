require_relative 'parser'

class ServerRequest

  def initialize
    @send_response = ServerResponse.new
  end

  def request(server)
    loop do
      client = server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      parsed = Parser.new(request_lines)
      # user_input = request_lines[0].split[1].split("?")[0]
      # input_params = request_lines[0].split[1].split("?")[1]
      # input_verb = request_lines[0].split[0]

      @send_response.respond(client, parsed)
      client.close
      break if parsed.path == "/shutdown"
    end
  end
end


# parser.new(request_lines)
# parser would then split the request lines into the input(path), params (param/value), and verb
