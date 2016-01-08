require_relative 'test_helper'
require '../lib/number_game'

class NumberGameTest < Minitest::Test

  def test_start_game
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/start_game")
    assert_equal "Good Luck!", response.body[25..34]
  end

  def test_redirect
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.post("/game?guess=8")
    assert_equal "You have made", response.body[25..37]
  end

  def test_does_it_make_a_random_number_between_1_to_10
    game = NumberGame.new
    numbers = Array(0..10)
    assert numbers.include?(game.target.to_i)
  end

  def test_make_low_guess
    game = NumberGame.new
    game.target = 7
    game.guess = 5
    guess_result = game.compare_numbers
    assert_equal "low", guess_result
  end

  def test_make_high_guess
    game = NumberGame.new
    game.target = 7
    game.guess = 9
    guess_result = game.compare_numbers
    assert_equal "high", guess_result
  end

  def test_make_correct_guess
    game = NumberGame.new
    game.target = 7
    game.guess = 7
    guess_result = game.compare_numbers
    assert_equal "just right! Congrats!", guess_result
  end

  def test_negative_guess
    game = NumberGame.new
    game.target = 7
    game.guess = -80
    guess_result = game.compare_numbers
    assert_equal "low", guess_result
  end

  def test_multiple_digit_guess
    game = NumberGame.new
    game.target = 7
    game.guess = 2938429042
    guess_result = game.compare_numbers
    assert_equal "high", guess_result
  end


end
