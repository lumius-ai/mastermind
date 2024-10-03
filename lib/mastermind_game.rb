require_relative './game_row'

class MastermindGame
  attr_accessor :game_code, :game_board, :guesses_left

  # Creates specified code
  def initialize(args = {})
    begin
      @guesses_left = args.fetch("guesses")
    rescue KeyError
      @guesses_left = 10
    ensure
      begin
        @game_code = args.fetch("code")
      rescue KeyError
        prng = Random.new(Random.seed)
        @game_code = "%04d" % prng.rand(9999)
      ensure
        @game_board = []
        for i in 0...guesses_left
          game_board.append(GameRow.new())
        end
      end
    end
  end

  # Makes guess
  def make_guess(string)

  end
  
  #Generates hint
  def generate_hint(guess)

  end

  # Determines win or loss
  def is_win?()

  end

  # Runs one game
  def run_game()

  end
  # Display whole board to terminal
  def to_s

  end
end