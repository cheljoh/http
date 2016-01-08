require_relative 'test_helper'

#run file individually
#run with new server
class ServerResponseTest < Minitest::Test

  def test_attempt_guess_when_game_has_not_started
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/game?guess=8")
    assert_equal "Please start a game", response.body[25..43]
  end

  def test_attempt_to_see_game_results_when_game_has_not_started
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/game")
    assert_equal "Please start a game", response.body[25..43]
  end

  def test_bad_path_with_get_request
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/laksjda;kldjas")
    assert_equal "Wrong path, sorry!", response.body[25..42]
  end

  def test_bad_path_with_post_request
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/laksjda;kldjas")
    assert_equal "Wrong path, sorry!", response.body[25..42]
  end

end
