require_relative 'sliding_piece'



class Queen < SlidingPiece
  DIFFS = [[1,0],
                [0,1],
                [-1,0],
                [0,-1],
                [1,1],
                [-1,1],
                [1,-1],
                [-1,-1]]

  def initialize(color, pos, moved, board)
    @points = 9
    super
  end

  def to_s
    color == :white  ? " \u{2655} " : " \u{265B} "
  end

end
