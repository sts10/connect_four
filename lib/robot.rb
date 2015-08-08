class Robot
  def initialize(name, game)
    @name = name
    @game = game
    @number_to_use = 2
  end
  def choose_slot
    rand(7)
    # to be smarter about choosing a slot:
    # 1. Make a 7-long array of each's column current row number
    # 2. Add one to each of those row numbers to get possible moves
    # scan all possible moves for this_surface.check_for_consec(3) == 2
    # if none, then scan all possible moves for this_surface.check_for_consec(3) == 1 to find needed blocks
  end
end
