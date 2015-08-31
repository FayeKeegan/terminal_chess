require_relative 'sliding_piece'

#this is a test

class Bishop < SlidingPiece
  DIFFS = [[1,1],
          [-1,1],
          [1,-1],
          [-1,-1]]

  def initialize(color, pos, moved, board)
    super
  end

  def to_s
    color == :white ? " \u{2657} " : " \u{265D} "
  end

end
