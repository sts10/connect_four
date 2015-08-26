
require 'pry'
require 'twitter'
require 'rumoji'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 

while true

  my_game = Game.new
  kitty = Robot.new("kitty_1878", 1, KITTY_REST, "schlinkbot", my_game)
  levin = Robot.new("schlinkbot", 2, LEVIN_REST, "kitty_1878", my_game)


  puts "OK, we're ready to play!" 
  puts "Here's the board!"
  my_game.present_board

  while true
    chosen_slot = kitty.choose_slot
    kitty_move = my_game.move(1, chosen_slot)
    while kitty_move == false
      kitty_move = my_game.move(1, chosen_slot)
    end

    winner = my_game.check_for_winner
    if winner 
      puts "Kitty wins"
      sleep 1
      break
    end

    if my_game.board_full?
      puts "board full is true"
      sleep 3
      break
    end
    # sleep random amount
    my_game.present_board
    puts "waiting for Levin to choose"

    chosen_slot = levin.choose_slot
    levin_move = my_game.move(2, chosen_slot)
    while levin_move == false
      levin_move = my_game.move(2, chosen_slot)
    end

    winner = my_game.check_for_winner
    if winner 
      puts "levin wins"
      sleep 1
      break
    end

    if my_game.board_full?
      puts "board full is true"
      sleep 3
      break
    end
    # sleep random amount
    my_game.present_board
    puts "waiting for Kitty to choose"
  end
end
