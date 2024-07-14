# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(frame_number, shots)
    @frame_number = frame_number
    @shots = shots
  end

  def score(frames)
      return frame_score if last?

      if shots[0].strike?
        frame_score + next_two_shots_score(frames)
      elsif spare?
        frame_score + next_shot_score(frames)
      else
        frame_score
      end
  end

  def last?
    @frame_number == 9
  end

  private

  def spare?
    !shots[0].strike? && @shots[0].score + @shots[1].score == 10
  end

  def frame_score
    @shots.sum(&:score)
  end

  def next_shot_score(frames)
    frames[@frame_number + 1].shots[0].score
  end

  def next_two_shots_score(frames)
    next_frame = frames[@frame_number + 1]
    if next_frame.shots[0].strike? && !next_frame.last?
      10 + frames[@frame_number + 2].shots[0].score
    else
      next_frame.shots[0..1].sum(&:score)
    end
  end
end
