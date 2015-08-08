require 'pry'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'

puts "Welcome to Connect Four!" 


# OK, looks like the Connect Four board is 7 across by 6 high. Going to make an array of arrays to represent the board. 

my_game = Game.new
juliet = Robot.new("Juliet", my_game)

puts "OK, we're ready to play!" 
puts "Here's the board!"
my_game.present_board

total_number_of_moves = 0 
slot_choice = 0
player_number = 1

while true
  if total_number_of_moves.even?
    puts "Where do you want to move Player ##{player_number}?"
    slot_choice = gets.chomp
    break if slot_choice.to_s == "q"
    my_game.move(player_number, slot_choice.to_i)
  else
    my_game.move(2, juliet.choose_slot)
  end

  my_game.present_board
  winner = my_game.check_for_winner

  total_number_of_moves = total_number_of_moves + 1
  if winner != false
    puts "Player ##{winner} has won!"
    puts "Game over"
    break
  end

end

puts "Goodbye!"
