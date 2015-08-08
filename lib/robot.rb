class Robot
  def initialize(name, game)
    @name = name
    @game = game
    @number_to_use = 2
  end
  def choose_slot
    rand(7)
  end
end
