class ComputerPlayer
  attr_accessor :game, :color, :display

  def initialize(game, color, display)
    @game = game
    @color = color
    @display = display
    @board = @game.board
  end

  def take_turn
    start_pos = nil
    end_pos = nil
    if @board.find_move_into_check
    	puts("found move into check")
      move = @board.find_move_into_check
      start_pos, end_pos = move[0], move[1]
    elsif @board.find_best_capture
    	puts("found capture")
    	move = @board.find_best_capture
      start_pos, end_pos = move[0], move[1]
    else
    	puts("capture and check move not found")
      while start_pos.nil? && end_pos.nil?
        random_piece = @board.current_player_pieces.select { |piece| piece.valid_moves.length > 0 }.sample
        random_start = random_piece.pos
        random_end = random_piece.valid_moves.select { |end_pos| !@board.move_into_check?(random_start, end_pos) }.sample
        puts("start: " + random_start.to_s + "   end: " + random_end.to_s)
        if (!random_start.nil? && !random_end.nil?)
          start_pos = random_start
          end_pos = random_end
	      end
      end
    end
    puts("about to place... " + start_pos.to_s + ", " + end_pos.to_s)
    @board.place_piece(start_pos, end_pos)
    @board.render
  end

end
