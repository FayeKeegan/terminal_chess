require_relative 'display'
require_relative 'empty_square'
require_relative 'pawn'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'bishop'
require_relative 'rook'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'colorize'
require 'byebug'


class Game 

	attr_accessor :current_player

	attr_reader :board, :player1, :player2, :players, :display

  def initialize
    @board = Board.new(self)
    @display = Display.new
    @current_player = :white
    @board.current_player = @current_player
    @player1 = HumanPlayer.new(self, :white, @display)
    @player2 = HumanPlayer.new(self, :black, @display)
    @players = { white: @player1, black: @player2 }
    @cursor_position = @display.cursor_position
  end

  def play
    @board.setup_board
    until @board.check_mate?
      players[@current_player].take_turn
      switch_player
    end
    puts " >>>> CHECK MATE: #{current_player} LOSES <<<< ".colorize(:red)
    @board.render
  end


  def switch_player
    self.current_player = (current_player == :white) ? :black : :white
    @board.current_player = current_player
  end

end

g = Game.new
g.play

