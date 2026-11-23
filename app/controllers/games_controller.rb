require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word].to_s.upcase
    @letters = params[:letters].to_s.split(",")

    # Check if the word uses available letters
    available_letters = @letters.dup

    @valid_letters = @word.chars.all? do |letter|
      available_letters.include?(letter)
    end

    # Check if the word exists in English
    @valid_word = false

    if @valid_letters && @word.length > 0
      begin
        url = "https://api.dictionaryapi.dev/api/v2/entries/en/#{@word.downcase}"
        URI.open(url)
        @valid_word = true
      rescue OpenURI::HTTPError
        @valid_word = false
      end
    end
  end
end
