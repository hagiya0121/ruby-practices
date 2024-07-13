# frozen_string_literal: true

class Game
  LAST_FRAME = 9

  def initialize(input_score)
    @frames = create_frames(input_score)
  end

  def score
    @frames.sum do |frame|
      frame.score(@frames)
    end
  end

  private

  def create_frames(input_score)
    frame_scores = []
    index = 0

    marks = input_score.split(',')
    LAST_FRAME.times do
      length = Shot.new(marks[index]).score == 10 ? 1 : 2
      frame_scores << marks[index, length]
      index += length
    end
    frame_scores << marks[index..]

    frame_scores.each_with_index.map { |scores, i| Frame.new(*scores, frame_number: i) }
  end
end
