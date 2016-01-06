require_relative 'test_helper'

class ServerRequestTest < Minitest::Test

  def test_hello_world
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/hello")
    assert_equal "Hello, World!", response.body[31..43]
  end

  def test_root
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/")

    expected =
"Verb: GET
Path: /
Protocol: HTTP/1.1
Host: Hurley"

    assert_equal expected, response.body[31..79]
  end

  def test_datetime
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/datetime")

    assert_equal "2016", response.body[59..62]
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

  def test_shutdown
    skip
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/shutdown")

    assert_equal "Total requests:", response.body[25..39]
  end

end
