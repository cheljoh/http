require_relative 'setup_reqs'
require_relative 'server_request'
require_relative 'server_response'

class Server

  def initialize
    server = TCPServer.new(9292)
    ServerRequest.new.request(server)
  end

end

server = Server.new
