# frozen_string_literal: true

require_relative 'pt_br/jogo_da_forca'
require_relative 'us_en/hangman_game'

def choose_language
  print 'English or Portugues?: '
  gets.chomp.downcase
end

def start_game(choose_language)
  case choose_language.to_s
  when 'english'
    game = HangmanGame.new
    game.play
  when 'portugues'
    jogo = JogoDaForca.new
    jogo.jogar
  else
    puts 'English or Portugues?'
  end
end

def main
  start_game(choose_language)
end

main
