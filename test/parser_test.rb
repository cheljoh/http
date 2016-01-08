require "./lib/parser"
require_relative 'test_helper'

class ParserTest < Minitest::Test
  attr_reader :parser, :request_lines
  def setup
    @request_lines =
    ["GET /word_search?word=pizza HTTP/1.1",
     "Host: 127.0.0.1:9292",
     "Connection: keep-alive",
     "Cache-Control: no-cache",
     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
     "Postman-Token: 90c0e681-7940-d8ea-51e7-96ef4b3a5872",
     "Accept: */*",
     "DNT: 1",
     "Accept-Encoding: gzip, deflate, sdch",
     "Accept-Language: en-US,en;q=0.8"]
     @parser = Parser.new(request_lines)
  end

  def test_verb_parsed_correctly
    assert_equal "GET", parser.verb
  end

  def test_path_parsed_correctly
    assert_equal "/word_search", parser.path
  end

  def test_full_parameters_parsed_correctly
    assert_equal "/word_search?word=pizza", parser.full_params
  end

  def test_just_parameter_parsed_correctly
    assert_equal "word", parser.parameter
  end

  def test_value_parsed_correctly
    assert_equal "pizza", parser.value
  end

  def test_host_parsed_correctly
    assert_equal "127.0.0.1:9292", parser.host
  end
end
