#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

PADDING = 8

options = { line: false, word: false, char: false }
opt = OptionParser.new
opt.on('-l') { |v| options[:line] = v }
opt.on('-w') { |v| options[:word] = v }
opt.on('-c') { |v| options[:char] = v }
opt.parse!(ARGV)

options.each_key { |key| options[key] = true } if options.values.none?

file_path = ARGV[0]

File.open(file_path, 'r') do |file|
  file_counts = { lines: 0, words: 0, bytes: file.size }
  file.each_line do |line|
    file_counts[:words] += line.split(' ').size
    file_counts[:lines] += 1
  end
  results = []
  results << file_counts[:lines] if options[:line]
  results << file_counts[:words] if options[:word]
  results << file_counts[:bytes] if options[:char]
  puts results.map { |i| i.to_s.rjust(PADDING) }.join + " #{file_path}"
end
