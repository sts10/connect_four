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

  def check_for_consec(num_consec, mark=0)
    board_tc = [ 
      [],[],[],[],[],[]
    ]
    # should be something like board_tc = Board.new(board).make_copy_of_board
    @board.board_array.each_with_index do |row, row_number|
      board_tc[row_number] = row.dup
    end

    if mark != 0 # means we're checking a mark
      begin
        board_tc[@row_number][@column_number] = mark
      rescue
        binding.pry
      end
      puts "@board is #{@board}"
      puts "board_tc, after putting in the mark, is #{board_tc}"
    end

    num_to_check = num_consec - 1
    puts "checking the surface #{self.to_s} for #{num_consec} consecutive pieces..."
    # check horizonal
    horizontal_array_to_check = []
    7.times do |i|
      if board_tc[@row_number] && board_tc[@row_number][@column_number+num_to_check-i] && @column_number+num_to_check-i >= 0
        horizontal_array_to_check << board_tc[@row_number][@column_number+num_to_check-i] 
      end
    end
    puts "here's the horizontal array to check: #{horizontal_array_to_check}"

    vertical_array_to_check = []
    7.times do |i|
      if board_tc[@row_number+num_to_check-i] && board_tc[@row_number+num_to_check-i][@column_number] && @row_number+num_to_check-i >= 0
        #puts "about to add #{@row_number+num_to_check-i} , #{@column_number} to vertical array to check, which is #{vertical_array_to_check}"
        vertical_array_to_check << board_tc[@row_number+num_to_check-i][@column_number] 
      end
    end

    top_left_to_bottom_right_array_to_check = []
    7.times do |i|
      if board_tc[@row_number+num_to_check-i] && board_tc[@row_number+num_to_check-i][@column_number+num_to_check-i] && @column_number+num_to_check-i >= 0 && @row_number+num_to_check-i >= 0
        top_left_to_bottom_right_array_to_check << board_tc[@row_number+num_to_check-i][@column_number+num_to_check-i] 
      end
    end

    top_right_to_bottom_left_array_to_check = []
    7.times do |i|
      if board_tc[@row_number-num_to_check+i] && board_tc[@row_number-num_to_check+i][@column_number+num_to_check-i] && @column_number+num_to_check-i >= 0 && @row_number-num_to_check+i >= 0
        top_right_to_bottom_left_array_to_check << board_tc[@row_number-num_to_check+i][@column_number+num_to_check-i] 
      end
    end
    
    all_possible_winners_from_this_move = [] 
    all_possible_winners_from_this_move = [horizontal_array_to_check, vertical_array_to_check,top_left_to_bottom_right_array_to_check, top_right_to_bottom_left_array_to_check]

    puts "all possible: #{all_possible_winners_from_this_move}"

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
