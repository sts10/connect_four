class Robot
  def initialize(name, game)
    @name = name
    @game = game
    @number_to_use = 2
  end
  def move
    @game.move(@number_to_use, rand(7))
  end
end
