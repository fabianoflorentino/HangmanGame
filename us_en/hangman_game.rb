# frozen_string_literal: true

# The Hangman class represents a game of hangman in Ruby, which aims to
# guess a word randomly chosen by the computer. The class has
# several functions that include choosing the word, playing the game, guessing the letter,
# checking if the supposed letter is correct, checking if the game is over, and showing
# the current state of the word to be guessed. The class also contains attributes like
# the word to be guessed, the wrong letters already chosen by the player, the
# correct letters already chosen by the player, and a flag that indicates if the game is over
# or not. The game has limited attempts, and the player can choose one
# letter at a time to try to guess the word. The game uses private roles to
# draw the state of the gallows and show the current state of the word to be guessed.
class HangmanGame
  # Initialize the Hangman class with the word to be guessed, the wrong letters
  # already chosen by the player, the correct letters already chosen by the player and
  # a flag that indicates whether the game is over or not.
  def initialize
    @word = ['ruby', 'rails', 'javascript', 'python', 'java', 'c', 'c++',
             'c#', 'php', 'swift', 'kotlin', 'go', 'ruby on rails',
             'ruby on rails'].sample.downcase
    @wrong_letters = ''
    @correct_letters = []
    @end_of_game = false
  end

  # Randomly chooses a word from the list of available words.
  def choose_word
    @word = @word.sample
  end

  # Runs the game, drawing the state of the gallows and showing the current state of the gallows
  # word to be guessed, allowing the player to guess one letter at a time
  # until the game is over.
  def play
    until @end_of_game
      draw_hangman
      show_word
      letter = guess_letter
      @correct_letters << letter if correct_letter?(letter) || @wrong_letters += letter
      check_game_end
    end
  end

  # Prompts the player to type a letter and returns the letter in lower case.
  def guess_letter
    puts 'Type a letter:'
    gets.chomp.downcase
  end

  # Check whether the guessed letter is correct or not, comparing with the word a
  # be guessed.
  def correct_letter?(letter)
    @word.include?(letter)
  end

  # Checks if the game is over if the player guessed all the letters of the word
  # or if the player has missed more than six times.
  def check_game_end
    # Check if the player won
    if (remaining_letters - @correct_letters).empty?
      puts 'Congratulations! You guessed the word!'
      show_word
      @end_of_game = true
    elsif @wrong_letters.length >= 6
      draw_hangman
      puts "You missed it! The word was '#{@word}'."
      @end_of_game = true
    end
  end

  private

  # Draw the current gallows state based on the number of wrong letters chosen
  # by the player.
  def draw_hangman
    puts '+---+'
    puts '|   |'
    draw_head
    draw_body
    draw_arms
    draw_legs
    puts '|'
    puts '====='
  end

  # Draws the head on the gallows if the player has already missed at least one letter.
  def draw_head
    puts @wrong_letters.length >= 1 ? '|   O' : '|'
  end

  # Draws the body on the gallows if the player has already missed two letters.
  def draw_body
    puts '|   |' if @wrong_letters.length == 2
  end

  # Draw the arms on the gallows if the player has already missed three or more letters.
  def draw_arms
    arms = puts '|  /|' if @wrong_letters.length == 3
    arms = puts '|  /|\\' if @wrong_letters.length >= 4
    arms
  end

  # Draws the legs on the gallows if the player has already missed five or more letters.
  def draw_legs
    legs = puts '|  /' if @wrong_letters.length == 5
    legs = puts '|  / \\' if @wrong_letters.length >= 6
    legs
  end

  # Shows the current state of the word to be guessed, replacing the letters
  # not guessed by "_".
  def show_word
    display_word = ''
    @word.split('').each do |letter|
      display_word += if @correct_letters.include?(letter)
                        "#{letter} "
                      else
                        '_'
                      end
    end
    puts display_word
  end

  # Returns the letters of the word that have not yet been guessed.
  def remaining_letters
    @word.split('') - @correct_letters
  end
end
