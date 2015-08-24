require 'pry'
require 'twitter'
require 'rumoji'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'
require_relative 'secrets.rb'

puts "Welcome to Connect Four!" 


my_game = Game.new
kitty = Robot.new("kitty_1878", KITTY_REST, "schlinkbot", my_game)
levin = Robot.new("schlinkbot", LEVIN_REST, "kitty_1878", my_game)


puts "OK, we're ready to play!" 
puts "Here's the board!"
my_game.present_board

tweet_to_reply_to = levin.tweet("@kitty_1878 you start") 


while true
  chosen_slot = kitty.choose_slot
  kitty_move = my_game.move(1, chosen_slot)
  while kitty_move == false
    kitty_move = my_game.move(1, chosen_slot)
  end
  kitty_tweet = kitty.tweet_board(my_game, tweet_to_reply_to.id)
  tweet_to_reply_to = kitty_tweet

  winner = my_game.check_for_winner
  if winner 
    puts "Kitty wins"
    break
  end
  # sleep random amount
  sleep 5
  chosen_slot = levin.choose_slot
  levin_move = my_game.move(2, chosen_slot)
  while levin_move == false
    levin_move = my_game.move(2, chosen_slot)
  end

  tweet_to_reply_to = levin.tweet_board(my_game, tweet_to_reply_to.id)

  winner = my_game.check_for_winner
  if winner 
    puts "levin wins"
    break
  end

  # sleep random amount
  sleep 5
end

