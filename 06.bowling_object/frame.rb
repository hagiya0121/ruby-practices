# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(*marks, frame_number: 0)
    @shots = marks.map { |mark| Shot.new(mark) }
    @frame_number = frame_number
  end

  def score(frames)
    return frame_score if @frame_number == frames.length - 1

    if strike?
      frame_score + next_two_shots_score(frames)
    elsif spare?
      frame_score + next_shot_score(frames)
    else
      frame_score
    end
  end

  def strike?
    @shots[0].score == 10
  end

  private

  def spare?
    return false if @shots[1].nil?

    @shots[0].score + @shots[1].score == 10
  end

  def frame_score
    @shots.sum(&:score)
  end

  def next_shot_score(frames)
    frames[@frame_number + 1].shots[0].score
  end

  def next_two_shots_score(frames)
    next_frame = frames[@frame_number + 1]
    if next_frame.strike? && next_frame != frames.last
      10 + frames[@frame_number + 2].shots[0].score
    else
      next_frame.shots[0].score + next_frame.shots[1].score
    end
  end
end
