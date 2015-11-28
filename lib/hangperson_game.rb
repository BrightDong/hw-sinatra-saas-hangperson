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
    @word_remain = word
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  attr_accessor :word, :guesses, :wrong_guesses

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
      else
      #wrong guess
          if @wrong_guesses.index(c) == nil
              @wrong_guesses += c
          end
      end
      return true
  end

end
