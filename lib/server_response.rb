require_relative 'number_game'
require_relative 'setup_reqs'

class ServerResponse

  def initialize
    @request_counter = 0
    @hello_counter = 0
  end

  def default_headers(output) #need to have response to compute output
  #def headers(output, code="200 ok", location="http://127.0.0.1:9292")
     ["http/1.1 200 ok",
      "location: http://127.0.0.1:9292",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def redirect_headers(output) #need to have response to compute output
  #def headers(output, code="200 ok", location="http://127.0.0.1:9292")
     ["http/1.1 302 Found",
      "location: http://127.0.0.1/game",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def respond(client, parsed)
    @request_counter += 1
    if parsed.verb == "GET"
      response = response_get(client, parsed)
    elsif parsed.verb == "POST"
      response = response_post(client, parsed)
    end
    output = "<html><head></head><body>#{response}</body></html>"
    header = default_headers(output)
    header = redirect_headers(output) if parsed.verb == "POST" && parsed.path == "/game"
    client.puts header
    client.puts output
  end

  def response_get(client, parsed)
    response = ""
    output_diagnostics = diagnostics(client, parsed.full_request)
    if parsed.path == "/"
      response = output_diagnostics
    elsif parsed.path == "/hello"
      response = hello_message
      @hello_counter += 1
    elsif parsed.path == "/datetime"
      response = date
    elsif parsed.path == "/shutdown"
      response = shutdown
    elsif parsed.path == "/word_search"
      response = word_search(parsed.value)
    elsif parsed.path == "/game"
      response = @game.game_get
    end
    response
  end

  def response_post(client, parsed)
    if parsed.path == "/game"
      response = @game.game_post(parsed.full_params)
    elsif parsed.path == "/start_game"
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

  def word_search(word)

    if valid_word?(word)
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end

  end

  def valid_word?(word)
    dictionary = File.read("/usr/share/dict/words").split
    dictionary.include?(word)
  end

  def diagnostics(client, request_lines)
    "<pre>
Verb: #{request_lines[0].split[0]}
Path: #{request_lines[0].split[1]}
Protocol: #{request_lines[0].split[2]}
Host: #{request_lines[1].split[1].split(":")[0]}
Port: #{request_lines[1].split[1].split(":")[1]}
Origin: #{request_lines[1].split[1].split(":")[0]}
Accept: #{request_lines[4].split[1] if !request_lines[4].nil?}
    </pre>"
  end
end
