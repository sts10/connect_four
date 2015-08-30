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


while true

  puts "about to start listening for a board"
  tweeted_board = levin.listen_for_board
  puts "out of the listen for board method"

  board = Board.new(tweeted_board)
  #Check for winners, check for full board
  levin_choice = levin.choose_slot(board)
  board.move(2, levin_choice)
  #sleep rand?
  levin.tweet_board(board, tweeted_board.id)
  #check for winner or full board?
  winner = board.check_for_winner
  if winner
    puts "Levin wins"
    break
  elsif board.board_full?
    puts "board is full"
    break
  end

end
