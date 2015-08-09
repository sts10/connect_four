class Game 
  attr_accessor :board, :last_row_number, :last_column_number
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
    @last_row_number = false
    @last_column_number = false
  end
  def move(player_number, slot_number)
    # first, find the first row in the column that is free
    success = false
    @board.each_with_index do |row, row_number|
      if row[slot_number] == 0
        row[slot_number] = player_number
        @last_column_number = slot_number
        @last_row_number = row_number
        success = true
        break
      end
    end
    success
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
    this_surface = Surface.new(@last_row_number, @last_column_number, @board)
    result = this_surface.check_for_winner
    return result
  end

end

