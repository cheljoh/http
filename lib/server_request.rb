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

      @send_response.respond(client, parsed)

      client.close
      break if parsed.path == "/shutdown"
    end
  end
end
