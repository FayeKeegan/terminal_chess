require_relative 'sliding_piece'


class Rook < SlidingPiece
  DIFFS = [[1,0],
          [0,1],
          [-1,0],
          [0,-1]]
  def initialize(color, pos, moved, board)
    super
  end

  def to_s
    color == :black  ? " \u{2656} " : " \u{265C} "
  end

end
