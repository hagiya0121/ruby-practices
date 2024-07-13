# frozen_string_literal: true

class Game
  LAST_FRAME = 9

  def initialize(input_score)
    @frames = create_frames(input_score)
  end

  def score
    @frames.each_with_index.sum do |frame, index|
      next frame.score if index == LAST_FRAME

      if frame.strike?
        frame.score + next_two_shots_score(index)
      elsif frame.spare?
        frame.score + next_shot_score(index)
      else
        frame.score
      end
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

    frame_scores.map { |scores| Frame.new(*scores) }
  end

  def next_shot_score(index)
    @frames[index + 1].shots[0].score
  end

  def next_two_shots_score(index)
    next_frame = @frames[index + 1]
    if next_frame.strike? && next_frame != @frames.last
      10 + @frames[index + 2].shots[0].score
    else
      next_frame.shots[0].score + next_frame.shots[1].score
    end
  end
end
