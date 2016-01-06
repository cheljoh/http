class NumberGame

  def initialize(client)
    @guess_counter = 0
    @guess = 123
  end

  def game_get
    "You have made #{@guess_counter} guesses and your guess of #{@guess} was too ___"
  end

  def game_post(input_params)
    param = input_params.split("=")[0]
    @guess = input_params.split("=")[1]
    @guess_counter += 1

    # `server.get("http://127.0.0.1:9292/game`

    game_get #need to figure out how to redirect user, post to get
  end

end
