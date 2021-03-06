require_relative 'stepping_piece'
require_relative 'piece'

class Knight < SteppingPiece
  DIFFS = [ [-2, -1],
            [-2,  1],
            [2,   1],
            [2,  -1],
            [1,   2],
            [1,  -2],
            [-1, -2],
            [-1,  2]]
  def initialize(color, pos, moved, board)
    @points = 3
    super
  end

  def to_s
    color == :white ? " \u{2658} " : " \u{265E} "
  end

end
