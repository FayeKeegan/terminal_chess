class ComputerPlayer
  attr_accessor :game, :color, :display

  def initialize(game, color, display)
    @game = game
    @color = color
    @display = display
    @board = @game.board
  end

  def take_turn
    if @board.find_move_into_check
      put_opponent_in_check
    elsif @board.find_best_capture
    	make_capture
    else
      make_random_move
    end
    @board.render
  end

  def put_opponent_in_check
  	move = @board.find_move_into_check
    @board.make_move(move)
  end

  def make_capture
  	move = @board.find_best_capture
    @board.make_move(move)
  end

  def make_random_move
  	move = find_random_move
    @board.make_move(move)
  end

  def find_random_move
  	start_pos = nil
    end_pos = nil
  	while start_pos.nil? && end_pos.nil?
      random_piece = @board.current_player_pieces.select { |piece| piece.valid_moves.length > 0 }.sample
      random_start = random_piece.pos
      random_end = random_piece.valid_moves.select { |end_pos| !@board.move_into_check?(random_start, end_pos) }.sample
      if (!random_start.nil? && !random_end.nil?)
        start_pos = random_start
        end_pos = random_end
      end
    end
    return [start_pos, end_pos]
  end

end
