class Game 
  attr_accessor :board
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
    self.check_for_winner
  end

  def check_for_winner
    # We're going to go through each row and check for 4 1's or 4 2's in a row. 
    puts "checking for a winner"
    @board.each do |row|
      result = self.check_single_array_for_winner(row)
      if result != false
        puts "about to return a winner!"
        return result 
      end
    end
    # Now we should check for vertical wins
    board_as_columns = [
      [],[],[],[],[],[],[]
    ] 
    # the first column is: [@board[0][0], @board[1][0], @board[2][0], etc.]
    @board.each_with_index do |row, row_number|
      7.times do |column_number|
        board_as_columns[column_number] << @board[row_number][column_number]
      end
    end
    board_as_columns.each do |column|
      result = self.check_single_array_for_winner(column)
      if result != false
        puts "about to return a vertical winner!"
        return result
      end
    end

    # now we have to check the diagnoal wins
    #

    # we checked every possible win so return false
    return false
  end

  def check_single_array_for_winner(array)
    consec_ones = 0
    consec_twos = 0
    array.each do |space|
      if space == 1
        consec_ones = consec_ones + 1
        consec_twos = 0
      elsif space == 2
        consec_twos = consec_twos + 1
        consec_ones = 0
      else
        consec_twos = 0
        consec_ones = 0
      end

      if consec_ones == 4
        puts "P1 wins!"
        return 1
      end 
      if consec_twos == 4
        puts "P2 wins!"
        return 2
      end
    end
    return false # didn't find a winner in this array
  end
end

