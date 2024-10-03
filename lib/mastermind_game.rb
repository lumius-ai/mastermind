require_relative './game_row'

class MastermindGame
  attr_accessor :game_code, :game_board, :guesses_left

  # Randomly generates code
  def init(num_guesses = 10)

  end

  # Creates specified code
  def init(num_guesses = 10, code)

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