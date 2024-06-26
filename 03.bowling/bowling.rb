#!/usr/bin/env ruby

# frozen_string_literal: true

input_score = ARGV[0]
scores = input_score.split(',').map { |s| s == 'X' ? 10 : s.to_i }

current_frame = 0
shot_count = 0
total_point = 0
scores.each.with_index do |score, index|
  total_point += score
  next if current_frame == 9

  shot_count += 1

  total_point += scores[index + 1] + scores[index + 2] if shot_count == 1 && score == 10

  total_point += scores[index + 1] if shot_count == 2 && score + scores[index - 1] == 10

  if shot_count == 2 || score == 10
    current_frame += 1
    shot_count = 0
  end
end
puts total_point
