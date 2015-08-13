class Robot
  def initialize(name, game)
    @name = name
    @game = game
    @board = game.board
    @number_to_use = 2
  end

  def make_elevations
 # 1. Make a 7-long array of each's column current row number
    elevations = [0,0,0,0,0,0,0]
        
    @game.board_as_columns.each_with_index do |column, column_number|
      column_full = true
      column.each_with_index do |space, row_number|
        if space == 0 
          elevations[column_number] = row_number
          column_full = false
          break
        end
        elevations[column_number] = 6 if column_full 
      end
    end
    puts "elevations array is #{elevations}"
    elevations
  end

  def choose_slot
    # to be smarter about choosing a slot:
    slot_choice = false

    elevations = self.make_elevations

    # 2. Add one to each of those row numbers to get possible moves
    # scan all possible moves for this_surface.check_for_consec(3) == 2
    # poss moves = [[elevations[0], 0], [elevations[1], 1], etc.]

    elevations.each_with_index do |row_number, column_number|
      this_surface = Surface.new(row_number, column_number, @board)
      urgent = this_surface.check_for_consec(4, @number_to_use)
      if urgent == 2
        slot_choice = column_number
        puts "non randomly assigned slot choice cuz I know where I can win"
        break
      elsif this_surface.check_for_consec(4, 1) == 1
        slot_choice = column_number
        puts "non randomly assigned slot choice cuz I know where I need to block the human"
        break
      end
    end



    # if none, then scan all possible moves for this_surface.check_for_consec(3) == 1 to find needed blocks
    if slot_choice
      return slot_choice
    else
      puts "just going to choose randomly"
      return rand(7)
    end
  end
end
