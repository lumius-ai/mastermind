require_relative '../lib/mastermind_game'

describe MastermindGame do
  describe 'Constructor Testing' do
    r = MastermindGame.new
    j = MastermindGame.new({ 'guesses' => 3, 'code' => 'abdc' })

    it 'Inits with the default constructor' do
      expect(r.guesses_left).to eql(10)
    end

    it 'Inits with custom number of guesses' do
      expect(j.guesses_left).to eql(3)
    end

    it 'Inits with custom secret code' do
      expect(j.game_code).to eql('abdc')
    end
  end

  describe 'Making Guesses testing' do
    r = MastermindGame.new({ 'guesses' => 3, 'code' => '9999' })

    it 'Stores a first guess' do
      r.make_guess('1122')
      expect(r.game_board[0].to_s).to eql('Guess: 1 1 2 2   Hint: ----')
    end

    it 'Updates the number of guesses left' do
      expect(r.guesses_left).to eql(2)
    end

    it 'Correctly stores a second guess' do
      r.make_guess('3333')
      expect(r.game_board[1].to_s).to eql('Guess: 3 3 3 3   Hint: ----')
    end
  end

  describe 'Generating Hints testing' do
    r = MastermindGame.new({ 'guesses' => 3, 'code' => '4567' })

    it 'Identifies no pins(wrong value, wrong location)' do
      expect(r.generate_hint('1111')).to eql('----')
    end

    it 'Identifies yellow pins(correct value, wrong location)' do
      expect(r.generate_hint('5111')).to eql('Y---')
    end

    it 'Identifies black pins(correct value, correct location)' do
      expect(r.generate_hint('4111')).to eql('B---')
    end
  end

  describe 'Determining win condition' do
    w = MastermindGame.new({ 'guesses' => 1, 'code' => '1111' })
    l = MastermindGame.new({ 'guesses' => 1, 'code' => '1111' })

    it 'Identifies a game in progress' do
      expect(w.is_win?).to eql(false)
    end

    it 'Identifies a won game' do
      w.make_guess('1111')
      expect(w.is_win?).to eql(true)
    end

    it 'identifies a lost game' do
      l.make_guess('2222')
      expect(l.is_win?).to eql(false)
    end
  end

  describe 'Proper to_string display' do
    r = MastermindGame.new({ 'guesses' => 4, 'code' => '5556' })
    r.make_guess('6111')
    r.make_guess('1116')
    r.make_guess('1111')

    j = MastermindGame.new({ 'guesses' => 3, 'code' => '1111' })
    j.make_guess('4444')
    j.make_guess('4414')
    j.make_guess('1111')

    it 'Hides code in ongoing game' do
      expect(r.to_s).to eql("MASTERMIND GAME\n--------------------\nCODE: ? ? ? ?\n--------------------\nGuess: 1 1 1 1   Hint: ----\nGuess: 1 1 1 6   Hint: B---\nGuess: 6 1 1 1   Hint: Y---\nGUESSES LEFT: 1")
    end

    it 'Shows code on game over' do
      expect(j.to_s).to eql("MASTERMIND GAME\n--------------------\nCODE: 1 1 1 1\n--------------------\nGuess: 1 1 1 1   Hint: BBBB\nGuess: 4 4 1 4   Hint: B---\nGuess: 4 4 4 4   Hint: ----\nGUESSES LEFT: 0")
    end
  end
end
