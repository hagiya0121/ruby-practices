# frozen_string_literal: true

require_relative 'game'
require_relative 'frame'
require_relative 'shot'

input_marks = ARGV[0]
game = Game.new(input_marks)
puts game.score
