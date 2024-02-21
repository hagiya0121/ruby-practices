#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each.with_index(1) do |frame, frame_number|
  if frame[0] == 10 && frame_number <= 9  # strike
    if frames[frame_number][0] == 10
      point += 10 + frames[frame_number][0] + frames[frame_number + 1][0]
    else
      point += 10 + frames[frame_number].sum
    end
  elsif frame.sum == 10 && frame_number <= 9 # spare
    point += 10 + frames[frame_number][0]
  else
    point += frame.sum
  end
end
puts point
