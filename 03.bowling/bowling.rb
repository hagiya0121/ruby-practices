#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',').map { |s| s == 'X' ? 10 : s.to_i }

frame = 0
shot_count = 0
point = 0
scores.each.with_index do |score, index|
  point += score
  next if frame == 9

  shot_count += 1

  if shot_count == 1 && score == 10
    point += scores[index + 1] + scores[index + 2]
  end

  if shot_count == 2 && scores[index] + scores[index - 1] == 10
    point += scores[index + 1]
  end

  if shot_count == 2 || score == 10
    frame += 1
    shot_count = 0
  end
end
puts point
