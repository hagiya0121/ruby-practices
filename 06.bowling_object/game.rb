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
    frame_marks = []
    index = 0

    marks = input_marks.split(',')
    LAST_FRAME.times do
      length = Shot.new(marks[index]).score == 10 ? 1 : 2
      frame_marks << marks[index, length]
      index += length
    end
    frame_marks << marks[index..]

    frame_marks.each_with_index.map { |marks, i| Frame.new(*marks, frame_number: i) }
  end
end
