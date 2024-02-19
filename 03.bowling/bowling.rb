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
frames.each.with_index(1) do |frame, index|
  if frame[0] == 10 # strike
    throw_count = index * 2 - (strike_count + 1)
    strike_count += 1
  elsif frame.sum == 10 # spare
    throw_count = index * 2 - (strike_count + 1)
  else
  end
end
