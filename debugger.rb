
require 'pry'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'


my_game = Game.new


my_game.move(1,1)
my_game.move(1,2)
my_game.move(1,3)
my_game.present_board
winner = my_game.check_for_winner
puts "winner: #{winner}"

#this_surface = Surface.new(row, column, my_game.board)

binding.pry
