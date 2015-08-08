class Surface
  attr_reader :winner
  def initialize(row, y, board)
    @row = row
    @column = column
    @board = board
    @winner = 0
  end
  def check_for_horizontal
    # We're going to go through each row and check for 4 1's or 4 2's in a row. 
    number_of_ones_in_a_row = 0
    number_of_twos_in_a_row = 0

    @board[row].each do |space|
      if space == 1
        number_of_ones_in_a_row = number_of_ones_in_a_row + 1
        number_of_twos_in_a_row = 0
      else if space == 2
        number_of_twos_in_a_row = number_of_twos_in_a_row
        + 1
        number_of_ones_in_a_row = 0
      else
        number_of_twos_in_a_row = 0
        number_of_ones_in_a_row = 0
      end
    end
  end

end
