require_relative './game_row'

class MastermindGame
  attr_accessor :game_code, :game_board, :guesses_left, :mode

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


  # Runs one game
  def run_game()
    mode = ""
    while mode == ""
      puts("Choose mode: guesser or codemaster (Type g or c)")
      mode = gets.chomp.downcase
      if mode != "g" and mode != "c"
        mode = ""
      end
    end
    @mode = mode

    case mode
    when 'g'
      puts("Player is guesser")
      while not self.is_win? and @guesses_left > 0
        puts("Make a guess(4 digit number 0000 - 9999)")
        player_guess = gets.chomp
        if(player_guess.length != 4 or not numeric?(player_guess)) 
          next
        else
          self.make_guess(player_guess)
          puts(self)
        end
      end
      if self.is_win?
        puts("You have won!")
      elsif not self.is_win? and @guesses_left == 0
        puts("You have lost :(")
      end
      return
    when 'c'
      code = ""
      prng1 = Random.new(Random.seed)
      pins = ""
      puts("Player is codemaster")
      while code == ""
        puts("Enter code: ")
        code = gets.chomp
        if code.length != 4 or not numeric?(code)
          code = ""
          next
        else
          @game_code = code
        end
      end
      # First board display
      puts(self)

      #AI random guess loop
      while not self.is_win? and @guesses_left > 0
        # sleep 1 second
        sleep(1)
        self.make_guess(("%04d" % prng1.rand(9999)).to_s)
        puts(self)
      end
      self.is_win? ? puts("Computer wins") : puts("Computer loses")
    end
      
    
  end
  # Display whole board to terminal
  def to_s
    copy_board = array_copy(@game_board)

    outstring = "MASTERMIND GAME\n--------------------\n"
    if(self.is_win? or @mode = 'c')
      outstring += "CODE: #{@game_code.chars.join(" ")}\n--------------------\n"
    else
      outstring += "CODE: #{"????".chars.join(" ")}\n--------------------\n"
    end
    for i in 0...@game_board.length
      row = copy_board.pop 
      outstring += (row.to_s + "\n")  
    end
    outstring += "GUESSES LEFT: #{@guesses_left}"

    return outstring
  end

  private
  # Boolean is the input numeric?
  def numeric?(instring)
    return instring.match?(/[[:digit:]]/)
  end

  # Copies an array
  def array_copy(in_array)
    out_array = []
    for i in 0...in_array.length
      out_array.append(in_array[i])
    end
    return out_array
  end

  # Generates the pins for hints
  def generate_pins(in_string)
    out = ""
    if in_string == ""
      return "----"
    end
    in_string.chars.each do |character|
      if character.upcase == 'B' or character.upcase == 'Y' or character == '-'
        out += character
      end
    end
    while out.length != 4
      out += '-'
    end
    return out
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
end