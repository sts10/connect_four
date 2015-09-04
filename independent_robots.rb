require 'pry'
require 'twitter'
require 'rumoji'
require_relative 'lib/game.rb'
require_relative 'lib/board.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 

puts "enter Twitter handle of this robot"
robot_name = gets.chomp
if robot_name[0] == "@"
  robot_name = robot_name[1..-1]
end

if robot_name == "schlinkbot"
  rest_object = LEVIN_REST
  stream_object = LEVIN_STREAMING
  robot_number = 2
elsif robot_name == "kitty_1878"
  rest_object = KITTY_REST
  stream_object = KITTY_STREAMING
  robot_number = 1
end

#levin = Robot.new("schlinkbot", 2, LEVIN_REST)
this_robot = Robot.new(robot_name, robot_number, rest_object)

puts "Cool, this bot's name is #{this_robot.name} and I set it to use #{robot_number}"

puts "should this bot go first? If yes, enter opponent handle, if no enter n"
first = gets.chomp
if first.downcase != "n"
  puts "cool, about to tweet at @#{first}"
  greeting = ["Want to play?", "sup", "oh hey", "You go first", "you first", "I got this"].sample
  this_robot.tweet("@#{first} #{greeting}\n\n#{Board.make_empty_board}")
end

stream_object.user do |object|
  case object
  when Twitter::Tweet
    puts "It's a tweet from #{object.user.screen_name} that says: " + object.text
    #binding.pry

    if object.text.include?("@#{this_robot.name}") && Board.string_is_board?(object.text)
      puts "found a board tweet at me! The board is contained in #{object.id}"
      this_robot.opponent = object.user.screen_name
      board = Board.new(object)
      choice = this_robot.choose_slot(board)

      board.move(robot_number, choice)

      sleep rand(5..12)
      this_robot.tweet_board(board, object.id)

      #check for winner or full board?
      winner = board.check_for_winner
      if winner
        puts "#{this_robot.name} wins"
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


# Pretty sure this is never used. I made this method a class method in the Board model
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

