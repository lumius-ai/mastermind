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
    mode = ""
    while mode == ""
      puts("Choose mode: guesser or codemaster (Type g or c)")
      mode = gets.chomp.downcase
      if mode != "g" and mode != "c"
        mode = ""
      end
    end

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
      while not self.is_win? and @guesses_left > 0
        prng1 = Random.new(Random.seed)
        num = ("%04d" % prng1.rand(9999)).to_s
        computer_guess = GameRow.new(num)

        pins = ""
        while pins == ""
          puts("Computer Guesses #{num}, code is #{@game_code}. Place B or Y pins")
          pins = gets.chomp

          if(pins.length != 4) and numeric?(pins)
            
          end
        end

      end
      puts("This part is not implemented yet!")
      return
    end


    
  end
  # Display whole board to terminal
  def to_s
    copy_board = array_copy(@game_board)

    outstring = "MASTERMIND GAME\n--------------------\n"
    if(self.is_win?)
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
  def numeric?(instring)
    return instring.match?(/[[:digit:]]/)
  end

  def array_copy(in_array)
    out_array = []
    for i in 0...in_array.length
      out_array.append(in_array[i])
    end

    return out_array
  end
end