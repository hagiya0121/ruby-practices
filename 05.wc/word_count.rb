#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = ARGV[0]

File.open(file_path, 'r') do |file|
  words = 0; lines = 0; bytes = file.size
  file.each_line do |line|
    words += line.split(" ").size
    lines += 1
  end
  puts lines, words, bytes
end
