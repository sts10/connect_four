
require 'pry'
require_relative 'lib/game.rb'
require_relative 'lib/surface.rb'
require_relative 'lib/robot.rb'


my_game = Game.new

juliet = Robot.new("Juliet", my_game)

my_game.move(1,0)
my_game.move(1,2)
my_game.move(1,3)
my_game.present_board

chosen_slot = juliet.choose_slot
juliet_move = my_game.move(2, chosen_slot)

my_game.present_board
winner = my_game.check_for_winner
puts "winner: #{winner}"

#this_surface = Surface.new(row, column, my_game.board)


