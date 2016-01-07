require_relative 'number_game'
require_relative 'setup_reqs'
require_relative 'path_methods'

class ServerResponse
attr_reader :path_methods
  def initialize
    @request_counter = 0
    @hello_counter = 0
    @path_methods = PathMethods.new
  end

  def headers(output, redirect)
    response_code, location = decide_redirect(redirect)
     ["#{response_code}",
      "location: #{location}",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def decide_redirect(redirect)
    if redirect
      response_code, location = "http/1.1 302 Found", "http://127.0.0.1:9292/game"
    else
      response_code, location = "http/1.1 200 ok", "http://127.0.0.1:9292"
    end
  end

  def respond(client, parsed)
    @request_counter += 1
    response = decide_path(client, parsed)
    output = "<html><head></head><body>#{response}</body></html>"
    redirect = parsed.verb == "POST" && parsed.path == "/game"
    header = headers(output, redirect)
    client.puts header
    client.puts output
  end

  def decide_path(client, parsed)
    if parsed.verb == "GET"
      response_get(client, parsed)
    elsif parsed.verb == "POST"
      response_post(client, parsed)
    end
  end

  def response_get(client, parsed)
    if parsed.path == "/"
      path_methods.diagnostics(client, parsed.full_request)
    elsif parsed.path == "/hello"
      @hello_counter += 1
      path_methods.hello_message(@hello_counter)
    elsif parsed.path == "/datetime"
      path_methods.date
    elsif parsed.path == "/shutdown"
      path_methods.shutdown(@request_counter)
    elsif parsed.path == "/word_search"
      path_methods.word_search(parsed.value)
    elsif parsed.path == "/game"
      @game.game_get
    end
  end

  def response_post(client, parsed)
    if parsed.path == "/game"
      @game.game_post(parsed.full_params)
    elsif parsed.path == "/start_game"
      @game = NumberGame.new(client)
      "Good Luck!"
    end
  end

end
