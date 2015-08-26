require 'IO/console'
require 'byebug'

MOVEMENTS = { 'a' => [0,-1],
              's' => [1,0],
              'd' => [0,1],
              'w' => [-1,0],
              '\r' => [0,0]
              }

class Display

  attr_accessor :cursor_position, :clicked

  def initialize(size=8)
      @board_size = size
      @cursor_position = [0,0]
      @clicked = false
  end

  def clicked?
    @clicked
  end

  def click
    @click = true
  end

  def unclick
    @clicked = false
  end

  def get_movement
    begin
      input = $stdin.getch
      if input == "\r"
        @clicked = true
        return
      elsif input == 'q'
        raise "QUIT"
      elsif MOVEMENTS[input].nil?
        raise ArgumentError.new
      else
        movement = MOVEMENTS[input]
        new_position(movement)
      end
    rescue ArgumentError
      retry
    end
    nil
  end

  def new_position(movement)
    new_position = []
    new_position[0] = @cursor_position[0] + movement[0]
    new_position[1] = @cursor_position[1] + movement[1]
    raise ArgumentError.new unless movement_is_valid?(new_position)
    @cursor_position = new_position
    nil
  end

  def movement_is_valid?(new_position)
    new_position.all? {|coord| coord.between?(0,7)}
  end

end
