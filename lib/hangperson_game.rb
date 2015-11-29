class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses =''
    @wrong_guesses =''
    @word_remain = word + ''  # guess a bug of ruby
    @word_with_guesses ='-' * word.length
    @check_win_or_lose = :play
    @max_guess = 7
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose

  def guess(c) 
      raise ArgumentError, "input is nil or empty" if c == nil || c == ''
      raise ArgumentError, "input is not a a-zA-Z char" if c[/[a-zA-Z]/] == nil
      c = c.downcase
      #repeat guess
      if @wrong_guesses.index(c) != nil || @guesses.index(c) != nil
          return false
      end
    
      #correct guess
      if (@word_remain.delete!(c) != nil)
          @guesses += c 
          #guesses_split = @guesses.split('')
          word_remain_split = @word_remain.split('')
          word_tmp = @word
          word_remain_split.each{|x| word_tmp = word_tmp.sub(x,'-')}
          @word_with_guesses = word_tmp 
          @check_win_or_lose = :win if @word_remain == ''
      else
      #wrong guess
          if @wrong_guesses.index(c) == nil
              @wrong_guesses += c
              @check_win_or_lose = :lose if @wrong_guesses.length == @max_guess
          end
      end
      return true
  end

end
