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
numeric_scores = scores.map { |s| s == 'X' ? 10 : s.to_i }
frames.each.with_index(1) do |frame, index|
  throw_count = index * 2 - (strike_count + 1)
  if frame[0] == 10 # strike
    strike_count += 1
    point +=  10 + numeric_scores[throw_count] + numeric_scores[throw_count + 1]
  elsif frame.sum == 10 # spare
    point += 10 + numeric_scores[throw_count + 1]
  else
    point += frame.sum
  end
end
puts point
