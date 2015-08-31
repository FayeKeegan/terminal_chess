require_relative 'piece'
require 'byebug'

class Pawn < Piece

  attr_reader :valid_moves, :dir

  def initialize(color, pos, moved, board)
    super
    @dir = color == :white ? -1 : 1
  end

  def diags(forward_pos)
    row, col = forward_pos
    dir = color == :white ? -1 : 1
    diags = [[row, col + dir], [row, col - dir]]
    diags.select {|diag| board.on_board?(diag)}
  end

  def forward_one
    row, col = pos
    fwd = [row + dir, col]
    return fwd if board.on_board?(fwd)
  end

  def forward_two
    row, col = pos
    [row + dir*2, col]
  end

  def valid_moves
    valid_move_arr = []
    unless forward_one
      return []
    end
    forward_pos = forward_one
    valid_move_arr << forward_pos if board[*forward_pos].empty?
    diags(forward_pos).each do |diag|
      if  board[*diag].piece? && board[*diag].color == other_color
        valid_move_arr << diag
      end
    end
    if !moved
      if board[*forward_pos].empty? && board[*forward_two].empty?
        valid_move_arr << forward_two
      end
    end

    valid_move_arr
  end

  def to_s
    color == :white ? " \u{2659} " : " \u{265F} "
  end
end
