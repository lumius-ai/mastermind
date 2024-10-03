
class GameRow
  attr_accessor :guess, :hint

  def initialize(guess_string = "----")
    @guess = guess_string.chars
    @hint = "----".chars
    
  end

  def guess_write(new_guess)
    g = new_guess.chars
    if g.length != 4
      return false
    else
      @guess = g
      return true
    end

  end

  def hint_write(new_hint)
    h = new_hint.chars
    if h.length != 4
      return false
    else
      @hint = h
      return true
    end
  end

  def to_s()
    return("Guess: #{@guess.join(" ")}   Hint: #{@hint.join()}")

  end

end