# frozen_string_literal: true

class Game
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
    shots_by_frame = []
    index = 0

    all_shots = input_marks.split(',').map { |mark| Shot.new(mark) }
    Frame::LAST_FRAME.times do
      length = all_shots[index].strike? ? 1 : 2
      shots_by_frame << all_shots[index, length]
      index += length
    end
    shots_by_frame << all_shots[index..]

    shots_by_frame.map.with_index { |shots, i| Frame.new(i, shots) }
  end
end
