require_relative 'parser'
require_relative 'server_response'

class ServerRequest

  def initialize
    @send_response = ServerResponse.new
  end

  def request(server)
    loop do
      client, request_lines = get_client(server)
      parsed = Parser.new(request_lines)

      @send_response.respond(client, parsed)
      client.close

      break if parsed.path == "/shutdown"
    end
  end

  def get_client(server)
      client = server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      return client, request_lines
  end

end
