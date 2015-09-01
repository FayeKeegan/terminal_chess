class HumanPlayer

  attr_accessor :game, :color, :display

  def initialize(game, color, display)
    @game = game
    @color = color
    @display = display
    @board = @game.board
  end

  def get_selection
    @display.unclick
    until @display.clicked?
      @display.get_movement
      @board.render
    end
    display.cursor_position
  end

  def take_turn
    begin
      @board.render
      start_pos, end_pos = get_start_and_end_pos
      raise InCheckError.new unless !@board.move_into_check?(start_pos, end_pos)
    rescue InCheckError
      puts "CANT PUT INTO CHECK"
      retry
    end
    @board.place_piece(start_pos, end_pos)
  end

  def get_start_and_end_pos
    begin
      start_pos = get_selection
      @board.selected_piece = @board[*start_pos]
      raise InvalidSelectionError.new unless @board.valid_selection?
    rescue InvalidSelectionError
      puts "Invalid start_pos"
      @board.selected_piece = nil
      retry
    end

    @board.render

    begin
      end_pos = get_selection
      raise InvalidSelectionError.new unless @board.valid_end_pos?(end_pos)
    rescue InvalidSelectionError
      puts "Invalid end position"
      retry
    end
    @board.selected_piece = nil
    [start_pos, end_pos]
  end
end
