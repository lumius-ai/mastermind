require_relative './game_row'

class MastermindGame
  attr_accessor :game_code, :game_board, :guesses_left

  def initialize(args = {})
    # Init number of guesses
    if args["guesses"] == nil
      @guesses_left = 10
    else
      @guesses_left = args["guesses"]
    end

    # Init code
    if args["code"] == nil;
      prng = Random.new(Random.seed)
      @game_code = "%04d" % prng.rand(9999)
    else
      @game_code = args["code"]
    end

    # Guesses are pushed to the board stack
    @game_board = []
  end

  # Makes guess
  def make_guess(string)
    if string.length != 4
      return false
    else
      row = GameRow.new(string)
      row.hint_write(generate_hint(string))
      @game_board.append(row)
      @guesses_left -= 1
      return true
    end

  end
  
  #Generates hint
  def generate_hint(guess)
    output = []
    guess = guess.chars

    guess.each_with_index do |element, index|
      if(@game_code.include?(element))
        if(guess[index] == @game_code[index])
          output.append("B")
        else
          output.append("Y")
        end
      end
    end

    while output.length != 4
      output.append('-')
    end

    return output.join


  end

  # Determines win or loss
  def is_win?()
    if @game_board.length == 0
      return false
    end
    
    if(@game_board[-1].hint.join == 'BBBB')
      return true
    else
      return false
    end
  end

  # Runs one game
  def run_game()

  end
  # Display whole board to terminal
  def to_s
    outstring = "MASTERMIND GAME\n--------------------\n"
    if(self.is_win?)
      outstring += "CODE: #{@game_code.chars.join(" ")}\n--------------------\n"
    else
      outstring += "CODE: #{"????".chars.join(" ")}\n--------------------\n"
    end
    for i in 0...@game_board.length
      row = @game_board.pop 
      outstring += (row.to_s + "\n")  
    end
    outstring += "GUESSES LEFT: #{@guesses_left}"

    return outstring
  end
end