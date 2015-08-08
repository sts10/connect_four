require 'pry'
require_relative 'lib/game.rb'

puts "Welcome to Connect Four!" 


# OK, looks like the Connect Four board is 7 across by 6 high. Going to make an array of arrays to represent the board. 

test = Game.new
puts "OK, we're ready to play!" 
puts "Here's the board!"
test.present_board

total_number_of_moves = 0 
slot_choice = 0

while true
  if total_number_of_moves.even?
    player_number = 1
  else
    player_number = 2
  end
  puts "Where do you want to move Player ##{player_number}?"
  slot_choice = gets.chomp
  break if slot_choice.to_s == "q"

  test.move(player_number, slot_choice.to_i)
  result = test.present_board
  total_number_of_moves = total_number_of_moves + 1
  if result != false
    puts "Player ##{result} has won!"
    puts "Game over"
    break
  end

end

puts "Goodbye!"
