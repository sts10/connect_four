require 'pry'
puts "Welcome to Connect Four!" 


# OK, looks like the Connect Four board is 7 across by 6 high. Going to make an array of arrays to represent the board. 

class Game 
  attr_accessor :board
  def initialize
    # @board is going to be upside down, as if playing on the ceiling and the pieces are lighter than air...
    @board = [ 
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
    ]
  end
  def move(player_number, slot_number)
    # first, find the first row in the column that is free
    @board.each do |row|
      if row[slot_number] == 0
        row[slot_number] = player_number
        break
      end
    end
    self.present_board
  end

  def present_board
    puts "presenting board"
    i = 5
    6.times do
      @board[i].each do |space|
        print space.to_s + " "
      end
      print "\n"
      i = i - 1
    end
  end
end

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

  total_number_of_moves = total_number_of_moves + 1
end

puts "Goodbye!"
