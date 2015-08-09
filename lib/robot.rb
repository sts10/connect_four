class Robot
  def initialize(name, game)
    @name = name
    @game = game
    @board = game.board
    @number_to_use = 2
  end
  def choose_slot
    # to be smarter about choosing a slot:
    # 1. Make a 7-long array of each's column current row number
    elevations = [0,0,0,0,0,0,0]
    board_as_columns = [
      [],[],[],[],[],[],[]
    ] 
    # the first column is: [@board[0][0], @board[1][0], @board[2][0], etc.]
    @board.each do |row|
      board_as_columns.each_with_index do |column, column_number|
        column << row[column_number]
      end
    end
    
    board_as_columns.each_with_index do |column, column_number|
      column.each_with_index do |space, row_number|
        if space == 0 
          elevations[column_number] = row_number
          break
        end
      end
    end
    puts "elevations array is #{elevations}"
    # 2. Add one to each of those row numbers to get possible moves
    # scan all possible moves for this_surface.check_for_consec(3) == 2
    # if none, then scan all possible moves for this_surface.check_for_consec(3) == 1 to find needed blocks
    rand(7)
  end
end
