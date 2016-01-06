require_relative 'setup_reqs'
require_relative 'server_request'
require_relative 'server_response'

class Server
  attr_reader :server

  def initialize
    @server = TCPServer.new(9292)
  end

  def request
    make_request = ServerRequest.new
    make_request.request(server)
  end
end


server = Server.new
server.request
