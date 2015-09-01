require_relative 'sliding_piece'


class Rook < SlidingPiece
  DIFFS = [[1,0],
          [0,1],
          [-1,0],
          [0,-1]]
  def initialize(color, pos, moved, board)
    @points = 5
    super
  end

  def to_s
    color == :white  ? " \u{2656} " : " \u{265C} "
  end

end
