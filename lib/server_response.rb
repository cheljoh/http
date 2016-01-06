require_relative 'number_game'

class ServerResponse

  def initialize
    @request_counter = 0
    @hello_counter = 0
  end

  # def headers(request_lines)
  #   response = "<pre>" + request_lines.join("\n") + "</pre>"
  #   output = "<html><head></head><body>#{response}</body></html>"
  #   headers = ["http/1.1 200 ok",
  #     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #     "server: ruby",
  #     "content-type: text/html; charset=iso-8859-1",
  #     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  # end

  def respond(client, parser)
    @request_counter += 1 #unless user_input == "/shutdown"
    #client.puts headers(request_lines)
    output_diagnostics = diagnostics(client, parser.full_request)
    if parser.path == "/"
      client.puts(output_diagnostics)
    elsif parser.path == "/hello"
      client.puts(hello_message)
      @hello_counter += 1
    elsif parser.path == "/datetime"
      client.puts(date)
    elsif parser.path == "/shutdown"
      client.puts(shutdown)
    elsif parser.path == "/word_search"
      client.puts(word_search(parser.value))
    elsif parser.path == "/game" && parser.verb == "GET"
      # client.puts(game_get)
      client.puts(@game.game_get)
    elsif parser.path == "/game" && parser.verb == "POST"
      # client.puts(game_post)
      client.puts(@game.game_post(parser.value))
    elsif parser.path == "/start_game" && parser.verb == "POST"
      @game = NumberGame.new(client)
      client.puts "Good Luck!"
    end
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
Accept: #{request_lines[4].split[1]}
    </pre>"
  end
end
