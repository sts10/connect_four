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
  first_tweet = ["(What! shall I be left alone-- without her?)", "Wait a minute", "I've long wanted to ask you one thing", "Here"].sample
  tweet_to_reply_to = levin.tweet("@kitty_1878 #{first_tweet}") 

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
    if my_game.board_full?
      puts "board full is true"
      break
    end
    # sleep random amount
    my_game.present_board
    puts "waiting for Levin to choose"
    sleep (rand(2..5)*60)

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

    if my_game.board_full?
      puts "board full is true"
      break
    end
    # sleep random amount
    my_game.present_board
    puts "waiting for Kitty to choose"
    sleep (rand(10..15)*60)
  end
  # Sleep between games, partially in attempt to avoid Twitter API errors
  sleep (rand(20..30)*60)
end
