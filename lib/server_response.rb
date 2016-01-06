require_relative 'number_game'

class ServerResponse

  def initialize
    @request_counter = 0
    @hello_counter = 0
  end

  def headers(output) #need to have response to compute output
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end


  def respond(client, request_lines, user_input, input_params, verb)
    @request_counter += 1
    if verb == "GET"
      response = response_get(client, request_lines, user_input, input_params)
    elsif verb == "POST"
      response = response_post(client, user_input, input_params)
    end
    output = "<html><head></head><body>#{response}</body></html>"
    header = headers(output)
    client.puts header
    client.puts output
  end

  def response_get(client, request_lines, user_input, input_params)
    response = ""
    output_diagnostics = diagnostics(client, request_lines)
    if user_input == "/"
      response = output_diagnostics
    elsif user_input == "/hello"
      response = hello_message
      @hello_counter += 1
    elsif user_input == "/datetime"
      response = date
    elsif user_input == "/shutdown"
      response = shutdown
    elsif user_input == "/word_search"
      response = word_search(input_params)
    elsif user_input == "/game"
      response = @game.game_get
    end
    response
  end

  def response_post(client, user_input, input_params)
    if user_input == "/game"
        response = @game.game_post(input_params)
    elsif user_input == "/start_game"
        @game = NumberGame.new(client)
        response = "Good Luck!"
    end
    response
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

  def word_search(input_params)
    param = input_params.split("=")[0]
    value = input_params.split("=")[1]
    dictionary = File.read("/usr/share/dict/words").split
    if dictionary.include?(value)
      "#{value.upcase} is a known word"
    else
      "#{value.upcase} is not a known word"
    end
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
  end
end
