require_relative '../lib/game_row'

describe GameRow do
  describe "Constructor testing" do
    r = GameRow.new("aaaa")
    j = GameRow.new()
    it "Inits the guess correctly" do
      expect(r.guess).to eql(['a','a','a','a'])
    end

    it "Inits with default constructor correctly" do
      expect(j.guess).to eql(['-','-','-', '-'])
    end

    it "Inits with default hint" do
      expect(r.hint).to eql(['-','-','-', '-'])
    end
  end

  describe "guess_write testing" do
    r = GameRow.new()

    it "modifies the guess value with guess_write" do
      r.guess_write("a b c d")
      expect(r.guess).to eql(['a', 'b', 'c', 'd']) 
    end

    it "overrwites current guess value with new guess value" do
      r.guess_write("x x x x")
      expect(r.guess).to eql(['x', 'x', 'x', 'x'])
    end

    it "prevents too long guesses" do  
      expect(r.guess_write("c c c c c")).to eql(false)
    end

    it "prevents too short guesses" do
      expect(r.guess_write("aaaa")).to eql(false)
    end
  end

  describe "hint_write testing" do
    r = GameRow.new()

    it "adds hint_write into an empty hint variable" do
      r.hint_write("r r r r")
      expect(r.hint).to eq(['r', 'r', 'r', 'r'])
    end

    it "overwrites existing hint value" do
      r.hint_write("x x x x")
      expect(r.hint).to eq(['x', 'x', 'x', 'x'])
    end

    it "prevents hints too long" do
      expect(r.hint_write('x x x x x')).to eql(false)
    end

    it "prevents hints too short" do
      expect(r.hint_write('askjn')).to eql(false)
    end
  end

  describe "to_s testing" do
    r = GameRow.new()
    r.guess_write("q w e r")
    r.hint_write("y y w w")
    expect(r.to_s()).to eql("Guess: q w e r   Hint: yyww")
  end

end