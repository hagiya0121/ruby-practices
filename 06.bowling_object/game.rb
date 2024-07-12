# frozen_string_literal: true

class Game
  LAST_FRAME = 9

  def initialize(marks)
    @frames = create_frames(marks)
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

  def create_frames(marks)
    frames = []
    index = 0

    marks = marks.split(',')
    LAST_FRAME.times do
      if Shot.new(marks[index]).score == 10
        frames << [marks[index]]
        index += 1
      else
        frames << [marks[index], marks[index + 1]]
        index += 2
      end
    end
    frames << marks[index..]

    frames.map { |frame| Frame.new(*frame) }
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
