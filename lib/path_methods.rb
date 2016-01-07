
class PathMethods

  def hello_message(hello_counter)
      "<pre> Hello, World! (#{hello_counter}) </pre>"
  end

  def date
    Time.now.strftime("%I:%M%p on %A, %B %d, %Y")
  end

  def shutdown(request_counter)
    "Total requests: #{request_counter}"
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

  def diagnostics(client, parsed_full_request)
    "<pre>
  Verb: #{parsed_full_request[0].split[0]}
  Path: #{parsed_full_request[0].split[1]}
  Protocol: #{parsed_full_request[0].split[2]}
  Host: #{parsed_full_request[1].split[1].split(":")[0]}
  Port: #{parsed_full_request[1].split[1].split(":")[1]}
  Origin: #{parsed_full_request[1].split[1].split(":")[0]}
  Accept: #{parsed_full_request[4].split[1] if !parsed_full_request[4].nil?}
    </pre>"
  end
end
