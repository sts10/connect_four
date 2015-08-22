require 'pry'
require 'twitter'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 


# OK, looks like the Connect Four board is 7 across by 6 high. Going to make an array of arrays to represent the board. 

my_game = Game.new
kitty = Robot.new("kitty_1878", KITTY_REST, my_game)
levin = Robot.new("schlinkbot", LEVIN_REST, my_game)

puts "OK, we're ready to play!" 
puts "Here's the board!"
my_game.present_board

while true
  choosen_slot = kitty.choose_slot
  kitty_move = my_game.move(2, chosen_slot)
  if kitty_move == false
    next # this won't work for levin's bad moves...
  end
  kitty.tweet_board(my_game)

  winner = my_game.check_for_winner
  if winner 
    puts "Kitty wins"
    break
  end
  # sleep random amount
  #
  choosen_slot = levin.choose_slot
  levin_move = my_game.move(2, chosen_slot)
  if levin_move == false
    next # this won't work for levin's bad moves...
  end
  levin.tweet_board(my_game)

  winner = my_game.check_for_winner
  if winner 
    puts "levin wins"
    break
  end

  # sleep random amount
end

