class ComputerPlayer
  attr_accessor :game, :color, :display

  def initialize(game, color, display)
    @game = game
    @color = color
    @display = display
    @board = @game.board
  end

  def take_turn
  	
  end

end
