require_relative 'sliding_piece'

class Bishop < SlidingPiece
  DIFFS = [[1,1],
                [-1,1],
                [1,-1],
                [-1,-1]]

  def initialize(color, pos, moved, board)
    super
  end

  def to_s
    color == :black ? " \u{2657} " : " \u{265D} "
  end

end
