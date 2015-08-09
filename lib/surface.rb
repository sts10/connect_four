class Surface
  attr_reader :winner
  def initialize(row_number, column_number, board)
    @row_number = row_number
    @column_number = column_number
    @board = board
    @winner = 0
  end
  def to_s
    "#{@row_number}, #{@column_number}"
  end

  def check_for_winner
    self.check_for_consec(4)
  end

  def check_for_consec(num_consec)
    num_to_check = num_consec - 1
    puts "checking the surface #{self.to_s} for #{num_consec} consecutive pieces..."
    # check horizonal
    horizontal_array_to_check = []
    7.times do |i|
      horizontal_array_to_check << @board[@row_number][@column_number+num_to_check-i] if @board[@row_number] && @board[@row_number][@column_number+num_to_check-i]
    end
    if num_consec == 4
      puts "here's the horizontal array to check: #{horizontal_array_to_check}"
    end

    vertical_array_to_check = []
    7.times do |i|
      vertical_array_to_check << @board[@row_number+num_to_check-i][@column_number] if @board[@row_number+num_to_check-i] && @board[@row_number+num_to_check-i][@column_number]
    end

    top_left_to_bottom_right_array_to_check = []
    7.times do |i|
      top_left_to_bottom_right_array_to_check << @board[@row_number+num_to_check-i][@column_number+num_to_check-i] if @board[@row_number+num_to_check-i] && @board[@row_number+num_to_check-i][@column_number+num_to_check-i]
    end

    top_right_to_bottom_left_array_to_check = []
    7.times do |i|
      top_right_to_bottom_left_array_to_check << @board[@row_number-num_to_check+i][@column_number+num_to_check-i] if @board[@row_number-num_to_check+i] && @board[@row_number-num_to_check+i][@column_number+num_to_check-i]
    end
    
    all_possible_winners_from_this_move = [] 
    all_possible_winners_from_this_move = [horizontal_array_to_check, vertical_array_to_check,top_left_to_bottom_right_array_to_check, top_right_to_bottom_left_array_to_check]

    result = check_array_of_arrays_for_winner(all_possible_winners_from_this_move, num_consec)
    #binding.pry
    return result
  end

  def check_array_of_arrays_for_winner(array, num_consec)
    result = false # set this as an assumption before we check

    array.each do |row|
      #puts "about to check #{row} for winners"

      result = self.check_single_array_for_winner(row, num_consec)
      if result != false
        #puts "about to return a winner, thanks to the check_array_of_arrays_for_winner method!"
        break
      end
    end
    return result
  end

  def check_single_array_for_winner(array, num_consec)
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
      if consec_ones == num_consec && consec_twos == num_consec
        puts "both players have #{num_consec} pieces consecutively at #{self.to_s}"
        return 3
      end

     
      if consec_ones == num_consec
        return 1
      end 
      if consec_twos == num_consec
        return 2
      end
    end
    return false # didn't find a winner in this array
  end
end
