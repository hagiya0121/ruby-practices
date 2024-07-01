# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    total_point = @first_shot.score + @second_shot.score + @third_shot.score
    return total_point unless @third_shot.mark.nil?
    return 'strike' if @first_shot.mark == 'X'

    total_point == 10 ? 'spare' : total_point
  end
end
