require 'pry'
require 'twitter'
require 'rumoji'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 

#puts "enter name of this robot"
#robot_name = gets.chomp
#puts "enter number to use"
#robot_number = gets.chomp

kitty = Robot.new("kitty_1878", 1, KITTY_REST, "sts10")


while true

  puts "about to start listening for a board"
  tweeted_board = kitty.listen_for_board
  puts "out of the listen for board method"

  board = Board.new(tweeted_board)
  #Check for winners, check for full board
  kitty_choice = kitty.choose_slot(board)
  board.move(1, kitty_choice)
  #sleep rand?
  #check for winner or full board?
  kitty.tweet_board(board, tweeted_board.id)


  #winner = my_game.check_for_winner
  #if winner 
    #puts "Kitty wins"
    #break
  #end
  #if my_game.board_full?
    #puts "board full is true"
    #break
  #end
end
