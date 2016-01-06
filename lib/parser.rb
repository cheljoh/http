class Parser

  attr_reader :full_request, :verb, :path, :parameter, :value, :full_params

  def initialize(request_lines)
    @full_request = request_lines
    @verb = request_lines[0].split[0]
    @path = request_lines[0].split[1].split("?")[0]
    @full_params = request_lines[0].split[1]
    @parameter = request_lines[0].split[1].split("?")[1].split("=")[0] if !request_lines[0].split[1].split("?")[1].nil?
    @value = request_lines[0].split[1].split("?")[1].split("=")[1] if !request_lines[0].split[1].split("?")[1].nil?
  end

end
