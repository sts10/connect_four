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

  def check_for_winner
    # Alright, let's do something simple first
    # Let's just check for 4 in a row horizontally
    #
    @board.each do |row|
      if row[slot_number] == 0
        row[slot_number] = player_number
        break
      end
    end
  end
end

