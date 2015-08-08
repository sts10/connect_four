class Game 
  attr_accessor :board, :last_move_x, :last_move_y
  def initialize
    # @board is going to be upside down, as if playing on the ceiling and the pieces are lighter than air...
    @board = [ 
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
    ]
    @last_move_x = false
    @last_move_y = false
  end
  def move(player_number, slot_number)
    # first, find the first row in the column that is free
    @board.each_with_index do |row, row_number|
      if row[slot_number] == 0
        row[slot_number] = player_number
        @last_move_x = slot_number
        @last_move_y = row_number
        self.check_for_winner
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
    this_surface = Surface.new(@last_move_x, @last_move_y, @board)
    result = this_surface.check_for_winner
    return result
  end

end

