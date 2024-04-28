#!/usr/bin/env ruby
# frozen_string_literal: true

PADDING = 8

file_path = ARGV[0]

File.open(file_path, 'r') do |file|
  lines = 0
  words = 0
  bytes = file.size
  file.each_line do |line|
    words += line.split(' ').size
    lines += 1
  end
  puts [lines, words, bytes].map { |i| i.to_s.rjust(PADDING) }.join + " #{file_path}"
end
