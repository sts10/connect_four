require 'pry'
require 'twitter'
require 'rumoji'
require_relative 'lib/game.rb'
require_relative 'lib/board.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 

#puts "enter name of this robot"
#robot_name = gets.chomp
#puts "enter number to use"
#robot_number = gets.chomp

levin = Robot.new("schlinkbot", 2, LEVIN_REST, "sts10")


TWITTER_STREAMING.user do |object|
  case object
  when Twitter::Tweet
    puts "It's a tweet from #{object.user.screen_name} that says: " + object.text
    #binding.pry

    if object.text.include?("@#{levin.name}") && Board.string_is_board?(object.text)
      puts "found a board tweet at me! The board is contained in #{object.id}"
      board = Board.new(object)
      levin_choice = levin.choose_slot(board)
      board.move(2, levin_choice)

      sleep rand(5..12)
      levin.tweet_board(board, object.id)

      #check for winner or full board?
      winner = board.check_for_winner
      if winner
        puts "Levin wins"
      elsif board.board_full?
        puts "board is full"
      end
    end
  when Twitter::Streaming::Event
    puts "It's a Streaming::Event! Not really sure what this means!"
  when Twitter::Streaming::StallWarning
    puts "Falling behind!"
  end
end


def is_string_board?(string)
  count = 0
  string.each_char do |character|
    if character == "|"
      count = count + 1
    end
  end
  if count == 12
    return true
  else
    return false
  end
end
