require 'byebug'
class Piece
  attr_accessor :color, :pos, :board, :moved

  def initialize(color, pos, moved=false, board)
    @color, @pos, @moved, @board = color, pos, moved, board
  end

  def dup(duped_board)
    self.class.new(color, pos, moved, duped_board)
  end

  def inspect
    {:class => self.class,
    :color => color,
    :pos => pos}
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def king?
    false
  end

  def to_s
    " X ".colorize(@color)
  end

  def move_to(pos)
    self.pos = pos
    self.moved = true
  end

  def moves
    raise "not implemented yet!"
  end

  def other_color
    color == :white ? :black : :white
  end

  def valid_moves
    moves.select do |pos|
      board.on_board?(pos) &&
      (board[*pos].empty? || board[*pos].color == other_color)
    end
  end
end
