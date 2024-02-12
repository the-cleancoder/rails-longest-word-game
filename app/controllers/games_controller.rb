require 'faraday'
require 'faraday/net_http'

Faraday.default_adapter = :net_http

def contains_only_specific_characters?(string, characters)
  regex = /\A[#{characters.join}]*\z/
  !!(string =~ regex)
end

class GamesController < ApplicationController

  def new
    @letters = [*'A'..'Z'].sample(10)
  end

  def score
    @params = params
    @answer = params['answer']
    letters = params['letter'].split
    if !contains_only_specific_characters?(@answer, letters)
      @result = "your word '#{@answer}' not in the Grid"
    else
      response = Faraday.get("https://wagon-dictionary.herokuapp.com/#{@answer}")
      activity = JSON.parse(response.body)
      if !activity['found']
        @result = 'Not Valid Word'
      else
        @result = 'Congrats'
      end

    end
    # if @answer.
    response = Faraday.get("https://wagon-dictionary.herokuapp.com/#{@answer}")

    # check if the params answer is a word
    p activity
  end

end
