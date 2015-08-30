class Board
  attr_accessor :board_array
  def initialize(tweet)
    @tweet_board = tweet
    @board_array = [ 
      [],[],[],[],[],[]
    ]
  end
  def make_flat_array_from_tweet
    white = Rumoji.decode(":white_circle:")
    red =Rumoji.decode(":red_circle:") 
    blue =Rumoji.decode(":large_blue_circle:") 
    flat_array = []
    @tweet_board.text.each_char do |char|
      if char == white
        flat_array << 0
      elsif char == red
        flat_array << 1
      elsif char == blue
        flat_array << 2
      end
    end
    return flat_array
  end
  def make_board_array
    flat_array = self.make_flat_array_from_tweet
    @board_array = flat_array.each_slice(7).to_a
    # ah shit need to flip this vertically
  end
end



