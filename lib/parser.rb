class Parser

  attr_reader :full_request, :verb, :path, :parameter, :value, :full_params

  def initialize(request_lines)
    @full_request = request_lines
    @verb = @full_request[0].split[0]
    @path = @full_request[0].split[1].split("?")[0]
    @full_params = @full_request[0].split[1]
    @parameter = @full_request[0].split[1].split("?")[1].split("=")[0] if !@full_request[0].split[1].split("?")[1].nil?
    @value = @full_request[0].split[1].split("?")[1].split("=")[1] if !@full_request[0].split[1].split("?")[1].nil?
  end

end
