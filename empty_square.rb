
class EmptySquare

  attr_reader :score
  
  def initialize
    @score = 0
  end

  def empty?
    true
  end

  def piece?
    false
  end

  def to_s
    "   "
  end

  def king?
    false
  end

end
