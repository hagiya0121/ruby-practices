#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

PADDING = 8

def main
  options = parse_options
  options.each_key { |key| options[key] = true } if options.values.none?
  if ARGV.empty?
    results = calc_word_count(readlines, options)
    puts format_results(results)
  else
    results = ARGV.map do |file_path|
      lines = File.readlines(file_path)
      calc_word_count(lines, options)
    end
    print_word_count(results, ARGV)
  end
end

def parse_options
  options = { line: false, word: false, char: false }
  opt = OptionParser.new
  opt.on('-l') { |v| options[:line] = v }
  opt.on('-w') { |v| options[:word] = v }
  opt.on('-c') { |v| options[:char] = v }
  opt.parse!(ARGV)
  options
end

def calc_word_count(lines, options)
  results = []
  results << lines.size if options[:line]
  results << lines.join.split(' ').size if options[:word]
  results << lines.join.bytesize if options[:char]
  results
end

def format_results(results)
  results.map { |e| e.to_s.rjust(PADDING) }.join
end

def print_word_count(results, file_names)
  results.each_with_index do |result, index|
    puts format_results(result) + "\s#{file_names[index]}"
  end

  return if results.size <= 1

  puts "#{results.transpose.map { |e| e.sum.to_s.rjust(PADDING) }.join}\stotal"
end

main
