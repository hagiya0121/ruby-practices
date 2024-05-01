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
  results = ARGV.map { |file_path| calc_word_count(file_path, options) }
  print_word_count(results)
end

def print_word_count(results)
  results.each_with_index do |result, index|
    puts result.map { |e| e.to_s.rjust(PADDING) }.join + "\s#{ARGV[index]}"
  end
  puts "#{results.transpose.map { |column_values| column_values.sum.to_s.rjust(PADDING) }.join}\stotal"
end

def calc_word_count(file_path, options)
  results = []
  word_counts = { lines: 0, words: 0, bytes: 0 }
  File.open(file_path, 'r') do |file|
    word_counts[:bytes] = file.size
    file.each_line do |line|
      word_counts[:words] += line.split(' ').size
      word_counts[:lines] += 1
    end
    results << word_counts[:lines] if options[:line]
    results << word_counts[:words] if options[:word]
    results << word_counts[:bytes] if options[:char]
  end
  results
end

main(options)
