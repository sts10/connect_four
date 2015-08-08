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
    self.check_for_winner
  end

  def check_for_winner
    # We're going to go through each row and check for 4 1's or 4 2's in a row. 
    @board.each do |row|
      result = self.check_single_array_for_winner(row)
    end

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
  end
end

