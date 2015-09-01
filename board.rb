require_relative 'display'
require_relative 'empty_square'
require_relative 'pawn'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'bishop'
require_relative 'rook'
require 'colorize'
require 'byebug'


class Board

  attr_accessor :selected_piece, :game, :current_player
  attr_reader :grid

  def initialize(game)
    size = 8
    @grid = Array.new(size) { Array.new(size) { EmptySquare.new } }
    @selected_piece = nil
    @game = game
    @current_player = nil
  end

  def display
    @game.display
  end

  def setup_board
    setup_pieces
  end

  def on_board?(pos)
    pos.flatten.all? { |coord| coord.between?(0, 7) }
  end

  def off_board?(pos)
    !on_board?(pos)
  end

  def [](row,col)
    @grid[row][col]
  end

  def []=(row, col, piece)
    @grid[row][col] = piece
  end

  def dup
    duped_board = Board.new(@game)
    duped_board.current_player = @game.current_player
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, square_idx|
        duped_board[row_idx,square_idx] = square.dup(duped_board) unless square.empty?
      end
    end
    duped_board
  end

  def place_piece(start_pos, end_pos)
    selected_piece = self[*start_pos]
    self[*end_pos] = selected_piece
    selected_piece.move_to(end_pos)
    clear_square(start_pos)
  end

  def clear_square(start_pos)
    self[*start_pos] = EmptySquare.new
  end

  def occupied?(pos)
    self[*pos].piece?
  end

  def in_check?
    opponents_moves.include?(my_king)
  end

  def my_king
    king = grid.flatten.select do |square|
      square.king? && square.color == current_player
    end
    # debugger
    king.first.pos
  end

  def opponents_pieces
    grid.flatten.select do |square|
      square.piece? && square.color == other_color
    end
  end

  def opponents_moves
    moves = []
    opponents_pieces.each do |piece|
      moves += piece.valid_moves
    end
    moves
  end

  def other_color
    current_player == :white ? :black : :white
  end

  def valid_selection?
    selected_piece.piece? && selected_piece.color == current_player
  end

  def valid_end_pos?(end_pos)
    selected_piece.valid_moves.include?(end_pos)
  end

  def colorize_pos(i,j)
    (i + j).even? ? :white : :gray
  end

  def render
    system "clear"
    puts "MOVE CURSOR:      W ↑  |  A ←  |  S →  |  D  ↓  |"
    puts "SELECT PIECE:     enter"
    puts "Light blue squares indicate valid moves"
    puts "It is #{game.current_player.to_s}'s turn."
    puts "    A  B  C  D  E  F  G  H "
    self.grid.each_with_index do |row, row_idx|
      print_row = " #{row_idx + 1} "
      row.each_with_index do |square, square_idx|
        square_color = colorize_pos(row_idx, square_idx)
        if highlight_valid_moves.include?([row_idx,square_idx])
          square_color = :light_blue
        end
        if [row_idx, square_idx] == display.cursor_position
          square_color = :yellow
        end
        print_square = square.to_s.colorize(background: square_color)
        print_row << print_square
      end
      puts print_row
    end
    puts "in check: " + in_check?.to_s
    nil
  end

  def highlight_valid_moves
    selected_piece.nil? ? [] : self.selected_piece.valid_moves
  end

  def opponent_in_check?(start_pos, end_pos)
    duped_board = dup
    duped_board.place_piece(start_pos, end_pos)
    duped_board.current_player = other_color
    if duped_board.in_check?
      puts "OTHER PLAYER IN CHECK"
      return true
    else
      return false
    end
  end

  def find_move_into_check
    best_start, best_end, check_possible = nil, nil, false
    current_player_pieces.each do |piece|
      start_pos = piece.pos
      piece.valid_moves.each do |end_pos|
        if opponent_in_check?(start_pos, end_pos) && !move_into_check?(start_pos, end_pos)
          check_possible = true
          best_start = start_pos
          best_end = end_pos
        end
      end
    end
    if check_possible
      return [best_start, best_end]
    else
      nil
    end
  end

  def score_capture(end_pos)
    score = nil
    end_square = self[*end_pos]
    if opponents_pieces.include?(end_square)
      score = end_square.points
    end
    score
  end

  def find_best_capture
    best_start = nil
    best_end = nil
    capture_possible = false
    max_score = 0
    current_player_pieces.each do |piece|
      start_pos = piece.pos
      piece.valid_moves.each do |end_pos|
        duped_board = dup
        score = duped_board.score_capture(end_pos)
        if (score && score > max_score) && (!move_into_check?(start_pos, end_pos))
          capture_possible = true
          best_start = start_pos
          best_end = end_pos
        end
      end
    end
    if capture_possible
      [best_start,best_end]
    else
      nil
    end
  end

  def move_into_check?(start_pos, end_pos)
    duped_board = dup
    duped_board.place_piece(start_pos,end_pos)
    if duped_board.in_check?
      return true
    else
      return false
    end
  end

  def current_player_pieces
    grid.flatten.select do |square|
      square.piece? && square.color == current_player
    end
  end

  def check_mate?
    return false unless in_check?
    current_player_pieces.each do |piece|
      start_pos = piece.pos
      piece.valid_moves.each do |end_pos|
        duped_board = dup
        duped_board.place_piece(start_pos, end_pos)
        return false unless duped_board.in_check?
      end
    end
    true
  end

  private


  def setup_pieces
    setup_pawns
    setup_kings
    setup_queens
    setup_rooks
    setup_knights
    setup_bishops
  end

  def setup_pawns
    (0..7).each do |i|
      self[6, i] = Pawn.new(:white, [6,i], false, self)
      self[1, i] = Pawn.new(:black, [1,i], false, self)
    end
  end

  def setup_kings
    self[0,4] = King.new(:black, [0,4], false, self)
    self[7,4] = King.new(:white, [7,4], false, self)
  end

  def setup_queens
    self[0,3] = Queen.new(:black, [0,3], false, self)
    self[7,3] = Queen.new(:white, [7,3], false, self)
  end

  def setup_rooks
    [0,7].each do |j|
      self[0,j] = Rook.new(:black, [0,j], false, self)
      self[7,j] = Rook.new(:white, [7,j], false, self)
    end
  end

  def setup_knights
    [1,6].each do |j|
      self[0,j] = Knight.new(:black, [0,j], false, self)
      self[7,j] = Knight.new(:white, [7,j], false, self)
    end
  end

  def setup_bishops
    [2,5].each do |j|
      self[0,j] = Bishop.new(:black, [0,j], false, self)
      self[7,j] = Bishop.new(:white, [7,j], false, self)
    end
  end

end

class InvalidSelectionError < StandardError
end

class InCheckError < StandardError
end
