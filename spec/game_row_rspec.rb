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
      r.guess_write("abcd")
      expect(r.guess).to eql(['a', 'b', 'c', 'd']) 
    end

    it "overrwites current guess value with new guess value" do
      r.guess_write("xxxx")
      expect(r.guess).to eql(['x', 'x', 'x', 'x'])
    end

    it "prevents too long guesses" do  
      expect(r.guess_write("ccccc")).to eql(false)
    end

    it "prevents too short guesses" do
      expect(r.guess_write("a")).to eql(false)
    end
  end

  describe "hint_write testing" do
    r = GameRow.new()

    it "adds hint_write into an empty hint variable" do
      r.hint_write("rrrr")
      expect(r.hint).to eq(['r', 'r', 'r', 'r'])
    end

    it "overwrites existing hint value" do
      r.hint_write("xxxx")
      expect(r.hint).to eq(['x', 'x', 'x', 'x'])
    end

    it "prevents hints too long" do
      expect(r.hint_write('xxxxx')).to eql(false)
    end

    it "prevents hints too short" do
      expect(r.hint_write('a')).to eql(false)
    end
  end

  describe "to_s testing" do
    r = GameRow.new()
    r.guess_write("qwer")
    r.hint_write("yyww")
    it "Converts to string properly" do
      expect(r.to_s()).to eql("Guess: q w e r   Hint: yyww")
    end
  end

end