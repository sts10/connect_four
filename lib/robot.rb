
class Robot
  attr_accessor :name
  def initialize(name, number_to_use, rest_client, opponent)
    @name = name
    @rest_client = rest_client
    @opponent = opponent
    @number_to_use = number_to_use
    if @number_to_use == 1
      @opponent_number = 2
    else 
      @opponent_number = 1
    end
  end

  def listen_for_board
    TWITTER_STREAMING.user do |object|
      case object
      when Twitter::Tweet
        puts "It's a tweet from #{object.user.screen_name} that says: " + object.text

        if object.text.include?("@#{@name}") && self.is_string_board?(object.text)
          puts "found a board tweet at me!"
          return object
        end
      when Twitter::Streaming::Event
        puts "It's a Streaming::Event! Not really sure what this means!"
      when Twitter::Streaming::StallWarning
        puts "Falling behind!"
      end
    end
  end

  def is_string_board?(string)
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

  def choose_slot(board)
    # to be smarter about choosing a slot:
    slot_choice = false

    elevations = board.make_elevations

    # 2. Add one to each of those row numbers to get possible moves
    # scan all possible moves for this_surface.check_for_consec(3) == 2
    # poss moves = [[elevations[0], 0], [elevations[1], 1], etc.]

    elevations.each_with_index do |row_number, column_number|
      if row_number == 6 # is this supposed to be row_unmber == 6 ? (used to be `if column_number == 6`
        next
      end
      this_surface = Surface.new(row_number, column_number, board)
      if this_surface.check_for_consec(4, @number_to_use) == @number_to_use
        slot_choice = column_number
        puts "non randomly assigned slot choice cuz I know where I can win"
        break
      end
    end

# If not spaces to win, look for spaces to block the opponent from winning
    if slot_choice == false
      elevations.each_with_index do |row_number, column_number|
        if row_number == 6 # is this supposed to be row_unmber == 6 ? (used to be `if column_number == 6`
          next
        end
        this_surface = Surface.new(row_number, column_number, board)
        if this_surface.check_for_consec(4, @opponent_number) == @opponent_number
          slot_choice = column_number
          puts "non randomly assigned slot choice cuz I know where I need to block the human"
          break
        end
      end
    end

    if slot_choice
      return slot_choice
    else
      if elevations == [6, 6, 6, 6, 6, 6, 6]
        puts "board is full!"
      end
      puts "just going to choose randomly"
      valid_random_move = false
      while valid_random_move == false
        random_move = rand(7)
        # if elevations something != 6
        if elevations[random_move] != 6
          valid_random_move = true
        end
      end

      return random_move
    end
  end

  def tweet(text_to_tweet, id_to_reply_to=0)
    if id_to_reply_to == 0
      @rest_client.update(text_to_tweet)
    else
      @rest_client.update(text_to_tweet, in_reply_to_status_id: id_to_reply_to)
    end
  end

  def tweet_board(board, id_to_reply_to)
    text_to_tweet = "@#{@opponent}\n\n"
    i = 5
    6.times do 
      text_to_tweet = text_to_tweet + "|"
      board.board_array[i].each do |space|
        if space == 0
          text_to_tweet = text_to_tweet + Rumoji.decode(":white_circle:")
        elsif space == 1
          text_to_tweet = text_to_tweet + Rumoji.decode(":red_circle:")
        else
          text_to_tweet = text_to_tweet + Rumoji.decode(":large_blue_circle:")
        end
      end
      text_to_tweet = text_to_tweet + "|\n"
      i = i - 1
    end
    self.tweet(text_to_tweet, id_to_reply_to)
  end

end
