require_relative 'test_helper'

class NumberGameTest < Minitest::Test

  def test_start_game
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/start_game")

    expected =
    "<html><head></head><body>Good Luck!</body></html>"

    assert_equal expected, response.body
  end

  def test_make_high_guess
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/game?guess=3")

    expected =
    "You have made"

    assert_equal expected, response.body[25..37]
  end

end
