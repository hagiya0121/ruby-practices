# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(*marks)
    @shots = marks.map { |mark| Shot.new(mark) }
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    @shots[0].score == 10
  end

  def spare?
    return false if @shots[1].nil?
    @shots[0].score + @shots[1].score == 10
  end
end
