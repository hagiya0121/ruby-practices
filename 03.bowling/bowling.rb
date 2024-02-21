#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',').map { |s| s == 'X' ? 10 : s.to_i }

current_frame = 0
shot_count = 0
total_points = 0
scores.each.with_index do |score, index|
  total_points += score
  next if current_frame == 9

  shot_count += 1

  if shot_count == 1 && score == 10
    total_points += scores[index + 1] + scores[index + 2]
  end

  if shot_count == 2 && scores[index] + scores[index - 1] == 10
    total_points += scores[index + 1]
  end

  if shot_count == 2 || score == 10
    current_frame += 1
    shot_count = 0
  end
end
puts total_points
