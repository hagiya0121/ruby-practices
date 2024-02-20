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

strike_count = 0
point = 0
shot_scores = scores.map { |s| s == 'X' ? 10 : s.to_i }
frames.each.with_index(1) do |frame, frame_number|
  # 現在のフレームの1投目が全体の何投目かを計算
  shot_count = frame_number * 2 - (strike_count + 1)
  if frame[0] == 10 && frame_number <= 9  # strike
    strike_count += 1
    point +=  10 + shot_scores[shot_count] + shot_scores[shot_count + 1]
  elsif frame.sum == 10 && frame_number <= 9 # spare
    point += 10 + shot_scores[shot_count + 1]
  else
    point += frame.sum
  end
end
puts point
