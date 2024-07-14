# frozen_string_literal: true

class Game
  LAST_FRAME = 9

  def initialize(input_marks)
    @frames = create_frames(input_marks)
  end

  def score
    @frames.sum do |frame|
      frame.score(@frames)
    end
  end

  private

  def create_frames(input_marks)
    frame_shots = []
    index = 0

    converted_shots = input_marks.split(',').map { |mark| Shot.new(mark) }
    LAST_FRAME.times do
      length = converted_shots[index].score == 10 ? 1 : 2
      frame_shots << converted_shots[index, length]
      index += length
    end
    frame_shots << converted_shots[index..]

    frame_shots.each_with_index.map { |shots, i| Frame.new(i, shots) }
  end
end
