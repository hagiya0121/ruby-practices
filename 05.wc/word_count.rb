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

def main(options)
  print_file_count(options)
end

def print_file_count(options)
  results = ARGV.map {|path| calc_file_count(path, options)}
  results.each_with_index do |e, i|
    puts e.map { |a| a.to_s.rjust(PADDING) }.join + "\s#{ARGV[i]}"
  end
  puts results.transpose.map {|a| a.sum.to_s.rjust(PADDING)}.join + "\stotal"
end

def calc_file_count(file_path, options)
  results = []
  File.open(file_path, 'r') do |file|
    file_counts = { lines: 0, words: 0, bytes: file.size }
    file.each_line do |line|
      file_counts[:words] += line.split(' ').size
      file_counts[:lines] += 1
    end
    results << file_counts[:lines] if options[:line]
    results << file_counts[:words] if options[:word]
    results << file_counts[:bytes] if options[:char]
  end
  results
end

main(options)
