require_relative 'piece'

class SteppingPiece < Piece

  def initialize(color, pos, moved, board)
    super
  end

  def moves
    x, y = pos
    moves = []
    self.class::DIFFS.each do |dx, dy|
      moves << [x + dx, y + dy]
    end
    moves
  end

end
