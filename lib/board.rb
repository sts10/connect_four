class Board
  attr_accessor :board_array, :last_row_number, :last_column_number
  def initialize(tweet)
    @tweet_board = tweet
    @board_array = self.make_board_array(tweet)
    @last_row_number = false
    @last_column_number = false
  end

  def self.string_is_board?(string)
    count = 0
    string.each_char do |character|
      if character == "|"
        count = count + 1
      end
    end
    if count == 12
      return true
    else
      return false
    end
  end

  def self.make_empty_board
    white = Rumoji.decode(":white_circle:")

    empty_board = ""
    6.times do |row_number|
      empty_board = empty_board + "|" 
        7.times do |space| 
          empty_board = empty_board + white  
        end
      empty_board = empty_board + "|\n"
    end
    empty_board
  end

  def make_flat_array_from_tweet(tweet)
    white = Rumoji.decode(":white_circle:")
    red   = Rumoji.decode(":red_circle:") 
    blue  = Rumoji.decode(":large_blue_circle:") 
    flat_array = []
    tweet.text.each_char do |char|
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

  def make_board_array(tweet)
    flat_array = self.make_flat_array_from_tweet(tweet)
    flat_array.each_slice(7).to_a.reverse
  end

  def move(player_number, slot_number)
    # first, see if they tried to move off the board
    return false if slot_number > 6
    success = false
    @board_array.each_with_index do |row, row_number|
      if row[slot_number] == 0
        row[slot_number] = player_number
        @last_column_number = slot_number
        @last_row_number = row_number
        success = true
        break
      end
    end
    success
  end

  def make_copy_of_board
    new_board = [ 
      [],[],[],[],[],[]
    ]
    @board_array.each_with_index do |row, row_number|
      new_board[row_number] = row.dup
    end

    new_board
  end

  def board_as_columns
    board_as_columns = [
      [],[],[],[],[],[],[]
    ] 
    # the first column is: [@board[0][0], @board[1][0], @board[2][0], etc.]
    @board_array.each do |row|
      board_as_columns.each_with_index do |column, column_number|
        column << row[column_number]
      end
    end
    board_as_columns
  end

  def board_full?
    @board_array[-1].none? { |space| space == 0 }
  end

  def check_for_winner
    # honestly not sure if you can pass self like this?
    this_surface = Surface.new(@last_row_number, @last_column_number, self)
    result = this_surface.check_for_consec(4)
    return result
  end

  def make_elevations
    # 1. Make a 7-long array of each's column current row number
    elevations = [0,0,0,0,0,0,0]
        
    self.board_as_columns.each_with_index do |column, column_number|
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
end



