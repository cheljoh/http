require_relative 'test_helper'

class PathMethodsTest < Minitest::Test

  def test_hello_world
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/hello")
    assert_equal "Hello, World!", response.body[31..43]
  end

  def test_root
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/")
    expected =
    "Verb: GET"
    assert_equal expected, response.body[33..41]
  end

  def test_datetime
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/datetime")
    assert_equal "2016", response.body[58..61]
  end

  def test_word_search_known_word
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/word_search?word=pizza")
    expected = "PIZZA is a known word"
    assert_equal expected, response.body[25..45]
  end

  def test_word_search_unknown_word
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/word_search?word=yolo")
    expected = "YOLO is not a known word"
    assert_equal expected, response.body[25..48]
  end

end
