class Surface
  attr_reader :winner
  def initialize(x, y, board)
    @x = x
    @y = y
    @board = board
    @winner = 0
  end
  def check_for_winner
    # check horizonal
    horizontal_array_to_check = []
    7.times do |i|
      horizontal_array_to_check << @board[@x+3-i][@y] if @board[@x+3] && @board[@x+3][@y]
    end

    vertical_array_to_check = []
    7.times do |i|
      vertical_array_to_check << @board[@x][@y+3-i]
    end

    top_left_to_bottom_right_array_to_check = []
    7.times do |i|
      top_left_to_bottom_right_array_to_check << @board[@x+3-i][@y+3-i]
    end

    top_right_to_bottom_left_array_to_check = []
    7.times do |i|
      top_right_to_bottom_left_array_to_check << @board[@x-3+1][@y+3-i]
    end
    
    all_possible_winners_from_this_move = [] 
    all_possible_winners_from_this_move << [horizontal_array_to_check, vertical_array_to_check,top_left_to_bottom_right_array_to_check, top_right_to_bottom_left_array_to_check]

    result = check_array_of_arrays_for_winner(all_possible_winners_from_this_move)
    return result
  end

  def check_array_of_arrays_for_winner(array)
    result = false # set this as an assumption before we check

    array.each do |row|
      result = self.check_single_array_for_winner(row)
      if result != false
        puts "about to return a winner, thanks to the check_array_of_arrays_for_winner method!"
        break
      end
    end
    return result
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
