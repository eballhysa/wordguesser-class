class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    letter = letter.to_s.downcase
    raise ArgumentError, "Invalid input" unless letter =~ /^[a-z]$/
    if word.include? letter
      if guesses.include? letter
        false
      else
        guesses << letter
        true
      end
    else
      #wrong_guesses << letter unless wrong_guesses.include? letter
      if wrong_guesses.include? letter
        false
      else
        wrong_guesses << letter
        true
      end
    end
  end

  def word_with_guesses
    word.chars.map{|letter| guesses.include?(letter) ? letter : "-"}.join
  end

  def check_win_or_lose
    return :win if game_won?
    return :lose if game_lost?
    :play
  end

  def game_won?
    word.chars.all?{|letter| guesses.include? letter} and wrong_guesses.length < 7 
  end

  def game_lost?
    word.chars.any?{|letter| not guesses.include? letter} and wrong_guesses.length >= 7 
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
