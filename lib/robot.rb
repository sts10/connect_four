

class Robot
  def initialize(name, number_to_use, rest_client, opponent, game)
    @name = name
    @rest_client = rest_client
    @opponent = opponent
    @game = game
    @board = game.board
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

        if object.text.include?("@#{@name}") && object.text.downcase.include?("play?")
          text_to_tweet = "@#{object.user.screen_name} hi! Yes, working on that..."

          @rest_client.update(text_to_tweet, in_reply_to_status_id: object.id)
        end
      when Twitter::Streaming::Event
        puts "It's a Streaming::Event! Not really sure what this means!"
      when Twitter::Streaming::StallWarning
        puts "Falling behind!"
      end
    end
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
      if column_number == 6 
        next
      end
      this_surface = Surface.new(row_number, column_number, @board)
      if this_surface.check_for_consec(4, @number_to_use) == @number_to_use
        slot_choice = column_number
        puts "non randomly assigned slot choice cuz I know where I can win"
        break
      elsif this_surface.check_for_consec(4, @opponent_number) == @opponent_number
        slot_choice = column_number
        puts "non randomly assigned slot choice cuz I know where I need to block the human"
        break
      end
    end

    if slot_choice
      return slot_choice
    else
      puts "just going to choose randomly"
      return rand(7)
    end
  end

  def tweet(text_to_tweet, id_to_reply_to=0)
    if id_to_reply_to == 0
      @rest_client.update(text_to_tweet)
    else
      @rest_client.update(text_to_tweet, in_reply_to_status_id: id_to_reply_to)
    end
  end

  def tweet_board(game, id_to_reply_to)
    text_to_tweet = "@#{@opponent}\n\n"
    i = 5
    6.times do 
      text_to_tweet = text_to_tweet + "|"
      @board[i].each do |space|
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
