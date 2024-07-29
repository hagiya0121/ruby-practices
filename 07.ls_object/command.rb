# frozen_string_literal: true

require 'optparse'

class Command
  attr_reader :options, :file_path

  def initialize(argv)
    @options = parse_options(argv)
    @file_path = argv.first || './'
  end

  private

  def parse_options(argv)
    options = { all: false, reverse: false, long: false }
    opt = OptionParser.new
    opt.on('-a') { |v| options[:all] = v }
    opt.on('-r') { |v| options[:reverse] = v }
    opt.on('-l') { |v| options[:long] = v }
    opt.parse!(argv)
    options
  end
end
