class GameRow
  attr_accessor :guess, :hint

  def initialize(guess_string = '----')
    @guess = guess_string.chars
    @hint = '----'.chars
  end

  def guess_write(new_guess)
    g = new_guess.chars
    return false if g.length != 4

    @guess = g
    true
  end

  def hint_write(new_hint)
    h = new_hint.chars
    return false if h.length != 4

    @hint = h
    true
  end

  def to_s
    "Guess: #{@guess.join(' ')}   Hint: #{@hint.join}"
  end
end
