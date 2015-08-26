require_relative 'stepping_piece'
require_relative 'piece'


class King < SteppingPiece
  DIFFS = [[-1,-1],
            [-1,1],
            [1,-1],
            [1,1],
            [1,0],
            [-1,0],
            [0,1],
            [0,-1]]

  def initialize(color, pos, moved, board)
    super
  end

  def king?
    true
  end

  def to_s
    color == :black ? " \u{2654} " : " \u{265A} "
  end

end
