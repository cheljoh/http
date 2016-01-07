class NumberGame

  attr_accessor :guess

  def initialize(client)
    @guess_counter = 0
    @guess = 0
    @target = rand(10).to_s
  end

  def game_get
    guess_result = compare_numbers
    "You have made #{@guess_counter} guesses and your guess of #{guess} was #{guess_result}"
  end

  def game_post(input_params)
    @guess = input_params.split("=")[1]
    @guess_counter += 1
  end

  def compare_numbers
    return = "high" if guess > @target
    return "low" if guess < @target
    return "just right! Congrats!" if guess == @target
  end
end
